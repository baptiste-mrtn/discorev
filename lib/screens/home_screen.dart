import 'package:discorev/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:discorev/screens/candidate/announce_list_screen.dart';
import 'package:discorev/screens/recruiter/dashboard_screen.dart';

import '../services/security_service.dart';

class HomeScreen extends StatefulWidget {
  final SecurityService secureStorageService = SecurityService();

  final int accountType;
  HomeScreen({this.accountType = 0});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

@override
  Widget build(BuildContext context) {
    if (widget.accountType == 1) {
      return const AnnounceListScreen();
    } else if (widget.accountType == 2) {
      return const DashboardScreen();
    } else {
      return const LoginScreen();
    }
  }

}
