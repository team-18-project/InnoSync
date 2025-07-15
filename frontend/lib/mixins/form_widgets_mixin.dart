import 'package:flutter/material.dart';
import '../widgets/submit_button.dart';
import '../widgets/form_container.dart';

// Mixin for form widget builders
mixin FormWidgetsMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Getters for form state
  GlobalKey<FormState> get formKey => _formKey;

  // Common button widget
  Widget buildSubmitButton({
    required String text,
    required VoidCallback onPressed,
    bool? isLoading,
  }) {
    return SubmitButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading ?? false,
    );
  }

  // Common form container
  Widget buildFormContainer({
    required Widget child,
    String? title,
    String? subtitle,
  }) {
    return FormContainer(
      formKey: _formKey,
      title: title,
      subtitle: subtitle,
      child: child,
    );
  }
}
