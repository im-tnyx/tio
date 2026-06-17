import 'package:flutter/material.dart';
import '../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../core/widgets/action_buttons.dart';
import '../action/welcome_action.dart';

class WelcomeActionButtons extends StatelessWidget {
  const WelcomeActionButtons({
    required this.onAction,
    super.key,
  });

  final ValueChanged<WelcomeAction> onAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryButton(
          text: 'Get Started',
          expand: true,
          onPressed: () => onAction(const WelcomeGetStartedAction()),
        ),
        const SizedBox(height: Dimens.spaceM),
        SecondaryButton(
          text: 'Sign In',
          expand: true,
          onPressed: () => onAction(const WelcomeSignInAction()),
        ),
      ],
    );
  }
}
