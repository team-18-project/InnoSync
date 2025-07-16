import 'package:flutter/material.dart';
import 'package:frontend/models/invitation_model.dart';
import 'package:frontend/widgets/common/widgets.dart';
import 'package:frontend/widgets/invitation/widgets.dart';

class InvitationsPage extends StatefulWidget {
  final Function(Invitation) onInvitationTap;
  const InvitationsPage({super.key, required this.onInvitationTap});

  @override
  State<InvitationsPage> createState() => _InvitationsPageState();
}

class _InvitationsPageState extends State<InvitationsPage> {
  final List<Invitation> invitations = [
    Invitation(
      id: 1,
      message: 'Message',
      projectId: 1,
      projectRoleId: 1,
      projectTitle: 'Project Title',
      recipientId: 1,
      recipientName: 'Recipient Name',
      respondedAt: DateTime.now(),
      roleName: 'Role Name',
      sentAt: DateTime.now(),
      status: 'INVITED',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: invitations.length,
        separatorBuilder: (context, i) => const VSpace.mediumPlus(),
        itemBuilder: (context, i) => InvitationCard(
          invitation: invitations[i],
          onTap: () => widget.onInvitationTap(invitations[i]),
        ),
        padding: const EdgeInsets.all(24),
      ),
    );
  }
}
