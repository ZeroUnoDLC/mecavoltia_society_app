import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_user.freezed.dart';

@freezed
class SessionUser with _$SessionUser {
  const factory SessionUser({
    required String id,
    required String email,
    required String displayName,
  }) = _SessionUser;
}
