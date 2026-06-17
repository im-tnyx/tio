import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../core/theme/tokens/foundation/shapes.dart';

class WelcomeFeaturesList extends StatelessWidget {
  const WelcomeFeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Text
          Text(
            'Eat Smart. Feel Better.\nStay Healthy.',
            style: theme.textTheme.displayMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              height: 1.25,
            ),
          ),
          const SizedBox(height: Dimens.spaceXL),
          // Features List
          _buildFeatureItem(
            context,
            'Log meals with photos, voice, or text',
            Icons.camera_alt_rounded,
          ),
          _buildFeatureItem(
            context,
            'Personalized meal plans for your goals',
            Icons.restaurant_rounded,
          ),
          _buildFeatureItem(
            context,
            'Get realtime insights from AI',
            Icons.auto_awesome_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String text, IconData icon) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spaceM),
      child: ClipRRect(
        borderRadius: Shapes.cardRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: Dimens.blurGlass,
            sigmaY: Dimens.blurGlass,
          ),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: Dimens.featureTileHeight,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.onSurface.withValues(alpha: Dimens.opacityGlass),
              borderRadius: Shapes.cardRadius,
              border: Border.all(
                color: colors.outline.withValues(
                  alpha: Dimens.opacityGlassBorder,
                ),
                width: Dimens.borderThin,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.spaceSM,
              vertical: Dimens.spaceS,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Check mark icon in circular container
                Container(
                  width: Dimens.featureTileIconContainerSize,
                  height: Dimens.featureTileIconContainerSize,
                  decoration: BoxDecoration(
                    color: colors.onSurface.withValues(
                      alpha: Dimens.opacityGlass,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.outline.withValues(
                        alpha: Dimens.opacityGlassBorder,
                      ),
                      width: Dimens.borderThin,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: colors.onSurface,
                      size: Dimens.iconSizeXS,
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.spaceSM),
                // Feature description text
                Expanded(
                  child: Text(
                    text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onSurface.withValues(
                        alpha: Dimens.opacityStrong,
                      ),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.spaceS),
                // Trailing chevron right icon
                Icon(
                  Icons.chevron_right_rounded,
                  color: colors.onSurface.withValues(
                    alpha: Dimens.opacityMuted,
                  ),
                  size: Dimens.iconSizeS,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
