import 'dart:convert';

import 'package:discorev/screens/recruiter/add_job_screen.dart';
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
  }

  List<Map<String, dynamic>> parseJobs(String message) {
    try {
      final List<dynamic> jobsJson = jsonDecode(message);
      return jobsJson.map((job) => job as Map<String, dynamic>).toList();
    } catch (e) {
      print('Erreur lors de l\'analyse des jobs: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tous les Jobs'),
      ),
      body: FutureBuilder<ResultApi>(
        future: _jobsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.success) {
            final jobs = parseJobs(snapshot.data!.message);
            if (jobs.isEmpty) {
              return const Center(child: Text('Aucun job disponible.'));
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
                  Text('Aucune annonce trouvée'),
            );
          }
        },
      ),
    );
  }
}
