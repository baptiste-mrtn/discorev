import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/discorev.png', // Ajoutez l'adresse de votre logo ici
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                hintText: 'E-mail',
                prefixIcon: Icon(Icons.person),
                focusColor: Colors.orangeAccent
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Naviguer vers la page de création de compte
                  },
                  child: const Text('Créer un compte',
                    style: TextStyle(color: Colors.orangeAccent),),
                ),
                TextButton(
                  onPressed: () {
                    // Naviguer vers la page de récupération de mot de passe
                  },
                  child: const Text('Mot de passe oublié ?',
                    style: TextStyle(color: Colors.orangeAccent),),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action à effectuer lors de la validation du formulaire
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.white, // text color
              ),
              child: const Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}