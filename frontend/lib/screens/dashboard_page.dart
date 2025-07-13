import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF7FD),
      appBar: AppBar(
        title: const Text('User Dashboard'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Логика для уведомлений
            },
          ),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://example.com/user-avatar.jpg'), // Заменить на реальный URL
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Левый блок с информацией о пользователе
            Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade200, blurRadius: 8),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Фото профиля
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://example.com/user-avatar.jpg'), // Заменить на реальный URL
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Ahmed Baha Eddine Alimi",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const Text("3ilim69@gmail.com", style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 16),
                  const Text("Bio:", style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text(
                    "I am a Computer Science student at Innopolis University...",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  const Text("Positions:", style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text("Frontend Dev, Sys Admin, DB Admin"),
                  const SizedBox(height: 16),
                  const Text("Technologies:", style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text("Angular, React, Vue, PostgreSQL, Docker, Git"),
                ],
              ),
            ),
            const SizedBox(width: 20),
            // Основной блок с вкладками
            Expanded(
              child: DefaultTabController(
                length: 5, // Количество вкладок
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.green,
                      tabs: const [
                        Tab(text: "Overview"),
                        Tab(text: "Projects"),
                        Tab(text: "Invitations"),
                        Tab(text: "Proposals"),
                        Tab(text: "Chats"),
                      ],
                    ),
                    const Expanded(
                      child: TabBarView(
                        children: [
                          // Вкладки
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
            ),
          ],
        ),
      ),
    );
  }
}
