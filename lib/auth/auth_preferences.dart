
import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferences {
  static const String isLoggedInKey = 'isLoggedIn';
  static const String emailKey = 'userEmail';
  static const String tokenKey = 'token';

  Future<void> saveLogin(String email,String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(isLoggedInKey, true);
    await prefs.setString(emailKey, email);
    await prefs.setString(tokenKey, token);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(isLoggedInKey) ?? false;
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(emailKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(isLoggedInKey);
    await prefs.remove(emailKey);
    await prefs.remove(tokenKey);
  }
}
