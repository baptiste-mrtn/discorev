import 'package:discorev/models/custom_colors.dart';
import 'package:flutter/material.dart';

import '../screens/candidate/announce_list_screen.dart';
import '../screens/home_screen.dart';

class BottomNavbar extends StatefulWidget {
  final int accountType;

  BottomNavbar({required this.accountType});

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            HomeScreen(accountType: widget.accountType,)),
      );
    });
  }

  // Une liste des pages qui doivent afficher la navbar
  final List<Widget> _pagesWithNavBar = [
    HomeScreen(),
    const AnnounceListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Chercher',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoris',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
        // Ajoutez d'autres éléments de la barre de navigation ici
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: CustomColors.primaryColorBlue, // Couleur des éléments sélectionnés
      unselectedItemColor: CustomColors.tertiaryColorWhite, // Couleur des éléments non sélectionnés
    );
  }
}
