import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:flutter/services.dart';

class ValidatedTextField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback? toggleObscure;

  const ValidatedTextField({
    super.key,
    required this.icon,
    required this.hint,
    this.obscure = false,
    required this.controller,
    this.validator,
    this.toggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      inputFormatters: [
        NoControlCharsFormatter(),
      ],
      decoration: AppTheme.inputDecoration(
        icon: icon,
        hint: hint,
        suffixIcon: toggleObscure != null
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: AppTheme.primaryColor,
                ),
                onPressed: toggleObscure,
              )
            : null,
      ),
    );
  }
}

class NoControlCharsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Удаляем все управляющие символы (код < 32, кроме \n)
    final filtered = newValue.text.replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '');
    return TextEditingValue(
      text: filtered,
      selection: newValue.selection,
    );
  }
}
