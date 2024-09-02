import 'dart:convert';

import 'package:discorev/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:discorev/services/job_service.dart';
import 'package:discorev/models/result_api.dart';

class AllJobsScreen extends StatefulWidget {
  @override
  _AllJobsScreenState createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen> {
  late Future<ResultApi> _jobsFuture;
  final JobService jobService = JobService();

  @override
  void initState() {
    super.initState();
    _jobsFuture = jobService.findAll();
    print('jobs : $_jobsFuture');
  }

  List<Map<String, dynamic>> parseJobs(dynamic message) {
    print('Raw message to parse: $message'); // Imprimez pour vérifier ce que vous recevez

    if (message is List) {
      try {
        // Si c'est déjà une liste, vous pouvez la caster directement
        return message.map((job) => job as Map<String, dynamic>).toList();
      } catch (e) {
        print('Erreur lors de l\'analyse des annonces: $e');
        return [];
      }
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Annonces'),
      ),
      body: FutureBuilder<ResultApi>(
        future: _jobsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            print('Snapshot data: ${snapshot.data}');
            final jobs = parseJobs(snapshot.data!.message);
            print('Parsed jobs: $jobs');
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
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
                child:
                  Text('Une erreur est survenue.'),
            );
          }
        },
      ),
    );
  }
}
