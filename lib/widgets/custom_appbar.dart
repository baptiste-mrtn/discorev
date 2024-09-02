import 'package:discorev/models/custom_colors.dart';
import 'package:discorev/screens/auth/login_screen.dart';
import 'package:discorev/screens/messages.dart';
import 'package:discorev/screens/profile.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleAppbar;
  final AuthService authService = AuthService();

  // Constructeur
  CustomAppBar({super.key, required this.titleAppbar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleAppbar),
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (String value) async {
            switch (value) {
              case 'Page 1':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
                break;
              case 'Page 2':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MessagesPage()),
                );
                break;
              case 'Déconnexion':
                await authService.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                break;
            }
          },
          icon: const Icon(Icons.menu, color: CustomColors.primaryColorYellow,),
          itemBuilder: (BuildContext context) {
            return {'Page 1', 'Page 2', 'Déconnexion'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  // Cette méthode est nécessaire pour indiquer à Flutter la hauteur de l'AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
