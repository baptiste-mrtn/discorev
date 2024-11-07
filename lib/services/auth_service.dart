import 'package:discorev/models/result_api.dart';
import 'package:discorev/services/general_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'security_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final SecurityService secureStorageService = SecurityService();
  final GeneralService companyService = GeneralService('/companies');
  final GeneralService userService = GeneralService('/users');

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

  Future<ResultApi> login(String email, String password) async {
    final url = await baseUrl;
    final response = await http.post(
      Uri.parse('$url/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    final message = jsonDecode(response.body)['message'];

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];
      DateTime now = DateTime.now();
      DateTime futureDate = now.add(const Duration(hours: 1));

      secureStorageService.saveToken(token, futureDate);

      userService.findOneBy(email);
      print(token);
      return ResultApi(success: true, message: message);
    } else {
      print('Erreur: ${response.statusCode}, $message');
      return ResultApi(success: false, message: message);
    }
  }

  Future<ResultApi> register(String email, String password, String name, String surname, {required int roleId, String? companyName, int? companySiren, String? companyDescription, String? companySector}) async {
    final url = await baseUrl;
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
      'name': '$surname $name',
      'role_id': roleId,
      'company_id': 1
    };

    if (roleId == 2) {
      if (companyName != null && companySiren != null) {
        Map<String, dynamic> requestBodyCompany = {
          'company_name': companyName,
          'company_siren': companySiren,
          'company_description': companyDescription,
          'company_industry': companySector,
        };
        final responseCompany = await companyService.addOne(requestBodyCompany);
        if(responseCompany.success){
          // TODO: replace "1" with response company id
          requestBody['company_id'] = 1;
          return ResultApi(success: true, message: "Company created");
        } else {
          return ResultApi(success: false, message: "Error occurred on company creation");
        }
      } else {
        // Gérer l'erreur si les informations de l'entreprise sont manquantes
        return ResultApi(success: false, message: "Company details are required for recruiters.");
      }
    }

    final response = await http.post(
      Uri.parse('$url/signup'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    final message = jsonDecode(response.body)['message'];

    if (response.statusCode == 201) {
      return ResultApi(success: true, message: message);
    } else {
      print('Erreur: ${response.statusCode}, $message');
      return ResultApi(success: false, message: message);
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

  Future logout() async {
    secureStorageService.deleteToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    await prefs.remove('accountType');
  }

  Future<bool> isLogged() async {
    String? token = await secureStorageService.readToken();

    return token != null && token.isNotEmpty;
  }
}