import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:discorev/models/user.dart';
import '../services/auth_token_service.dart';
import '../services/user_service.dart';  // Assurez-vous que le modèle User est importé

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final AuthTokenService authTokenService = AuthTokenService();
  final UserService userService = UserService();

  final bool _isFirstTime = true;
  bool _isLoggedIn = false;
  String _userRole = '';
  DateTime? _tokenExpiryDate;
  Timer? _expiryTimer;
  User? _userInfos;  // Utilisation du modèle User au lieu de List<dynamic>

  bool get isFirstTime => _isFirstTime;
  bool get isLoggedIn => _isLoggedIn;
  String get userRole => _userRole;
  User? get userInfos => _userInfos;  // Retour du modèle User au lieu d'une liste dynamique

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    try {
      bool isLogged = await authTokenService.isTokenValid();
      print("isLogged ok : $isLogged");
      _isLoggedIn = isLogged;

      // Lecture du role utilisateur
      String? userRole = await secureStorage.read(key: 'accountType');
      if (userRole != null) {
        print("userRole ok : $userRole");
        _userRole = userRole;
      }

      // Lecture de la date d'expiration du token
      String? expiryDateString = await secureStorage.read(key: 'tokenExpiryDate');
      print("expiryDateString ok : $expiryDateString");
      _tokenExpiryDate = expiryDateString != null ? DateTime.parse(expiryDateString) : null;

      // Lecture des informations utilisateur
      String? userInfosString = await secureStorage.read(key: 'userInfos');
      if (userInfosString != null) {
        print("userInfosString ok : $userInfosString");
        _userInfos = User.fromJson(jsonDecode(userInfosString));
      }

      _startTokenExpiryCheck();
      notifyListeners();
    } catch (e) {
      print("Erreur lors du chargement de l'état d'authentification: $e");
    }
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
    _userInfos = null;  // Réinitialiser les infos utilisateur
    notifyListeners();

    // Effacer l'état d'authentification
    secureStorage.deleteAll();

    // Optionnel : Vous pouvez déclencher une action spécifique comme rediriger l'utilisateur
  }

  @override
  void dispose() {
    _expiryTimer?.cancel();
    super.dispose();
  }

  // Fonction pour mettre à jour les infos utilisateur (par exemple après une connexion)
  Future<void> updateUserInfo(User user) async {
    _userInfos = user;
    await secureStorage.write(key: 'userInfos', value: jsonEncode(user.toJson()));
    notifyListeners();
  }
}
