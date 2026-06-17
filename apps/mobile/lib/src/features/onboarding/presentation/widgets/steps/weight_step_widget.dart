import 'package:flutter/material.dart';
import '../../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../../core/theme/tokens/semantic/colors.dart';
import '../../../../../core/widgets/wheel_picker.dart';
import '../../../../../core/widgets/typewriter_text.dart';

class WeightStepWidget extends StatefulWidget {
  const WeightStepWidget({
    required this.heightCm,
    required this.weightKg,
    required this.onWeightSelect,
    required this.onTypingDone,
    super.key,
  });

  final double heightCm;
  final double weightKg;
  final ValueChanged<double> onWeightSelect;
  final VoidCallback onTypingDone;

  @override
  State<WeightStepWidget> createState() => _WeightStepWidgetState();
}

class _WeightStepWidgetState extends State<WeightStepWidget> {
  bool _isTitleFinished = false;
  bool _isKg = true;

  final List<String> _kgMainList = List.generate(171, (index) => (index + 30).toString());
  final List<String> _kgDecList = List.generate(10, (index) => index.toString());
  
  final List<String> _lbsMainList = List.generate(391, (index) => (index + 60).toString());
  final List<String> _lbsDecList = List.generate(10, (index) => index.toString());

  late int _mainIndex;
  late int _decIndex;

  @override
  void initState() {
    super.initState();
    final initialWeight = widget.weightKg > 0.0 ? widget.weightKg : 70.0;
    
    _mainIndex = (initialWeight.floor() - 30).clamp(0, 170);
    _decIndex = ((initialWeight * 10).round() % 10).clamp(0, 9);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onWeightSelect(initialWeight);
    });

    if (widget.weightKg > 0.0) {
      _isTitleFinished = true;
    }
  }

  void _updateWeight() {
    double weight = 0.0;
    if (_isKg) {
      final main = double.parse(_kgMainList[_mainIndex]);
      final dec = double.parse(_kgDecList[_decIndex]) / 10.0;
      weight = main + dec;
    } else {
      final main = double.parse(_lbsMainList[_mainIndex]);
      final dec = double.parse(_lbsDecList[_decIndex]) / 10.0;
      weight = (main + dec) * 0.453592;
    }
    widget.onWeightSelect(weight);
  }

  double get _currentWeightCalculated {
    if (_isKg) {
      final main = double.parse(_kgMainList[_mainIndex]);
      final dec = double.parse(_kgDecList[_decIndex]) / 10.0;
      return main + dec;
    } else {
      final main = double.parse(_lbsMainList[_mainIndex]);
      final dec = double.parse(_lbsDecList[_decIndex]) / 10.0;
      return (main + dec) * 0.453592;
    }
  }

  double get _bmi {
    final heightM = widget.heightCm / 100.0;
    if (heightM <= 0.0) return 0.0;
    return _currentWeightCalculated / (heightM * heightM);
  }

  _BmiCategory _getBmiCategory(double bmi) {
    if (bmi < 18.5) {
      return const _BmiCategory(
        label: 'Underweight',
        color: Colors.blue,
        desc: 'Your BMI is lower than the healthy range. Consider consulting a nutritionist.',
      );
    } else if (bmi < 25.0) {
      return const _BmiCategory(
        label: 'Normal',
        color: AppColors.statusLive,
        desc: 'Great job! Your weight is in the healthy range for your height.',
      );
    } else if (bmi < 30.0) {
      return const _BmiCategory(
        label: 'Overweight',
        color: AppColors.statusOffline,
        desc: 'Your BMI indicates you are slightly above healthy targets. We can help you adjust macros.',
      );
    } else {
      return const _BmiCategory(
        label: 'Obese',
        color: Colors.red,
        desc: 'Your BMI is in the obese range. We recommend setting a safe calorie deficit goal.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final calculatedBmi = _bmi;
    final category = _getBmiCategory(calculatedBmi);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.spaceL),
          if (widget.weightKg > 0.0)
            Text(
              "What is your weight?",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            )
          else
            TypewriterText(
              text: "What is your weight?",
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
                  "We use weight to establish metabolic rate and macros.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Dimens.spaceXL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      child: WheelPicker(
                        items: _isKg ? _kgMainList : _lbsMainList,
                        initialIndex: _mainIndex,
                        onItemSelected: (index) {
                          _mainIndex = index;
                          _updateWeight();
                        },
                      ),
                    ),
                    const SizedBox(width: Dimens.spaceXS),
                    Text(
                      '.',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: Dimens.spaceXS),
                    SizedBox(
                      width: 65,
                      child: WheelPicker(
                        items: _isKg ? _kgDecList : _lbsDecList,
                        initialIndex: _decIndex,
                        onItemSelected: (index) {
                          _decIndex = index;
                          _updateWeight();
                        },
                      ),
                    ),
                    const SizedBox(width: Dimens.spaceM),
                    SizedBox(
                      width: 80,
                      child: WheelPicker(
                        items: const ['kg', 'lbs'],
                        initialIndex: _isKg ? 0 : 1,
                        onItemSelected: (index) {
                          setState(() {
                            _isKg = index == 0;
                            _mainIndex = 0;
                            _decIndex = 0;
                          });
                          _updateWeight();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.spaceXL),
                if (widget.heightCm > 0.0)
                  Card(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.03),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.radiusCard),
                      side: BorderSide(
                        color: theme.colorScheme.outline.withValues(alpha: 0.1),
                        width: Dimens.borderThin,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.paddingCard),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "BMI: ",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                calculatedBmi.toStringAsFixed(1),
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: category.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: Dimens.spaceM),
                              Chip(
                                label: Text(category.label),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                                backgroundColor: category.color,
                                side: BorderSide.none,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimens.spaceS),
                          Text(
                            category.desc,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
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

class _BmiCategory {
  const _BmiCategory({
    required this.label,
    required this.color,
    required this.desc,
  });

  final String label;
  final Color color;
  final String desc;
}
