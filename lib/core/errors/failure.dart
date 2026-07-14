/// Fallas tipadas del dominio: `data` captura excepciones (dio, parsing)
/// y las convierte en estas — la UI jamás ve un DioException (rules.md §5).
sealed class Failure implements Exception {
  const Failure(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Credenciales inválidas o sesión expirada sin refresh posible.
final class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Sin conectividad o el servidor no responde.
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// El servidor respondió con un error de negocio (4xx con código).
final class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.code});

  final String? code;
}

/// Cualquier otra cosa: parsing roto, estado imposible.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
