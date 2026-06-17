import 'package:flutter/material.dart';
import '../../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../../core/widgets/wheel_picker.dart';
import '../../../../../core/widgets/typewriter_text.dart';

class AgeStepWidget extends StatefulWidget {
  const AgeStepWidget({
    required this.age,
    required this.onAgeSelect,
    required this.onTypingDone,
    super.key,
  });

  final int age;
  final ValueChanged<int> onAgeSelect;
  final VoidCallback onTypingDone;

  @override
  State<AgeStepWidget> createState() => _AgeStepWidgetState();
}

class _AgeStepWidgetState extends State<AgeStepWidget> {
  bool _isTitleFinished = false;
  final List<String> _ageItems = List.generate(88, (index) => (index + 13).toString());
  late int _activeIndex;

  @override
  void initState() {
    super.initState();
    final initialAge = widget.age > 0 ? widget.age : 25;
    _activeIndex = initialAge - 13;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onAgeSelect(initialAge);
    });

    if (widget.age > 0) {
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
          if (widget.age > 0)
            Text(
              "How old are you?",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            )
          else
            TypewriterText(
              text: "How old are you?",
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
                  "Age helps calibrate your baseline daily energy requirements.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Dimens.spaceXL),
                Center(
                  child: SizedBox(
                    width: 140,
                    child: WheelPicker(
                      items: _ageItems,
                      initialIndex: _activeIndex,
                      onItemSelected: (index) {
                        final selectedAge = index + 13;
                        widget.onAgeSelect(selectedAge);
                      },
                    ),
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
