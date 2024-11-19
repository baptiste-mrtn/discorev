import 'package:discorev/models/result_api.dart';
import 'package:discorev/services/general_service.dart';
import 'package:discorev/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/company.dart';
import '../models/user.dart';
import 'auth_token_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final AuthTokenService authTokenService = AuthTokenService();
  final GeneralService companyService = GeneralService('/companies');
  final UserService userService = UserService();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

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
    try {
      final url = await baseUrl;
      final response = await http.post(
        Uri.parse('$url/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final body = jsonDecode(response.body);

      // Récupération du message renvoyé par l'API
      final message = body['message'];

      if (response.statusCode == 200) {
        // Extraction des données de l'utilisateur et du token
        final String token = body['token'];
        final userJson = body['user'];

        // Désérialisation en objet User
        final User user = User.fromJson(userJson);

        // Gestion du token sécurisé avec une durée de validité
        DateTime now = DateTime.now();
        DateTime futureDate = now.add(const Duration(hours: 1));

        // Sauvegarde du token et de la date d'expiration
        await authTokenService.saveToken(token, futureDate);

        // Configuration des informations utilisateur dans UserService
        userService.setUserInfos(user);
        userService.setAccountType(user.roleId);

        return ResultApi(success: true, message: message);
      } else {
        // En cas de réponse différente de 200
        return ResultApi(success: false, message: message);
      }
    } catch (e) {
      // Gestion des exceptions imprévues
      return ResultApi(success: false, message: 'Une erreur inattendue est survenue.');
    }
  }



  Future<ResultApi> register(
      String email,
      String password,
      String name,
      String surname, {
        required int roleId,
        String? companyName,
        int? companySiren,
        String? companyDescription,
        String? companySector,
      }) async {
    final url = await baseUrl;

    // Préparer le corps de la requête utilisateur
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
      'name': '$surname $name',
      'role_id': roleId,
      'company_id': 1, // Par défaut jusqu'à la création d'une entreprise
    };

    // Gestion des recruteurs avec création d'entreprise
    Company? createdCompany; // Pour stocker l'entreprise créée

    if (roleId == 2) {
      if (companyName != null && companySiren != null) {
        Company newCompany = Company(
          id: 0, // ID temporaire avant création
          name: companyName,
          siren: companySiren,
          description: companyDescription,
          sector: companySector,
        );

        // Appeler le service pour créer une entreprise
        final responseCompany = await companyService.addOne(newCompany.toJson());
        if (responseCompany.success) {
          createdCompany = Company.fromJson(responseCompany.data);
          requestBody['company_id'] = createdCompany.id;
        } else {
          return ResultApi(
            success: false,
            message: "Error occurred while creating the company: ${responseCompany.message}",
          );
        }
      } else {
        // Gérer l'erreur si les informations de l'entreprise sont manquantes
        return ResultApi(
          success: false,
          message: "Company details are required for recruiters.",
        );
      }
    }

    // Envoyer la requête d'inscription
    final response = await http.post(
      Uri.parse('$url/signup'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    final decodedResponse = jsonDecode(response.body);
    final message = decodedResponse['message'];

    if (response.statusCode == 201) {
      // Map des données utilisateur pour le modèle User
      final userData = decodedResponse['user'];
      final user = User.fromJson(userData);

      // Sauvegarde des informations utilisateur et token
      String token = decodedResponse['token'];
      DateTime now = DateTime.now();
      DateTime futureDate = now.add(const Duration(hours: 1));
      await authTokenService.saveToken(token, futureDate);
      userService.setUserInfos(user);
      userService.setAccountType(user.roleId);

      return ResultApi(
        success: true,
        message: message,
      );
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
    authTokenService.deleteToken();
    secureStorage.deleteAll();
  }
  //
  // Future<bool> isLogged() async {
  //   try {
  //     bool token = await authTokenService.isTokenValid();
  //     if (token) {
  //       print("Token valid.");
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     print("Erreur lors de la verification du token: $e");
  //     return false;
  //   }
  // }
}