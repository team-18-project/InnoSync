import 'package:flutter/material.dart';
import 'package:frontend/theme/colors.dart';

class DashboardTabs extends StatelessWidget {
  final List<String> tabLabels;
  final List<Widget> tabViews;
  final Color indicatorColor;

  const DashboardTabs({
    super.key,
    required this.tabLabels,
    required this.tabViews,
    this.indicatorColor = AppColors.primary,
  }) : assert(tabLabels.length == tabViews.length);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabLabels.length,
      child: Column(
        children: [
          TabBar(
            indicatorColor: indicatorColor,
            tabs: tabLabels.map((label) => Tab(text: label)).toList(),
          ),
          Expanded(child: TabBarView(children: tabViews)),
        ],
      ),
    );
  }
}
