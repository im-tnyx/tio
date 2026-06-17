import 'package:flutter/material.dart';
import 'components/app_bar_theme.dart';
import 'components/app_button_theme.dart';
import 'components/app_card_theme.dart';
import 'components/app_input_theme.dart';
import 'components/app_navigation_theme.dart';
import 'components/app_sheet_theme.dart';
import 'tokens/foundation/palette.dart';
import 'tokens/typography/app_typography.dart';

class AppTheme {
  AppTheme._();

  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: Palette.black,
    brightness: Brightness.light,
  ).copyWith(
    primary: Palette.black,
    onPrimary: Palette.white,
    surface: Palette.white,
    onSurface: Palette.black,
  );

  static final ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: Palette.white,
    brightness: Brightness.dark,
  ).copyWith(
    primary: Palette.white,
    onPrimary: Palette.black,
    surface: Palette.neutral950,
    onSurface: Palette.white,
  );

  static ThemeData buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = isDark ? darkScheme : lightScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      
      appBarTheme: isDark ? AppBars.dark : AppBars.light,
      cardTheme: isDark ? AppCards.dark : AppCards.light,
      inputDecorationTheme: isDark ? AppInputs.dark : AppInputs.light,
      navigationBarTheme: isDark ? AppNavigations.dark : AppNavigations.light,
      bottomSheetTheme: isDark ? AppSheets.dark : AppSheets.light,

      filledButtonTheme: isDark ? Buttons.filledDark : Buttons.filledLight,
      outlinedButtonTheme: isDark ? Buttons.outlinedDark : Buttons.outlinedLight,
      textButtonTheme: isDark ? Buttons.textDark : Buttons.textLight,

      textTheme: AppTypography.textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
    );
  }
}
