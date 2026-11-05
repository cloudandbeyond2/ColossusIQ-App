import 'package:shared_preferences/shared_preferences.dart';

class AuthSessionService {
  static const String _keyIsLoggedIn = 'is_student_logged_in';
  static const String _keyRole = 'user_role';
  static const String _keyName = 'user_name';
  static const String _keyDesignation = 'user_designation';
  static const String _keyEmail = 'user_email';
  static const String _keyCollege = 'user_college';

  /// Check if the user is currently logged in.
  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyIsLoggedIn) ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Set the login state in persistent storage.
  static Future<void> setLoggedIn(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, value);
    } catch (_) {}
  }

  /// Save full user session profile
  static Future<void> saveUserSession({
    required String role,
    required String name,
    required String designation,
    required String email,
    required String college,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, true);
      await prefs.setString(_keyRole, role);
      await prefs.setString(_keyName, name);
      await prefs.setString(_keyDesignation, designation);
      await prefs.setString(_keyEmail, email);
      await prefs.setString(_keyCollege, college);
    } catch (_) {}
  }

  static Future<String> getRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyRole) ?? 'Student';
    } catch (_) {
      return 'Student';
    }
  }

  static Future<String> getName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyName) ?? 'Anand R';
    } catch (_) {
      return 'Anand R';
    }
  }

  static Future<String> getDesignation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyDesignation) ?? 'Semester 5 · B.E. CSE';
    } catch (_) {
      return 'Semester 5 · B.E. CSE';
    }
  }

  static Future<String> getEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyEmail) ?? 'anand.22cs104@ait.edu.in';
    } catch (_) {
      return 'anand.22cs104@ait.edu.in';
    }
  }

  static Future<String> getCollege() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyCollege) ?? 'Anna Institute of Technology';
    } catch (_) {
      return 'Anna Institute of Technology';
    }
  }

  /// Clear session when user explicitly signs out.
  static Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, false);
    } catch (_) {}
  }
}

