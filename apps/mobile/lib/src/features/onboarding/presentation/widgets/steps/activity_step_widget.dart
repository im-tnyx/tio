import 'package:flutter/material.dart';
import '../../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../../core/widgets/selectable_card.dart';
import '../../../../../core/widgets/typewriter_text.dart';

class ActivityStepWidget extends StatefulWidget {
  const ActivityStepWidget({
    required this.selectedActivity,
    required this.onActivitySelect,
    required this.onTypingDone,
    super.key,
  });

  final String selectedActivity;
  final ValueChanged<String> onActivitySelect;
  final VoidCallback onTypingDone;

  @override
  State<ActivityStepWidget> createState() => _ActivityStepWidgetState();
}

class _ActivityStepWidgetState extends State<ActivityStepWidget> {
  bool _isTitleFinished = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedActivity.isNotEmpty) {
      _isTitleFinished = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.spaceL),
          if (widget.selectedActivity.isNotEmpty)
            Text(
              "What is your activity level?",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            )
          else
            TypewriterText(
              text: "What is your activity level?",
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
                  "Activity level calibrates your daily maintenance calories (TDEE).",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Dimens.spaceL),
                SelectableCard(
                  selected: widget.selectedActivity == 'sedentary',
                  onClick: () => widget.onActivitySelect('sedentary'),
                  child: Row(
                    children: [
                      Icon(
                        Icons.chair_alt_rounded,
                        color: widget.selectedActivity == 'sedentary'
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
                              'Sedentary',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: widget.selectedActivity == 'sedentary'
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: widget.selectedActivity == 'sedentary'
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: Dimens.spaceXXS),
                            Text(
                              'Little to no exercise, typical desk job.',
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
                  selected: widget.selectedActivity == 'light',
                  onClick: () => widget.onActivitySelect('light'),
                  child: Row(
                    children: [
                      Icon(
                        Icons.directions_walk_rounded,
                        color: widget.selectedActivity == 'light'
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
                              'Lightly Active',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: widget.selectedActivity == 'light'
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: widget.selectedActivity == 'light'
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: Dimens.spaceXXS),
                            Text(
                              'Light exercise or active standing/moving (1-3 days/week).',
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
                  selected: widget.selectedActivity == 'active',
                  onClick: () => widget.onActivitySelect('active'),
                  child: Row(
                    children: [
                      Icon(
                        Icons.directions_run_rounded,
                        color: widget.selectedActivity == 'active'
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
                              'Moderately Active',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: widget.selectedActivity == 'active'
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: widget.selectedActivity == 'active'
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: Dimens.spaceXXS),
                            Text(
                              'Intense exercise or high active steps (3-5 days/week).',
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
                  selected: widget.selectedActivity == 'very_active',
                  onClick: () => widget.onActivitySelect('very_active'),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bolt_rounded,
                        color: widget.selectedActivity == 'very_active'
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
                              'Very Active',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: widget.selectedActivity == 'very_active'
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: widget.selectedActivity == 'very_active'
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: Dimens.spaceXXS),
                            Text(
                              'Heavy physical labor or elite sports training (6-7 days/week).',
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
