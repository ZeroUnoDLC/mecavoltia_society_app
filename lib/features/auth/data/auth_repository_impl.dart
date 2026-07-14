import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mecavoltia_society_app/core/errors/failure.dart';
import 'package:mecavoltia_society_app/core/network/api_client.dart';
import 'package:mecavoltia_society_app/core/storage/token_storage.dart';
import 'package:mecavoltia_society_app/features/auth/domain/auth_repository.dart';
import 'package:mecavoltia_society_app/features/auth/domain/session_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required Dio publicClient,
    required Dio apiClient,
    required this._storage,
  })  : _public = publicClient,
        _api = apiClient;

  final Dio _public;
  final Dio _api;
  final TokenStorage _storage;

  @override
  Future<SessionUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _public.post<Map<String, dynamic>>(
        '/api/auth/login',
        data: {'email': email, 'password': password},
      );
      final body = response.data!;
      await _storage.save((
        accessToken: body['accessToken'] as String,
        refreshToken: body['refreshToken'] as String,
      ));
      final user = body['user'] as Map<String, dynamic>;
      return SessionUser(
        id: user['id'] as String,
        email: user['email'] as String,
        displayName: user['displayName'] as String,
      );
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      if (status == 401) {
        throw const AuthFailure('Email o contraseña incorrectos');
      }
      if (status == 429) {
        throw const AuthFailure(
          'Demasiados intentos. Esperá unos minutos y probá de nuevo.',
        );
      }
      throw const NetworkFailure('No pudimos conectar con el servidor');
    }
  }

  @override
  Future<SessionUser?> restoreSession() async {
    final refresh = await _storage.readRefreshToken();
    if (refresh == null) return null;
    try {
      // /me valida el access token; si expiró, el interceptor refresca solo.
      final response = await _api.get<Map<String, dynamic>>('/api/auth/me');
      final body = response.data!;
      return SessionUser(
        id: body['id'] as String,
        email: body['email'] as String,
        // /me no trae displayName: se usa el email hasta cargar el perfil
        displayName: body['email'] as String,
      );
    } on DioException {
      await _storage.clear();
      return null;
    }
  }

  @override
  Future<void> logout() async {
    final refresh = await _storage.readRefreshToken();
    if (refresh != null) {
      try {
        await _public.post<void>(
          '/api/auth/logout',
          data: {'refreshToken': refresh},
        );
      } on DioException {
        // Best-effort: la sesión local muere igual
      }
    }
    await _storage.clear();
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
      publicClient: ref.watch(publicDioProvider),
      apiClient: ref.watch(apiDioProvider),
      storage: ref.watch(tokenStorageProvider),
    );
