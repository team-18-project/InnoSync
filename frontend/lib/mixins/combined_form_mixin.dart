import 'package:flutter/material.dart';
import 'validation_mixin.dart';
import 'ui_mixin.dart';
import 'form_widgets_mixin.dart';
import 'form_logic_mixin.dart';

// Combined form mixin that provides access to all form functionality
// Use this when you need all form features in one place
// This mixin combines: ValidationMixin, UIMixin, FormWidgetsMixin, and FormLogicMixin
mixin CombinedFormMixin<T extends StatefulWidget> on State<T> {
  // Include all the separated mixins
  ValidationMixin<T> get validation => this as ValidationMixin<T>;
  UIMixin<T> get ui => this as UIMixin<T>;
  FormWidgetsMixin<T> get widgets => this as FormWidgetsMixin<T>;
  FormLogicMixin<T> get logic => this as FormLogicMixin<T>;
}

// Legacy alias for backward compatibility
@Deprecated('Use CombinedFormMixin instead')
mixin BaseFormMixin<T extends StatefulWidget> on State<T> {
  ValidationMixin<T> get validation => this as ValidationMixin<T>;
  UIMixin<T> get ui => this as UIMixin<T>;
  FormWidgetsMixin<T> get widgets => this as FormWidgetsMixin<T>;
  FormLogicMixin<T> get logic => this as FormLogicMixin<T>;
}
