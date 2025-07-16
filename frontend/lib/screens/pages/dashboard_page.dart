import 'package:flutter/material.dart';
import '../../widgets/dashboard/widgets.dart';
import '../../widgets/common/widgets.dart';
import '../../widgets/common/theme_switcher_button.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMd),
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
                tabLabels: const ["Overview", "Proposals", "Chats"],
                tabViews: const [
                  Center(child: Text('Overview content')),
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
