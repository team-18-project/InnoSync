import 'package:flutter/material.dart';
import '../repositories/proposal_repository.dart';

class ProposalsTab extends StatefulWidget {
  final String token;
  final ProposalRepository proposalRepository;

  const ProposalsTab({
    super.key,
    required this.token,
    required this.proposalRepository,
  });

  @override
  State<ProposalsTab> createState() => _ProposalsTabState();
}

class _ProposalsTabState extends State<ProposalsTab> {
  late Future<List<Map<String, dynamic>>> _proposalsFuture;

  @override
  void initState() {
    super.initState();
    _proposalsFuture = widget.proposalRepository.fetchProposals(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _proposalsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print('ProposalsTab error: ${snapshot.error}');
          return const Center(child: Text('Failed to load proposals'));
        }
        final proposals = snapshot.data ?? [];
        if (proposals.isEmpty) {
          return const Center(child: Text('No proposals found'));
        }
        return ListView.builder(
          itemCount: proposals.length,
          itemBuilder: (context, index) {
            final proposal = proposals[index];
            return ListTile(
              title: Text(proposal['project_title'] ?? ''),
              subtitle: Text(proposal['role_name'] ?? ''),
            );
          },
        );
      },
    );
  }
} 