import 'package:flutter/material.dart';
import 'package:tnyx/src/core/theme/tokens/foundation/dimens.dart';
import 'package:tnyx/src/features/splash/presentation/action/splash_action.dart';
import 'package:tnyx/src/features/splash/presentation/state/splash_ui_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    required this.state,
    required this.onAction,
    super.key,
  });

  final SplashUiState state;
  final ValueChanged<SplashAction> onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.radius2XL),
              child: Image.asset(
                'assets/icons/app_icon.png',
                width: 120,
                height: 120,
              ),
            ),
            if (state.isLoading) ...[
              const SizedBox(height: 48),
              CircularProgressIndicator(
                color: theme.colorScheme.onSurface,
                strokeWidth: 2,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
