import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_appbar.dart';

class CompanyInfoScreen extends StatefulWidget {
  const CompanyInfoScreen({super.key});

  @override
  _CompanyInfoScreenState createState() => _CompanyInfoScreenState();
}

class _CompanyInfoScreenState extends State<CompanyInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _surname = '';
  String _location = '';
  String _email = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppbar: 'Informations du compte'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom'),
                onChanged: (value) => setState(() => _name = value),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer votre nom' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prénom'),
                onChanged: (value) => setState(() => _surname = value),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer votre prénom' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Localisation'),
                onChanged: (value) => setState(() => _location = value),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer votre localisation' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => setState(() => _email = value),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer votre email' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Téléphone'),
                onChanged: (value) => setState(() => _phone = value),
                validator: (value) => value!.isEmpty ? 'Veuillez entrer votre numéro de téléphone' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Sauvegarde les informations
                    // Ajouter votre logique de sauvegarde ici
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Informations mises à jour avec succès')));
                  }
                },
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
