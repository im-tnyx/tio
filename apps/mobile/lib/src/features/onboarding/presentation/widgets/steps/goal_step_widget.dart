import 'package:flutter/material.dart';
import '../../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../../core/widgets/selectable_card.dart';
import '../../../../../core/widgets/typewriter_text.dart';

class GoalStepWidget extends StatefulWidget {
  const GoalStepWidget({
    required this.selectedGoals,
    required this.onGoalSelect,
    required this.onTypingDone,
    super.key,
  });

  final List<String> selectedGoals;
  final ValueChanged<List<String>> onGoalSelect;
  final VoidCallback onTypingDone;

  @override
  State<GoalStepWidget> createState() => _GoalStepWidgetState();
}

class _GoalStepWidgetState extends State<GoalStepWidget> {
  bool _isTitleFinished = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedGoals.isNotEmpty) {
      _isTitleFinished = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentGoal = widget.selectedGoals.isNotEmpty ? widget.selectedGoals.first : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.spaceL),
          if (widget.selectedGoals.isNotEmpty)
            Text(
              "What is your primary goal?",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            )
          else
            TypewriterText(
              text: "What is your primary goal?",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              color: theme.colorScheme.onSurface,
              onTypingFinished: () {
                setState(() {
                  _isTitleFinished = true;
                });
                widget.onTypingDone();
              },
            ),
          const SizedBox(height: Dimens.spaceS),
          AnimatedOpacity(
            opacity: _isTitleFinished ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We customize your target daily calories and macros based on this goal.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Dimens.spaceL),
                SelectableCard(
                  selected: currentGoal == 'lose_weight',
                  onClick: () => widget.onGoalSelect(['lose_weight']),
                  child: Row(
                    children: [
                      Icon(
                        Icons.trending_down_rounded,
                        color: currentGoal == 'lose_weight'
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                        size: Dimens.iconSizeM,
                      ),
                      const SizedBox(width: Dimens.spaceM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lose Weight',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: currentGoal == 'lose_weight'
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: currentGoal == 'lose_weight'
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: Dimens.spaceXXS),
                            Text(
                              'Reduce fat, lean down, and feel lighter.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.spaceM),
                SelectableCard(
                  selected: currentGoal == 'build_muscle',
                  onClick: () => widget.onGoalSelect(['build_muscle']),
                  child: Row(
                    children: [
                      Icon(
                        Icons.fitness_center_rounded,
                        color: currentGoal == 'build_muscle'
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                        size: Dimens.iconSizeM,
                      ),
                      const SizedBox(width: Dimens.spaceM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Build Muscle',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: currentGoal == 'build_muscle'
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: currentGoal == 'build_muscle'
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: Dimens.spaceXXS),
                            Text(
                              'Gain strength, increase mass, and tone.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.spaceM),
                SelectableCard(
                  selected: currentGoal == 'keep_fit',
                  onClick: () => widget.onGoalSelect(['keep_fit']),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_rounded,
                        color: currentGoal == 'keep_fit'
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                        size: Dimens.iconSizeM,
                      ),
                      const SizedBox(width: Dimens.spaceM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Maintain Weight',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: currentGoal == 'keep_fit'
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: currentGoal == 'keep_fit'
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: Dimens.spaceXXS),
                            Text(
                              'Improve overall fitness and maintain composition.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
