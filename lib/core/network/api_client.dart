import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mecavoltia_society_app/core/config/env.dart';
import 'package:mecavoltia_society_app/core/network/auth_interceptor.dart';
import 'package:mecavoltia_society_app/core/network/session_events.dart';
import 'package:mecavoltia_society_app/core/storage/token_storage.dart';

part 'api_client.g.dart';

BaseOptions _baseOptions() => BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
    );

/// Cliente SIN auth: login, refresh, logout (no debe llevar Bearer viejo).
@Riverpod(keepAlive: true)
Dio publicDio(Ref ref) => Dio(_baseOptions());

/// Cliente autenticado: Bearer automático + refresh single-flight ante 401.
@Riverpod(keepAlive: true)
Dio apiDio(Ref ref) {
  final storage = ref.watch(tokenStorageProvider);
  final publicClient = ref.watch(publicDioProvider);
  final sessionEvents = ref.watch(sessionEventsProvider);

  final dio = Dio(_baseOptions());
  dio.interceptors.add(
    AuthInterceptor(
      storage: storage,
      retryClient: Dio(_baseOptions()),
      onSessionExpired: sessionEvents.notifyExpired,
      refreshTokens: (refreshToken) async {
        try {
          final response = await publicClient.post<Map<String, dynamic>>(
            '/api/auth/refresh',
            data: {'refreshToken': refreshToken},
          );
          final body = response.data;
          if (body == null) return null;
          return (
            accessToken: body['accessToken'] as String,
            refreshToken: body['refreshToken'] as String,
          );
        } on DioException {
          return null;
        }
      },
    ),
  );
  return dio;
}
