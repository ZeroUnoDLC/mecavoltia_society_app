import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mecavoltia_society_app/core/errors/failure.dart';
import 'package:mecavoltia_society_app/core/network/session_events.dart';
import 'package:mecavoltia_society_app/features/auth/data/auth_repository_impl.dart';
import 'package:mecavoltia_society_app/features/auth/domain/auth_repository.dart';
import 'package:mecavoltia_society_app/features/auth/domain/session_user.dart';
import 'package:mecavoltia_society_app/features/auth/presentation/auth_controller.dart';

class FakeAuthRepository implements AuthRepository {
  SessionUser? stored;
  String? validPassword;
  int logoutCalls = 0;

  @override
  Future<SessionUser> login({
    required String email,
    required String password,
  }) async {
    if (password != validPassword) {
      throw const AuthFailure('Email o contraseña incorrectos');
    }
    final user = SessionUser(id: 'u1', email: email, displayName: 'Brayan');
    stored = user;
    return user;
  }

  @override
  Future<SessionUser?> restoreSession() async => stored;

  @override
  Future<void> logout() async {
    logoutCalls += 1;
    stored = null;
  }
}

void main() {
  late FakeAuthRepository fake;
  late ProviderContainer container;

  setUp(() {
    fake = FakeAuthRepository()..validPassword = 'correct-password';
    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);
  });

  test('sin sesión persistida arranca deslogueado', () async {
    final user = await container.read(authControllerProvider.future);
    expect(user, isNull);
  });

  test('restaura la sesión persistida al arrancar', () async {
    fake.stored = const SessionUser(
      id: 'u1',
      email: 'brayan@mecavoltia.com',
      displayName: 'Brayan',
    );

    final user = await container.read(authControllerProvider.future);

    expect(user?.email, 'brayan@mecavoltia.com');
  });

  test('login correcto deja al usuario autenticado', () async {
    await container.read(authControllerProvider.future);

    await container.read(authControllerProvider.notifier).login(
          email: 'brayan@mecavoltia.com',
          password: 'correct-password',
        );

    final state = container.read(authControllerProvider);
    expect(state.value?.displayName, 'Brayan');
  });

  test('login con contraseña incorrecta expone AuthFailure', () async {
    await container.read(authControllerProvider.future);

    await container.read(authControllerProvider.notifier).login(
          email: 'brayan@mecavoltia.com',
          password: 'mala',
        );

    final state = container.read(authControllerProvider);
    expect(state.hasError, isTrue);
    expect(state.error, isA<AuthFailure>());
  });

  test('logout revoca en el repo y desloguea', () async {
    fake.stored = const SessionUser(
      id: 'u1',
      email: 'brayan@mecavoltia.com',
      displayName: 'Brayan',
    );
    await container.read(authControllerProvider.future);

    await container.read(authControllerProvider.notifier).logout();

    expect(fake.logoutCalls, 1);
    expect(container.read(authControllerProvider).value, isNull);
  });

  test('el evento de sesión expirada (refresh muerto) desloguea', () async {
    fake.stored = const SessionUser(
      id: 'u1',
      email: 'brayan@mecavoltia.com',
      displayName: 'Brayan',
    );
    await container.read(authControllerProvider.future);
    expect(container.read(authControllerProvider).value, isNotNull);

    container.read(sessionEventsProvider).notifyExpired();
    await Future<void>.delayed(Duration.zero);

    expect(container.read(authControllerProvider).value, isNull);
  });
}
