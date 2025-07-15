import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:frontend/theme/colors.dart';

class ProfileImagePicker extends StatelessWidget {
  final File? profileImage;
  final Function(File) onImagePicked;
  final double radius;
  final IconData placeholderIcon;
  final Color? backgroundColor;

  const ProfileImagePicker({
    super.key,
    required this.profileImage,
    required this.onImagePicked,
    this.radius = 70,
    this.placeholderIcon = Icons.add_a_photo,
    this.backgroundColor,
  });

  Future<void> _pickImage(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        onImagePicked(File(pickedFile.path));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? AppColors.profilePickerBackground,
        backgroundImage: profileImage != null ? FileImage(profileImage!) : null,
        child: profileImage == null
            ? Icon(placeholderIcon, size: radius, color: AppColors.primary)
            : null,
      ),
    );
  }
}
