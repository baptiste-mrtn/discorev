import 'dart:convert';

import 'package:discorev/services/general_service.dart';

import 'package:discorev/models/job.dart'; // Assurez-vous que ce modèle existe

class JobService extends GeneralService {
  static const String defaultEndpoint = '/jobs';

  JobService({String endpoint = defaultEndpoint}) : super(endpoint);

  /// Récupère tous les jobs et les mappe en objets de type `Job`
  Future<List<Job>> findAllJobs() async {
    final response = await apiService.getAllData();

    if (response.success) {
      final data = response.message; // Assurez-vous que la réponse est une liste JSON
      final List<dynamic> jsonData = jsonDecode(data);
      return jsonData.map((job) => Job.fromJson(job)).toList();
    } else {
      throw Exception('Erreur lors de la récupération des jobs : ${response.message}');
    }
  }

  /// Récupère les jobs spécifiques à l'utilisateur (endpoint `/jobs/myjobs`)
  Future<List<Job>> findMyJobs() async {
    final originalEndpoint = apiService.endpoint;
    apiService.endpoint = '/jobs/myjobs'; // Change temporairement l'endpoint
    final response = await apiService.getAllData();

    if (response.success) {
      final data = response.message; // Assurez-vous que la réponse est une liste JSON
      final List<dynamic> jsonData = jsonDecode(data);
      apiService.endpoint = originalEndpoint; // Rétablir l'endpoint d'origine
      return jsonData.map((job) => Job.fromJson(job)).toList();
    } else {
      apiService.endpoint = originalEndpoint; // Rétablir l'endpoint d'origine
      throw Exception('Erreur lors de la récupération des jobs utilisateur : ${response.message}');
    }
  }

  /// Récupère un seul job par son ID et le mappe en objet de type `Job`
  Future<Job> findJobById(int id) async {
    final response = await apiService.getOneData(id);

    if (response.success) {
      final data = response.message; // Assurez-vous que la réponse est un objet JSON
      final Map<String, dynamic> jsonData = jsonDecode(data);
      return Job.fromJson(jsonData);
    } else {
      throw Exception('Erreur lors de la récupération du job : ${response.message}');
    }
  }
}

