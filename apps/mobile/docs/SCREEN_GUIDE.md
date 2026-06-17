# UI Spec & Screen Architecture Guide: Home & Nutrition

This document outlines the detailed architecture and UI widgets for the **Home Dashboard**, **Nutrition Calendar/Diary**, **Meal Editor**, and **Global Navigation Bars** (TopBar & BottomNav), based on the production-grade Flutter design in `G:\Tnyx-hub\apps\flutter`.

---

## 🎨 Global Layout Shell (`main_shell.dart`)

The entire app navigation uses a floating, transparent structural layout that overlays the active screens. The app body consists of the current screen stacked under a dynamic `MainTopBar` and a floating `MainBottomNav`.

### 1. Dynamic TopBar (`main_top_bar.dart`)
Instead of a static AppBar, the top bar is a custom-animated header (`TnyxDynamicHeader`):
* **Scroll-Adaptive Opacity**: The background opacity fades in/out dynamically based on the scroll offset (`scrollOpacity`) of the active screen.
* **Premium Badge**: A pill badge in the center that dynamically styles itself based on the user's plan tier (Bolt icon for *Plus*, Star icon for *Premium* with custom glow/box-shadow).
* **Right Quick-Actions**:
  * **Streak Indicator**: A warning-orange fire icon displaying the daily streak.
  * **Profile Avatar**: A circular avatar button navigating to the profile screen.

### 2. Glassmorphic Sliding BottomNav (`main_bottom_nav.dart`)
A custom-built, floating bottom bar rather than the standard system bottom bar, simplified for the nutrition focus:
* **Glassmorphism (Glass Effect)**: Uses `BackdropFilter` with `ImageFilter.blur(sigmaX: 10, sigmaY: 10)` over a semi-transparent surface.
* **Floating Pill Layout**: Positioned with custom horizontal margins and rounded corners (`BorderRadius.circular(30)`) to float above the content.
* **Animated Sliding Highlight**: An `AnimatedPositioned` container smoothly slides behind the active tab icon with a standard cubic bezier curve transition.
* **Simplified 3-Tab Structure**: Removed the **Workout** and **AI Center (TnyxParticle)** tabs. The navigation bar features only three tabs:
  1. **Home**: Primary metrics dashboard.
  2. **Nutrition**: Date-driven food logging and meal diary.
  3. **Progress**: Visual logs and weight/nutrition trends.


---

## 🏠 Home Dashboard (`home_screen.dart`)

Designed as a vertical dashboard utilizing `CustomScrollView` and sliver widgets:

1. **Premium Hero Header**:
   * A large rounded container at the top holding the current metrics summary.
   * **`HomeNotificationCard`**: Dismissible warnings or suggestions (e.g. *"Log your breakfast"*).
   * **`HomeStatsCard`**: Large card showing daily overall progress.
   * **`HomeTargetsCard`**: Card outlining targets (steps, water, sleep).
2. **Nutrition Circle & Stats Pager**:
   * A horizontal `PageView` showing:
     * **Calories Card**: Macro rings (calories remaining, consumed, burned).
     * **Macros Card**: Detailed breakdown of Protein, Carbs, Fat, and Fiber.
     * **Vitamins Card**: Micronutrients status.
3. **Daily Action Triggers**:
   * **Water Tracker**: Quick add water card.
   * **Activity Feed**: Dynamic step counts and calories burned.
   * **Recovery Feed**: Schlaf/Sleep parameters and rest scores.
   * **Discover Feed**: Articles and tips.
4. **Expandable Meal FAB**:
   * Bottom-right floating action button that opens a menu for logging (Text, Voice, Barcode, Search).

---

## 🥦 Nutrition Date Diary (`nutrition_screen.dart` & `nutrition_meal_diary_screen.dart`)

The dedicated nutrition center is date-driven, enabling logs retrieval for past days.

### 1. Pinned Weekly Calendar
* Utilizes a `NestedScrollView` containing a `SliverPersistentHeader`.
* Renders a `TnyxWeeklyCalendar` pinned to the top. Swiping left/right changes weeks; tapping a day updates the selected date, which triggers the ViewModel to fetch and display meal logs for that day.

### 2. Interactive Meal Diary
* **Nutrient Grid**: Progress bars for daily Protein (g), Carbs (g), Fat (g), and Fiber (g).
* **Grouped Meal Feed**: Iterates through logged items and groups them under headings:
  * **BREAKFAST**
  * **LUNCH**
  * **DINNER**
  * **SNACKS**
* **`NutritionMealCard`**: Individual cards under each category showing the name, serving size, image (if uploaded), and calorie count. Tapping a card opens the **Meal Editor**.

---

## 📝 Meal & Ingredient Editor (`meal_edit_screen.dart`)

Provides granular editing of ingredients and quantities rather than just updating the description:

```
+------------------------------------------+
|  <-  Edit your meal              [Share] |
+------------------------------------------+
|  [Add Image]   Meal Name: Double Roti    |
|                1 Serving         [Edit]  |
|                "This meal is light..."   |
|                                          |
|  [  P: 12g  ] [  C: 45g  ] [  F: 8g  ]   |
|                                          |
|  ITEMS                       [Add Item+] |
|  - Whole Wheat Flour  (120g)   [Change]  |
|  - Salt               (2g)     [Delete]  |
|  - Water              (80ml)   [Change]  |
+------------------------------------------+
|  [Category: LUNCH v]       [Feb 5, 20:35] |
|  [ Add Hint ]              [ Save Meal ] |
+------------------------------------------+
```

1. **Hero Header**:
   * **Image Uploader**: Button to add or update the meal image.
   * **Edit Name Dialog**: Popup to change the meal name.
2. **Macronutrient Breakdown**:
   * Displays the combined macro values for all items inside the meal.
3. **Granular Items Editor**:
   * Lists every individual ingredient in the meal.
   * Users can tap an item to open `MealItemEditRoute` or use inline triggers to change quantity, edit units (g, ml, serving), or delete the ingredient.
   * Includes an **Add Item +** button to search and append new food items to the meal.
4. **Action Bottom Bar**:
   * **Category Dropdown**: Change meal classification.
   * **Timestamp**: Set logging date and time.
   * **Hint Input**: Add logging context/notes.
   * **Save Meal Button**: Persist all modified ingredients and macros to the database.
