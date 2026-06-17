import 'package:flutter/material.dart';
import '../../domain/model/section.dart';
import 'data_section.dart';

class SectionRenderer extends StatelessWidget {
  const SectionRenderer({
    required this.section,
    required this.step,
    required this.onTypingDone,
    super.key,
  });

  final OnboardingSection section;
  final int step;
  final VoidCallback onTypingDone;

  @override
  Widget build(BuildContext context) {
    switch (section) {
      case OnboardingSection.data:
        return DataSection(
          step: step,
          onTypingDone: onTypingDone,
        );
      default:
        return Center(
          child: Text('Section $section, Step $step not implemented yet'),
        );
    }
  }
}
