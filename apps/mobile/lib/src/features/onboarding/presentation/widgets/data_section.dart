import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/onboarding_provider.dart';
import 'steps/name_step_widget.dart';
import 'steps/gender_step_widget.dart';
import 'steps/age_step_widget.dart';
import 'steps/height_step_widget.dart';
import 'steps/weight_step_widget.dart';
import 'steps/goal_step_widget.dart';
import 'steps/target_weight_step_widget.dart';
import 'steps/activity_step_widget.dart';

class DataSection extends StatelessWidget {
  const DataSection({
    required this.step,
    required this.onTypingDone,
    super.key,
  });

  final int step;
  final VoidCallback onTypingDone;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnboardingProvider>(context);

    switch (step) {
      case 1:
        return NameStepWidget(
          name: provider.state.name,
          onNameChange: provider.updateName,
          onTypingDone: onTypingDone,
        );
      case 2:
        return GenderStepWidget(
          selectedGender: provider.state.gender,
          onGenderSelect: provider.updateGender,
          onTypingDone: onTypingDone,
        );
      case 3:
        return AgeStepWidget(
          age: provider.state.dob,
          onAgeSelect: provider.updateDOB,
          onTypingDone: onTypingDone,
        );
      case 4:
        return HeightStepWidget(
          heightCm: provider.state.height,
          onHeightSelect: provider.updateHeight,
          onTypingDone: onTypingDone,
        );
      case 5:
        return WeightStepWidget(
          heightCm: provider.state.height,
          weightKg: provider.state.currentWeight,
          onWeightSelect: (w) => provider.updateWeight(current: w, target: provider.state.targetWeight),
          onTypingDone: onTypingDone,
        );
      case 6:
        return GoalStepWidget(
          selectedGoals: provider.state.goals,
          onGoalSelect: provider.updateGoals,
          onTypingDone: onTypingDone,
        );
      case 7:
        return TargetWeightStepWidget(
          currentWeightKg: provider.state.currentWeight,
          targetWeightKg: provider.state.targetWeight,
          onTargetWeightSelect: (w) => provider.updateWeight(current: provider.state.currentWeight, target: w),
          onTypingDone: onTypingDone,
        );
      case 8:
        return ActivityStepWidget(
          selectedActivity: provider.state.activityLevel,
          onActivitySelect: provider.updateActivity,
          onTypingDone: onTypingDone,
        );
      default:
        return Center(
          child: Text('Step $step not implemented yet'),
        );
    }
  }
}
