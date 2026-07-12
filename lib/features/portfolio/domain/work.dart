import 'package:freezed_annotation/freezed_annotation.dart';

part 'work.freezed.dart';

/// Las 3 categorías del portafolio (slugs de la API, seed del web_back).
const workCategories = [
  (slug: 'mecatronica', label: 'Mecatrónica'),
  (slug: 'electricidad', label: 'Electricidad'),
  (slug: 'software', label: 'Software'),
];

@freezed
class WorkImage with _$WorkImage {
  const factory WorkImage({
    required String id,
    required String path,
    required String altEs,
    required String altEn,
    required int position,
    required bool isCover,
  }) = _WorkImage;
}

@freezed
class Work with _$Work {
  const factory Work({
    required String id,
    required String slug,
    required String categorySlug,
    required String titleEs,
    required String titleEn,
    required String summaryEs,
    required String summaryEn,
    required String descriptionEs,
    required String descriptionEn,
    required bool published,
    required List<WorkImage> images,
  }) = _Work;
}

/// Payload de creación/edición (el slug lo genera el back y es inmutable).
@freezed
class WorkDraft with _$WorkDraft {
  const factory WorkDraft({
    required String categorySlug,
    required String titleEs,
    required String titleEn,
    required String summaryEs,
    required String summaryEn,
    required String descriptionEs,
    required String descriptionEn,
    required bool published,
  }) = _WorkDraft;
}
