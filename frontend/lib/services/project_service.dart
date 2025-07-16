import 'package:dio/dio.dart';
import '../models/project_model.dart';

class ProjectService {
  final Dio dio;
  ProjectService(this.dio);

  Future<List<Project>> getProjects() async {
    final response = await dio.get('/api/v1/projects/me');
    return (response.data as List)
        .map((e) => Project.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> createProject(CreateProjectRequest req) async {
    await dio.post('/api/v1/projects', data: req.toJson());
  }

  Future<void> updateProject(int id, UpdateProjectRequest req) async {
    await dio.put('/api/v1/projects/$id', data: req.toJson());
  }

  Future<void> deleteProject(int id) async {
    await dio.delete('/api/v1/projects/$id');
  }
} 