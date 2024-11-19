import 'package:discorev/screens/messages_screen.dart';
import 'package:discorev/screens/profile_screen.dart';
import 'package:discorev/screens/recruiter/add_job_screen.dart';
import 'package:flutter/material.dart';
import '../screens/search_screen.dart';
import '../screens/home_screen.dart';
import '../screens/recruiter/dashboard_screen.dart';
import '../models/custom_colors.dart';
import '../services/user_service.dart';

class BottomNavbar extends StatefulWidget {
  final int initialIndex;
  const BottomNavbar({super.key, this.initialIndex = 0});

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  final UserService userService = UserService();
  int userAccountType = -1;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    // Appeler une fonction asynchrone pour récupérer le type de compte
    _loadAccountType();
  }

  // Méthode asynchrone pour obtenir et stocker le type de compte
  void _loadAccountType() async {
    // Récupérer le type de compte
    int? accountType = await userService.getAccountType();
    setState(() {
      userAccountType = accountType!; // Mettre à jour le type de compte
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation en fonction du type de compte
    if (userAccountType == -1) {
      return; // Ne rien faire si le type de compte n'est pas encore récupéré
    }

    switch (userAccountType) {
      case 0:
      // Type de compte 0
        _navigateToScreen(index, [
          HomeScreen(),
          const SearchScreen(),
          const DashboardScreen(),
          HomeScreen(), // Messages
          HomeScreen(), // Profil
        ]);
        break;
      case 1:
      // Type de compte 1 : candidat
        _navigateToScreen(index, [
          HomeScreen(),
          HomeScreen(), // Remplacer par l'écran approprié
          HomeScreen(), // Remplacer par l'écran approprié
          HomeScreen(), // Remplacer par l'écran approprié
          HomeScreen(), // Remplacer par l'écran approprié
        ]);
        break;
      case 2:
      // Type de compte 2 : recruteur
        _navigateToScreen(index, [
          SearchScreen(),
          HomeScreen(),
          AddJobScreen(),
          MessagesScreen(),
          ProfileScreen(),
        ]);
        break;
    }
  }

  // Fonction pour effectuer la navigation
  void _navigateToScreen(int index, List<Widget> screens) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screens[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: userAccountType == 0
          ? const <BottomNavigationBarItem>[
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
      ]
          : userAccountType == 1
          ? const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'Offres',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Mon compte',
        ),
      ]
          : const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Rechercher',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          label: 'Publier',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profil',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: CustomColors.primaryColorYellow,
      unselectedItemColor: CustomColors.secondaryColorBlue,
    );
  }
}

