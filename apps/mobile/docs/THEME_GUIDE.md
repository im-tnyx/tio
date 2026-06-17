# TNYX Design System: Developer Theme Guide

This guide explains how to use, extend, and maintain the theme folder and token structure inside the **TNYX Mobile App**.

---

## 🎨 Theme System Architecture

The theme architecture is divided into three layers to maximize **reusability** and **consistency**:

```
                       +---------------------------------------+
                       |    Layer 3: STATE (Manager & Scope)   |
                       +-------------------+-------------------+
                                           |
                                           v
                       +-------------------+-------------------+
                       |   Layer 2: COMPONENTS (Material 3)    |
                       +-------------------+-------------------+
                                           |
                                           v
                       +-------------------+-------------------+
                       |    Layer 1: TOKENS (Foundation)       |
                       +---------------------------------------+
```

---

## 1. Layer 1: Tokens (Design Variables)

Located in [lib/src/core/theme/tokens/](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/):

### A. Foundation Tokens (Values)
These define the base hardcoded parameters (numbers, colors, shape sizes) of the design system. Never use raw hex values or padding numbers inside widgets. Use foundation tokens instead.
* **Palette** ([palette.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/foundation/palette.dart)): Core color hex definitions (e.g. `Palette.neutral950`, `Palette.white`).
* **Dimens** ([dimens.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/foundation/dimens.dart)): Global measurements (e.g. `Dimens.spaceM` spacing, `Dimens.radiusCard` radii, `Dimens.iconSizeM`).
* **Insets** ([insets.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/foundation/insets.dart)): Standard padding configurations mapped to `EdgeInsets` (e.g. `Insets.screen`, `Insets.button`).
* **Shapes** ([shapes.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/foundation/shapes.dart)): Border geometries (e.g. `Shapes.button` shapes, `Shapes.cardRadius`).

### B. Mappings
These map foundation tokens to dynamic variables depending on theme states (Light vs Dark mode).
* **Semantic Colors** ([colors.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/semantic/colors.dart)): Mapped variables like `inputFillLight` or `focusAccentLight`. Always use these colors to support light/dark modes automatically!
* **Typography** ([app_typography.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/typography/app_typography.dart)): Defines typography hierarchy styles (`displayLarge`, `bodyMedium`, etc.) mapped to font configurations in [fonts.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/fonts.dart).

---

## 2. Layer 2: Component Overrides (Material 3)

Located in [lib/src/core/theme/components/](file:///g:/Tio/apps/mobile/lib/src/core/theme/components/):

Instead of configuring component themes inside widget code, configure them globally so that standard Flutter Material 3 widgets (`Card`, `FilledButton`, `TextField`, `NavigationBar`) look correct automatically.
* **AppBars** ([app_bar_theme.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/components/app_bar_theme.dart)): System status bar styles, transparent appbar surfaces.
* **Buttons** ([app_button_theme.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/components/app_button_theme.dart)): Global standard paddings, radii, and backgrounds.
* **AppInputs** ([app_input_theme.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/components/app_input_theme.dart)): Input text field background fills, focused border indicators.
* **AppNavigations** ([app_navigation_theme.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/components/app_navigation_theme.dart)): Bottom navigation heights, indicator capsules, and labels text colors.
* **AppSheets** ([app_sheet_theme.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/components/app_sheet_theme.dart)): Bottom modal sheets drag handles and screen borders.

---

## 💡 Developer Guidelines (How to code)

### How to use colors?
Never hardcode hex values. Always retrieve colors dynamically from the Theme context:
```dart
// ❌ WRONG (Not theme-adaptive, hardcoded)
color: Colors.black,
color: Palette.neutral950,

//   RIGHT (Adapts to Light/Dark modes instantly)
color: Theme.of(context).colorScheme.surface,
color: Theme.of(context).colorScheme.onSurface,
```

### How to use padding and spacing?
Avoid raw double inputs for paddings and margins. Always use `Dimens` or `Insets`:
```dart
// ❌ WRONG
padding: EdgeInsets.all(16.0),
child: SizedBox(height: 24.0),

//   RIGHT
padding: Insets.screen,
child: SizedBox(height: Dimens.spaceL),
```

### How to reuse buttons?
Never duplicate custom configurations for buttons. Use the wrapper widgets in [action_buttons.dart](file:///g:/Tio/apps/mobile/lib/src/core/widgets/action_buttons.dart):
```dart
// Primary theme-adaptive button
PrimaryButton(
  text: 'Get Started',
  onPressed: () => print('Primary pressed'),
  expand: true,
),

// Secondary outline/glassmorphic button
SecondaryButton(
  text: 'Sign In',
  onPressed: () => print('Secondary pressed'),
  expand: true,
),
```

### How to add a new token?
1. Declare the foundation token value in [dimens.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/foundation/dimens.dart) or [palette.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/foundation/palette.dart).
2. If it is theme-adaptive, map it to a semantic variable in [colors.dart](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/semantic/colors.dart).
3. Bind the token inside the corresponding Component Theme file in `theme/components/`.
