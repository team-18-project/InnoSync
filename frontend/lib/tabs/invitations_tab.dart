import 'package:flutter/material.dart';
import '../repositories/invitation_repository.dart';

class InvitationsTab extends StatefulWidget {
  final String token;
  final InvitationRepository invitationRepository;

  const InvitationsTab({
    super.key,
    required this.token,
    required this.invitationRepository,
  });

  @override
  State<InvitationsTab> createState() => _InvitationsTabState();
}

class _InvitationsTabState extends State<InvitationsTab> {
  late Future<List<Map<String, dynamic>>> _invitationsFuture;

  @override
  void initState() {
    super.initState();
    _invitationsFuture = widget.invitationRepository.fetchInvitations(widget.token);
  }

  void _showCreateInvitationDialog() {
    final projectRoleIdController = TextEditingController();
    final recipientIdController = TextEditingController();
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Invitation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: projectRoleIdController,
              decoration: const InputDecoration(labelText: 'Project Role ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: recipientIdController,
              decoration: const InputDecoration(labelText: 'Recipient User ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: messageController,
              decoration: const InputDecoration(labelText: 'Message (optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final projectRoleId = int.tryParse(projectRoleIdController.text);
              final recipientId = int.tryParse(recipientIdController.text);
              if (projectRoleId == null || recipientId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Project Role ID and Recipient User ID are required')),
                );
                return;
              }
              final success = await widget.invitationRepository.createInvitation(
                token: widget.token,
                projectRoleId: projectRoleId,
                recipientId: recipientId,
                message: messageController.text.isEmpty ? null : messageController.text,
              );
              if (success) {
                setState(() {
                  _invitationsFuture = widget.invitationRepository.fetchInvitations(widget.token);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invitation created successfully')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to create invitation')),
                );
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: _showCreateInvitationDialog,
            child: const Text('Create Invitation'),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _invitationsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                print('InvitationsTab error: ${snapshot.error}');
                return const Center(child: Text('Failed to load invitations'));
              }
              final invitations = snapshot.data ?? [];
              if (invitations.isEmpty) {
                return const Center(child: Text('No invitations found'));
              }
              return ListView.builder(
                itemCount: invitations.length,
                itemBuilder: (context, index) {
                  final invitation = invitations[index];
                  return ListTile(
                    title: Text(invitation['project_title'] ?? ''),
                    subtitle: Text(invitation['role_name'] ?? ''),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
} 