import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../theme/dimensions.dart';
import 'spacing.dart';

class FormContainer extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final GlobalKey<FormState> formKey;

  const FormContainer({
    super.key,
    required this.child,
    required this.formKey,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: AppDimensions.containerWidth,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingXl,
              vertical: AppDimensions.paddingXl,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (title != null) ...[
                    Text(title!, style: AppTextStyles.appTitle),
                    const VSpace.xs(),
                  ],
                  if (subtitle != null) ...[
                    Text(subtitle!, style: AppTextStyles.appSubtitle),
                    const VSpace.xl(),
                  ],
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
