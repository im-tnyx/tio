import 'package:flutter/material.dart';
import '../tokens/foundation/dimens.dart';
import '../tokens/semantic/colors.dart';
import '../tokens/typography/app_typography.dart';

sealed class AppNavigations {
  AppNavigations._();

  static final NavigationBarThemeData light = NavigationBarThemeData(
    height: Dimens.bottomNavHeight,
    backgroundColor: AppColors.lightSurface,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: Dimens.elevationNone,
    indicatorColor: AppColors.selectionContainerLight,
    iconTheme: WidgetStateProperty.resolveWith(
      (states) {
        final isSelected = states.contains(WidgetState.selected);

        return IconThemeData(
          size: Dimens.bottomNavIcon,
          color: isSelected
              ? AppColors.selectionAccentLight
              : AppColors.lightTextSecondary,
        );
      },
    ),
    labelTextStyle: WidgetStateProperty.resolveWith(
      (states) {
        final isSelected = states.contains(WidgetState.selected);

        if (isSelected) {
          return AppTypography.labelMedium.copyWith(
            color: AppColors.selectionAccentLight,
            fontWeight: FontWeight.w600,
          );
        }

        return AppTypography.labelMedium.copyWith(
          color: AppColors.lightTextSecondary,
          fontWeight: FontWeight.w500,
        );
      },
    ),
  );

  static final NavigationBarThemeData dark = NavigationBarThemeData(
    height: Dimens.bottomNavHeight,
    backgroundColor: AppColors.darkSurface,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: Dimens.elevationNone,
    indicatorColor: AppColors.selectionContainerDark,
    iconTheme: WidgetStateProperty.resolveWith(
      (states) {
        final isSelected = states.contains(WidgetState.selected);

        return IconThemeData(
          size: Dimens.bottomNavIcon,
          color: isSelected
              ? AppColors.selectionAccentDark
              : AppColors.darkTextSecondary,
        );
      },
    ),
    labelTextStyle: WidgetStateProperty.resolveWith(
      (states) {
        final isSelected = states.contains(WidgetState.selected);

        if (isSelected) {
          return AppTypography.labelMedium.copyWith(
            color: AppColors.selectionAccentDark,
            fontWeight: FontWeight.w600,
          );
        }

        return AppTypography.labelMedium.copyWith(
          color: AppColors.darkTextSecondary,
          fontWeight: FontWeight.w500,
        );
      },
    ),
  );
}
