import 'package:flutter/material.dart';

class SortFilterButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? label;

  const SortFilterButton({super.key, this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.sort, color: Colors.black87),
              if (label != null) ...[
                const SizedBox(width: 4),
                Text(
                  label!,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.black87,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
