import 'package:discorev/services/api_service.dart';

import '../models/result_api.dart';

class GeneralService {
  String endpoint;
  late ApiService apiService;

  GeneralService(this.endpoint){
    apiService = ApiService(endpoint: endpoint);
  }

  Future findAll() async {
    final response = await apiService.getAllData();
    return response;
  }

  Future findOne(int id) async {
    final response = await apiService.getOneData(id);
    return response;
  }

  Future findOneBy(String term) async {
    final response = await apiService.getOneDataBy(term);
    return response;
  }

  Future addOne(Object body) async {
    final response = await apiService.postData(body);
    return response;
  }

  Future updateOne(int id, Object body) async {
    final response = await apiService.updateOneData(id, body);
    return response;
  }

  Future deleteOne(int id, Object body) async {
    final response = await apiService.deleteOneData(id);
    return response;
  }
}
