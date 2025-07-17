import 'package:flutter/material.dart';
import '../../theme/dimensions.dart';

class TabSelector extends StatelessWidget {
  final TabController controller;
  final List<String> tabLabels;

  const TabSelector({
    super.key,
    required this.controller,
    required this.tabLabels,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: AppDimensions.tabHeight,
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.primary),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        labelColor: colorScheme.onPrimary,
        unselectedLabelColor: colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicatorPadding: EdgeInsets.zero,
        tabs: tabLabels.map((label) => Tab(text: label)).toList(),
      ),
    );
  }
}
