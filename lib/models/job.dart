class Job {
  final int id;
  final String title;
  final String description;
  final int salaryRange;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int recruiterId;
  final int companyId;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.salaryRange,
    required this.status,
    required this.recruiterId,
    required this.companyId,
    this.createdAt,
    this.updatedAt
  });

  // Méthode pour convertir une réponse JSON en instance de Job
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      salaryRange: json['salary_range'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      recruiterId: json['recruiter_id'],
      companyId: json['company_id']
    );
  }

  // Méthode pour convertir une instance de Job en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'salary_range': salaryRange,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'recruiter_id': recruiterId,
      'company_id': companyId
    };
  }
}
