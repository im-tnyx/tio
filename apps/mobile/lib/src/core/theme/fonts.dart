enum AppFontType {
  system,
  sfPro,
}

sealed class AppFonts {
  static const String sfPro = 'SFPro';

  static const String primary = sfPro;

  static const AppFontType defaultFontType = AppFontType.sfPro;

  static String? getFamily(AppFontType fontType) {
    switch (fontType) {
      case AppFontType.system:
        return null;
      case AppFontType.sfPro:
        return sfPro;
    }
  }
}
