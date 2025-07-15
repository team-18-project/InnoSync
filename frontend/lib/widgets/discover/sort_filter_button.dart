import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';
import 'package:frontend/theme/text_styles.dart';

class SortFilterButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? label;

  const SortFilterButton({super.key, this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.sort, color: AppColors.textPrimary),
              if (label != null) ...[
                const SizedBox(width: 4),
                Text(
                  label!,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_drop_down,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
