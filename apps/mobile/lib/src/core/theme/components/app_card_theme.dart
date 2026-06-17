import 'package:flutter/material.dart';
import '../tokens/foundation/dimens.dart';
import '../tokens/foundation/shapes.dart';
import '../tokens/foundation/palette.dart';

sealed class AppCards {
  AppCards._();

  static final CardThemeData light = CardThemeData(
    elevation: Dimens.elevationNone,
    color: Palette.neutral050,
    surfaceTintColor: Colors.transparent,
    shape: Shapes.card,
  );

  static final CardThemeData dark = CardThemeData(
    elevation: Dimens.elevationNone,
    color: Palette.neutral900,
    surfaceTintColor: Colors.transparent,
    shape: Shapes.card,
  );
}
