# TNYX Project: Phase 1 Work Summary

This document provides a summary of all the modifications, bugs resolved, and layouts designed in Phase 1 of the **TNYX Mobile App**.

---

## 🛠️ Summary of Work Done

### 1. Theme Mode Management Integration
- **Bug**: The dynamic theme loader (`ThemeModeManager`) and tree scope (`ThemeModeScope`) were implemented but disconnected from the bootstrap lifecycle. The theme mode was hardcoded to `ThemeMode.system`.
- **Fix**: 
  - Integrated `ThemeModeManager` in [main.dart](file:///g:/Tio/apps/mobile/lib/src/main.dart) to load saved user preferences at startup and wrapped the application inside `ThemeModeScope`.
  - Bound the `MaterialApp.router`'s `themeMode` in [app.dart](file:///g:/Tio/apps/mobile/lib/src/app/app.dart) to the dynamic scope notifier (with a safe fallback using `dependOnInheritedWidgetOfExactType` so that tests running standalone widgets do not throw errors).

### 2. Contrast & Theme Accessibility Fixes
- **Active Navigation Indicator**: In light mode, active tab text and icons turned white on a white/light gray background. Resolved by splitting selection tokens into `selectionAccentLight` (black) and `selectionAccentDark` (white) inside [colors.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/semantic/colors.dart).
- **Text Field Focus Boundary**: Light mode text field focused borders were set to white, blending into the white background. Fixed by splitting focus tokens into `focusAccentLight` (black) and `focusAccentDark` (white).
- **Theme-Adaptive Primary Buttons**: In [action_buttons.dart](file:///g:/Tio/apps/mobile/lib/src/core/widgets/action_buttons.dart), `PrimaryButton` was refactored to use dynamic theme-derived values (`onSurface` for background and `surface` for text) to avoid disappearing on white backdrops.

### 3. Welcome Screen Redesign & Modularization
The Welcome Screen has been completely updated to match the mockup designs and split into modular, reusable components inside [presentation/widgets/](file:///g:/Tio/apps/mobile/lib/src/features/welcome/presentation/widgets/):
- **[welcome_backdrop.dart](file:///g:/Tio/apps/mobile/lib/src/features/welcome/presentation/widgets/welcome_backdrop.dart)**: Renders dynamic gradient backdrop overlays that adapt to light and dark theme background colors.
- **[welcome_header.dart](file:///g:/Tio/apps/mobile/lib/src/features/welcome/presentation/widgets/welcome_header.dart)**: Displays the top salad banner image with a bottom gradient fading overlay.
- **[welcome_top_bar.dart](file:///g:/Tio/apps/mobile/lib/src/features/welcome/presentation/widgets/welcome_top_bar.dart)**: Renders the language selector ("EN") and "Skip" controls using clean splash ink ripple effects.
- **[welcome_features_list.dart](file:///g:/Tio/apps/mobile/lib/src/features/welcome/presentation/widgets/welcome_features_list.dart)**: Displays the bold core heading and app feature checklist using rounded white check marks.
- **[welcome_footer.dart](file:///g:/Tio/apps/mobile/lib/src/features/welcome/presentation/widgets/welcome_footer.dart)**: Formats and centers the legal/privacy policy link texts.

### 4. Layout Adaptability & Padding Safeties
- Refactored [welcome_screen.dart](file:///g:/Tio/apps/mobile/lib/src/features/welcome/presentation/screen/welcome_screen.dart) to use a non-scrollable dynamic `Column` + `Spacer` layout that adapts dynamically to different screen aspect ratios without overflowing.
- Wrapped the bottom controls in a `SafeArea(top: false)` to respect the system navigation bar (home indicator bar) padding, preventing overlap with modern gesture bars.

### 5. Self-Contained Local Execution Tools
- **[run_mobile_debug.bat](file:///g:/Tio/run_mobile_debug.bat)**: Implemented a one-click local runner script that maps `PUB_CACHE` and `ANDROID_HOME` to the G: drive `dev/` directory to ensure local SDKs and packages are used. Added the target entrypoint flag `-t lib/src/main.dart` for execution.
- **[.vscode/settings.json](file:///g:/Tio/.vscode/settings.json)**: Created VS Code settings mapping `"dart.flutterSdkPath"` to `"dev/flutter-sdk"`.
- **[.vscode/launch.json](file:///g:/Tio/.vscode/launch.json)**: Corrected launcher paths targeting `lib/src/main.dart` so F5 debug hot reload works automatically out-of-the-box.

---

## 📈 Quality Verification Status
- **Static Analysis**: `flutter analyze` runs successfully with **0 errors and 0 warnings**.
- **Widget Tests**: All widget test suites compile and pass successfully.
