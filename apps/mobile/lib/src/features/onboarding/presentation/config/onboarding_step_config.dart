import '../../domain/model/section.dart';

class OnboardingStepConfig {
  OnboardingStepConfig._();

  static int getSteps(OnboardingSection section, {String gymAccess = ''}) {
    switch (section) {
      case OnboardingSection.data:
        return 8; // Name, Gender, Age, Height, Weight, Goal, TargetWeight, Activity
    }
  }
}

