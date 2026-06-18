import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://xluwxmvcmeebnlgfriqm.supabase.co',
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhsdXd4bXZjbWVlYm5sZ2ZyaXFtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzk1MjE0ODUsImV4cCI6MjA5NTA5NzQ4NX0.jRJrDQq4LUpNBEwwBiFbQb2gvIhH65a7ALaKTCoSGjY',
  );

  /// Initializes Supabase globally using the configured keys
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: url,
      publishableKey: anonKey,
    );
  }
}

