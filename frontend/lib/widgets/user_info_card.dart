import 'package:flutter/material.dart';
import 'spacing.dart';

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 8)],
      ),
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
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const VSpace(8),
          Text(email, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const VSpace(16),
          const Text("Bio:", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(bio, style: const TextStyle(fontSize: 14)),
          const VSpace(16),
          const Text(
            "Positions:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(positions, style: const TextStyle(fontSize: 14)),
          const VSpace(16),
          const Text(
            "Technologies:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(technologies, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
