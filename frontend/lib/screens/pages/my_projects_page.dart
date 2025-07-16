import 'package:flutter/material.dart';
import 'package:frontend/screens/pages/views/project_create.dart';
import 'package:frontend/models/project_model.dart';
import 'package:frontend/screens/pages/views/project_view.dart';
import 'package:frontend/widgets/common/widgets.dart';
import 'package:frontend/widgets/discover/widgets.dart';

class MyProjectsPage extends StatefulWidget {
  const MyProjectsPage({super.key});

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
          : ListView.builder(
              itemCount: _projects.length,
              itemBuilder: (context, index) => ProjectCard(
                project: _projects[index],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectView(
                      project: _projects[index],
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
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
