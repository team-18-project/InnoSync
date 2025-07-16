import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';
import '../../models/project_model.dart';
import '../../models/talent_model.dart';
import '../../widgets/discover/widgets.dart';
import '../../mixins/search_mixin.dart';
import '../../widgets/common/widgets.dart';

typedef ProjectTapCallback = void Function(Project project);
typedef TalentTapCallback = void Function(Talent talent);

class DiscoverPage extends StatefulWidget {
  final ProjectTapCallback? onProjectTap;
  final TalentTapCallback? onTalentTap;
  const DiscoverPage({super.key, this.onProjectTap, this.onTalentTap});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with SearchMixin {
  final List<Project> _projects = [
    Project(
      id: 1,
      title: 'InnoSync Platform',
      description:
          'A collaborative platform for innovative teams to manage projects and recruitment.',
      logoUrl: null,
      skills: ['Flutter', 'Dart', 'Go', 'React', 'Node.js'],
      positions: ['Full-stack Developer', 'Software Engineer'],
    ),
    Project(
      id: 2,
      title: 'EcoTrack',
      description:
          'Track your carbon footprint and get personalized eco-friendly tips.',
      logoUrl: null,
      skills: ['Flutter', 'Dart', 'Go', 'React', 'Node.js'],
      positions: ['Full-stack Developer', 'Software Engineer'],
    ),
    Project(
      id: 3,
      title: 'HealthSync',
      description: 'A health data aggregator for patients and doctors.',
      logoUrl: null,
      skills: ['Flutter', 'Dart', 'Go', 'React', 'Node.js'],
      positions: ['Full-stack Developer', 'Software Engineer'],
    ),
  ];

  final List<Talent> _talents = [
    Talent(
      name: 'Alex Johnson',
      description:
          'Full-stack developer with expertise in Flutter and Go. Passionate about creating user-friendly applications.',
      yearsOfExperience: 5,
      graduationType: 'Computer Science',
      skills: ['Flutter', 'Dart', 'Go', 'React', 'Node.js'],
      positions: ['Full-stack Developer', 'Software Engineer'],
      location: 'San Francisco, CA',
      email: 'alex.johnson@email.com',
    ),
    Talent(
      name: 'Sarah Chen',
      description:
          'UI/UX designer with a strong background in mobile app design and user research.',
      yearsOfExperience: 3,
      graduationType: 'Design',
      skills: ['Figma', 'Sketch', 'Adobe XD', 'Prototyping'],
      positions: ['UI/UX Designer', 'Product Designer'],
      location: 'New York, NY',
      email: 'sarah.chen@email.com',
    ),
    Talent(
      name: 'Michael Rodriguez',
      description:
          'Backend engineer specializing in scalable systems and cloud architecture.',
      yearsOfExperience: 7,
      graduationType: 'Software Engineering',
      skills: ['Python', 'Java', 'AWS', 'Docker', 'Kubernetes'],
      positions: ['Backend Engineer', 'Software Engineer'],
      location: 'Austin, TX',
      email: 'michael.rodriguez@email.com',
    ),
  ];

  String _searchMode = 'Projects'; // or 'Talents'

  List<Project> get _filteredProjects {
    if (searchFilters.isEmpty) return _projects;
    return _projects.where((project) {
      final text = (project.title + ' ' + project.description + ' ' + project.skills.join(' ') + ' ' + project.positions.join(' ')).toLowerCase();
      return searchFilters.any((filter) => text.contains(filter.toLowerCase()));
    }).toList();
  }

  List<Talent> get _filteredTalents {
    if (searchFilters.isEmpty) return _talents;
    return _talents.where((talent) {
      final text = (talent.name + ' ' + talent.description + ' ' + talent.skills.join(' ') + ' ' + talent.positions.join(' ')).toLowerCase();
      return searchFilters.any((filter) => text.contains(filter.toLowerCase()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Creative switcher
            ModeSwitcher(
              currentMode: _searchMode,
              onModeChanged: (mode) => setState(() => _searchMode = mode),
            ),
            const VSpace.mediumPlusPlus(),
            // Search bar and sort row
            Row(
              children: [
                CustomSearchBar(
                  controller: searchController,
                  onSubmitted: addSearchFilter,
                  onAddFilter: addSearchFilter,
                ),
                const HSpace.medium(),
                SortFilterButton(
                  onTap: () {
                    // TODO: Implement sort/filter logic
                  },
                ),
              ],
            ),
            // Search filter chips
            SearchFilterChips(
              filters: searchFilters,
              onRemoveFilter: removeSearchFilter,
            ),
            const VSpace.large(),
            // Content list (Projects or Talents)
            Expanded(
              child: _searchMode == 'Projects'
                  ? ListView.separated(
                      itemCount: _filteredProjects.length,
                      separatorBuilder: (context, i) =>
                          const VSpace.mediumPlus(),
                      itemBuilder: (context, i) {
                        final project = _filteredProjects[i];
                        return ProjectCard(
                          project: project,
                          onTap: () => widget.onProjectTap?.call(project),
                        );
                      },
                    )
                  : ListView.separated(
                      itemCount: _filteredTalents.length,
                      separatorBuilder: (context, i) =>
                          const VSpace.mediumPlus(),
                      itemBuilder: (context, i) {
                        final talent = _filteredTalents[i];
                        return TalentCard(
                          talent: talent,
                          onTap: () => widget.onTalentTap?.call(talent),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
