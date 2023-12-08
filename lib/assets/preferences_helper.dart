import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String themeKey = 'theme';
  static const String loggedInKey = 'loggedIn';

  static Future<bool> setTheme(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(themeKey, value);
  }

  static Future<bool> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey) ?? true;
  }

  static Future<bool> setLoggedInStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(loggedInKey, value);
  }

  static Future<bool> getLoggedInStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loggedInKey) ?? false;
  }

  static Future<void> clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

}

