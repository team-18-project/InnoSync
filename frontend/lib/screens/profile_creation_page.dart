import 'package:flutter/material.dart';
import 'dart:io';
import '../widgets/common/widgets.dart';
import '../widgets/login/widgets.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/dimensions.dart';
import '../theme/app_theme.dart';
import '../repositories/profile_repository.dart';
import '../utils/token_storage.dart';
import '../services/api_service.dart';
import '../utils/ui_helpers.dart';

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
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile Creation', style: AppTextStyles.h2),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingXl),
        child: Column(
          children: [
            ProfileImagePicker(
              profileImage: _profileImage,
              onImagePicked: _onImagePicked,
              backgroundColor: AppColors.profilePickerBackground,
            ),
            const VSpace.lg(),
            _buildInputField('Full Name', _fullNameController, readOnly: true),
            const VSpace.lg(),
            _buildInputField('Email', _emailController, readOnly: true),
            const VSpace.lg(),
            _buildInputField('Telegram', _telegramController),
            const VSpace.lg(),
            _buildInputField('Github', _githubController),
            const VSpace.lg(),
            _buildInputField('Bio', _bioController, maxLines: 4),
            const VSpace.xxl(),
            ElevatedButton(
              style: AppTheme.primaryButtonStyle,
              onPressed: () async {
                final token = await getToken();
                final success = await profileRepository.createProfile(
                  token: token!,
                  name: _fullNameController.text,
                  email: _emailController.text,
                  telegram: _telegramController.text.isEmpty
                      ? null
                      : _telegramController.text,
                  github: _githubController.text.isEmpty
                      ? null
                      : _githubController.text,
                  bio: _bioController.text.isEmpty ? null : _bioController.text,
                );
                if (success) {
                  await saveToken(token!);
                  Navigator.pushReplacementNamed(context, '/main');
                } else {
                  UIHelpers.showError(context, 'Failed to create profile');
                }
              },
              child: const Text('Sign up', style: AppTextStyles.buttonText),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMd,
          horizontal: AppDimensions.paddingLg,
        ),
      ),
    );
  }
}
