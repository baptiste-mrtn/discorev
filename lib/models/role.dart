import 'dart:convert';

// Définition de la classe Role
class Role {
  final int id;
  final String name;

  Role({
    required this.id,
    required this.name,
  });

  // Méthode pour convertir un objet Role en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Méthode pour créer un objet Role à partir d'un Map
  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id'],
      name: map['name'],
    );
  }

  // Méthode pour convertir un objet Role en JSON
  String toJson() => json.encode(toMap());

  // Méthode pour créer un objet Role à partir d'un JSON
  factory Role.fromJson(String source) => Role.fromMap(json.decode(source));
}

void main() {
  // Exemple d'utilisation de la classe Role

  // Créer un role
  Role role = Role(id: 1, name: 'user');

  // Convertir en JSON
  String roleJson = role.toJson();
  print('Role en JSON: $roleJson');

  // Créer un role à partir d'un JSON
  Role newRole = Role.fromJson(roleJson);
  print('Nouveau role: ${newRole.name}}');
}
