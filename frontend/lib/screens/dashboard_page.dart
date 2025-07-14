import 'package:flutter/material.dart';
import '../widgets/user_info_card.dart';
import '../widgets/dashboard_tabs.dart';
import '../widgets/spacing.dart';
import '../theme/app_theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('User Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Логика для уведомлений
            },
          ),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              'https://example.com/user-avatar.jpg',
            ), // Заменить на реальный URL
          ),
          const HSpace.medium(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultPadding),
        child: Row(
          children: [
            // Левый блок с информацией о пользователе
            UserInfoCard(
              name: "Ahmed Baha Eddine Alimi",
              email: "3ilim69@gmail.com",
              bio: "I am a Computer Science student at Innopolis University...",
              positions: "Frontend Dev, Sys Admin, DB Admin",
              technologies: "Angular, React, Vue, PostgreSQL, Docker, Git",
              avatarUrl: "https://example.com/user-avatar.jpg",
            ),
            const HSpace.mediumPlus(),
            // Основной блок с вкладками
            Expanded(
              child: DashboardTabs(
                tabLabels: const [
                  "Overview",
                  "Projects",
                  "Invitations",
                  "Proposals",
                  "Chats",
                ],
                tabViews: const [
                  Center(child: Text('Overview content')),
                  Center(child: Text('Projects content')),
                  Center(child: Text('Invitations content')),
                  Center(child: Text('Proposals content')),
                  Center(child: Text('Chats content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
