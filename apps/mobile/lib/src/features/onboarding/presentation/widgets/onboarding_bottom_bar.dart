import 'package:flutter/material.dart';
import '../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../core/widgets/action_buttons.dart';

class OnboardingBottomBar extends StatelessWidget {
  const OnboardingBottomBar({
    required this.visible,
    required this.enabled,
    required this.text,
    required this.onClick,
    super.key,
  });

  final bool visible;
  final bool enabled;
  final String text;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.paddingScreen,
        vertical: Dimens.spaceM,
      ),
      child: PrimaryButton(
        text: text,
        onPressed: enabled ? onClick : null,
        expand: true,
      ),
    );
  }
}
