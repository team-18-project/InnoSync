class Project {
  final int id;
  final String title;
  final String description;
  final String? logoUrl;
  final List<String> skills;
  final List<String> positions;

  Project({
    required this.id,
    required this.title,
    required this.description,
    this.logoUrl,
    this.skills = const [],
    this.positions = const [],
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      logoUrl: json['logo_url'] as String?,
      skills: (json['skills'] as List?)?.map((e) => e.toString()).toList() ?? [],
      positions: (json['positions'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'logo_url': logoUrl,
    'skills': skills,
    'positions': positions,
  };
}
