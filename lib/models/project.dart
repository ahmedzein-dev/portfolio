// models/project.dart
class Project {
  Project({
    required this.title,
    required this.description,
    this.category = '',
    this.year = '',
    this.company = '',
    this.technologies = const [],
    this.features = const [],
    this.url = '',
    this.imagePath = '',
    this.icon = '',
    this.isFeatured = false,
  });

  final String title;
  final String description;
  final String category;
  final String year;
  final String company;
  final List<String> technologies;
  final List<String> features;
  final String url;
  final String imagePath;
  final String icon;
  final bool isFeatured;
}
