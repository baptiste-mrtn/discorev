import 'package:discorev/models/custom_colors.dart';
import 'package:discorev/screens/candidates/announce_list.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Une liste des pages qui doivent afficher la navbar
  final List<Widget> _pagesWithNavBar = [
    const HomePage(),
    const AnnounceList(),
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
