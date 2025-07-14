import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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
      height: AppTheme.tabHeight,
      decoration: AppTheme.tabSelectorDecoration,
      child: TabBar(
        controller: controller,
        indicator: AppTheme.tabIndicatorDecoration,
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: tabLabels.map((label) => Tab(text: label)).toList(),
      ),
    );
  }
}
