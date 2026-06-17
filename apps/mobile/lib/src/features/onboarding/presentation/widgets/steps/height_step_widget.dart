import 'package:flutter/material.dart';
import '../../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../../core/widgets/wheel_picker.dart';
import '../../../../../core/widgets/typewriter_text.dart';

class HeightStepWidget extends StatefulWidget {
  const HeightStepWidget({
    required this.heightCm,
    required this.onHeightSelect,
    required this.onTypingDone,
    super.key,
  });

  final double heightCm;
  final ValueChanged<double> onHeightSelect;
  final VoidCallback onTypingDone;

  @override
  State<HeightStepWidget> createState() => _HeightStepWidgetState();
}

class _HeightStepWidgetState extends State<HeightStepWidget> {
  bool _isTitleFinished = false;
  bool _isCm = true;

  final List<String> _cmList = List.generate(151, (index) => (index + 100).toString());
  late int _cmIndex;

  final List<String> _ftList = List.generate(6, (index) => (index + 3).toString());
  final List<String> _inList = List.generate(12, (index) => index.toString());
  late int _ftIndex;
  late int _inIndex;

  @override
  void initState() {
    super.initState();
    final initialHeight = widget.heightCm > 0 ? widget.heightCm : 170.0;

    _cmIndex = (initialHeight.round() - 100).clamp(0, 150);

    final totalInches = initialHeight / 2.54;
    final feet = (totalInches / 12).floor();
    final inches = (totalInches % 12).round();
    _ftIndex = (feet - 3).clamp(0, 5);
    _inIndex = inches.clamp(0, 11);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onHeightSelect(initialHeight);
    });

    if (widget.heightCm > 0) {
      _isTitleFinished = true;
    }
  }

  void _updateHeight() {
    double height = 0.0;
    if (_isCm) {
      height = double.parse(_cmList[_cmIndex]);
    } else {
      final feet = _ftIndex + 3;
      final inches = _inIndex;
      height = (feet * 12 + inches) * 2.54;
    }
    widget.onHeightSelect(height);
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
          if (widget.heightCm > 0)
            Text(
              "How tall are you?",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            )
          else
            TypewriterText(
              text: "How tall are you?",
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
                  "Height is used to calibrate BMI and caloric targets.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Dimens.spaceXL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isCm) ...[
                      SizedBox(
                        width: 90,
                        child: WheelPicker(
                          items: _cmList,
                          initialIndex: _cmIndex,
                          onItemSelected: (index) {
                            _cmIndex = index;
                            _updateHeight();
                          },
                        ),
                      ),
                      const SizedBox(width: Dimens.spaceS),
                      Text(
                        'cm',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else ...[
                      SizedBox(
                        width: 65,
                        child: WheelPicker(
                          items: _ftList,
                          initialIndex: _ftIndex,
                          onItemSelected: (index) {
                            _ftIndex = index;
                            _updateHeight();
                          },
                        ),
                      ),
                      const SizedBox(width: Dimens.spaceXS),
                      Text(
                        'ft',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: Dimens.spaceS),
                      SizedBox(
                        width: 65,
                        child: WheelPicker(
                          items: _inList,
                          initialIndex: _inIndex,
                          onItemSelected: (index) {
                            _inIndex = index;
                            _updateHeight();
                          },
                        ),
                      ),
                      const SizedBox(width: Dimens.spaceXS),
                      Text(
                        'in',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    const SizedBox(width: Dimens.spaceM),
                    SizedBox(
                      width: 85,
                      child: WheelPicker(
                        items: const ['cm', 'ft/in'],
                        initialIndex: _isCm ? 0 : 1,
                        onItemSelected: (index) {
                          setState(() {
                            _isCm = index == 0;
                          });
                          _updateHeight();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
