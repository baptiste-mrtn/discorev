import 'package:discorev/services/api_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  ApiService apiService = ApiService(endpoint: '/users');

  Future<http.Response> findAll() async {
    final response = await apiService.getAllData();
    return response;
  }

  Future<http.Response> findOne(int id) async {
    final response = await apiService.getOneData(id);
    return response;
  }

  Future<http.Response> addOne(Object body) async {
    final response = await apiService.postData(body);
    return response;
  }

  Future<http.Response> updateOne(int id, Object body) async {
    final response = await apiService.updateOneData(id, body);
    return response;
  }

  Future<http.Response> deleteOne(int id, Object body) async {
    final response = await apiService.deleteOneData(id);
    return response;
  }
}