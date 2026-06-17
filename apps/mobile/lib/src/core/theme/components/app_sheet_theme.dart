import 'package:flutter/material.dart';
import 'package:tnyx/src/core/theme/tokens/foundation/shapes.dart';
import 'package:tnyx/src/core/theme/tokens/semantic/colors.dart';
import '../tokens/foundation/dimens.dart';

sealed class AppSheets {
  AppSheets._();

  static final BottomSheetThemeData light = BottomSheetThemeData(
    elevation: Dimens.elevationNone,
    modalElevation: Dimens.elevationDialog,
    backgroundColor: AppColors.lightSurface,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    showDragHandle: true,
    dragHandleColor: AppColors.lightTextMuted.withValues(alpha: 0.50),
    dragHandleSize: const Size(
      Dimens.sheetHandleWidth,
      Dimens.sheetHandleHeight,
    ),
    constraints: const BoxConstraints(
      maxWidth: Dimens.screenMaxContentWidth,
    ),
    shape: Shapes.sheet,
  );

  static final BottomSheetThemeData dark = BottomSheetThemeData(
    elevation: Dimens.elevationNone,
    modalElevation: Dimens.elevationDialog,
    backgroundColor: AppColors.darkSurface,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    showDragHandle: true,
    dragHandleColor: AppColors.darkTextMuted.withValues(alpha: 0.50),
    dragHandleSize: const Size(
      Dimens.sheetHandleWidth,
      Dimens.sheetHandleHeight,
    ),
    constraints: const BoxConstraints(
      maxWidth: Dimens.screenMaxContentWidth,
    ),
    shape: Shapes.sheet,
  );
}
