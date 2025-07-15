import 'package:flutter/material.dart';
import '../../theme/colors.dart';
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
    return Container(
      height: AppDimensions.tabHeight,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryDark),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        labelColor: AppColors.textOnPrimary,
        unselectedLabelColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: tabLabels.map((label) => Tab(text: label)).toList(),
      ),
    );
  }
}
