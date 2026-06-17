import 'package:flutter/material.dart';
import '../tokens/foundation/dimens.dart';
import '../tokens/foundation/insets.dart';
import '../tokens/foundation/shapes.dart';
import '../tokens/semantic/colors.dart';

sealed class AppInputs {
  AppInputs._();

  static final InputDecorationTheme light = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.inputFillLight,
    contentPadding: Insets.input,
    border: const OutlineInputBorder(
      borderRadius: Shapes.inputRadius,
      borderSide: BorderSide.none,
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: Shapes.inputRadius,
      borderSide: BorderSide.none,
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: Shapes.inputRadius,
      borderSide: BorderSide(
        color: AppColors.focusAccentLight,
        width: Dimens.borderThick,
      ),
    ),
  );

  static final InputDecorationTheme dark = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.inputFillDark,
    contentPadding: Insets.input,
    border: const OutlineInputBorder(
      borderRadius: Shapes.inputRadius,
      borderSide: BorderSide.none,
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: Shapes.inputRadius,
      borderSide: BorderSide.none,
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: Shapes.inputRadius,
      borderSide: BorderSide(
        color: AppColors.focusAccentDark,
        width: Dimens.borderThick,
      ),
    ),
  );
}
