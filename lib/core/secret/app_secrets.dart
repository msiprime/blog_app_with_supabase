import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecrets {
  static String get supaBaseUrl => dotenv.env['SUPABASE_URL'] ?? 'default_url';

  static String get supaAnonKey =>
      dotenv.env['SUPABASE_ANON_KEY'] ?? 'default_key';
}
