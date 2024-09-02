import 'dart:convert';

import 'package:discorev/models/result_api.dart';
import 'package:discorev/services/security_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String endpoint;
  final SecurityService secureStorageService = SecurityService();

  ApiService({required this.endpoint});

  Future<void> loadEnv() async {
    await dotenv.load(fileName: ".env");
  }

  Future<String> get baseUrl async {
    await loadEnv();
    final apiUrl = dotenv.env['API_URL'];
    if (apiUrl == null) {
      throw Exception('API_URL is not defined in the .env file.');
    }
    return '$apiUrl$endpoint';
  }

  Future<ResultApi> getAllData() async {
    await secureStorageService.ensureTokenValid();
    final token = await secureStorageService.readToken();

    final url = await baseUrl;

    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    print(json.decode(response.body));

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResultApi> getOneData(int id) async {
    await secureStorageService.ensureTokenValid();
    final token = await secureStorageService.readToken();

    final url = await baseUrl;

    final response = await http.get(
      Uri.parse('$url/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    print(json.decode(response.body));

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResultApi> getOneDataBy(String term) async {
    await secureStorageService.ensureTokenValid();
    final token = await secureStorageService.readToken();

    final url = await baseUrl;

    final response = await http.get(
      Uri.parse('$url/$term'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    print(json.decode(response.body));

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ResultApi> updateOneData(int id, Object entity) async {
    await secureStorageService.ensureTokenValid();
    final token = await secureStorageService.readToken();

    final url = await baseUrl;

    final response = await http.put(Uri.parse('$url/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: entity);
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Failed to update data');
    }
  }

  Future<ResultApi> deleteOneData(int id) async {
    await secureStorageService.ensureTokenValid();
    final token = await secureStorageService.readToken();

    final url = await baseUrl;

    final response = await http.delete(
      Uri.parse('$url/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Failed to delete data');
    }
  }

  Future<ResultApi> postData(Object obj) async {
    await secureStorageService.ensureTokenValid();

    final token = await secureStorageService.readToken();
    final url = await baseUrl;
    final data = jsonEncode(obj);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: data,
      );

      print(response.body);
      if (response.statusCode == 200) {
        print(json.decode(response.body)['message']);
        return json.decode(response.body)['message'];
      } else {
        throw Exception('Failed to post data');
      }
    } catch (err) {
      return ResultApi(success: false, message: '$err');
    }
  }
}
