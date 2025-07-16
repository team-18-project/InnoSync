import 'package:flutter/material.dart';
import '../../widgets/common/theme_switcher_button.dart';

class MyProjectsPage extends StatefulWidget {
  const MyProjectsPage({super.key});

  @override
  State<MyProjectsPage> createState() => _MyProjectsPageState();
}

class _MyProjectsPageState extends State<MyProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        actions: const [ThemeSwitcherButton()],
      ),
      body: const Center(child: Text('My Projects Page')),
    );
  }
}
