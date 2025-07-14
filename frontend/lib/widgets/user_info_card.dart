import 'package:flutter/material.dart';
import 'spacing.dart';
import '../theme/app_theme.dart';

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
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(20),
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
          const VSpace(16),
          Text(name, style: AppTheme.cardTitleStyle),
          const VSpace(8),
          Text(email, style: AppTheme.cardSubtitleStyle),
          const VSpace(16),
          const Text("Bio:", style: AppTheme.cardLabelStyle),
          Text(bio, style: AppTheme.cardBodyStyle),
          const VSpace(16),
          const Text("Positions:", style: AppTheme.cardLabelStyle),
          Text(positions, style: AppTheme.cardBodyStyle),
          const VSpace(16),
          const Text("Technologies:", style: AppTheme.cardLabelStyle),
          Text(technologies, style: AppTheme.cardBodyStyle),
        ],
      ),
    );
  }
}
