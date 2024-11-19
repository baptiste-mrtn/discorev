import 'package:discorev/screens/auth/login_screen.dart';
import 'package:discorev/services/auth_token_service.dart';
import 'package:discorev/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:discorev/screens/recruiter/dashboard_screen.dart';

import '../services/user_service.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthTokenService authTokenService = AuthTokenService();
  final UserService userService = UserService();
  final AuthTokenService securityService = AuthTokenService();

  bool isLoading = true;
  bool isLogged = false;
  int? accountType;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    // Vérifie si l'utilisateur est connecté
    isLogged = await authTokenService.isTokenValid();

    if (isLogged) {
      try{
        accountType = await userService.getAccountType();
      } catch(e){
        print("Erreur lors de la récupération du type de compte : $e");
      }

      // Rediriger selon le type de compte
      if (accountType == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      } else if (accountType == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      }
    } else {
      // Rediriger vers l'écran de connexion si l'utilisateur n'est pas connecté
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? SplashScreen() : Container(); // L'écran de redirection sera géré dans `_initializeData`
  }

}
