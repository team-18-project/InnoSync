import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/spacing.dart';

// Mixin for form functionality
mixin BaseFormMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Getters for form state
  GlobalKey<FormState> get formKey => _formKey;
  bool get isLoading => _isLoading;

  // Common validation methods
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Common UI methods
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppTheme.errorColor),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppTheme.primaryColor),
    );
  }

  void setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  // Common submit method
  void handleSubmit(VoidCallback onSubmit) {
    if (_formKey.currentState!.validate()) {
      setLoading(true);
      try {
        onSubmit();
      } catch (e) {
        showError(e.toString());
      } finally {
        setLoading(false);
      }
    }
  }

  // Common button widget
  Widget buildSubmitButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: AppTheme.primaryButtonStyle,
      onPressed: _isLoading ? null : onPressed,
      child: _isLoading
          ? const FixedHeightSpace(
              height: 20,
              child: FixedWidthSpace(
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.progressIndicatorColor,
                  ),
                ),
              ),
            )
          : Text(text, style: AppTheme.buttonTextStyle),
    );
  }

  // Common form container
  Widget buildFormContainer({
    required Widget child,
    String? title,
    String? subtitle,
  }) {
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
              key: _formKey,
              child: Column(
                children: [
                  if (title != null) ...[
                    Text(
                      title,
                      style: AppTheme.appTitleStyle.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const VSpace(5),
                  ],
                  if (subtitle != null) ...[
                    Text(subtitle, style: AppTheme.appSubtitleStyle),
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
