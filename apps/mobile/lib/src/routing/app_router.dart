import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tnyx/src/features/splash/presentation/route/splash_route.dart';
import 'package:tnyx/src/features/welcome/presentation/route/welcome_route.dart';
import 'package:tnyx/src/features/auth/presentation/screen/login_screen.dart';
import 'package:tnyx/src/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:tnyx/src/features/main_nav/presentation/screen/main_nav_screen.dart';

sealed class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String main = '/main';
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashRoute(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeRoute(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.main,
        builder: (context, state) => const MainNavScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('No route defined for ${state.uri}')),
    ),
  );
}
