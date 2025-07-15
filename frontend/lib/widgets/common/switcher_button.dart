import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

class SwitcherButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SwitcherButton({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(24),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(
            color: selected ? AppColors.textOnPrimary : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
