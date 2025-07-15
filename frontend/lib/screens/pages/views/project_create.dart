import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';
import 'package:frontend/theme/text_styles.dart';
import 'package:frontend/widgets/common/widgets.dart';
import 'package:frontend/widgets/login/widgets.dart';
import 'dart:io';

class ProjectCreate extends StatefulWidget {
  const ProjectCreate({super.key});

  @override
  State<ProjectCreate> createState() => _ProjectCreateState();
}

class _ProjectCreateState extends State<ProjectCreate> {
  File? _logoFile;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> _skills = [];
  final List<String> _positions = [];
  final TextEditingController _skillsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 70,
            ), // leave space for floating chips
            child: Column(
              children: [
                ProfileImagePicker(
                  profileImage: _logoFile,
                  onImagePicked: (file) => setState(() => _logoFile = file),
                  backgroundColor: AppColors.profilePickerBackground,
                ),
                const VSpace.md(),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                const VSpace.md(),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                const VSpace.md(),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _skillsController,
                        decoration: InputDecoration(
                          labelText: 'Skills',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              final value = _skillsController.text.trim();
                              if (value.isNotEmpty) {
                                setState(() {
                                  _skills.add(value);
                                  _skillsController.clear();
                                });
                              }
                            },
                            iconSize: 24,
                          ),
                        ),
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            setState(() {
                              _skills.add(value.trim());
                              _skillsController.clear();
                            });
                          }
                        },
                      ),
                    ),
                    const VSpace.small(),
                  ],
                ),
                const Spacer(),
                SubmitButton(
                  text: 'Create',
                  onPressed: () {
                    setState(() {
                      _titleController.clear();
                      _descriptionController.clear();
                      _skillsController.clear();
                      _skills.clear();
                      _logoFile = null;
                    });
                  },
                  isLoading: false,
                ),
                const VSpace.md(),
              ],
            ),
          ),
          if (_skills.isNotEmpty)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _skills
                        .map(
                          (keyword) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(
                              label: Text(
                                keyword,
                                style: AppTextStyles.bodyLarge.copyWith(
                                  color: AppColors.textOnPrimary,
                                ),
                              ),
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              deleteIcon: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.textOnPrimary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                              ),
                              onDeleted: () =>
                                  setState(() => _skills.remove(keyword)),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
