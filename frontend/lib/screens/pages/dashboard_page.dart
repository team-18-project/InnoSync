import 'package:flutter/material.dart';
import '../../widgets/common/widgets.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../repositories/profile_repository.dart';
import '../../services/api_service.dart';
import '../../utils/token_storage.dart';
import '../profile_creation_page.dart';
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
                  // Overview tab content
                  _DashboardOverviewTab(token: token),
                  // Proposals tab content
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

class _DashboardOverviewTab extends StatefulWidget {
  final String token;
  const _DashboardOverviewTab({required this.token});

  @override
  State<_DashboardOverviewTab> createState() => _DashboardOverviewTabState();
}

class _DashboardOverviewTabState extends State<_DashboardOverviewTab> {
  int _projectsCount = 0;
  int _invitationsCount = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  Future<void> _fetchStats() async {
    setState(() => _loading = true);
    try {
      final projects = await ApiService.getUserProjects(widget.token);
      final api = ApiService();
      final invitations = await api.fetchInvitations(widget.token);
      setState(() {
        _projectsCount = projects.length;
        _invitationsCount = invitations.length;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to your Dashboard!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.account_circle, size: 40, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Here you can track your projects, proposals, and invitations.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Card(
                  color: AppColors.primary.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Icon(Icons.folder, size: 32, color: AppColors.primary),
                        const SizedBox(height: 8),
                        Text('My Projects: $_projectsCount'),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  color: AppColors.primary.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Icon(Icons.mail, size: 32, color: AppColors.primary),
                        const SizedBox(height: 8),
                        Text('Invitations: $_invitationsCount'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Дополнительная информация
          Card(
            color: AppColors.primary.withOpacity(0.07),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Additional info:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('• You can edit your profile, manage your projects and invitations.'),
                  Text('• Stay tuned for more analytics and features!'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
              onPressed: () async {
                final profileRepository = ProfileRepository(apiService: ApiService());
                final profile = await profileRepository.fetchProfile(widget.token);
                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileCreationPage(profileData: profile),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
