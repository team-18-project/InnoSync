import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/screens/pages/views/profile_content.dart';

class DashboardPage extends StatelessWidget {
  final String token;
  const DashboardPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiService.fetchProfile(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text('Failed to load profile data'));
          }
          return ProfileContent(profile: snapshot.data!);
        },
      ),
    );
  }
}
