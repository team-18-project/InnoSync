import 'package:flutter/material.dart';
import 'spacing.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/dimensions.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String bio;
  final String positions;
  final String technologies;
  final String? avatarUrl;
  final double width;
  final double avatarRadius;

  const UserInfoCard({
    super.key,
    required this.name,
    required this.email,
    required this.bio,
    required this.positions,
    required this.technologies,
    this.avatarUrl,
    this.width = 250,
    this.avatarRadius = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: AppDimensions.shadowBlur,
            offset: const Offset(0, AppDimensions.shadowOffset),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingXl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile photo
          CircleAvatar(
            radius: avatarRadius,
            backgroundImage: avatarUrl != null
                ? NetworkImage(avatarUrl!)
                : null,
            child: avatarUrl == null
                ? Icon(Icons.person, size: avatarRadius)
                : null,
          ),
          const VSpace.lg(),
          Text(name, style: AppTextStyles.cardTitle),
          const VSpace.sm(),
          Text(email, style: AppTextStyles.cardSubtitle),
          const VSpace.lg(),
          const Text("Bio:", style: AppTextStyles.cardLabelStyle),
          Text(bio, style: AppTextStyles.bodyMedium),
          const VSpace.lg(),
          const Text("Positions:", style: AppTextStyles.cardLabelStyle),
          Text(positions, style: AppTextStyles.bodyMedium),
          const VSpace.lg(),
          const Text("Technologies:", style: AppTextStyles.cardLabelStyle),
          Text(technologies, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
