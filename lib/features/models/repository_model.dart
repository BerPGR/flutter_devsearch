class RepositoryModel {
  final String name;
  final String? description;
  final int stars;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String htmlUrl;

  RepositoryModel({
    required this.name,
    this.description,
    required this.stars,
    required this.updatedAt,
    required this.createdAt,
    required this.htmlUrl,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'],
      description: json['description'],
      stars: json['stargazers_count'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      htmlUrl: json['html_url'],
    );
  }
}