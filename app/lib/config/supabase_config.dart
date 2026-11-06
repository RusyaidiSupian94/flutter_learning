class SupabaseConfig {
  static const String supabaseUrl = String.fromEnvironment('SUPBASE_URL');
  static const String supbasePublishableKey = String.fromEnvironment('SUPBASE_PUBLISHABLE_KEY');
  static bool get isConfigured => supabaseUrl.isNotEmpty && supbasePublishableKey.isNotEmpty;
}