import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../action/splash_action.dart';
import '../screen/splash_screen.dart';
import '../view_model/splash_view_model.dart';
import '../../../../routing/app_router.dart';

class SplashRoute extends StatefulWidget {
  const SplashRoute({super.key});

  @override
  State<SplashRoute> createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  late final SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SplashViewModel();
    _viewModel.effects.listen(_handleEffect);
    _viewModel.handleAction(const SplashInitAction());
  }

  void _handleEffect(SplashEffect effect) {
    if (!mounted) return;
    if (effect is SplashNavigateToWelcome) {
      context.go(AppRoutes.welcome);
    } else if (effect is SplashNavigateToOnboarding) {
      context.go(AppRoutes.onboarding);
    } else if (effect is SplashNavigateToMain) {
      context.go(AppRoutes.main);
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _viewModel,
      builder: (context, _) {
        return SplashScreen(
          state: _viewModel.state,
          onAction: _viewModel.handleAction,
        );
      },
    );
  }
}
