import 'dart:convert';
import 'package:discorev/models/user.dart';  // Assurez-vous que le modèle User est importé
import 'package:discorev/services/general_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService extends GeneralService {
  static const String defaultEndpoint = '/users';

  UserService({String endpoint = defaultEndpoint}) : super(endpoint);

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // Stocker le type de compte sous forme d'int
  Future<void> setAccountType(int accountType) async {
    await secureStorage.write(key: 'accountType', value: accountType.toString());
  }

  // Récupérer le type de compte sous forme d'int
  Future<int?> getAccountType() async {
    String? accountTypeString = await secureStorage.read(key: 'accountType');
    print('Account Type String: $accountTypeString');

    // Retourner un entier ou null si la conversion échoue
    if (accountTypeString != null) {
      return int.tryParse(accountTypeString);  // Renvoie un int ou null en cas d'échec
    }
    return null;
  }

  // Stocker les informations de l'utilisateur sous forme d'objet User
  Future<void> setUserInfos(User user) async {
    print(user);
    await secureStorage.write(key: 'userInfos', value: jsonEncode(user.toJson()));
  }

  // Récupérer les informations de l'utilisateur sous forme d'objet User
  Future<User?> getUserInfos() async {
    String? userInfoString = await secureStorage.read(key: 'userInfos');

    if (userInfoString != null) {
      // Convertir la chaîne JSON en User (on suppose que User a une méthode fromJson)
      final Map<String, dynamic> userMap = jsonDecode(userInfoString);
      return User.fromJson(userMap);  // Créer un objet User à partir du JSON
    }
    return null;  // Si aucune donnée n'est trouvée, retourner null
  }
}
