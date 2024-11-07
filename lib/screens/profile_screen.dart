import 'package:discorev/screens/settings/account_settings_screen.dart';
import 'package:discorev/screens/settings/company_info_screen.dart';
import 'package:discorev/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleAppbar: 'Profil'
      ),
      bottomNavigationBar: const BottomNavbar(initialIndex: 4,),
      body: ListView(
        children: [
          _buildSection(
            context,
            title: 'Général',
            items: [
              {'title': 'Informations de l\'entreprise', 'route': const CompanyInfoScreen()},
              {'title': 'Paramètres du compte', 'route': AccountSettingsScreen()},
            ],
          ),
          _buildSection(
            context,
            title: 'Administratif',
            items: [
              {'title': 'Documents et contrats', 'route': DocumentsScreen()},
              {'title': 'Facturation', 'route': BillingScreen()},
              {'title': 'Demandes', 'route': RequestsScreen()},
            ],
          ),
          _buildSection(
            context,
            title: 'Support technique',
            items: [
              {'title': 'Rôles et permissions', 'route': RolesPermissionsScreen()},
              {'title': 'Aide et assistance', 'route': HelpSupportScreen()},
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required List<Map<String, dynamic>> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(),
        ...items.map((item) {
          return ListTile(
            title: Text(item['title']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item['route']),
              );
            },
          );
        }).toList(),
      ],
    );
  }
}

class DocumentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Documents et contrats')), body: Center(child: Text('Page Documents et contrats')));
  }
}

class BillingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Facturation')), body: Center(child: Text('Page Facturation')));
  }
}

class RequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Demandes')), body: Center(child: Text('Page Demandes')));
  }
}

class RolesPermissionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Rôles et permissions')), body: Center(child: Text('Page Rôles et permissions')));
  }
}

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Aide et assistance')), body: Center(child: Text('Page Aide et assistance')));
  }
}
