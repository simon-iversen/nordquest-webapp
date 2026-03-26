import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nordquest_webapp/src/app/app_shell.dart';
import 'package:nordquest_webapp/src/features/auth/logic/auth_providers.dart';
import 'package:nordquest_webapp/src/features/auth/presentation/login_screen.dart';
import 'package:nordquest_webapp/src/features/map/presentation/map_screen.dart';
import 'package:nordquest_webapp/src/features/profile/presentation/profile_screen.dart';
import 'package:nordquest_webapp/src/features/progress/presentation/progress_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.read(authNotifierProvider);

  final router = GoRouter(
    refreshListenable: authNotifier,
    initialLocation: '/map',
    redirect: (context, state) {
      final loggedIn = ref.read(authNotifierProvider).isLoggedIn;
      final onLogin = state.matchedLocation == '/login';
      if (!loggedIn && !onLogin) return '/login';
      if (loggedIn && onLogin) return '/map';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/map', builder: (_, __) => const MapScreen()),
          GoRoute(
            path: '/progress',
            builder: (_, __) => const ProgressScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (_, __) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});
