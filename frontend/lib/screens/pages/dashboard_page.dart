import 'package:flutter/material.dart';
import '../../widgets/common/widgets.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../repositories/profile_repository.dart';
import '../../services/api_service.dart';
import '../../widgets/dashboard/widgets.dart';

class DashboardPage extends StatelessWidget {
  final String token;
  const DashboardPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    final profileRepository = ProfileRepository(apiService: apiService);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('User Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Notification logic
            },
          ),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              'https://www.google.com/url?sa=i&url=https%3A%2F%2Fru.pinterest.com%2Fpin%2F713468766005290935%2F&psig=AOvVaw2oNFO-cJe-cCtNjKp3p_xR&ust=1752659042989000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCLDHqvjJvo4DFQAAAAAdAAAAABAE',
            ),
          ),
          const HSpace.medium(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMd),
        child: Row(
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: profileRepository.fetchProfile(token),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: 250,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError || snapshot.data == null) {
                  return UserInfoCard(
                    name: "-",
                    email: "-",
                    bio: "-",
                    positions: "-",
                    technologies: "-",
                    avatarUrl: null,
                  );
                }
                final profile = snapshot.data!;
                return UserInfoCard(
                  name: profile['name'] ?? '-',
                  email: profile['email'] ?? '-',
                  bio: profile['bio'] ?? '-',
                  positions: profile['position'] ?? '-',
                  technologies: (profile['technologies'] is List)
                      ? (profile['technologies'] as List)
                            .map((t) => t['name'] ?? '')
                            .where((t) => t.isNotEmpty)
                            .join(', ')
                      : '-',
                  avatarUrl: profile['avatar_url'],
                );
              },
            ),
            const HSpace.mediumPlus(),
            Expanded(
              child: DashboardTabs(
                tabLabels: const ["Overview", "Proposals"],
                tabViews: [
                  // --- Overview Content ---
                  Builder(
                    builder: (context) {
                      // Try to get the profile from the FutureBuilder above
                      // (not ideal, but for mockup, just use a placeholder)
                      final String userName = 'Welcome!';
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome to InnoSync!',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Here is a quick overview of your activity.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                _StatCard(
                                  label: 'Projects',
                                  value: '3',
                                  icon: Icons.folder,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 16),
                                _StatCard(
                                  label: 'Invitations',
                                  value: '2',
                                  icon: Icons.mail,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 16),
                                _StatCard(
                                  label: 'Proposals',
                                  value: '1',
                                  icon: Icons.assignment,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Text(
                              'Next Steps',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('• Complete your profile for better matches.'),
                                    SizedBox(height: 4),
                                    Text('• Explore new projects and send proposals.'),
                                    SizedBox(height: 4),
                                    Text('• Respond to invitations from other teams.'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // --- Proposals Content ---
                  Center(child: Text('Proposals content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
