import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProjectsTab extends StatefulWidget {
  final String token; // JWT token

  const ProjectsTab({super.key, required this.token});

  @override
  State<ProjectsTab> createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {
  late Future<List<Map<String, dynamic>>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = ApiService.getUserProjects(widget.token);
  }

  void _showCreateProjectDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final teamSizeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Project'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: descController, decoration: InputDecoration(labelText: 'Description')),
            TextField(controller: teamSizeController, decoration: InputDecoration(labelText: 'Team Size'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = titleController.text.trim();
              if (title.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Title is required')),
                );
                return;
              }
              final success = await ApiService.createProject(
                widget.token,
                title,
                descController.text.isEmpty ? null : descController.text,
                int.tryParse(teamSizeController.text),
              );
              if (success) {
                setState(() {
                  _projectsFuture = ApiService.getUserProjects(widget.token);
                });
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to create project')),
                );
              }
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: _showCreateProjectDialog,
            child: Text('Create Project'),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _projectsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Failed to load projects'));
              }
              final projects = snapshot.data ?? [];
              if (projects.isEmpty) {
                return Center(child: Text('No projects found'));
              }
              return ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return ListTile(
                    title: Text(project['title'] ?? ''),
                    subtitle: Text(project['description'] ?? ''),
                    trailing: Text('Team: ${project['team_size'] ?? ''}'),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
