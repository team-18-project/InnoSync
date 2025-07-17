import 'package:flutter/material.dart';

class DashboardTabs extends StatelessWidget {
  final List<String> tabLabels;
  final List<Widget> tabViews;
  final Color? indicatorColor;

  const DashboardTabs({
    super.key,
    required this.tabLabels,
    required this.tabViews,
    this.indicatorColor,
  }) : assert(tabLabels.length == tabViews.length);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: tabLabels.length,
      child: Column(
        children: [
          TabBar(
            indicatorColor: indicatorColor ?? theme.colorScheme.primary,
            tabs: tabLabels.map((label) => Tab(text: label)).toList(),
          ),
          Expanded(child: TabBarView(children: tabViews)),
        ],
      ),
    );
  }
}
