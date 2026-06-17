import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tnyx/src/features/splash/presentation/action/splash_action.dart';
import 'package:tnyx/src/features/splash/presentation/state/splash_ui_state.dart';

sealed class SplashEffect {
  const SplashEffect();
}

class SplashNavigateToWelcome extends SplashEffect {
  const SplashNavigateToWelcome();
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
    // यहाँ आप Auth check या ज़रूरी डेटा लोडिंग कर सकते हैं
    await Future.delayed(const Duration(seconds: 2));
    _effects.add(const SplashNavigateToWelcome());
  }

  @override
  void dispose() {
    _effects.close();
    super.dispose();
  }
}
