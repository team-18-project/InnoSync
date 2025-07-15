import 'package:flutter/material.dart';
import 'dart:io';
import '../widgets/profile_image_picker.dart';
import '../widgets/spacing.dart';
import '../theme/app_theme.dart';
import '../repositories/profile_repository.dart';
import '../utils/token_storage.dart';
import '../services/api_service.dart';

class ProfileCreationPage extends StatefulWidget {
  const ProfileCreationPage({super.key});

  @override
  State<ProfileCreationPage> createState() => _ProfileCreationPageState();
}

class _ProfileCreationPageState extends State<ProfileCreationPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telegramController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  File? _profileImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _emailController.text = args['email'] ?? '';
      _fullNameController.text = args['name'] ?? '';
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _telegramController.dispose();
    _githubController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _onImagePicked(File image) {
    setState(() {
      _profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    final profileRepository = ProfileRepository(apiService: apiService);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Profile Creation'),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          children: [
            ProfileImagePicker(
              profileImage: _profileImage,
              onImagePicked: _onImagePicked,
            ),
            const VSpace.mediumPlus(),
            _buildInputField('Full Name', _fullNameController, readOnly: true),
            const VSpace.mediumPlus(),
            _buildInputField('Email', _emailController, readOnly: true),
            const VSpace.mediumPlus(),
            _buildInputField('Telegram', _telegramController),
            const VSpace.mediumPlus(),
            _buildInputField('Github', _githubController),
            const VSpace.mediumPlus(),
            _buildInputField('Bio', _bioController, maxLines: 4),
            const VSpace.mediumPlusPlus(),
            ElevatedButton(
              style: AppTheme.primaryButtonStyle,
              onPressed: () async {
                final token = await getToken();
                final success = await profileRepository.createProfile(
                  token: token!,
                  name: _fullNameController.text,
                  email: _emailController.text,
                  telegram: _telegramController.text.isEmpty ? null : _telegramController.text,
                  github: _githubController.text.isEmpty ? null : _githubController.text,
                  bio: _bioController.text.isEmpty ? null : _bioController.text,
                );
                if (success) {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to create profile')),
                  );
                }
              },
              child: const Text('Next', style: AppTheme.buttonTextStyle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
    );
  }
}
