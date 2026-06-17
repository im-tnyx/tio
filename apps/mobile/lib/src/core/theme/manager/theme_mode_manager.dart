import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeManager extends ChangeNotifier {
  static const String _themeKey = 'tnyx_theme_mode';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    final savedTheme = preferences.getString(_themeKey);

    if (savedTheme != null) {
      _themeMode = ThemeMode.values.firstWhere(
            (mode) => mode.toString() == savedTheme,
        orElse: () => ThemeMode.system,
      );
      notifyListeners();
    }
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    _persistThemeMode(mode.toString());
  }

  Future<void> _persistThemeMode(String mode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_themeKey, mode);
  }
}
