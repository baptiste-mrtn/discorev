import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isFirstTime = true;
  bool _isLoggedIn = false;
  String _userRole = '';
  DateTime? _tokenExpiryDate;
  Timer? _expiryTimer;

  bool get isFirstTime => _isFirstTime;
  bool get isLoggedIn => _isLoggedIn;
  String get userRole => _userRole;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    // Charger l'état d'authentification depuis le stockage sécurisé
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userRole = prefs.getString('userRole') ?? '';
    String? expiryDateString = prefs.getString('tokenExpiryDate');
    _tokenExpiryDate = expiryDateString != null ? DateTime.parse(expiryDateString) : null;

    // Démarrer la surveillance du token
    _startTokenExpiryCheck();

    notifyListeners();
  }

  void _startTokenExpiryCheck() {
    if (_tokenExpiryDate != null) {
      final timeToExpiry = _tokenExpiryDate!.difference(DateTime.now()).inSeconds;

      if (timeToExpiry > 0) {
        _expiryTimer?.cancel();  // Annuler tout Timer précédent
        _expiryTimer = Timer(Duration(seconds: timeToExpiry), _handleTokenExpiry);
      } else {
        _handleTokenExpiry();
      }
    }
  }

  Future<void> _handleTokenExpiry() async {
    // Gérer l'expiration du token (par exemple, déconnexion)
    _isLoggedIn = false;
    _userRole = '';
    notifyListeners();

    // Effacer l'état d'authentification
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Optionnel : Vous pouvez déclencher une action spécifique comme rediriger l'utilisateur
  }

  @override
  void dispose() {
    _expiryTimer?.cancel();
    super.dispose();
  }
}
