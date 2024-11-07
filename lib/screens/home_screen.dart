import 'package:discorev/screens/auth/login_screen.dart';
import 'package:discorev/services/auth_service.dart';
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
  final AuthService authService = AuthService();
  final UserService userService = UserService('/users');

  bool isLoading = true;
  bool isLogged = false; // Valeur par défaut false
  int? accountType;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    // Vérifie si l'utilisateur est connecté
    isLogged = await authService.isLogged() ?? false;
    print('isLogged = $isLogged'); // Debug

    if (isLogged) {
      // TODO : decommenter une fois la route findOneBy(term) créée
      // accountType = await userService.getAccountType();
      accountType = 2;
      print('accountType = $accountType'); // Debug
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SplashScreen();
    } else if (isLogged == true && accountType == 1) {
      print("candidat");
      return const SearchScreen();
    } else if (isLogged == true && accountType == 2) {
      print("recruteur");
      return const DashboardScreen();
    } else {
      return LoginScreen();
    }
  }
}
