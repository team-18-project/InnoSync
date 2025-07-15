import 'package:flutter/material.dart';
import 'pages/discover_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/invitations_page.dart';
import 'pages/my_projects_page.dart';
import '../theme/colors.dart';
import '../widgets/main_app_bar.dart';
import 'pages/views/project_view.dart';
import 'pages/views/talent_view.dart';
import '../models/project_model.dart';
import '../models/talent_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  Project? _selectedProject;
  Talent? _selectedTalent;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      DiscoverPage(
        onProjectTap: (project) {
          setState(() {
            _selectedProject = project;
            _selectedTalent = null;
          });
        },
        onTalentTap: (talent) {
          setState(() {
            _selectedTalent = talent;
            _selectedProject = null;
          });
        },
      ),
      const InvitationsPage(),
      const MyProjectsPage(),
      const DashboardPage(),
    ]);
  }

  void _goBackFromView() {
    setState(() {
      _selectedProject = null;
      _selectedTalent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: 'InnoSync'),
      body: _selectedProject != null
          ? ProjectView(project: _selectedProject!, onBack: _goBackFromView)
          : _selectedTalent != null
          ? TalentView(talent: _selectedTalent!, onBack: _goBackFromView)
          : _pages[_currentIndex],
      bottomNavigationBar: (_selectedProject == null && _selectedTalent == null)
          ? BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Discover',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.mail),
                  label: 'Invitations',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.folder),
                  label: 'My Projects',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
              ],
            )
          : null,
    );
  }
}
