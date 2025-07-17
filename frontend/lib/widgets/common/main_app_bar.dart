import 'package:flutter/material.dart';
import '../../theme/text_styles.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;

  const MainAppBar({
    super.key,
    this.title,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/main', (route) => false),
            )
          : null,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      elevation: 0,
      title: title != null
          ? Text(title!, style: AppTextStyles.appTitle.copyWith(fontSize: 20))
          : null,
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
