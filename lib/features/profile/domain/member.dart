import 'package:freezed_annotation/freezed_annotation.dart';

part 'member.freezed.dart';

@freezed
class Member with _$Member {
  const factory Member({
    required String id,
    required String email,
    required String slug,
    required String fullName,
    required String roleEs,
    required String roleEn,
    required String bioEs,
    required String bioEn,
    required String? photoPath,
    required String? linkedinUrl,
    required String? cvPath,
  }) = _Member;
}

/// Campos editables del perfil propio.
@freezed
class MemberUpdate with _$MemberUpdate {
  const factory MemberUpdate({
    String? fullName,
    String? roleEs,
    String? roleEn,
    String? bioEs,
    String? bioEn,
    String? linkedinUrl,
  }) = _MemberUpdate;
}
