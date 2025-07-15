import 'package:flutter/material.dart';

class SearchFilterChips extends StatelessWidget {
  final List<String> filters;
  final Function(String) onRemoveFilter;

  const SearchFilterChips({
    super.key,
    required this.filters,
    required this.onRemoveFilter,
  });

  @override
  Widget build(BuildContext context) {
    if (filters.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (context, i) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final keyword = filters[i];
              return Chip(
                label: Text(
                  keyword,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: const Color(0xFF298217),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                deleteIcon: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Color(0xFF298217),
                  ),
                ),
                onDeleted: () => onRemoveFilter(keyword),
              );
            },
          ),
        ),
      ],
    );
  }
}
