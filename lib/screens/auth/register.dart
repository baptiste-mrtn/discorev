import 'package:discorev/models/custom_colors.dart';
import 'package:discorev/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/square_icons.dart';
import '../home.dart';
import 'account_creation.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  void navigateToAccountCreation(BuildContext context, String accountType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountCreationPage(accountType: accountType),
      ),
    );
  }

  void navigateTo(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Création de compte'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/discorev.png',
                width: 200,
              ),
              Text(
                "Discorev",
                style: GoogleFonts.baloo2(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Vous êtes un ',
                  style: GoogleFonts.lora(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
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
              }),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: const Text(
                  "J'ai déjà un compte",
                  style: TextStyle(color: CustomColors.primaryColorYellow),
                ),
              ),
            ]),
          ),
        ));
  }

  // Fonction pour construire les icônes
  List<Widget> buildIcons(BuildContext context) {
    return [
      SquareIcon(
        icon: Icons.emoji_people,
        label: "Candidat",
        onPressed: () => navigateToAccountCreation(context, 'Candidat'),
      ),
      const SizedBox(height: 20),
      SquareIcon(
        icon: Icons.hail,
        label: "Recruteur",
        onPressed: () => navigateToAccountCreation(context, 'Recruteur'),
      ),
      const SizedBox(height: 20),
      SquareIcon(
        icon: Icons.location_city,
        label: "Etablissement",
        onPressed: () => navigateToAccountCreation(context, 'Etablissement'),
      ),
    ];
  }
}
