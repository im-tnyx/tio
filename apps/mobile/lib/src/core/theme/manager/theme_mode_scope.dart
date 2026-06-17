import 'package:flutter/widgets.dart';
import 'package:tnyx/src/core/theme/manager/theme_mode_manager.dart';

class ThemeModeScope extends InheritedNotifier<ThemeModeManager> {
  const ThemeModeScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static ThemeModeManager watch(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeModeScope>();
    assert(scope?.notifier != null, 'ThemeModeScope not found in widget tree.');
    return scope!.notifier!;
  }

  static ThemeModeManager read(BuildContext context) {
    final element =
        context.getElementForInheritedWidgetOfExactType<ThemeModeScope>();
    final scope = element?.widget as ThemeModeScope?;
    assert(scope?.notifier != null, 'ThemeModeScope not found in widget tree.');
    return scope!.notifier!;
  }
}


