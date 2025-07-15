import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';
import '../../models/project_model.dart';
import '../../models/talent_model.dart';
import '../../widgets/mode_switcher.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/sort_filter_button.dart';
import '../../widgets/search_filter_chips.dart';
import '../../widgets/project_card.dart';
import '../../widgets/talent_card.dart';
import '../../mixins/search_mixin.dart';
import '../../widgets/spacing.dart';

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
      title: 'InnoSync Platform',
      description:
          'A collaborative platform for innovative teams to manage projects and recruitment.',
      logoUrl: null,
      skills: ['Flutter', 'Dart', 'Go', 'React', 'Node.js'],
      positions: ['Full-stack Developer', 'Software Engineer'],
    ),
    Project(
      title: 'EcoTrack',
      description:
          'Track your carbon footprint and get personalized eco-friendly tips.',
      logoUrl: null,
      skills: ['Flutter', 'Dart', 'Go', 'React', 'Node.js'],
      positions: ['Full-stack Developer', 'Software Engineer'],
    ),
    Project(
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
                      itemCount: _projects.length,
                      separatorBuilder: (context, i) =>
                          const VSpace.mediumPlus(),
                      itemBuilder: (context, i) {
                        final project = _projects[i];
                        return ProjectCard(
                          project: project,
                          onTap: () => widget.onProjectTap?.call(project),
                        );
                      },
                    )
                  : ListView.separated(
                      itemCount: _talents.length,
                      separatorBuilder: (context, i) =>
                          const VSpace.mediumPlus(),
                      itemBuilder: (context, i) {
                        final talent = _talents[i];
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
