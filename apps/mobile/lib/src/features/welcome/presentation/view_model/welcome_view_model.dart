import 'package:flutter/foundation.dart';
import '../action/welcome_action.dart';

class WelcomeViewModel extends ChangeNotifier {
  void handleAction(WelcomeAction action) {
    if (action is WelcomeGetStartedAction) {
      _onGetStarted();
    } else if (action is WelcomeSignInAction) {
      _onSignIn();
    }
  }

  void _onGetStarted() {
    // Navigate to Onboarding or Registration
    if (kDebugMode) {
      print('Navigate to Get Started');
    }
  }

  void _onSignIn() {
    // Navigate to Sign In
    if (kDebugMode) {
      print('Navigate to Sign In');
    }
  }
}
