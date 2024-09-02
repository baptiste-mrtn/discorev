import 'package:discorev/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/result_api.dart';

class UserService {
  ApiService apiService = ApiService(endpoint: '/users');

  Future<ResultApi> findAll() async {
    final response = await apiService.getAllData();
    return response;
  }

  Future<ResultApi> findOne(int id) async {
    final response = await apiService.getOneData(id);
    return response;
  }

  Future<ResultApi> findOneBy(String term) async {
    final response = await apiService.getOneDataBy(term);
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

  Future<ResultApi> deleteOne(int id) async {
    final response = await apiService.deleteOneData(id);
    return response;
  }

  Future setAccountType(int accountType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accountType', accountType);
  }

  Future<int> getAccountType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('accountType') ?? 0;
  }

}