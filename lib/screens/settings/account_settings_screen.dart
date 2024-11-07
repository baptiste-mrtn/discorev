import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paramètres du compte')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Modification du mot de passe'),
            onTap: () {
              // Logique pour changer le mot de passe
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
            },
          ),
          ListTile(
            title: Text('Déconnexion'),
            onTap: () {
              // Logique pour déconnexion
            },
          ),
          ListTile(
            title: Text('Suppression du compte'),
            onTap: () {
              // Logique pour suppression du compte
            },
          ),
          ListTile(
            title: Text('Gestion des notifications'),
            onTap: () {
              // Logique pour gérer les notifications
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationSettingsScreen()));
            },
          ),
          ListTile(
            title: Text('Historique des actions'),
            onTap: () {
              // Logique pour afficher l'historique des actions
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActionHistoryScreen()));
            },
          ),
        ],
      ),
    );
  }
}

// Placeholder screens for navigation
class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modifier le mot de passe')),
      body: Center(child: Text('Page pour changer le mot de passe')),
    );
  }
}

class NotificationSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestion des notifications')),
      body: Center(child: Text('Page pour gérer les notifications')),
    );
  }
}

class ActionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historique des actions')),
      body: Center(child: Text('Page pour afficher l\'historique des actions')),
    );
  }
}
