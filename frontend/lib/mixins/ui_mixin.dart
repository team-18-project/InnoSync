import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// Mixin for UI functionality
mixin UIMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  // Getters for UI state
  bool get isLoading => _isLoading;

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
}
