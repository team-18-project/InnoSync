import 'package:flutter/material.dart';
import 'package:frontend/models/project_model.dart';
import 'package:frontend/theme/colors.dart';
import 'package:frontend/theme/text_styles.dart';
import 'package:frontend/widgets/common/widgets.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback? onTap;

  const ProjectCard({super.key, required this.project, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                    Text(
                      project.title,
                      style: AppTextStyles.h3.copyWith(fontSize: 20),
                    ),
                    const VSpace.small(),
                    Text(
                      project.description,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
