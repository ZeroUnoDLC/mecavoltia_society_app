import 'dart:typed_data';

import 'package:mecavoltia_society_app/features/portfolio/domain/work.dart';

abstract interface class PortfolioRepository {
  /// Todos los trabajos de la sociedad, incluidos los borradores.
  Future<List<Work>> listWorks();

  Future<Work> createWork(WorkDraft draft);

  Future<Work> updateWork(String id, WorkDraft draft);

  Future<void> setPublished(String id, {required bool published});

  Future<void> deleteWork(String id);

  Future<void> addImage({
    required String workId,
    required Uint8List bytes,
    required String filename,
    required String altEs,
    required String altEn,
    required bool isCover,
  });

  Future<void> removeImage({required String workId, required String imageId});
}
