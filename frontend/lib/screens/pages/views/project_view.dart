import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';
import '../../../theme/text_styles.dart';
import '../../../models/project_model.dart';
import '../../../widgets/common/widgets.dart';

class ProjectView extends StatelessWidget {
  final Project project;
  final VoidCallback? onBack;
  const ProjectView({super.key, required this.project, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(24),
              ),
              child: project.logoUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(project.logoUrl!, fit: BoxFit.cover),
                    )
                  : const Icon(Icons.apps, size: 64, color: Colors.grey),
            ),
            const VSpace(24),
            // Bold Title
            Text(
              project.title,
              style: AppTextStyles.h1.copyWith(fontSize: 28),
              textAlign: TextAlign.center,
            ),
            const VSpace(16),
            // Description
            Text(
              project.description,
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const VSpace(28),
            // Skills Needed
            if (project.skills.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Skills Needed',
                  style: AppTextStyles.cardLabelStyle.copyWith(fontSize: 16),
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
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xFF298217),
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
                  style: AppTextStyles.cardLabelStyle.copyWith(fontSize: 16),
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
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: const Color(0xFF298217),
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
