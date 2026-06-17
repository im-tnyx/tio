class OnboardingData {
  const OnboardingData({
    this.language = 'en',
    this.name = '',
    this.mobile = '',
    this.isMobileAgreed = false,
    this.gender = '',
    this.dob = 0,
    this.height = 0.0,
    this.currentWeight = 0.0,
    this.targetWeight = 0.0,
    this.activityLevel = '',
    this.goals = const [],
    this.healthConditions = const [],
    this.otherHealthCondition = '',
    this.workoutDecision = '',
    this.gymAccess = '',
    this.equipment = const [],
    this.experienceLevel = '',
    this.focusAreas = const [],
    this.trainingDays = const [],
    this.workoutDuration = '',
    this.workoutSplit = '',
    this.specialEvent = '',
    this.healthConcerns = '',
    this.stepTarget = 0,
    this.sleepTarget = 0,
    this.sleepTime = '22:00',
    this.wakeTime = '06:00',
    this.waterTarget = 0,
    this.caloriesTarget = 0,
    this.proteinTarget = 0,
    this.carbsTarget = 0,
    this.fatTarget = 0,
    this.fiberTarget = 0,
    this.goalPaceKgPerWeek = 0.5,
    this.aboutUs = '',
    this.otherAboutUsText = '',
    this.referral = '',
    this.isDataComplete = false,
    this.isGoalPaceBlocked = false,
  });

  final String language;
  final String name;
  final String mobile;
  final bool isMobileAgreed;
  final String gender;
  final int dob; // Holds Age in Years directly for simplify BMR calculations
  final double height;
  final double currentWeight;
  final double targetWeight;
  final String activityLevel;
  final List<String> goals;
  final List<String> healthConditions;
  final String otherHealthCondition;
  final String workoutDecision;
  final String gymAccess;
  final List<String> equipment;
  final String experienceLevel;
  final List<String> focusAreas;
  final List<String> trainingDays;
  final String workoutDuration;
  final String workoutSplit;
  final String specialEvent;
  final String healthConcerns;
  final int stepTarget;
  final int sleepTarget;
  final String sleepTime;
  final String wakeTime;
  final int waterTarget;
  final int caloriesTarget;
  final int proteinTarget;
  final int carbsTarget;
  final int fatTarget;
  final int fiberTarget;
  final double goalPaceKgPerWeek;
  final String aboutUs;
  final String otherAboutUsText;
  final String referral;
  final bool isDataComplete;
  final bool isGoalPaceBlocked;

  OnboardingData copyWith({
    String? language,
    String? name,
    String? mobile,
    bool? isMobileAgreed,
    String? gender,
    int? dob,
    double? height,
    double? currentWeight,
    double? targetWeight,
    String? activityLevel,
    List<String>? goals,
    List<String>? healthConditions,
    String? otherHealthCondition,
    String? workoutDecision,
    String? gymAccess,
    List<String>? equipment,
    String? experienceLevel,
    List<String>? focusAreas,
    List<String>? trainingDays,
    String? workoutDuration,
    String? workoutSplit,
    String? specialEvent,
    String? healthConcerns,
    int? stepTarget,
    int? sleepTarget,
    String? sleepTime,
    String? wakeTime,
    int? waterTarget,
    int? caloriesTarget,
    int? proteinTarget,
    int? carbsTarget,
    int? fatTarget,
    int? fiberTarget,
    double? goalPaceKgPerWeek,
    String? aboutUs,
    String? otherAboutUsText,
    String? referral,
    bool? isDataComplete,
    bool? isGoalPaceBlocked,
  }) {
    return OnboardingData(
      language: language ?? this.language,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      isMobileAgreed: isMobileAgreed ?? this.isMobileAgreed,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      height: height ?? this.height,
      currentWeight: currentWeight ?? this.currentWeight,
      targetWeight: targetWeight ?? this.targetWeight,
      activityLevel: activityLevel ?? this.activityLevel,
      goals: goals ?? this.goals,
      healthConditions: healthConditions ?? this.healthConditions,
      otherHealthCondition: otherHealthCondition ?? this.otherHealthCondition,
      workoutDecision: workoutDecision ?? this.workoutDecision,
      gymAccess: gymAccess ?? this.gymAccess,
      equipment: equipment ?? this.equipment,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      focusAreas: focusAreas ?? this.focusAreas,
      trainingDays: trainingDays ?? this.trainingDays,
      workoutDuration: workoutDuration ?? this.workoutDuration,
      workoutSplit: workoutSplit ?? this.workoutSplit,
      specialEvent: specialEvent ?? this.specialEvent,
      healthConcerns: healthConcerns ?? this.healthConcerns,
      stepTarget: stepTarget ?? this.stepTarget,
      sleepTarget: sleepTarget ?? this.sleepTarget,
      sleepTime: sleepTime ?? this.sleepTime,
      wakeTime: wakeTime ?? this.wakeTime,
      waterTarget: waterTarget ?? this.waterTarget,
      caloriesTarget: caloriesTarget ?? this.caloriesTarget,
      proteinTarget: proteinTarget ?? this.proteinTarget,
      carbsTarget: carbsTarget ?? this.carbsTarget,
      fatTarget: fatTarget ?? this.fatTarget,
      fiberTarget: fiberTarget ?? this.fiberTarget,
      goalPaceKgPerWeek: goalPaceKgPerWeek ?? this.goalPaceKgPerWeek,
      aboutUs: aboutUs ?? this.aboutUs,
      otherAboutUsText: otherAboutUsText ?? this.otherAboutUsText,
      referral: referral ?? this.referral,
      isDataComplete: isDataComplete ?? this.isDataComplete,
      isGoalPaceBlocked: isGoalPaceBlocked ?? this.isGoalPaceBlocked,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'name': name,
      'mobile': mobile,
      'isMobileAgreed': isMobileAgreed,
      'gender': gender,
      'dob': dob,
      'height': height,
      'currentWeight': currentWeight,
      'targetWeight': targetWeight,
      'activityLevel': activityLevel,
      'goals': goals,
      'healthConditions': healthConditions,
      'otherHealthCondition': otherHealthCondition,
      'workoutDecision': workoutDecision,
      'gymAccess': gymAccess,
      'equipment': equipment,
      'experienceLevel': experienceLevel,
      'focusAreas': focusAreas,
      'trainingDays': trainingDays,
      'workoutDuration': workoutDuration,
      'workoutSplit': workoutSplit,
      'specialEvent': specialEvent,
      'healthConcerns': healthConcerns,
      'stepTarget': stepTarget,
      'sleepTarget': sleepTarget,
      'sleepTime': sleepTime,
      'wakeTime': wakeTime,
      'waterTarget': waterTarget,
      'caloriesTarget': caloriesTarget,
      'proteinTarget': proteinTarget,
      'carbsTarget': carbsTarget,
      'fatTarget': fatTarget,
      'fiberTarget': fiberTarget,
      'goalPaceKgPerWeek': goalPaceKgPerWeek,
      'aboutUs': aboutUs,
      'otherAboutUsText': otherAboutUsText,
      'referral': referral,
      'isDataComplete': isDataComplete,
      'isGoalPaceBlocked': isGoalPaceBlocked,
    };
  }

  factory OnboardingData.fromJson(Map<String, dynamic> json) {
    return OnboardingData(
      language: json['language'] as String? ?? 'en',
      name: json['name'] as String? ?? '',
      mobile: json['mobile'] as String? ?? '',
      isMobileAgreed: json['isMobileAgreed'] as bool? ?? false,
      gender: json['gender'] as String? ?? '',
      dob: json['dob'] as int? ?? 0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      currentWeight: (json['currentWeight'] as num?)?.toDouble() ?? 0.0,
      targetWeight: (json['targetWeight'] as num?)?.toDouble() ?? 0.0,
      activityLevel: json['activityLevel'] as String? ?? '',
      goals: (json['goals'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      healthConditions: (json['healthConditions'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      otherHealthCondition: json['otherHealthCondition'] as String? ?? '',
      workoutDecision: json['workoutDecision'] as String? ?? '',
      gymAccess: json['gymAccess'] as String? ?? '',
      equipment: (json['equipment'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      experienceLevel: json['experienceLevel'] as String? ?? '',
      focusAreas: (json['focusAreas'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      trainingDays: (json['trainingDays'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      workoutDuration: json['workoutDuration'] as String? ?? '',
      workoutSplit: json['workoutSplit'] as String? ?? '',
      specialEvent: json['specialEvent'] as String? ?? '',
      healthConcerns: json['healthConcerns'] as String? ?? '',
      stepTarget: json['stepTarget'] as int? ?? 0,
      sleepTarget: json['sleepTarget'] as int? ?? 0,
      sleepTime: json['sleepTime'] as String? ?? '22:00',
      wakeTime: json['wakeTime'] as String? ?? '06:00',
      waterTarget: json['waterTarget'] as int? ?? 0,
      caloriesTarget: json['caloriesTarget'] as int? ?? 0,
      proteinTarget: json['proteinTarget'] as int? ?? 0,
      carbsTarget: json['carbsTarget'] as int? ?? 0,
      fatTarget: json['fatTarget'] as int? ?? 0,
      fiberTarget: json['fiberTarget'] as int? ?? 0,
      goalPaceKgPerWeek: (json['goalPaceKgPerWeek'] as num?)?.toDouble() ?? 0.5,
      aboutUs: json['aboutUs'] as String? ?? '',
      otherAboutUsText: json['otherAboutUsText'] as String? ?? '',
      referral: json['referral'] as String? ?? '',
      isDataComplete: json['isDataComplete'] as bool? ?? false,
      isGoalPaceBlocked: json['isGoalPaceBlocked'] as bool? ?? false,
    );
  }
}
