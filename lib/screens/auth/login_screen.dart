import 'package:discorev/screens/auth/choice_account_type_screen.dart';
import 'package:discorev/screens/auth/forgotten_password_screen.dart';
import 'package:discorev/screens/home_screen.dart';
import 'package:discorev/services/auth_service.dart';
import 'package:discorev/services/general_service.dart';
import 'package:discorev/widgets/title_logo.dart';
import 'package:flutter/material.dart';

import '../../models/custom_colors.dart';
import '../../services/auth_token_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final AuthTokenService authTokenService = AuthTokenService();
  final GeneralService userService = GeneralService('users');
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false; // pour gérer l'affichage du loader

  Future<void> loginUser() async {
    setState(() {
      isLoading = true; // Afficher le loader
    });

    final response = await authService.login(
      _emailController.text,
      _passwordController.text,
    );

    if (response.success) {
      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: CustomColors.tertiaryColorWhite,
          content: Text(
            'Connexion réussie !',
            style: TextStyle(color: Colors.green),
          ),
        ),
      );

      // Attendre que le token soit sauvegardé avant de rediriger
      await authTokenService.isTokenValid(); // Vérifie que le token est valide

      if (!mounted) return; // Pour éviter des erreurs si le widget a été démonté

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomColors.tertiaryColorWhite,
          content: Text(
            'Erreur lors de la connexion :\n${response.message}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    setState(() {
      isLoading = false; // Masquer le loader
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Column(
        children: [
          const TitleLogo(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        focusColor: CustomColors.primaryColorYellow,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez saisir votre email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Mot de passe',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez saisir votre mot de passe';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const CircularProgressIndicator() // Afficher un loader pendant la connexion
                        : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginUser(); // Appeler la méthode de connexion
                        }
                      },
                      child: const Text('Se connecter'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const ForgottenPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text('Mot de passe oublié'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ChoiceAccountTypeScreen(),
                              ),
                            );
                          },
                          child: const Text('Créer mon compte'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
