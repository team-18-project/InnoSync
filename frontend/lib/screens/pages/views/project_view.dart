import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';
import '../../../theme/text_styles.dart';
import '../../../models/project_model.dart';
import '../../../widgets/common/widgets.dart';
import '../../../widgets/common/theme_switcher_button.dart';

class ProjectView extends StatelessWidget {
  final Project project;
  final VoidCallback? onBack;
  const ProjectView({super.key, required this.project, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Big square logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: project.logoUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(project.logoUrl!, fit: BoxFit.cover),
                    )
                  : Icon(Icons.apps, size: 64, color: Theme.of(context).colorScheme.onSurface),
            ),
            const VSpace(24),
            // Bold Title
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 28),
              textAlign: TextAlign.center,
            ),
            const VSpace(16),
            // Description
            Text(
              project.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const VSpace(28),
            // Skills Needed
            if (project.skills.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Skills Needed',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
                ),
              ),
              const VSpace(8),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: project.skills
                    .map(
                      (skill) => Chip(
                        label: Text(
                          skill,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const VSpace(24),
            ],
            // Available Positions
            if (project.positions.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Available Positions',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
                ),
              ),
              const VSpace(8),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: project.positions
                    .map(
                      (pos) => Chip(
                        label: Text(
                          pos,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const VSpace(32),
            ],
            // Apply button
            SizedBox(
              width: double.infinity,
              child: SubmitButton(
                text: 'Apply',
                onPressed: () {
                  // TODO: Implement apply logic
                },
                isLoading: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
