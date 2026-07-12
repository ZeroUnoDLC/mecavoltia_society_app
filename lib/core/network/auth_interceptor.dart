import 'dart:async';

import 'package:dio/dio.dart';

import 'package:mecavoltia_society_app/core/storage/token_storage.dart';

/// Renueva el par de tokens presentando el refresh actual.
/// Devuelve null si el refresh fue rechazado (sesión muerta).
typedef RefreshTokens = Future<TokenPair?> Function(String refreshToken);

/// Avisa que la sesión expiró sin posibilidad de refresh (→ login).
typedef OnSessionExpired = void Function();

/// Adjunta el Bearer y, ante un 401, refresca UNA sola vez en vuelo
/// (single-flight: N requests concurrentes esperan el mismo refresh)
/// y reintenta la petición original — rules.md §4.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required TokenStorage storage,
    required RefreshTokens refreshTokens,
    required OnSessionExpired onSessionExpired,
    required Dio retryClient,
  })  : _storage = storage,
        _refreshTokens = refreshTokens,
        _onSessionExpired = onSessionExpired,
        _retryClient = retryClient;

  final TokenStorage _storage;
  final RefreshTokens _refreshTokens;
  final OnSessionExpired _onSessionExpired;
  final Dio _retryClient;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.readAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final alreadyRetried = err.requestOptions.extra['mv_retried'] == true;
    if (!isUnauthorized || alreadyRetried) {
      handler.next(err);
      return;
    }

    final refreshToken = await _storage.readRefreshToken();
    if (refreshToken == null) {
      _onSessionExpired();
      handler.next(err);
      return;
    }

    // QueuedInterceptor serializa los onError: el primero refresca,
    // los siguientes ya encuentran el token nuevo en storage.
    final currentAccess = await _storage.readAccessToken();
    final sentAuth = err.requestOptions.headers['Authorization'];
    final tokenChanged =
        currentAccess != null && sentAuth != 'Bearer $currentAccess';

    if (!tokenChanged) {
      final renewed = await _refreshTokens(refreshToken);
      if (renewed == null) {
        await _storage.clear();
        _onSessionExpired();
        handler.next(err);
        return;
      }
      await _storage.save(renewed);
    }

    try {
      final retried = await _retry(err.requestOptions);
      handler.resolve(retried);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions options) async {
    final token = await _storage.readAccessToken();
    options.headers['Authorization'] = 'Bearer $token';
    options.extra['mv_retried'] = true;
    return _retryClient.fetch<dynamic>(options);
  }
}
