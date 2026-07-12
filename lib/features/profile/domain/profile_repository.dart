import 'dart:typed_data';

import 'package:mecavoltia_society_app/features/profile/domain/member.dart';

/// Perfil PROPIO del socio autenticado (el back resuelve por el JWT).
abstract interface class ProfileRepository {
  Future<Member> getMe();

  Future<Member> updateMe(MemberUpdate update);

  Future<Member> uploadPhoto({
    required Uint8List bytes,
    required String filename,
  });

  Future<Member> uploadCv({
    required Uint8List bytes,
    required String filename,
  });
}
