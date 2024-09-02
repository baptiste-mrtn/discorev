import 'package:shared_preferences/shared_preferences.dart';

class SecurityService {
  Future<void> saveToken(String token, DateTime expiryDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    await prefs.setString('tokenExpiryDate', expiryDate.toIso8601String());
  }

  Future<String?> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<DateTime?> readTokenExpiryDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? expiryDateString = prefs.getString('tokenExpiryDate');
    return expiryDateString != null ? DateTime.parse(expiryDateString) : null;
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    await prefs.remove('tokenExpiryDate');
  }

  Future<bool> isTokenValid() async {
    String? token = await readToken();
    DateTime? expiryDate = await readTokenExpiryDate();

    if (token == null || expiryDate == null) {
      return false;
    }

    // Vérifiez si la date actuelle est antérieure à la date d'expiration
    return DateTime.now().isBefore(expiryDate);
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
