import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tokens/foundation/dimens.dart';
import '../tokens/foundation/palette.dart';

sealed class AppBars {
  AppBars._();

  static final AppBarTheme light = AppBarTheme(
    elevation: Dimens.elevationNone,
    systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    scrolledUnderElevation: Dimens.elevationNone,
    centerTitle: false,
    backgroundColor: Colors.transparent,
    foregroundColor: Palette.black,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    toolbarHeight: Dimens.topBarHeight,
    titleSpacing: Dimens.topBarPaddingHorizontal,
    iconTheme: const IconThemeData(
      size: Dimens.topBarIcon,
      color: Palette.black,
    ),
    actionsIconTheme: const IconThemeData(
      size: Dimens.topBarIcon,
      color: Palette.black,
    ),
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Palette.black,
    ),
  );

  static final AppBarTheme dark = AppBarTheme(
    elevation: Dimens.elevationNone,
    systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    scrolledUnderElevation: Dimens.elevationNone,
    centerTitle: false,
    backgroundColor: Colors.transparent,
    foregroundColor: Palette.white,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    toolbarHeight: Dimens.topBarHeight,
    titleSpacing: Dimens.topBarPaddingHorizontal,
    iconTheme: const IconThemeData(
      size: Dimens.topBarIcon,
      color: Palette.white,
    ),
    actionsIconTheme: const IconThemeData(
      size: Dimens.topBarIcon,
      color: Palette.white,
    ),
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Palette.white,
    ),
  );
}
