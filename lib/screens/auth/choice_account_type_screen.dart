import 'package:discorev/screens/auth/intro_screen.dart';
import 'package:discorev/screens/auth/login_screen.dart';
import 'package:discorev/widgets/title_logo.dart';
import 'package:flutter/material.dart';

import '../../models/custom_colors.dart';

class ChoiceAccountTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TitleLogo(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => IntroScreen(accountType: 1),
                            ),
                          );
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.person,
                              size: 50,
                            ),
                            Text('Candidat'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => IntroScreen(accountType: 2),
                            ),
                          );
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.business,
                              size: 50,
                            ),
                            Text('Recruteur'),
                          ],
                        ),
                      ),
                    ]),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'J\'ai déjà un compte',
                        style: TextStyle(
                          color: CustomColors.primaryColorYellow,
                          fontSize: 16.0,
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
