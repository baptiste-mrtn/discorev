import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isFirstTime = true; // Replace with actual check from secure storage
  bool _isLoggedIn = false;
  String _userRole = '';

  bool get isFirstTime => _isFirstTime;
  bool get isLoggedIn => _isLoggedIn;
  String get userRole => _userRole;

  void login(String email, String password) {
    // Implement login logic
    _isLoggedIn = true;
    _userRole = 'candidate'; // Replace with actual role from response
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userRole = '';
    notifyListeners();
  }

  void register(String email, String password, String role) {
    // Implement registration logic
    _isLoggedIn = true;
    _userRole = role;
    notifyListeners();
  }
}
