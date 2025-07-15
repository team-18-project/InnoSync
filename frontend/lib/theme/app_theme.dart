import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';
import 'dimensions.dart';

class AppTheme {
  // Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textOnPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
    ),
    minimumSize: const Size(double.infinity, AppDimensions.buttonHeight),
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.error,
    foregroundColor: AppColors.textOnPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
    ),
    minimumSize: const Size(double.infinity, AppDimensions.buttonHeight),
  );

  // Input Field Styles
  static InputDecoration inputDecoration({
    required IconData icon,
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.primary),
      suffixIcon: suffixIcon,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingMd,
      ),
      errorStyle: AppTextStyles.errorText,
    );
  }

  // Container Styles
  static BoxDecoration tabSelectorDecoration = BoxDecoration(
    border: Border.all(color: AppColors.primaryDark),
    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
  );

  static BoxDecoration tabIndicatorDecoration = BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
  );

  // Card decoration
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: AppDimensions.shadowBlur,
        offset: const Offset(0, AppDimensions.shadowOffset),
      ),
    ],
  );
}
