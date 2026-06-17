# Onboarding Architecture & Implementation Plan (Nutrition Focus)

This document outlines the architecture for the `Tio` Flutter mobile onboarding wizard, adapted from the modular design used in `Tnyx-hub/apps/android/mobile`.

---

## 🗺️ Architectural Concept

To make the onboarding flow highly scalable, maintainable, and extensible (so we can easily add new sections and steps as the app grows), we will mirror the native Android architecture in Flutter/Dart using:

1. **`OnboardingStepConfig`**: A configuration manager that defines the steps dynamically (e.g. total step count, active screens).
2. **`OnboardingContainer`**: The master widget hosting the onboarding flow, managing the current step index, page transitions (back/next buttons), and draft saving.
3. **`OnboardingSectionRenderer`**: A dispatcher that determines which screen widget to render based on the current section and step index.
4. **`OnboardingViewModel` / `OnboardingState`**: A state manager tracking input fields and checking if the current screen's inputs are valid (`StepValidator`).
5. **Theme & Component Integration**: Consuming `Tio`'s custom design system found in `core/theme` (fonts, palette, dimensions) and custom UI buttons (`core/widgets/action_buttons.dart`).

---

## 🥦 Nutrition-Focused `DATA` Section Setup

As requested, **only the `DATA` section** will be implemented, and it will be stripped down to only contain screens relevant for a **nutrition and meal intelligence app**. 

Here is the exact step sequence we will support:

| Step | Screen Name | Description & Purpose |
|------|-------------|-----------------------|
| **1** | `NameScreen` | Personalization & user greeting. |
| **2** | `GenderScreen` | Crucial for calculating Base Metabolic Rate (BMR) using Mifflin-St Jeor or Harris-Benedict formulas. |
| **3** | `AgeScreen` | Used in the BMR calculation formula. |
| **4** | `HeightScreen` | Used in BMR calculation and BMI tracking. |
| **5** | `WeightScreen` | Starting/current weight used in calorie calculations and tracking progress. |
| **6** | `GoalScreen` | Main objective selection: *Lose Weight*, *Gain Muscle*, or *Maintain Weight*. |
| **7** | `TargetWeightScreen` | Target weight input (only shown/relevant if the Goal is *Lose Weight* or *Gain Muscle*). |
| **8** | `ActivityLevelScreen` | Selection of daily activity level (Sedentary, Lightly Active, Active, Very Active) to compute TDEE (Total Daily Energy Expenditure). |

*Note: All workout access screens, equipment selection, sleep targets, and water targets from Tnyx-hub are skipped.*

---

## 🛠️ Modular Component Design in Flutter

### 1. Step Configuration Model
```dart
enum OnboardingSection { data }

class OnboardingStepConfig {
  static int getSteps(OnboardingSection section, {required String goal}) {
    switch (section) {
      case OnboardingSection.data:
        // If the goal is maintenance ("Maintain Weight"), target weight step is skipped
        return goal == 'maintain' ? 7 : 8;
    }
  }

  static String getStepIdentifier(int stepIndex, {required String goal}) {
    final steps = [
      'NAME',
      'GENDER',
      'AGE',
      'HEIGHT',
      'WEIGHT',
      'GOAL',
      if (goal != 'maintain') 'TARGET_WEIGHT',
      'ACTIVITY',
    ];
    return steps[stepIndex - 1];
  }
}
```

### 2. State & State Validation (`StepValidator`)
Each screen has custom validation parameters managed by `StepValidator`:
* **NAME**: Checks that the name is not empty and has a minimum length.
* **GENDER**: Checks that a value (`male`, `female`, `other`) is selected.
* **AGE**: Validates that age is numeric, positive, and within reasonable limits (e.g. 13-100).
* **HEIGHT**: Validates height (cm) range.
* **WEIGHT**: Validates current weight (kg) range.
* **GOAL**: Validates that a goal is chosen.
* **TARGET_WEIGHT**: Ensures target weight is positive and logically consistent with the goal (e.g., target weight is lower than current weight if goal is "lose_weight").
* **ACTIVITY**: Checks that activity factor multiplier is selected.

---

## 🎨 Theme & Component Directory Hierarchy

The implementation will strictly consume the following folders in `apps/mobile/lib/src`:
* **Design Tokens & Theme**: [core/theme/tokens/](file:///g:/Tio/apps/mobile/lib/src/core/theme/tokens/) (`dimens.dart`, `palette.dart`, `colors.dart`, `app_typography.dart`)
* **Custom Widgets**: [core/widgets/](file:///g:/Tio/apps/mobile/lib/src/core/widgets/) (`action_buttons.dart` for custom `PrimaryButton`, `SecondaryButton`, and custom text inputs).

## 🔐 Authentication Integration & Gate

To maximize user conversion, the onboarding flow is started **offline** (without requiring registration). The user is only prompted to authenticate at the end of the `DATA` section:

1. **Pre-Auth Questionnaire**: The user fills out steps 1-8 (Name, Gender, Age, Height, Weight, Goal, Target Weight, and Activity).
2. **Auth Gate**: Upon clicking "Next" on the final step (Activity Level):
   * If the user is **not** logged in, the `OnboardingContainer` routes them to the Login/Signup wizard (`/login`).
   * The viewmodel retains all filled-out onboarding information.
3. **Draft Sync (Post-Auth)**:
   * Once the user registers or logs in successfully, the captured onboarding data is pushed to the database (`profiles` table).
   * After data sync completes, they are automatically navigated to the home dashboard (`/main`).

## 🚀 Future Extensibility

Since we are modeling this directly on `Tnyx-hub`'s architecture:
* If we need to add a **WORKOUT** section in the future, we just add `OnboardingSection.workout` to the enum, define the steps in `OnboardingStepConfig`, and add `WorkoutSection` rendering to our `OnboardingSectionRenderer`.
* The `OnboardingContainer` and core navigation code will remain clean and unchanged.

