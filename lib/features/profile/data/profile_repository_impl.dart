import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mecavoltia_society_app/core/errors/failure.dart';
import 'package:mecavoltia_society_app/core/network/api_client.dart';
import 'package:mecavoltia_society_app/features/profile/domain/member.dart';
import 'package:mecavoltia_society_app/features/profile/domain/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository_impl.g.dart';

Member _memberFromJson(Map<String, dynamic> json) => Member(
      id: json['id'] as String,
      email: json['email'] as String,
      slug: json['slug'] as String,
      fullName: json['fullName'] as String,
      roleEs: json['roleEs'] as String,
      roleEn: json['roleEn'] as String,
      bioEs: json['bioEs'] as String,
      bioEn: json['bioEn'] as String,
      photoPath: json['photoPath'] as String?,
      linkedinUrl: json['linkedinUrl'] as String?,
      cvPath: json['cvPath'] as String?,
    );

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._api);

  final Dio _api;

  @override
  Future<Member> getMe() => _guard(() async {
        final response =
            await _api.get<Map<String, dynamic>>('/api/admin/members/me');
        return _memberFromJson(response.data!);
      });

  @override
  Future<Member> updateMe(MemberUpdate update) => _guard(() async {
        final payload = <String, dynamic>{
          if (update.fullName != null) 'fullName': update.fullName,
          if (update.roleEs != null) 'roleEs': update.roleEs,
          if (update.roleEn != null) 'roleEn': update.roleEn,
          if (update.bioEs != null) 'bioEs': update.bioEs,
          if (update.bioEn != null) 'bioEn': update.bioEn,
          if (update.linkedinUrl != null) 'linkedinUrl': update.linkedinUrl,
        };
        final response = await _api.patch<Map<String, dynamic>>(
          '/api/admin/members/me',
          data: payload,
        );
        return _memberFromJson(response.data!);
      });

  @override
  Future<Member> uploadPhoto({
    required Uint8List bytes,
    required String filename,
  }) =>
      _upload('/api/admin/members/me/photo', bytes, filename);

  @override
  Future<Member> uploadCv({
    required Uint8List bytes,
    required String filename,
  }) =>
      _upload('/api/admin/members/me/cv', bytes, filename);

  Future<Member> _upload(String path, Uint8List bytes, String filename) =>
      _guard(() async {
        final form = FormData.fromMap({
          'file': MultipartFile.fromBytes(bytes, filename: filename),
        });
        final response =
            await _api.post<Map<String, dynamic>>(path, data: form);
        return _memberFromJson(response.data!);
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
ProfileRepository profileRepository(Ref ref) =>
    ProfileRepositoryImpl(ref.watch(apiDioProvider));
