import 'dart:convert';

// Définition de la classe User
class User {
  final int id;
  final String name;
  final String email;
  final int roleId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
  });

  // Méthode pour convertir un objet User en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'roleId': roleId
    };
  }

  // Méthode pour créer un objet User à partir d'un Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      roleId: map['roleId'],
    );
  }

  // Méthode pour convertir un objet User en JSON
  String toJson() => json.encode(toMap());

  // Méthode pour créer un objet User à partir d'un JSON
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

void main() {
  // Exemple d'utilisation de la classe User

  // Créer un utilisateur
  User user = User(id: 1, name: 'John Doe', email: 'john.doe@example.com', roleId: 1);

  // Convertir l'utilisateur en JSON
  String userJson = user.toJson();
  print('User en JSON: $userJson');

  // Créer un utilisateur à partir d'un JSON
  User newUser = User.fromJson(userJson);
  print('Nouvel utilisateur: ${newUser.name}, ${newUser.email}');
}
