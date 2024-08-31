import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String? jobTitle; // Si un job est disponible, sinon null

  const DashboardScreen({this.jobTitle});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Carte arrondie ou bouton Ajouter
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // décalage de l'ombre
                  ),
                ],
              ),
              child: jobTitle != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobTitle!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Description du poste disponible ici...',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              )
                  : Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.add, size: 40, color: Colors.blue),
                    onPressed: () {
                      // Logique pour ajouter un job
                    },
                  ),
                  const Text(
                    'Ajouter',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Trois boutons espacés
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Logique pour "Toutes mes annonces"
                      },
                      child: const Text('Toutes mes annonces'),
                    ),
                  ),
                  const SizedBox(width: 10), // Espacement entre les boutons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Logique pour "Ajouter une annonce"
                      },
                      child: const Text('Ajouter une annonce'),
                    ),
                  ),
                  const SizedBox(width: 10), // Espacement entre les boutons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Logique pour "Gestion des candidats"
                      },
                      child: const Text('Gestion des candidats'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
