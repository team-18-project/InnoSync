import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Vertical spacing widget for consistent spacing between elements
class VSpace extends StatelessWidget {
  final double height;

  const VSpace(this.height, {super.key});

  // Predefined spacing sizes
  const VSpace.small({super.key}) : height = AppTheme.smallSpacing;
  const VSpace.medium({super.key}) : height = AppTheme.defaultSpacing;
  const VSpace.large({super.key}) : height = AppTheme.largeSpacing;

  // Custom spacing with theme-based calculations
  const VSpace.mediumMinus({super.key}) : height = AppTheme.defaultSpacing - 2;
  const VSpace.mediumPlus({super.key}) : height = AppTheme.defaultSpacing + 4;
  const VSpace.mediumPlusPlus({super.key})
    : height = AppTheme.defaultSpacing + 8;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

/// Horizontal spacing widget for consistent spacing between elements
class HSpace extends StatelessWidget {
  final double width;

  const HSpace(this.width, {super.key});

  // Predefined spacing sizes
  const HSpace.small({super.key}) : width = 8;
  const HSpace.medium({super.key}) : width = 16;
  const HSpace.large({super.key}) : width = AppTheme.defaultSpacing;

  // Custom spacing with theme-based calculations
  const HSpace.mediumPlus({super.key}) : width = AppTheme.defaultSpacing + 8;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

/// Fixed height container for layout purposes
class FixedHeightSpace extends StatelessWidget {
  final double height;
  final Widget child;

  const FixedHeightSpace({
    super.key,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, child: child);
  }
}

/// Fixed width container for layout purposes
class FixedWidthSpace extends StatelessWidget {
  final double width;
  final Widget child;

  const FixedWidthSpace({super.key, required this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: child);
  }
}

/// Flexible spacing that takes available space
class FlexibleSpace extends StatelessWidget {
  const FlexibleSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return const Spacer();
  }
}
