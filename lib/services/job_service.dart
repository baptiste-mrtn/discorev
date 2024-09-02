import 'package:discorev/services/api_service.dart';

import '../models/result_api.dart';

class JobService {
  ApiService apiService = ApiService(endpoint: '/jobs');

  Future<ResultApi> findAll() async {
    final response = await apiService.getAllData();
    return response;
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
