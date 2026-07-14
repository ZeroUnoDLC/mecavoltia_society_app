import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mecavoltia_society_app/core/errors/failure.dart';
import 'package:mecavoltia_society_app/core/network/api_client.dart';
import 'package:mecavoltia_society_app/features/portfolio/domain/portfolio_repository.dart';
import 'package:mecavoltia_society_app/features/portfolio/domain/work.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'portfolio_repository_impl.g.dart';

/// Mapper JSON → entidad de dominio: la UI jamás ve el shape de la API.
Work workFromJson(Map<String, dynamic> json) => Work(
      id: json['id'] as String,
      slug: json['slug'] as String,
      categorySlug: json['categorySlug'] as String,
      titleEs: json['titleEs'] as String,
      titleEn: json['titleEn'] as String,
      summaryEs: json['summaryEs'] as String,
      summaryEn: json['summaryEn'] as String,
      descriptionEs: json['descriptionEs'] as String,
      descriptionEn: json['descriptionEn'] as String,
      published: json['published'] as bool,
      images: (json['images'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(
            (image) => WorkImage(
              id: image['id'] as String,
              path: image['path'] as String,
              altEs: image['altEs'] as String,
              altEn: image['altEn'] as String,
              position: image['position'] as int,
              isCover: image['isCover'] as bool,
            ),
          )
          .toList(),
    );

Map<String, dynamic> _draftToJson(WorkDraft draft) => {
      'categorySlug': draft.categorySlug,
      'titleEs': draft.titleEs,
      'titleEn': draft.titleEn,
      'summaryEs': draft.summaryEs,
      'summaryEn': draft.summaryEn,
      'descriptionEs': draft.descriptionEs,
      'descriptionEn': draft.descriptionEn,
      'published': draft.published,
    };

class PortfolioRepositoryImpl implements PortfolioRepository {
  PortfolioRepositoryImpl(this._api);

  final Dio _api;

  @override
  Future<List<Work>> listWorks() => _guard(() async {
        final response = await _api.get<List<dynamic>>('/api/admin/works');
        return (response.data ?? [])
            .cast<Map<String, dynamic>>()
            .map(workFromJson)
            .toList();
      });

  @override
  Future<Work> createWork(WorkDraft draft) => _guard(() async {
        final response = await _api.post<Map<String, dynamic>>(
          '/api/admin/works',
          data: _draftToJson(draft),
        );
        return workFromJson(response.data!);
      });

  @override
  Future<Work> updateWork(String id, WorkDraft draft) => _guard(() async {
        final response = await _api.patch<Map<String, dynamic>>(
          '/api/admin/works/$id',
          data: _draftToJson(draft),
        );
        return workFromJson(response.data!);
      });

  @override
  Future<void> setPublished(String id, {required bool published}) =>
      _guard(() async {
        await _api.patch<Map<String, dynamic>>(
          '/api/admin/works/$id',
          data: {'published': published},
        );
      });

  @override
  Future<void> deleteWork(String id) => _guard(() async {
        await _api.delete<void>('/api/admin/works/$id');
      });

  @override
  Future<void> addImage({
    required String workId,
    required Uint8List bytes,
    required String filename,
    required String altEs,
    required String altEn,
    required bool isCover,
  }) =>
      _guard(() async {
        final form = FormData.fromMap({
          'file': MultipartFile.fromBytes(bytes, filename: filename),
          'altEs': altEs,
          'altEn': altEn,
          'isCover': isCover.toString(),
        });
        await _api.post<Map<String, dynamic>>(
          '/api/admin/works/$workId/images',
          data: form,
        );
      });

  @override
  Future<void> removeImage({
    required String workId,
    required String imageId,
  }) =>
      _guard(() async {
        await _api.delete<void>('/api/admin/works/$workId/images/$imageId');
      });

  Future<T> _guard<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on DioException catch (e) {
      final data = e.response?.data;
      final code = data is Map<String, dynamic> ? data['code'] : null;
      final message = data is Map<String, dynamic> ? data['message'] : null;
      if (code is String) {
        throw ServerFailure(
          message is String ? message : 'El servidor rechazó la operación',
          code: code,
        );
      }
      throw const NetworkFailure('No pudimos conectar con el servidor');
    }
  }
}

@Riverpod(keepAlive: true)
PortfolioRepository portfolioRepository(Ref ref) =>
    PortfolioRepositoryImpl(ref.watch(apiDioProvider));
