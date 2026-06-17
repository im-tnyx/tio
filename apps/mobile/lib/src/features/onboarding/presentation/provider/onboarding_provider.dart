import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/model/onboarding_data.dart';
import '../../domain/model/flow_state.dart';
import '../../domain/model/section.dart';
import '../config/onboarding_step_config.dart';

class OnboardingProvider extends ChangeNotifier {
  OnboardingProvider() {
    _flowState = FlowState(
      flow: _flow,
      currentSectionIndex: 0,
      step: 1,
    );
    loadLocalDraft();
  }

  final List<OnboardingSection> _flow = [OnboardingSection.data];
  OnboardingData _state = const OnboardingData();
  late FlowState _flowState;
  bool _isSavingDraft = false;

  OnboardingData get state => _state;
  FlowState get flowState => _flowState;
  bool get isSavingDraft => _isSavingDraft;

  int get totalSteps {
    return OnboardingStepConfig.getSteps(
      _flowState.safeSection,
      gymAccess: _state.gymAccess,
    );
  }

  // ---------- STATE UPDATES ----------

  void updateName(String name) {
    _state = _state.copyWith(name: name);
    _saveLocal();
    notifyListeners();
  }

  void updateGender(String gender) {
    _state = _state.copyWith(gender: gender);
    _saveLocal();
    notifyListeners();
  }

  void updateGoals(List<String> goals) {
    _state = _state.copyWith(goals: goals);
    _saveLocal();
    notifyListeners();
  }

  void updateDOB(int age) {
    _state = _state.copyWith(dob: age);
    _saveLocal();
    notifyListeners();
  }

  void updateHeight(double height) {
    _state = _state.copyWith(height: height);
    _saveLocal();
    notifyListeners();
  }

  void updateWeight({required double current, required double target}) {
    _state = _state.copyWith(currentWeight: current, targetWeight: target);
    _saveLocal();
    notifyListeners();
  }

  void updateActivity(String activity) {
    _state = _state.copyWith(activityLevel: activity);
    _saveLocal();
    notifyListeners();
  }

  // ---------- VALIDATION ----------

  bool isStepValid() {
    final step = _flowState.step;
    final primaryGoals = {'lose_weight', 'build_muscle', 'keep_fit'};
    final primaryGoal = _state.goals.firstWhere(
      (g) => primaryGoals.contains(g),
      orElse: () => 'keep_fit',
    );

    switch (step) {
      case 1: // Name
        return _state.name.trim().length >= 3;
      case 2: // Gender
        return _state.gender.isNotEmpty;
      case 3: // Age / DOB
        return _state.dob > 0;
      case 4: // Height
        return _state.height > 0.0;
      case 5: // Current Weight
        return _state.currentWeight > 0.0;
      case 6: // Goal
        return _state.goals.any((g) => primaryGoals.contains(g));
      case 7: // Target Weight
        return primaryGoal == 'keep_fit' || _state.targetWeight > 0.0;
      case 8: // Activity
        return _state.activityLevel.isNotEmpty;
      default:
        return true;
    }
  }

  // ---------- NAVIGATION ----------

  /// Advances onboarding step. 
  /// Returns:
  /// - `true` if finalized and routed to home.
  /// - `false` if redirection to login screen is required.
  /// - `null` if advanced to next step normally.
  Future<bool?> nextStep() async {
    if (!isStepValid()) return null;

    final primaryGoals = {'lose_weight', 'build_muscle', 'keep_fit'};
    final primaryGoal = _state.goals.firstWhere(
      (g) => primaryGoals.contains(g),
      orElse: () => 'keep_fit',
    );

    final currentStep = _flowState.step;

    // Check if we are at the end of Section.DATA (Step 8 is Activity)
    if (currentStep == 8) {
      final currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser != null) {
        _isSavingDraft = true;
        notifyListeners();
        try {
          await finalizeProfile(currentUser);
          return true; // Complete
        } catch (e) {
          _isSavingDraft = false;
          notifyListeners();
          rethrow;
        }
      } else {
        return false; // Requires Authentication
      }
    }

    // Step progression handling conditional logic
    int nextStepVal = currentStep + 1;
    if (currentStep == 6 && primaryGoal == 'keep_fit') {
      // Skip TargetWeightScreen (Step 7) if goal is Maintenance
      nextStepVal = 8;
    }

