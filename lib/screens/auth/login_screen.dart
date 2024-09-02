import 'package:discorev/screens/auth/choice_account_type_screen.dart';
import 'package:discorev/screens/auth/forgotten_password_screen.dart';
import 'package:discorev/screens/home_screen.dart';
import 'package:discorev/services/auth_service.dart';
import 'package:discorev/services/user_service.dart';
import 'package:discorev/widgets/title_logo.dart';
import 'package:flutter/material.dart';

import '../../models/custom_colors.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final UserService userService = UserService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connexion'),

        ),
        body: Column(children: [
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
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await authService.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (response.success) {
                            // TODO: décommenter pour récupérer les données de l'user
                            // await userService.findOneBy(_emailController.text); // Assurez-vous que les données sont prêtes
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: CustomColors.tertiaryColorWhite,
                                content: Text(
                                  'Connexion réussie !',
                                  style: TextStyle(color: CustomColors.primaryColorBlue),
                                ),
                              ),
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erreur lors de la connexion :\n${response.message}'),
                              ),
                            );
                          }
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
                                builder: (context) =>
                                    const ForgottenPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Mot de passe oublié',
                            style: TextStyle(
                              color: CustomColors.primaryColorYellow,
                              fontSize: 16.0,
                            ),
                          )),
                      TextButton(
                          onPressed: () async {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChoiceAccountTypeScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Créer mon compte',
                            style: TextStyle(
                              color: CustomColors.primaryColorYellow,
                              fontSize: 16.0,
                            ),
                          )),
                    ]),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
