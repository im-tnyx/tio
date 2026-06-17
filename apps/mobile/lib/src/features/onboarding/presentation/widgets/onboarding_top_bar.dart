import 'package:flutter/material.dart';
import '../../../../core/theme/tokens/foundation/dimens.dart';

class OnboardingTopBar extends StatelessWidget {
  const OnboardingTopBar({
    required this.showBackButton,
    required this.showProgressBar,
    required this.progress,
    required this.onBackClick,
    super.key,
  });

  final bool showBackButton;
  final bool showProgressBar;
  final double progress; // Between 0.0 and 1.0
  final VoidCallback onBackClick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.topBarPaddingHorizontal,
            vertical: Dimens.topBarPaddingVertical,
          ),
          child: Row(
            children: [
              if (showBackButton)
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: theme.colorScheme.onSurface,
                  iconSize: Dimens.iconSizeS,
                  onPressed: onBackClick,
                )
              else
                const SizedBox(width: 48, height: 48),
              const Spacer(),
            ],
          ),
        ),
        if (showProgressBar)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingScreen),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.radiusPill),
              child: SizedBox(
                height: Dimens.progressBarHeight,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                  valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                ),
              ),
            ),
          )
        else
          const SizedBox(height: Dimens.progressBarHeight),
      ],
    );
  }
}
