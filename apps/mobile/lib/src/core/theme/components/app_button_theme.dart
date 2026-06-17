import 'package:flutter/material.dart';
import '../tokens/foundation/dimens.dart';
import '../tokens/foundation/insets.dart';
import '../tokens/foundation/shapes.dart';
import '../tokens/foundation/palette.dart';
import '../tokens/typography/app_typography.dart';

sealed class Buttons {
  Buttons._();

  static final FilledButtonThemeData filledLight = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      elevation: Dimens.elevationButton,
      minimumSize: const Size(double.infinity, Dimens.buttonHeightLarge),
      padding: Insets.button,
      backgroundColor: Palette.black,
      foregroundColor: Palette.white,
      shape: Shapes.button,
      textStyle: AppTypography.labelLarge,
    ),
  );

  static final FilledButtonThemeData filledDark = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      elevation: Dimens.elevationButton,
      minimumSize: const Size(double.infinity, Dimens.buttonHeightLarge),
      padding: Insets.button,
      backgroundColor: Palette.white,
      foregroundColor: Palette.black,
      shape: Shapes.button,
      textStyle: AppTypography.labelLarge,
    ),
  );

  static final OutlinedButtonThemeData outlinedLight = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: Dimens.elevationNone,
      minimumSize: const Size(double.infinity, Dimens.buttonHeight),
      padding: Insets.button,
      foregroundColor: Palette.black,
      side: const BorderSide(color: Palette.neutral200, width: Dimens.borderThin),
      shape: Shapes.button,
      textStyle: AppTypography.labelLarge,
    ),
  );

  static final OutlinedButtonThemeData outlinedDark = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: Dimens.elevationNone,
      minimumSize: const Size(double.infinity, Dimens.buttonHeight),
      padding: Insets.button,
      foregroundColor: Palette.white,
      side: const BorderSide(color: Palette.neutral700, width: Dimens.borderThin),
      shape: Shapes.button,
      textStyle: AppTypography.labelLarge,
    ),
  );

  static final TextButtonThemeData textLight = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: Dimens.elevationNone,
      foregroundColor: Palette.black,
      padding: Insets.textButton,
      textStyle: AppTypography.labelLarge,
      shape: Shapes.button,
    ),
  );

  static final TextButtonThemeData textDark = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: Dimens.elevationNone,
      foregroundColor: Palette.white,
      padding: Insets.textButton,
      textStyle: AppTypography.labelLarge,
      shape: Shapes.button,
    ),
  );
}
