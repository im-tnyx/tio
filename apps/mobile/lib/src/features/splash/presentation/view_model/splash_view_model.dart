import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tnyx/src/features/splash/presentation/action/splash_action.dart';
import 'package:tnyx/src/features/splash/presentation/state/splash_ui_state.dart';

sealed class SplashEffect {
  const SplashEffect();
}

class SplashNavigateToWelcome extends SplashEffect {
  const SplashNavigateToWelcome();
}

class SplashNavigateToOnboarding extends SplashEffect {
  const SplashNavigateToOnboarding();
}

class SplashNavigateToMain extends SplashEffect {
  const SplashNavigateToMain();
}

class SplashViewModel extends ChangeNotifier {
  final SplashUiState _state = const SplashUiState();
  SplashUiState get state => _state;

  final StreamController<SplashEffect> _effects =
      StreamController<SplashEffect>.broadcast();
  Stream<SplashEffect> get effects => _effects.stream;

  void handleAction(SplashAction action) {
    if (action is SplashInitAction) {
      _init();
    }
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));

    // 1. Already logged in → go to main dashboard
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser != null) {
      _effects.add(const SplashNavigateToMain());
      return;
    }

    // 2. Onboarding draft saved → resume onboarding
    final prefs = await SharedPreferences.getInstance();
    final draft = prefs.getString('onboarding_draft');
    if (draft != null && draft.isNotEmpty) {
      _effects.add(const SplashNavigateToOnboarding());
      return;
    }

    // 3. Fresh user → show welcome screen
    _effects.add(const SplashNavigateToWelcome());
  }

  @override
  void dispose() {
    _effects.close();
    super.dispose();
  }
}
