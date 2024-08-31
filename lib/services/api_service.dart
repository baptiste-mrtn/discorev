import 'dart:convert';

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

  Future<http.Response> getAllData() async {
    final token = await secureStorageService.readToken();

    // On attend le résultat de baseUrl, car c'est une Future.
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

  Future<http.Response> getOneData(int id) async {
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


  Future<http.Response> updateOneData(int id, Object entity) async {
    final token = await secureStorageService.readToken();

    final url = await baseUrl;

    final response = await http.put(
      Uri.parse('$url/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: entity
    );
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Failed to update data');
    }
  }

  Future<http.Response> deleteOneData(int id) async {
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

  Future<http.Response> postData(Object data) async {
    final token = await secureStorageService.readToken();

    final url = await baseUrl;

    final response = await http.post(
      Uri.parse('$url/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    print(response.body);

    if (response.statusCode == 200) {
      print(json.decode(response.body)['message']);
      return response;
    } else {
      throw Exception('Failed to post data');
    }
  }
}
