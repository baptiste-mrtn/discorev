import 'package:discorev/screens/recruiter/add_job_screen.dart';
import 'package:discorev/widgets/bottom_navbar.dart';
import 'package:discorev/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'my_jobs_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String? jobTitle; // Si un job est disponible, sinon null

  const DashboardScreen({super.key, this.jobTitle});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(titleAppbar: 'Tableau de bord'),
      bottomNavigationBar: const BottomNavbar(initialIndex: 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Carte arrondie ou bouton Ajouter
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(16.0),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // décalage de l'ombre
                  ),
                ],
              ),
              child: jobTitle != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobTitle!,
                    style: const TextStyle(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, size: 40, color: Colors.blue),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddJobScreen(),
                        ),
                      );
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
            // Boutons alignés verticalement en bas
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity, // Prend toute la largeur possible
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyJobsScreen(),
                            ),
                          );
                        },
                        child: const Text('Toutes mes annonces'),
                      ),
                    ),
                    const SizedBox(height: 10), // Espacement entre les boutons
                    SizedBox(
                      width: double.infinity, // Prend toute la largeur possible
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddJobScreen(),
                            ),
                          );
                        },
                        child: const Text('Ajouter une annonce'),
                      ),
                    ),
                    const SizedBox(height: 10), // Espacement entre les boutons
                    SizedBox(
                      width: double.infinity, // Prend toute la largeur possible
                      height: 50,
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
            ),
          ],
        ),
      ),
    );
  }
}
