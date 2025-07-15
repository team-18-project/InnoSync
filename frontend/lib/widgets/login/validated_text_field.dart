import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';

class ValidatedTextField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscure;
  final VoidCallback? toggleObscure;

  const ValidatedTextField({
    super.key,
    required this.icon,
    required this.hint,
    required this.controller,
    this.validator,
    this.obscure = false,
    this.toggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primary),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMd,
        ),
        suffixIcon: toggleObscure != null
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primary,
                ),
                onPressed: toggleObscure,
              )
            : null,
      ),
    );
  }
}
