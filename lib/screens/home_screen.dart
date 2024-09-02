import 'package:discorev/screens/auth/login_screen.dart';
import 'package:discorev/services/auth_service.dart';
import 'package:discorev/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:discorev/screens/candidate/announce_list_screen.dart';
import 'package:discorev/screens/recruiter/dashboard_screen.dart';

import '../services/security_service.dart';
import '../services/user_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SecurityService secureStorageService = SecurityService();
  final AuthService authService = AuthService();
  final UserService userService = UserService();

  bool isLoading = true;
  bool? isLogged;
  int? accountType;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    isLogged = await authService.isLogged();
    if (isLogged!) {
      //TODO: decommenter une fois le back mis a jour
      //accountType = await userService.getAccountType();
      accountType=2;
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
      return const AnnounceListScreen();
    } else if (isLogged == true && accountType == 2) {
      return const DashboardScreen();
    } else {
      return LoginScreen();
    }
  }
}
