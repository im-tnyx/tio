import 'package:flutter/material.dart';

sealed class Palette {
  Palette._();

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color neutral050 = Color(0xFFF8F9FA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE8E8E8);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFAFAFAF);
  static const Color neutral500 = Color(0xFF657786);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF333333);
  static const Color neutral800 = Color(0xFF1A1A1A);
  static const Color neutral900 = Color(0xFF14171A);
  static const Color neutral950 = Color(0xFF121212);
}
