import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';
import '../../models/project_model.dart';
import '../../models/talent_model.dart';
import '../../widgets/discover/widgets.dart';
import '../../mixins/search_mixin.dart';
import '../../widgets/common/widgets.dart';
import '../../widgets/common/theme_switcher_button.dart';

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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Discover'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: const [ThemeSwitcherButton()],
      ),
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
                      separatorBuilder: (context, i) => const VSpace.mediumPlus(),
                      itemBuilder: (context, i) {
                        final project = _projects[i];
                        return Card(
                          color: Theme.of(context).colorScheme.surface,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Logo or placeholder
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: project.logoUrl != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.network(
                                            project.logoUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Icon(
                                          Icons.apps,
                                          size: 32,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                ),
                                const HSpace.small(),
                                // Title and description
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(project.title, style: Theme.of(context).textTheme.titleMedium),
                                      const VSpace.small(),
                                      Text(
                                        project.description,
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.separated(
                      itemCount: _talents.length,
                      separatorBuilder: (context, i) => const VSpace.mediumPlus(),
                      itemBuilder: (context, i) {
                        final talent = _talents[i];
                        return Card(
                          color: Theme.of(context).colorScheme.surface,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Logo or placeholder
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: talent.profileImageUrl != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.network(
                                            talent.profileImageUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Icon(
                                          Icons.person,
                                          size: 32,
                                          color: Theme.of(context).colorScheme.secondary,
                                        ),
                                ),
                                const HSpace.small(),
                                // Title and description
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(talent.name, style: Theme.of(context).textTheme.titleMedium),
                                      const VSpace.small(),
                                      Text(
                                        talent.description,
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
