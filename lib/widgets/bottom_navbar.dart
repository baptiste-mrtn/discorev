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
  final UserService userService = UserService('/users');
  int userAccountType = -1;

  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    // Appeler une fonction asynchrone pour récupérer le type de compte
    _loadAccountType();
  }

// Méthode asynchrone pour obtenir et stocker le type de compte
  void _loadAccountType() async {
    userAccountType = await userService.getAccountType();
    // TODO : retirer une fois la ligne du dessus fonctionnelle
    userAccountType = 2;
    setState(() {}); // Mettre à jour l'UI une fois le type de compte chargé
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Liste des pages pour chaque type d'utilisateur
//     final List<Widget> pages = userAccountType == 0
//         ? [
//       HomeScreen(),
//       const SearchScreen(),
//       const DashboardScreen(),
//       const MessagesScreen(),
//       HomeScreen(), // Remplacez avec vos écrans
//     ]
//         : userAccountType == 1
//         ? [
//       const DashboardScreen(),
//       const SearchScreen(),
//       HomeScreen(),
//       const MessagesScreen(),
//       HomeScreen(), // Remplacez avec vos écrans
//     ]
//         : [
//       const SearchScreen(),
//       const DashboardScreen(),
//       const AddJobScreen(),
//       const MessagesScreen(),
//       const ProfilePage(), // Remplacez avec vos écrans
//     ];
//
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: pages,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: userAccountType == 0
//             ? const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Chercher',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favoris',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Accueil',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: 'Messages',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ]
//             : userAccountType == 1
//             ? const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: 'Dashboard',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work),
//             label: 'Offres',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notifications',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: 'Messages',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'Mon compte',
//           ),
//         ]
//             : const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Rechercher',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Accueil',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_box),
//             label: 'Annonces',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: 'Messages',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'Profil',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: CustomColors.primaryColorYellow,
//         unselectedItemColor: CustomColors.secondaryColorBlue,
//       ),
//     );
//   }
// }
      // Navigation en fonction du type de compte
      switch (userAccountType) {
        case 0:
        // Type de compte 0
          switch (_selectedIndex) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()), // Remplacez par l'écran de messages
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()), // Remplacez par l'écran de profil
              );
              break;
          }
          break;
        case 1:
        // Type de compte 1 : candidat
          switch (_selectedIndex) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()), // Remplacez par une autre logique
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()), // Remplacez par une autre logique
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()), // Remplacez par une autre logique
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()), // Remplacez par une autre logique
              );
              break;
          }
          break;
        case 2:
        // Type de compte 2 : recruteur
          switch (_selectedIndex) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AddJobScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MessagesScreen()),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
          }
          break;
      }
    });
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
      // icones candidat
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
      // icones recruteur
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
