import 'package:discorev/screens/auth/login_screen.dart';
import 'package:discorev/services/auth_service.dart';
import 'package:discorev/widgets/title_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/custom_colors.dart';
import '../../services/user_service.dart';
import '../home_screen.dart';

class RegisterScreen extends StatefulWidget {
  final int accountType;

  RegisterScreen({required this.accountType});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService authService = AuthService();
  final UserService userService = UserService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController(); // Pour le champ du nom
  final _surnameController = TextEditingController(); // Pour le champ du prénom
  final _companyNameController =
      TextEditingController(); // Pour le champ de l'entreprise
  final _companySirenController = TextEditingController();
  final _companyDescriptionController = TextEditingController();
  String? _selectedSector; // Variable pour le secteur d'emploi sélectionné

  final List<String> employmentSectors = [
    'Technologie',
    'Santé',
    'Finance',
    'Éducation',
    'Construction',
    'Commerce',
    'Manufacture',
    'Agriculture',
    'Transport',
    'Tourisme',
    'Énergie',
    'Immobilier',
    'Médias',
    // Ajoutez d'autres secteurs si nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const TitleLogo(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nom',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Veuillez saisir votre nom';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _surnameController,
                        decoration: const InputDecoration(
                          labelText: 'Prénom',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Veuillez saisir votre prénom';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir votre email';
                    } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,4}$')
                        .hasMatch(value)) {
                      return 'Veuillez saisir une adresse e-mail valide';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez saisir un mot de passe';
                    } else {
                      var err = 'Votre mot de passe doit contenir :\n';
                      bool valid = true;
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        err += '- Une lettre majuscule \n';
                        valid = false;
                      }
                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                        err += '- Une lettre minuscule \n';
                        valid = false;
                      }
                      if (!RegExp(r'[!»#$%&()*+,\-./:;<=>?@\[\\\]^_`{|}~]').hasMatch(value)) {
                        err += '- Un caractère spécial \n';
                        valid = false;
                      }
                      if (value.length < 8) {
                        err += '- 8 caractères ou plus \n';
                        valid = false;
                      }
                      if (!valid) return err;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                if (widget.accountType == 2) _buildCompanyFields(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('S\'inscrire'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'J\'ai déjà un compte',
                    style: TextStyle(
                      color: CustomColors.primaryColorYellow,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Votre entreprise'),
        const SizedBox(height: 10),
        TextFormField(
          controller: _companyNameController,
          decoration: const InputDecoration(
            labelText: 'Nom de l\'entreprise',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez saisir le nom de votre entreprise';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _companySirenController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'N° siren',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            final number = int.tryParse(value!);
            if (value.isEmpty) {
              return 'Veuillez saisir le n° de siren';
            } else if (number == null || value.length != 9) {
              return 'Un numéro de siren comporte 9 chiffres';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _companyDescriptionController,
          decoration: const InputDecoration(
            labelText: 'Description de l\'entreprise (facultatif)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          value: _selectedSector,
          decoration: const InputDecoration(
            labelText: 'Secteur',
            border: OutlineInputBorder(),
          ),
          items: employmentSectors.map((String sector) {
            return DropdownMenuItem<String>(
              value: sector,
              child: Text(sector),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedSector = newValue;
            });
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      userService.setAccountType(widget.accountType);
      final response = await authService.register(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
        _surnameController.text,
        roleId: widget.accountType,
        companyName: widget.accountType == 2 ? _companyNameController.text : null,
        companySiren: widget.accountType == 2 ? int.tryParse(_companySirenController.text) : null,
        companyDescription: widget.accountType == 2 ? _companyDescriptionController.text : null,
        companySector: widget.accountType == 2 ? _selectedSector : null,
      );
      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: CustomColors.tertiaryColorWhite,
            content: Text(
              'Compte créé avec succès',
              style: TextStyle(color: Colors.green),
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
            backgroundColor: CustomColors.tertiaryColorWhite,
            content: Text(
              'Erreur lors de l\'inscription :\n${response.message}',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
      }
    }
  }
}
