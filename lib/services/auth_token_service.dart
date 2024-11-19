import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenService {

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> saveToken(String token, DateTime expiryDate) async {
    await secureStorage.write(key: 'authToken', value: token);
    print("Token sauvegardé");
    await secureStorage.write(key: 'tokenExpiryDate', value: expiryDate.toIso8601String());
    print("Date d'expiration sauvegardée : ${expiryDate.toIso8601String()}");
  }

  Future<String?> readToken() async {
    try {
      String? token = await secureStorage.read(key: 'authToken');
      print("Token lu");
      return token;
    } catch (e) {
      if (e.toString().contains('OperationError')) {
        print("Données corrompues détectées. Réinitialisation...");
        await secureStorage.deleteAll();
      }
      print("Erreur lors de la lecture du token : $e");
      return null;
    }
  }

  Future<DateTime?> readTokenExpiryDate() async {
    try {
      String? expiryDateString = await secureStorage.read(key: 'tokenExpiryDate');
      if (expiryDateString != null) {
        print(expiryDateString);
        return DateTime.parse(expiryDateString);
      }
    } catch (e) {
      print("Erreur lors de la conversion de la date d'expiration : $e");
    }
    return null;
  }

  Future<void> deleteToken() async {
    secureStorage.delete(key: 'authToken');
    secureStorage.delete(key: 'tokenExpiryDate');
  }

  Future<bool> isTokenValid() async {
    String? token = await readToken();
    DateTime? expiryDate = await readTokenExpiryDate();

    if (token == null) {
      print("Token absent");
      return false;
    }
    if (expiryDate == null) {
      print("Date d'expiration absente");
      return false;
    }
    if (DateTime.now().isAfter(expiryDate)) {
      print("Token expiré. Expiration : $expiryDate");
      return false;
    }
    print("Token valide jusqu'à : $expiryDate");
    return true;
  }



  Future<void> refreshToken() async {
    // Implémentez la logique pour rafraîchir le token ici
    // Après avoir obtenu un nouveau token, mettez à jour le stockage
  }

  Future<void> ensureTokenValid() async {
    if (!await isTokenValid()) {
      // Si le token est expiré, essayez de le rafraîchir
      await refreshToken();
    }
  }
}
