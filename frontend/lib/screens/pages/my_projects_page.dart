import 'package:flutter/material.dart';
import 'package:frontend/screens/pages/views/project_create.dart';

class MyProjectsPage extends StatefulWidget {
  const MyProjectsPage({super.key});

  @override
  State<MyProjectsPage> createState() => _MyProjectsPageState();
}

class _MyProjectsPageState extends State<MyProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('My Projects Page')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProjectCreate()),
        ),
      ),
    );
  }
}
