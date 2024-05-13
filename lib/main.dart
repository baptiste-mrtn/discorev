import 'package:discorev/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'navbar.dart'; // Importez le fichier bottom_nav_bar.dart

void main() {
  // Bloquer l'orientation en mode portrait uniquement
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Définir les couleurs par défaut pour les boutons et les liens
        primaryColor: Colors.orange,
        // Couleur principale pour les boutons et les liens
        hintColor: Colors.black54,
        // Couleur accentuée pour les boutons et les liens
        // Définir les couleurs par défaut pour les champs de texte
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.orange,
          // Couleur du curseur dans les champs de texte
          selectionColor: Colors.orange.withOpacity(0.4),
          // Couleur de la sélection dans les champs de texte
          selectionHandleColor: Colors
              .orangeAccent, // Couleur des poignées de sélection dans les champs de texte
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.orange), // Couleur de la bordure en focus
          ),
          // Autres paramètres de thème...
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void navigateTo(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discorev',
          style: GoogleFonts.baloo2(
            fontSize: 25,
            // Taille de la police
            fontWeight: FontWeight.bold,
            // Poids de la police (normal, bold, etc.)
            fontStyle: FontStyle.normal, // Style de la police (normal, italic)
            // Vous pouvez également définir d'autres propriétés de style ici
          ),
        ),
        backgroundColor: Colors.orangeAccent.shade100,
      ),
      backgroundColor: Colors.orangeAccent.shade100,
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Vous êtes un ',
            style: GoogleFonts.baloo2(
              fontSize: 25,
              // Taille de la police
              fontWeight: FontWeight.bold,
              // Poids de la police (normal, bold, etc.)
              fontStyle:
                  FontStyle.normal, // Style de la police (normal, italic)
              // Vous pouvez également définir d'autres propriétés de style ici
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        OrientationBuilder(builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildIcons(context),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildIcons(context),
                );
        })
      ])),
      bottomNavigationBar: BottomNavBar(), // Utilisez BottomNavBar ici
    );
  }

  // Fonction pour construire les icônes
  List<Widget> buildIcons(BuildContext context) {
    return [
      SquareIcon(
          icon: Icons.agriculture,
          label: "Artisan",
          onPressed: () => navigateTo(context)),
      const SizedBox(height: 20),
      SquareIcon(
        icon: Icons.family_restroom,
        label: "Parent",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
      ),
      const SizedBox(height: 20),
      SquareIcon(
        icon: Icons.location_city,
        label: "Etablissement",
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          )
        },
      ),
    ];
  }
}

class SquareIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String label;

  const SquareIcon(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Column(children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 5),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Icon(
              icon,
              size: 100,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.baloo2(
              fontSize: 16,
              // Taille de la police
              fontWeight: FontWeight.bold,
              // Poids de la police (normal, bold, etc.)
              fontStyle:
                  FontStyle.normal, // Style de la police (normal, italic)
              // Vous pouvez également définir d'autres propriétés de style ici
            ),
          ),
        ]));
  }
}
