import 'section.dart';

class FlowState {
  const FlowState({
    required this.flow,
    required this.currentSectionIndex,
    required this.step,
    this.isAuthRequired = false,
  });

  final List<OnboardingSection> flow;
  final int currentSectionIndex;
  final int step;
  final bool isAuthRequired;

  OnboardingSection get safeSection {
    if (currentSectionIndex >= 0 && currentSectionIndex < flow.length) {
      return flow[currentSectionIndex];
    }
    return OnboardingSection.data;
  }

  FlowState copyWith({
    List<OnboardingSection>? flow,
    int? currentSectionIndex,
    int? step,
    bool? isAuthRequired,
  }) {
    return FlowState(
      flow: flow ?? this.flow,
      currentSectionIndex: currentSectionIndex ?? this.currentSectionIndex,
      step: step ?? this.step,
      isAuthRequired: isAuthRequired ?? this.isAuthRequired,
    );
  }
}
