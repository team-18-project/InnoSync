import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../utils/token_storage.dart';

class InvitationsPage extends StatefulWidget {
  const InvitationsPage({super.key});

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
      SnackBar(content: Text(accept ? 'Invitation accepted!' : 'Invitation declined!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_invitations.isEmpty) {
      return const Scaffold(body: Center(child: Text('No invitations yet.')));
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: _invitations.length,
        itemBuilder: (context, i) {
          final inv = _invitations[i];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(inv['project_title'] ?? 'Project'),
              subtitle: Text(inv['message'] ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () => _respondToInvitation(inv['id'], true),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => _respondToInvitation(inv['id'], false),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
