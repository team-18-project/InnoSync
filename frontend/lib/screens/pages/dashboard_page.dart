import 'package:flutter/material.dart';
import '../../widgets/dashboard/widgets.dart';
import '../../widgets/common/widgets.dart';
import '../../theme/colors.dart';
  import '../../theme/dimensions.dart';
import '../repositories/invitation_repository.dart';
import '../repositories/proposal_repository.dart';
import '../repositories/profile_repository.dart';
import '../services/api_service.dart';

class DashboardPage extends StatelessWidget {
  final String token;
  const DashboardPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    final invitationRepository = InvitationRepository(apiService: apiService);
    final proposalRepository = ProposalRepository(apiService: apiService);
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
                tabLabels: const [
                  "Overview",
                  "Projects",
                  "Invitations",
                  "Proposals",
                ],
                tabViews: [
                  OverviewTab(token: token, profileRepository: profileRepository),
                  ProjectsTab(token: token),
                  InvitationsTab(token: token, invitationRepository: invitationRepository),
                  ProposalsTab(token: token, proposalRepository: proposalRepository),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
