import 'package:http/http.dart' as http;
import 'dart:convert';
import 'security_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final SecurityService secureStorageService = SecurityService();

  Future<void> loadEnv() async {
    await dotenv.load(fileName: ".env");
  }

  Future<String> get baseUrl async {
    await loadEnv();
    final apiUrl = dotenv.env['API_URL'];
    if (apiUrl == null) {
      throw Exception('API_URL is not defined in the .env file.');
    }
    return '$apiUrl/auth';
  }

  Future<bool> login(String email, String password) async {
    final url = await baseUrl;
    final response = await http.post(
      Uri.parse('$url/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final token = response.headers['authorization'];
      secureStorageService.saveToken(token!);
      return true;
    } else {
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }

  Future<bool> register(String email, String password, String name, String surname, {required int roleId, int? companySiren}) async {
    final url = await baseUrl;
    final response = await http.post(
      Uri.parse('$url/signup'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email' : email,
        'password' : password,
        'name' : '$surname $name',
        'role_id' : roleId,
        'companySiren' : companySiren
      })
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print('Erreur: ${response.statusCode}, ${response.body}');
      return false;
    }
  }

  Future<bool> forgottenPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forget'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}