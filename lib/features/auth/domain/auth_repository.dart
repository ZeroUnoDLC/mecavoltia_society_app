import 'package:mecavoltia_society_app/features/auth/domain/session_user.dart';

/// Contrato de identidad. La implementación vive en data/ (rules.md §1).
abstract interface class AuthRepository {
  /// Autentica y persiste los tokens. Lanza [AuthFailure] con credenciales malas.
  Future<SessionUser> login({required String email, required String password});

  /// Recupera la sesión persistida validando el token contra /me.
  /// Devuelve null si no hay sesión utilizable.
  Future<SessionUser?> restoreSession();

  /// Revoca la familia de sesiones y limpia el storage. Siempre exitoso local.
  Future<void> logout();
}
