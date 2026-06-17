import 'package:flutter/material.dart';
import '../../../../core/theme/tokens/foundation/dimens.dart';

class WelcomeFooter extends StatelessWidget {
  const WelcomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingScreen),
      child: Text.rich(
        TextSpan(
          text: 'By continuing to use the app, you accept our ',
          style: theme.textTheme.bodySmall?.copyWith(
            color: onSurface.withValues(alpha: Dimens.opacityHalf),
            height: 1.4,
          ),
          children: [
            TextSpan(
              text: 'Terms & Conditions',
              style: TextStyle(
                color: onSurface.withValues(alpha: Dimens.opacityStrong),
                decoration: TextDecoration.underline,
              ),
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: onSurface.withValues(alpha: Dimens.opacityStrong),
                decoration: TextDecoration.underline,
              ),
            ),
            const TextSpan(text: '.'),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

