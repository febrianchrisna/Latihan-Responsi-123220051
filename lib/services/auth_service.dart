import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';
  static const String _isLoggedInKey = 'isLoggedIn';

  static Future<bool> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if user already exists
    final existingUsername = prefs.getString(_usernameKey);
    if (existingUsername == username) {
      return false; // User already exists
    }

    await prefs.setString(_usernameKey, username);
    await prefs.setString(_passwordKey, password);
    return true;
  }

  static Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    final savedUsername = prefs.getString(_usernameKey);
    final savedPassword = prefs.getString(_passwordKey);

    if (savedUsername == username && savedPassword == password) {
      await prefs.setBool(_isLoggedInKey, true);
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<String?> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    if (isLoggedIn) {
      return prefs.getString(_usernameKey);
    }
    return null;
  }
}
