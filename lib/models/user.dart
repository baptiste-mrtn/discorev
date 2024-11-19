class User {
  final int id;
  final String name;
  final String email;
  final int roleId; // Peut être null
  final int? companyId; // Peut être null

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    this.companyId,
  });

  // Méthode pour convertir un JSON en objet User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0, // Valeur par défaut si null
      name: json['name'] ?? 'Unknown', // Valeur par défaut si null
      email: json['email'] ?? 'no-email@example.com', // Valeur par défaut si null
      roleId: json['role_id'], // Accepte null
      companyId: json['company_id'], // Accepte null
    );
  }

  // Méthode pour convertir un objet User en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role_id': roleId,
      'company_id': companyId,
    };
  }
}
