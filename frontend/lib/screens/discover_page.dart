import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/project_model.dart';
import '../widgets/common/widgets.dart';
import '../theme/text_styles.dart';

typedef ProjectTapCallback = void Function(Project project);

class DiscoverPage extends StatefulWidget {
  final ProjectTapCallback? onProjectTap;
  const DiscoverPage({super.key, this.onProjectTap});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final List<Project> _projects = [
    Project(
      title: 'InnoSync Platform',
      description:
          'A collaborative platform for innovative teams to manage projects and recruitment.',
      logoUrl: null,
    ),
    Project(
      title: 'EcoTrack',
      description:
          'Track your carbon footprint and get personalized eco-friendly tips.',
      logoUrl: null,
    ),
    Project(
      title: 'HealthSync',
      description: 'A health data aggregator for patients and doctors.',
      logoUrl: null,
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchFilters = [];

  String _searchMode = 'Projects'; // or 'Talents'

  void _addSearchFilter(String value) {
    final keyword = value.trim();
    if (keyword.isNotEmpty && !_searchFilters.contains(keyword)) {
      setState(() {
        _searchFilters.add(keyword);
      });
    }
    _searchController.clear();
  }

  void _removeSearchFilter(String keyword) {
    setState(() {
      _searchFilters.remove(keyword);
    });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      ModeSwitcher(
                        currentMode: _searchMode,
                        onModeChanged: (mode) =>
                            setState(() => _searchMode = mode),
                      ),
                      ModeSwitcher(
                        currentMode: _searchMode,
                        onModeChanged: (mode) =>
                            setState(() => _searchMode = mode),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const VSpace.medium(),
            // Search bar and sort row
            Row(
              children: [
                // Search bar
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: _addSearchFilter,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: AppColors.textSecondary,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () =>
                            _addSearchFilter(_searchController.text),
                      ),
                    ),
                  ),
                ),
                const HSpace.small(),
                // Sort/filter button with small triangle
                Material(
                  color: AppColors.textSecondary,
                  borderRadius: BorderRadius.circular(12.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      // TODO: Implement sort/filter logic
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.sort, color: AppColors.textPrimary),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.textPrimary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Search filter chips
            if (_searchFilters.isNotEmpty) ...[
              const VSpace.small(),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _searchFilters.length,
                  separatorBuilder: (context, i) => const HSpace.small(),
                  itemBuilder: (context, i) {
                    final keyword = _searchFilters[i];
                    return Chip(
                      label: Text(
                        keyword,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      deleteIcon: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.textOnPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      onDeleted: () => _removeSearchFilter(keyword),
                    );
                  },
                ),
              ),
            ],
            const VSpace.medium(),
            // Project list
            Expanded(
              child: ListView.separated(
                itemCount: _projects.length,
                separatorBuilder: (context, i) => const VSpace.medium(),
                itemBuilder: (context, i) {
                  final project = _projects[i];
                  return GestureDetector(
                    onTap: () => widget.onProjectTap?.call(project),
                    child: Card(
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
                                color: AppColors.textSecondary,
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
                                  : const Icon(
                                      Icons.apps,
                                      size: 32,
                                      color: AppColors.textSecondary,
                                    ),
                            ),
                            const HSpace.small(),
                            // Title and description
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(project.title, style: AppTextStyles.h3),
                                  const VSpace.small(),
                                  Text(
                                    project.description,
                                    style: AppTextStyles.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
