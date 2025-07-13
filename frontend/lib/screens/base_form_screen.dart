import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

abstract class BaseFormScreen extends StatefulWidget {
  const BaseFormScreen({super.key});
}

abstract class BaseFormScreenState<T extends BaseFormScreen> extends State<T> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Abstract methods that subclasses must implement
  String get screenTitle;
  String get screenSubtitle;
  Widget buildFormContent();
  void onSubmit();

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

  bool get isLoading => _isLoading;

  // Common submit method
  void handleSubmit() {
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
  Widget buildSubmitButton({required String text, VoidCallback? onPressed}) {
    return ElevatedButton(
      style: AppTheme.primaryButtonStyle,
      onPressed: _isLoading ? null : (onPressed ?? handleSubmit),
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(text, style: AppTheme.buttonTextStyle),
    );
  }

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
              key: _formKey,
              child: Column(
                children: [
                  // Title
                  Text(
                    screenTitle,
                    style: AppTheme.appTitleStyle.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Subtitle
                  Text(screenSubtitle, style: AppTheme.appSubtitleStyle),
                  const SizedBox(height: AppTheme.largeSpacing),
                  // Form content
                  buildFormContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
