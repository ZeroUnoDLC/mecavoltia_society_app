import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mecavoltia_society_app/core/network/session_events.dart';
import 'package:mecavoltia_society_app/features/auth/data/auth_repository_impl.dart';
import 'package:mecavoltia_society_app/features/auth/domain/session_user.dart';

part 'auth_controller.g.dart';

/// Estado de sesión de la app: SessionUser autenticado o null.
/// AsyncValue modela loading/error/data sin banderas manuales (rules.md §2).
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  StreamSubscription<void>? _expiredSub;

  @override
  Future<SessionUser?> build() async {
    // El interceptor avisa si el refresh murió → volver a login
    _expiredSub?.cancel();
    _expiredSub = ref.watch(sessionEventsProvider).expired.listen((_) {
      state = const AsyncData(null);
    });
    ref.onDispose(() => _expiredSub?.cancel());

    return ref.watch(authRepositoryProvider).restoreSession();
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).login(
            email: email,
            password: password,
          ),
    );
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }
}
