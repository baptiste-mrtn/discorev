import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> annonces = [
      {
        'id': 1,
        'titre': 'Stage Développement Web',
        'description': 'Recherche stagiaire en développement web...',
        'utilisateur': 'utilisateur1',
      },
      {
        'id': 2,
        'titre': 'Emploi Marketing Digital',
        'description': 'Nous recherchons un expert en marketing digital...',
        'utilisateur': 'utilisateur2',
      },
    ];

    return ListView.builder(
      itemCount: annonces.length,
      itemBuilder: (BuildContext context, int index) {
        // Récupérez les détails de l'annonce à partir de la liste
        Map<String, dynamic> annonce = annonces[index];
        return ListTile(
          title: Text(annonce['titre']),
          subtitle: Text(annonce['description']),
          // Vous pouvez ajouter d'autres éléments de l'annonce ici
          onTap: () {
            // Gérer le clic sur une annonce
            print('Annonce sélectionnée : ${annonce['titre']}');
          },
        );
      },
    );
  }
}