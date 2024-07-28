import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecrets {
  static String get supaBaseUrl => dotenv.env['SUPABASE_URL'] ?? 'default_url';

  static String get supaAnonKey =>
      dotenv.env['SUPABASE_ANON_KEY'] ?? 'default_key';

// static const String supaBaseUrl = 'https://scmmcqfjurewjtbcrzaq.supabase.co';
// static const String supaAnonKey =
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNjbW1jcWZqdXJld2p0YmNyemFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE4OTE4MzQsImV4cCI6MjAzNzQ2NzgzNH0.NDvDDBYYV5DseQgQEQ2p-CjolrOym6afdUP-vJWcjBk';
}
