import 'package:flutter/material.dart';
import '../../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../../core/widgets/selectable_card.dart';
import '../../../../../core/widgets/typewriter_text.dart';

class GenderStepWidget extends StatefulWidget {
  const GenderStepWidget({
    required this.selectedGender,
    required this.onGenderSelect,
    required this.onTypingDone,
    super.key,
  });

  final String selectedGender;
  final ValueChanged<String> onGenderSelect;
  final VoidCallback onTypingDone;

  @override
  State<GenderStepWidget> createState() => _GenderStepWidgetState();
}

class _GenderStepWidgetState extends State<GenderStepWidget> {
  bool _isTitleFinished = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedGender.isNotEmpty) {
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
          if (widget.selectedGender.isNotEmpty)
            Text(
              "Select biological gender",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            )
          else
            TypewriterText(
              text: "Select biological gender",
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
                  "Used to calculate baseline metabolism accurately.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Dimens.spaceL),
                SelectableCard(
                  selected: widget.selectedGender == 'male',
                  onClick: () => widget.onGenderSelect('male'),
                  child: Row(
                    children: [
                      Icon(
                        Icons.male_rounded,
                        color: widget.selectedGender == 'male'
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                        size: Dimens.iconSizeM,
                      ),
                      const SizedBox(width: Dimens.spaceM),
                      Text(
                        'Male',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: widget.selectedGender == 'male'
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: widget.selectedGender == 'male'
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.spaceM),
                SelectableCard(
                  selected: widget.selectedGender == 'female',
                  onClick: () => widget.onGenderSelect('female'),
                  child: Row(
                    children: [
                      Icon(
                        Icons.female_rounded,
                        color: widget.selectedGender == 'female'
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                        size: Dimens.iconSizeM,
                      ),
                      const SizedBox(width: Dimens.spaceM),
                      Text(
                        'Female',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: widget.selectedGender == 'female'
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: widget.selectedGender == 'female'
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.spaceM),
                SelectableCard(
                  selected: widget.selectedGender == 'other',
                  onClick: () => widget.onGenderSelect('other'),
                  child: Row(
                    children: [
                      Icon(
                        Icons.transgender_rounded,
                        color: widget.selectedGender == 'other'
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                        size: Dimens.iconSizeM,
                      ),
                      const SizedBox(width: Dimens.spaceM),
                      Text(
                        'Other',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: widget.selectedGender == 'other'
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: widget.selectedGender == 'other'
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
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
