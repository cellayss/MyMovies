import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageKeys {
  static const isLoggedIn = 'is_logged_in';
  static const hasSeenOnboarding = 'has_seen_onboarding';
  static const isDarkMode = 'is_dark_mode';
  static const favoriteMovies = 'favorite_movies';
}

class LocalStorage {
  LocalStorage._(this._preferences);

  final SharedPreferences _preferences;

  static Future<LocalStorage> create() async {
    final preferences = await SharedPreferences.getInstance();
    return LocalStorage._(preferences);
  }

  Future<bool> setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  Future<bool> setStringList(String key, List<String> value) {
    return _preferences.setStringList(key, value);
  }

  List<String> getStringList(String key) {
    return _preferences.getStringList(key) ?? [];
  }
}
