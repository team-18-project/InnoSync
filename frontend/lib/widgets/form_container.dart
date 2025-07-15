import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
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
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: AppTheme.containerWidth,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.defaultPadding,
              vertical: AppTheme.defaultPadding,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (title != null) ...[
                    Text(
                      title!,
                      style: AppTheme.appTitleStyle.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const VSpace(5),
                  ],
                  if (subtitle != null) ...[
                    Text(subtitle!, style: AppTheme.appSubtitleStyle),
                    const VSpace.large(),
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
