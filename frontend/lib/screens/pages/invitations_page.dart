import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../utils/token_storage.dart';
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
  List<Map<String, dynamic>> _invitations = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchInvitations();
  }

  Future<void> _fetchInvitations() async {
    final token = await getToken();
    if (token == null) return;
    final api = ApiService();
    try {
      final invitations = await api.fetchInvitations(token);
      setState(() {
        _invitations = invitations;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _respondToInvitation(int id, bool accept) async {
    final token = await getToken();
    if (token == null) return;
    // TODO: Replace with actual API call for accept/decline
    setState(() {
      _invitations.removeWhere((inv) => inv['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(accept ? 'Invitation accepted!' : 'Invitation declined!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: _invitations.length,
        separatorBuilder: (context, i) => const VSpace.mediumPlus(),
        itemBuilder: (context, i) => InvitationCard(
          invitation: Invitation.fromJson(_invitations[i]),
          onTap: () =>
              widget.onInvitationTap(Invitation.fromJson(_invitations[i])),
        ),
        padding: const EdgeInsets.all(24),
      ),
    );
  }
}
