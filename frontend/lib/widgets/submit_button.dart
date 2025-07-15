import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'spacing.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const SubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: AppTheme.primaryButtonStyle,
      onPressed: isLoading ? null : onPressed,
      child: isLoading
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
}
