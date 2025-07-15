class Project {
  final String title;
  final String description;
  final String? logoUrl;
  final List<String> skills;
  final List<String> positions;

  Project({
    required this.title,
    required this.description,
    this.logoUrl,
    this.skills = const [],
    this.positions = const [],
  });
}
