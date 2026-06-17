import '../../domain/model/section.dart';

class OnboardingStepConfig {
  OnboardingStepConfig._();

  static int getSteps(OnboardingSection section, {String gymAccess = ''}) {
    switch (section) {
      case OnboardingSection.intro:
        return 5;
      case OnboardingSection.data:
        return 9;
      case OnboardingSection.mobile:
        return 1;
      case OnboardingSection.workoutIntro:
        return 1;
      case OnboardingSection.workout:
        return gymAccess == 'home' ? 9 : 8;
      case OnboardingSection.targets:
        return 6;
      case OnboardingSection.source:
        return 2;
    }
  }

  static String? getWorkoutStep(int step, String gymAccess) {
    final steps = <String>[
      'GYM',
      if (gymAccess == 'home') 'EQUIPMENT',
      'EXPERIENCE',
      'FOCUS',
      'DAYS',
      'DURATION',
      'SPLIT',
      'HEALTH',
      'EVENT',
    ];

    if (step - 1 >= 0 && step - 1 < steps.length) {
      return steps[step - 1];
    }
    return null;
  }
}
