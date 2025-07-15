import 'package:flutter/material.dart';
import 'dart:io';
import '../widgets/profile_image_picker.dart';
import '../widgets/spacing.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/dimensions.dart';

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
            _buildInputField('Full Name', _fullNameController),
            const VSpace.lg(),
            _buildInputField('Email', _emailController),
            const VSpace.lg(),
            _buildInputField('Telegram', _telegramController),
            const VSpace.lg(),
            _buildInputField('Github', _githubController),
            const VSpace.lg(),
            _buildInputField('Bio', _bioController, maxLines: 4),
            const VSpace.xxl(),
            ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/main');
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
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
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
