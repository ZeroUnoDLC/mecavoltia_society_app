import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mecavoltia_society_app/core/router/splash_screen.dart';
import 'package:mecavoltia_society_app/features/auth/presentation/auth_controller.dart';
import 'package:mecavoltia_society_app/features/auth/presentation/login_screen.dart';
import 'package:mecavoltia_society_app/features/portfolio/domain/work.dart';
import 'package:mecavoltia_society_app/features/portfolio/presentation/work_form_screen.dart';
import 'package:mecavoltia_society_app/features/portfolio/presentation/works_screen.dart';
import 'package:mecavoltia_society_app/features/profile/presentation/profile_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/', builder: (_, __) => const WorksScreen()),
      GoRoute(path: '/works/new', builder: (_, __) => const WorkFormScreen()),
      GoRoute(
        path: '/works/:id/edit',
        builder: (_, state) => WorkFormScreen(existing: state.extra as Work?),
      ),
      GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
    ],
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final at = state.matchedLocation;

      if (auth.isLoading) {
        // Boot inicial → splash; submit del login → quedarse en /login
        if (at == '/splash' || at == '/login') return null;
        return '/splash';
      }

      final user = auth.valueOrNull;
      if (user == null) return at == '/login' ? null : '/login';
      if (at == '/login' || at == '/splash') return '/';
      return null;
    },
  );

  // La sesión cambia → el router reevalúa los redirects
  ref
    ..listen(authControllerProvider, (_, __) => router.refresh())
    ..onDispose(router.dispose);
  return router;
}
