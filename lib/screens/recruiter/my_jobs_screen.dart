import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:discorev/services/general_service.dart';
import 'package:discorev/models/result_api.dart';
import 'package:discorev/widgets/bottom_navbar.dart';
import 'package:discorev/widgets/splash_screen.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  _MyJobsScreenState createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen> {
  late Future<ResultApi> _jobsFuture;
  final GeneralService jobService = GeneralService('/jobs/myjobs');
  String selectedFilter = 'Tous'; // Début par défaut avec toutes les annonces

  @override
  void initState() {
    super.initState();
    _jobsFuture = getJobs();
  }

  Future<ResultApi> getJobs() async {
    return await jobService.findAll();
  }

  List<Map<String, dynamic>> parseJobs(dynamic message) {
    if (message is List) {
      return message.map((job) => job as Map<String, dynamic>).toList();
    } else if (message is String) {
      try {
        final List<dynamic> jobsJson = jsonDecode(message);
        return jobsJson.map((job) => job as Map<String, dynamic>).toList();
      } catch (e) {
        print('Erreur lors de l\'analyse des annonces: $e');
        return [];
      }
    } else {
      print('Le type de message n\'est ni une chaîne JSON ni une liste');
      return [];
    }
  }

  List<Map<String, dynamic>> filterJobs(List<Map<String, dynamic>> jobs) {
    if (selectedFilter == 'Tous') {
      return jobs; // Affiche toutes les annonces
    }
    return jobs.where((job) => job['status'] == selectedFilter).toList();
  }

  void setFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes Offres')),
      bottomNavigationBar: const BottomNavbar(initialIndex: 2),
      body: Column(
        children: [
          // Filtres : Tous, Actives, Inactives, Brouillons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Tous', 'Actives', 'Inactives', 'Brouillons'].map((filter) {
              return TextButton(
                onPressed: () => setFilter(filter),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: selectedFilter == filter ? Colors.blue : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
          Expanded(
            child: FutureBuilder<ResultApi>(
              future: _jobsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final jobs = filterJobs(parseJobs(snapshot.data!.message));
                  if (jobs.isEmpty) {
                    return const Center(child: Text('Aucune annonce disponible.'));
                  } else {
                    return ListView.builder(
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return Card(
                          margin: const EdgeInsets.all(10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job['title']?.toString() ?? 'Titre non disponible',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  job['description']?.toString() ?? 'Description non disponible',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Fourchette de salaire: ${job['salary_range']?.toString() ?? 'Non spécifiée'}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // Action de modification
                                      },
                                      child: const Text('Modifier'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Action de suppression
                                      },
                                      child: const Text('Supprimer'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return const Center(child: Text('Une erreur est survenue.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
