import 'package:flutter/material.dart';
import '../foundation/palette.dart';

sealed class AppColors {
  AppColors._();

  // Backgrounds
  static const Color lightSurface = Palette.white;
  static const Color darkSurface = Palette.neutral950;
  static const Color darkSurfaceVariant = Palette.neutral900;

  // Inputs
  static const Color inputFillLight = Palette.neutral050;
  static const Color inputFillDark = Palette.neutral900;
  static const Color focusAccentLight = Palette.black;
  static const Color focusAccentDark = Palette.white;

  // Navigation
  static const Color selectionAccentLight = Palette.black;
  static const Color selectionAccentDark = Palette.white;
  static const Color selectionContainerLight = Palette.neutral100;
  static const Color selectionContainerDark = Palette.neutral800;

  // Text
  static const Color lightTextSecondary = Palette.neutral600;
  static const Color darkTextSecondary = Palette.neutral400;
  static const Color lightTextMuted = Palette.neutral400;
  static const Color darkTextMuted = Palette.neutral600;

  // Status
  static const Color statusLive = Color(0xFF22C55E); // Green
  static const Color statusOffline = Color(0xFFEF4444); // Red
}
