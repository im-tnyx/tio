import 'package:flutter/material.dart';
import '../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../core/theme/tokens/foundation/insets.dart';

class WelcomeTopBar extends StatelessWidget {
  const WelcomeTopBar({
    required this.localeCode,
    required this.skipText,
    required this.onSkip,
    required this.onLanguageTap,
    super.key,
  });

  final String localeCode;
  final String skipText;
  final VoidCallback onSkip;
  final VoidCallback onLanguageTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = theme.textTheme.titleMedium?.copyWith(
      color: theme.colorScheme.onSurface,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Language - Optimized ripple effect in pill-shaped container
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer.withValues(
              alpha: Dimens.opacityGlassBackground,
            ),
            borderRadius: BorderRadius.circular(Dimens.radiusButton),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(
                alpha: Dimens.opacityGlassBorder,
              ),
              width: Dimens.borderThin,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onLanguageTap,
              borderRadius: BorderRadius.circular(Dimens.radiusButton),
              child: Padding(
                padding: Insets.textButton,
                child: Text(
                  localeCode.toUpperCase(),
                  style: headerStyle,
                ),
              ),
            ),
          ),
        ),

        // Skip Button - Matching pill-shaped container
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer.withValues(
              alpha: Dimens.opacityGlassBackground,
            ),
            borderRadius: BorderRadius.circular(Dimens.radiusButton),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(
                alpha: Dimens.opacityGlassBorder,
              ),
              width: Dimens.borderThin,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onSkip,
              borderRadius: BorderRadius.circular(Dimens.radiusButton),
              child: Padding(
                padding: Insets.textButton,
                child: Text(
                  skipText,
                  style: headerStyle,
                ),
              ),
            ),
          ),
        ),
      ],
    );

  }
}

