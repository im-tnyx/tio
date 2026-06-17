import 'package:flutter/material.dart';
import '../../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../../core/theme/tokens/semantic/colors.dart';
import '../../../../../core/widgets/wheel_picker.dart';
import '../../../../../core/widgets/typewriter_text.dart';

class TargetWeightStepWidget extends StatefulWidget {
  const TargetWeightStepWidget({
    required this.currentWeightKg,
    required this.targetWeightKg,
    required this.onTargetWeightSelect,
    required this.onTypingDone,
    super.key,
  });

  final double currentWeightKg;
  final double targetWeightKg;
  final ValueChanged<double> onTargetWeightSelect;
  final VoidCallback onTypingDone;

  @override
  State<TargetWeightStepWidget> createState() => _TargetWeightStepWidgetState();
}

class _TargetWeightStepWidgetState extends State<TargetWeightStepWidget> {
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
    final initialTarget = widget.targetWeightKg > 0.0
        ? widget.targetWeightKg
        : (widget.currentWeightKg > 0.0 ? widget.currentWeightKg : 70.0);

    _mainIndex = (initialTarget.floor() - 30).clamp(0, 170);
    _decIndex = ((initialTarget * 10).round() % 10).clamp(0, 9);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTargetWeightSelect(initialTarget);
    });

    if (widget.targetWeightKg > 0.0) {
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
    widget.onTargetWeightSelect(weight);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final calculatedTarget = _currentWeightCalculated;
    final diff = calculatedTarget - widget.currentWeightKg;
    final isLoss = diff < 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.spaceL),
          if (widget.targetWeightKg > 0.0)
            Text(
              "What is your target weight?",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            )
          else
            TypewriterText(
              text: "What is your target weight?",
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
                  "This helps establish the duration and rate of your transformation journey.",
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
                if (widget.currentWeightKg > 0.0)
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Current Weight",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: Dimens.spaceXXS),
                                  Text(
                                    _isKg
                                        ? "${widget.currentWeightKg.toStringAsFixed(1)} kg"
                                        : "${(widget.currentWeightKg / 0.453592).toStringAsFixed(1)} lbs",
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                isLoss
                                    ? Icons.arrow_downward_rounded
                                    : (diff == 0 ? Icons.compare_arrows_rounded : Icons.arrow_upward_rounded),
                                color: diff == 0
                                    ? theme.colorScheme.onSurfaceVariant
                                    : (isLoss ? AppColors.statusLive : AppColors.statusOffline),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Target Weight",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: Dimens.spaceXXS),
                                  Text(
                                    _isKg
                                        ? "${calculatedTarget.toStringAsFixed(1)} kg"
                                        : "${(calculatedTarget / 0.453592).toStringAsFixed(1)} lbs",
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(height: Dimens.spaceL),
                          Text(
                            diff == 0
                                ? "Your goal is to maintain your current weight of ${_isKg ? "${widget.currentWeightKg.toStringAsFixed(1)} kg" : "${(widget.currentWeightKg / 0.453592).toStringAsFixed(1)} lbs"}."
                                : "You want to ${isLoss ? 'lose' : 'gain'} ${diff.abs().toStringAsFixed(1)} kg (${(diff.abs() / 0.453592).toStringAsFixed(1)} lbs) to reach your target.",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
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
