import 'package:flutter/material.dart';
import '../repositories/profile_repository.dart';

class OverviewTab extends StatefulWidget {
  final String token;
  final ProfileRepository profileRepository;

  const OverviewTab({
    super.key,
    required this.token,
    required this.profileRepository,
  });

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  late Future<Map<String, dynamic>> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = widget.profileRepository.fetchProfile(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print('OverviewTab error: ${snapshot.error}');
          return const Center(child: Text('Failed to load profile'));
        }
        final profile = snapshot.data;
        if (profile == null) {
          return const Center(child: Text('No profile found'));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${profile['name'] ?? ''}', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('Email: ${profile['email'] ?? ''}'),
              const SizedBox(height: 8),
              Text('Bio: ${profile['bio'] ?? ''}'),
              // Добавь другие поля профиля по необходимости
            ],
          ),
        );
      },
    );
  }
} 