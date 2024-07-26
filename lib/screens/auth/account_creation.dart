import 'package:discorev/screens/home.dart';
import 'package:flutter/material.dart';

class AccountCreationPage extends StatelessWidget {
  final String accountType;

  const AccountCreationPage({super.key, required this.accountType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un compte $accountType'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AccountCreationForm(accountType: accountType),
      ),
    );
  }
}

class AccountCreationForm extends StatefulWidget {
  final String accountType;

  const AccountCreationForm({super.key, required this.accountType});

  @override
  _AccountCreationFormState createState() => _AccountCreationFormState();
}

class _AccountCreationFormState extends State<AccountCreationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String get accountType => accountType;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nom'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre nom';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Mot de passe'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre mot de passe';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(labelText: 'Confirmation du mot de passe'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre mot de passe';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Soumettre le formulaire
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Votre compte a été crée avec succès'))
                );
                _navigateWithDelay(context, accountType);
              }
            },
            child: const Text('Créer un compte'),
          ),
        ],
      ),
    );
  }
}

void _navigateWithDelay(BuildContext context, String accountType) {
  // Attendre 3 secondes avant de naviguer
  Future.delayed(const Duration(seconds: 3), () {
    switch (accountType) {
      case "Candidat":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
          const HomePage()),
        );
        break;
      case "Recruteur":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
          const HomePage()),
        );
        break;
      case "Etablissement":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
          const HomePage()),
        );
        break;
    }
  });
}
