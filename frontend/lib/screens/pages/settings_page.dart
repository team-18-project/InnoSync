import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/dimensions.dart';
import '../../widgets/common/theme_switcher_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: const [ThemeSwitcherButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXl),
        child: const Center(
          child: Text('Settings go here'),
        ),
      ),
    );
  }
}
