import 'package:flutter/material.dart';
import 'package:frontend/screens/pages/views/project_create.dart';
import 'package:frontend/models/project_model.dart';
import 'package:frontend/widgets/common/widgets.dart';
import 'package:frontend/widgets/discover/widgets.dart';

typedef ProjectTapCallback = void Function(Project project);

class MyProjectsPage extends StatefulWidget {
  const MyProjectsPage({super.key, this.onProjectTap});
  final ProjectTapCallback? onProjectTap;

  @override
  State<MyProjectsPage> createState() => _MyProjectsPageState();
}

class _MyProjectsPageState extends State<MyProjectsPage> {
  final List<Project> _projects = [];

  @override
  Widget build(BuildContext context) {
    _projects.addAll([
      Project(title: 'Project 1', description: 'Description 1'),
    ]); // TODO: replace with API request
    return Scaffold(
      body: _projects.isEmpty
          ? const Center(child: Text('No projects found'))
          : ListView.separated(
              itemCount: _projects.length,
              separatorBuilder: (context, i) => const VSpace.mediumPlus(),
              itemBuilder: (context, i) {
                final project = _projects[i];
                return ProjectCard(
                  project: project,
                  onTap: () => widget.onProjectTap?.call(project),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProjectCreate()),
        ),
      ),
    );
  }
}
