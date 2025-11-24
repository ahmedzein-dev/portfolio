import '../models/project.dart';
import 'data.dart';

abstract class ProjectRepository {
  List<Project> getProjects();
}

class LocalProjectRepository implements ProjectRepository {
  @override
  List<Project> getProjects() {
    return projects;
  }
}
