class Company {
  final int id;
  final String name;
  final int siren;
  final String? description;
  final String? sector;

  Company({
    required this.id,
    required this.name,
    required this.siren,
    this.description,
    this.sector,
  });

  // Méthode pour convertir une réponse JSON en instance de Company
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['company_name'],
      siren: json['company_siren'],
      description: json['company_description'],
      sector: json['company_industry'],
    );
  }

  // Méthode pour convertir une instance de Company en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': name,
      'company_siren': siren,
      'company_description': description,
      'company_industry': sector,
    };
  }
}
