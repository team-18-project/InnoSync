import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(
    0xFF40BA21,
  ); // Main green for buttons and primary selection
  static const Color secondaryColor = Color(
    0xFF298217,
  ); // Secondary green for backgrounds and extensions
  static const Color backgroundColor = Color(0xFFFCF7FD);
  static const Color textColor = Colors.black;
  static const Color errorColor = Colors.red;
  static const Color linkColor = Colors.blue;

  // Additional colors to replace hardcoded values
  static const Color cardBackgroundColor = Colors.white;
  static const Color cardShadowColor = Color(
    0xFFE0E0E0,
  ); // Light grey for shadows
  static const Color secondaryTextColor = Color(
    0xFF757575,
  ); // Grey for secondary text
  static const Color appBarColor =
      backgroundColor; // Use background color for app bar
  static const Color tabLabelColor = Colors.white; // For tab labels
  static const Color progressIndicatorColor =
      Colors.white; // For loading indicators
  static const Color profileImagePickerBackground = Color(
    0xFFF0F8F0,
  ); // Light green background for profile picker (keeping light for contrast)

  // Text Styles
  static const TextStyle appTitleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle appSubtitleStyle = TextStyle(
    color: primaryColor,
    fontSize: 14,
  );

  static const TextStyle errorTextStyle = TextStyle(color: errorColor);

  // Additional text styles
  static const TextStyle cardTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle cardSubtitleStyle = TextStyle(
    fontSize: 14,
    color: secondaryTextColor,
  );

  static const TextStyle cardBodyStyle = TextStyle(fontSize: 14);

  static const TextStyle cardLabelStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );

  // Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    minimumSize: const Size(double.infinity, 48),
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: progressIndicatorColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // Input Field Styles
  static InputDecoration inputDecoration({
    required IconData icon,
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: primaryColor),
      suffixIcon: suffixIcon,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(vertical: 14),
      errorStyle: errorTextStyle,
    );
  }

  // Container Styles
  static BoxDecoration tabSelectorDecoration = BoxDecoration(
    border: Border.all(color: secondaryColor),
    borderRadius: BorderRadius.circular(12),
  );

  static BoxDecoration tabIndicatorDecoration = BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.circular(12),
  );

  // Card decoration
  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardBackgroundColor,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: cardShadowColor,
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Spacing
  static const double defaultPadding = 20.0;
  static const double defaultSpacing = 12.0;
  static const double smallSpacing = 8.0;
  static const double largeSpacing = 25.0;

  // Sizes
  static const double tabHeight = 48.0;
  static const double buttonHeight = 48.0;
  static const double containerWidth = 350.0;
  static const double tabViewHeight = 300.0;
}
