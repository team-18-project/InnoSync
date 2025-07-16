import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';
import '../../../theme/text_styles.dart';
import '../../../models/talent_model.dart';
import '../../../widgets/common/widgets.dart';

class TalentView extends StatelessWidget {
  final Talent talent;
  final VoidCallback? onBack;

  const TalentView({super.key, required this.talent, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            CircleAvatar(
              radius: 80,
              backgroundColor: AppColors.textSecondary,
              child: talent.profileImageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.network(
                        talent.profileImageUrl!,
                        fit: BoxFit.cover,
                        width: 160,
                        height: 160,
                      ),
                    )
                  : const Icon(
                      Icons.person,
                      size: 80,
                      color: AppColors.textSecondary,
                    ),
            ),
            const VSpace(24),
            // Name
            Text(
              talent.name,
              style: AppTextStyles.h1.copyWith(fontSize: 28),
              textAlign: TextAlign.center,
            ),
            const VSpace(16),
            // Years and graduation type
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${talent.yearsOfExperience} years experience',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const HSpace.medium(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    talent.graduationType,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const VSpace(20),
            // Description
            Text(
              talent.description,
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const VSpace(28),
            // Skills
            if (talent.skills.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Skills',
                  style: AppTextStyles.cardLabelStyle.copyWith(fontSize: 16),
                ),
              ),
              const VSpace(8),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: talent.skills
                    .map(
                      (skill) => Chip(
                        label: Text(
                          skill,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const VSpace(24),
            ],
            if (talent.positions.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Positions',
                  style: AppTextStyles.cardLabelStyle.copyWith(fontSize: 16),
                ),
              ),
              const VSpace(8),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: talent.positions
                    .map(
                      (position) => Chip(
                        label: Text(
                          position,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const VSpace(24),
            ],
            // Contact Information
            if (talent.email != null || talent.location != null) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contact Information',
                  style: AppTextStyles.cardLabelStyle.copyWith(fontSize: 16),
                ),
              ),
              const VSpace(8),
              if (talent.email != null) ...[
                ListTile(
                  leading: const Icon(
                    Icons.email,
                    color: AppColors.textSecondary,
                  ),
                  title: Text(talent.email!),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
              if (talent.location != null) ...[
                ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    color: AppColors.textSecondary,
                  ),
                  title: Text(talent.location!),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
              const VSpace(32),
            ],
            // Contact button
            SizedBox(
              width: double.infinity,
              child: SubmitButton(
                text: 'Contact',
                onPressed: () async {
                  // TODO: Replace with actual API call if implemented
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Contact request sent! (Demo)'),
                    ),
                  );
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
