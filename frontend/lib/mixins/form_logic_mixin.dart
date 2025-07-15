import 'package:flutter/material.dart';
import 'ui_mixin.dart';
import 'form_widgets_mixin.dart';

// Mixin for form logic and submission handling
mixin FormLogicMixin<T extends StatefulWidget> on State<T> {
  // Common submit method
  void handleSubmit(VoidCallback onSubmit) {
    // This assumes the widget using this mixin also uses FormWidgetsMixin
    // to get access to the formKey
    if (this is FormWidgetsMixin) {
      final formKey = (this as FormWidgetsMixin).formKey;
      if (formKey.currentState!.validate()) {
        if (this is UIMixin) {
          (this as UIMixin).setLoading(true);
        }
        try {
          onSubmit();
        } catch (e) {
          if (this is UIMixin) {
            (this as UIMixin).showError(e.toString());
          }
        } finally {
          if (this is UIMixin) {
            (this as UIMixin).setLoading(false);
          }
        }
      }
    }
  }
}
