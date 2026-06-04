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
    this.screenshotPaths = const [],
    this.icon = '',
    this.isFeatured = false,
    this.isInDevelopment = false,
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
  final List<String> screenshotPaths;
  final String icon;
  final bool isFeatured;
  final bool isInDevelopment;
}