    _flowState = _flowState.copyWith(step: nextStepVal);
    _saveLocal();
    notifyListeners();
    return null;
  }

  /// Regresses onboarding step.
  /// Returns true if exiting onboarding entirely.
  bool previousStep() {
    final currentStep = _flowState.step;
    if (currentStep == 1) {
      return true; // Exit Onboarding Screen
    }

    final primaryGoals = {'lose_weight', 'build_muscle', 'keep_fit'};
    final primaryGoal = _state.goals.firstWhere(
      (g) => primaryGoals.contains(g),
      orElse: () => 'keep_fit',
    );

    int prevStepVal = currentStep - 1;
    if (currentStep == 8 && primaryGoal == 'keep_fit') {
      // Jump back past TargetWeightScreen (Step 7) directly to Current Weight
      prevStepVal = 6;
    }

    _flowState = _flowState.copyWith(step: prevStepVal);
    _saveLocal();
    notifyListeners();
    return false;
  }

  // ---------- PERSISTENCE & DRAFTS ----------

  Future<void> _saveLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(_state.toJson());
    await prefs.setString('onboarding_draft', jsonStr);
  }

  Future<void> loadLocalDraft() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('onboarding_draft');
    if (jsonStr != null) {
      try {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
        _state = OnboardingData.fromJson(jsonMap);
        
        // Match flow index
        final primaryGoals = {'lose_weight', 'build_muscle', 'keep_fit'};
        final primaryGoal = _state.goals.firstWhere(
          (g) => primaryGoals.contains(g),
          orElse: () => 'keep_fit',
        );

        // If step was target weight (7) but goal is keep_fit, shift active index
        if (_flowState.step == 7 && primaryGoal == 'keep_fit') {
          _flowState = _flowState.copyWith(step: 6);
        }
        notifyListeners();
      } catch (e) {
        // Safe fallback
      }
    }
  }

  Future<void> clearLocalDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('onboarding_draft');
    _state = const OnboardingData();
    _flowState = _flowState.copyWith(step: 1);
    notifyListeners();
  }

  // ---------- CALCULATIONS & DATABASE SYNC ----------

  void autoCalculateTargets() {
    final weight = _state.currentWeight;
    final height = _state.height;
    final age = _state.dob; // dob variable holds selected age directly
    final gender = _state.gender;
    final primaryGoals = {'lose_weight', 'build_muscle', 'keep_fit'};
    final goal = _state.goals.firstWhere(
      (g) => primaryGoals.contains(g),
      orElse: () => 'keep_fit',
    );
    final activity = _state.activityLevel;

    // Mifflin-St Jeor formula for base BMR calculations
    double bmr = 0;
    if (gender == 'male') {
      bmr = 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      bmr = 10 * weight + 6.25 * height - 5 * age - 161;
    }

    // TDEE multipliers
    double multiplier = 1.2;
    switch (activity) {
      case 'sedentary':
        multiplier = 1.2;
        break;
      case 'light':
        multiplier = 1.375;
        break;
      case 'active':
        multiplier = 1.55;
        break;
      case 'very_active':
        multiplier = 1.725;
        break;
    }

    double calories = bmr * multiplier;

    if (goal == 'lose_weight') {
      calories -= 500;
    } else if (goal == 'build_muscle') {
      calories += 300;
    }

    final int finalCalories = calories.round().clamp(1200, 10000);

    double proteinPerKg = 1.5;
    if (goal == 'lose_weight') {
      proteinPerKg = 2.0;
    } else if (goal == 'build_muscle') {
      proteinPerKg = 2.2;
    }
    final int finalProtein = (weight * proteinPerKg).round().clamp(60, 500);
    final int finalFat = ((finalCalories * 0.25) / 9).round().clamp(40, 200);
    final int finalCarbs = ((finalCalories - (finalProtein * 4) - (finalFat * 9)) / 4).round().clamp(100, 1000);

    int steps = 6000;
    if (activity == 'light') steps = 8000;
    if (activity == 'active') steps = 10000;
    if (activity == 'very_active') steps = 12000;

    int waterMl = (weight * 35).round().clamp(2000, 4500);

    _state = _state.copyWith(
      caloriesTarget: finalCalories,
      proteinTarget: finalProtein,
      carbsTarget: finalCarbs,
      fatTarget: finalFat,
      stepTarget: steps,
      waterTarget: waterMl,
    );
  }

  Future<void> finalizeProfile(User currentUser) async {
    autoCalculateTargets();

    final supabase = Supabase.instance.client;
    final metadata = {
      'name': _state.name,
      'gender': _state.gender,
      'goal': _state.goals.isNotEmpty ? _state.goals.first : 'keep_fit',
      'targetWeight': _state.targetWeight,
      'activityLevel': _state.activityLevel,
    };

    // 1. Sync User Profile
    await supabase.from('profiles').upsert({
      'id': currentUser.id,
      'age': _state.dob,
      'height_cm': _state.height,
      'weight_kg': _state.currentWeight,
      'goals_metadata': metadata,
      'updated_at': DateTime.now().toIso8601String(),
    });

    // 2. Sync Custom Calibrated Targets
    await supabase.from('nutrition_targets').upsert({
      'user_id': currentUser.id,
      'calories': _state.caloriesTarget,
      'protein_g': _state.proteinTarget,
      'carbs_g': _state.carbsTarget,
      'fat_g': _state.fatTarget,
      'fiber_g': 30,
      'water_target_ml': _state.waterTarget,
      'steps_target': _state.stepTarget,
      'updated_at': DateTime.now().toIso8601String(),
    });

    // Clean up draft states
    _isSavingDraft = false;
    _state = _state.copyWith(isDataComplete: true);
    await clearLocalDraft();
  }
}
