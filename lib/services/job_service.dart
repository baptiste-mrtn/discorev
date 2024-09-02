import 'dart:convert';

import 'package:discorev/services/api_service.dart';
import 'package:http/http.dart' as http;

import '../models/result_api.dart';

class JobService {
  ApiService apiService = ApiService(endpoint: '/jobs');

  Future<ResultApi> findAll() async {
    try {
      final response = await apiService.getAllData();
      // Supposons que getAllData() retourne une réponse JSON sous forme de String
      print(response);
      return ResultApi(success: true, message: jsonDecode(response.message));
    } catch (e) {
      return ResultApi(success: false, message: e.toString());
    }
  }

  Future<ResultApi> findOne(int id) async {
    final response = await apiService.getOneData(id);
    return response;
  }

  Future<ResultApi> addOne(Object body) async {
    final response = await apiService.postData(body);
    return response;
  }

  Future<ResultApi> updateOne(int id, Object body) async {
    final response = await apiService.updateOneData(id, body);
    return response;
  }

  Future<ResultApi> deleteOne(int id, Object body) async {
    final response = await apiService.deleteOneData(id);
    return response;
  }
}