import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tnyx/src/app/app.dart';
import 'package:tnyx/src/core/config/supabase_config.dart';
import 'package:tnyx/src/core/theme/manager/theme_mode_manager.dart';
import 'package:tnyx/src/core/theme/manager/theme_mode_scope.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase via configuration class
  await SupabaseConfig.initialize();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  // Enable true edge-to-edge full-screen display
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Style system bars to be transparent so backgrounds draw fully underneath them
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarContrastEnforced: false,
  ));

  final themeModeManager = ThemeModeManager();
  await themeModeManager.load();

  runApp(
    ThemeModeScope(
      notifier: themeModeManager,
      child: const App(),
    ),
  );
}
