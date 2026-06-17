import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routing/app_router.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/manager/theme_mode_scope.dart';
import '../features/onboarding/presentation/provider/onboarding_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeModeScope>();
    final themeMode = scope?.notifier?.themeMode ?? ThemeMode.system;

    return ChangeNotifierProvider<OnboardingProvider>(
      create: (_) => OnboardingProvider(),
      child: MaterialApp.router(
        title: 'TNYX',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.buildTheme(Brightness.light),
        darkTheme: AppTheme.buildTheme(Brightness.dark),
        themeMode: themeMode,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
