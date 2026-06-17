import 'package:flutter/material.dart';

sealed class AccentColors {
  AccentColors._();

  static const Color lime = Color(0xffd4e157);            // Base Color (Lime 400)
  static const Color limeStrong = Color(0xffafb42b);      // Darker/Stronger (Lime 700)
  static const Color limeSurfaceLight = Color(0xfff9fbe7);// Very Light Background (Lime 50)
  static const Color limeSurfaceDark = Color(0xff827717); // Dark Background (Lime 900)
  static const Color limeOutline = Color(0xffe6ee9c);     // Border/Outline (Lime 200)
  static const Color limeOnAccent = Color(0xff000000);    // Text on Accent (Black for contrast)
}
