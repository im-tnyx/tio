import 'package:flutter/material.dart';
import '../screen/welcome_screen.dart';
import 'package:go_router/go_router.dart';
import '../action/welcome_action.dart';

class WelcomeRoute extends StatelessWidget {
  const WelcomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeScreen(
      onAction: (action) {
        if (action is WelcomeGetStartedAction || action is WelcomeSignInAction) {
          context.go('/login');
        }
      },
    );
  }
}
