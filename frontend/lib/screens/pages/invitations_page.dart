import 'package:flutter/material.dart';
import '../../widgets/common/theme_switcher_button.dart';

class InvitationsPage extends StatefulWidget {
  const InvitationsPage({super.key});

  @override
  State<InvitationsPage> createState() => _InvitationsPageState();
}

class _InvitationsPageState extends State<InvitationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitations'),
        actions: const [ThemeSwitcherButton()],
      ),
      body: const Center(child: Text('Invitations Page')),
    );
  }
}
