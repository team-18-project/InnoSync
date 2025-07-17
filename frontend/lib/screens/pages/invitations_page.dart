import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/api_service.dart';
import '../../utils/token_storage.dart';
import '../../models/invitation_model.dart';
import '../../widgets/common/widgets.dart';
import '../../widgets/invitation/widgets.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';

class InvitationsPage extends ConsumerStatefulWidget {
  final Function(Invitation) onInvitationTap;
  const InvitationsPage({super.key, required this.onInvitationTap});

  @override
  ConsumerState<InvitationsPage> createState() => _InvitationsPageState();
}

class _InvitationsPageState extends ConsumerState<InvitationsPage> {
  List<Invitation> _invitations = [];
  bool _isLoading = true;
  String? _errorMessage;
  int? _processingId; // id приглашения, по которому идёт запрос

  @override
  void initState() {
    super.initState();
    _fetchInvitations();
  }

  Future<void> _fetchInvitations() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final token = await getToken();
      if (token == null) throw Exception('No token');
      final api = ApiService();
      final invitationsData = await api.fetchInvitations(token);
      setState(() {
        _invitations = invitationsData.map((data) => Invitation.fromJson(data)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load invitations: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _updateInvitationStatus(int id, String newStatus) async {
    setState(() {
      _processingId = id;
    });
    try {
      final token = await getToken();
      if (token == null) throw Exception('No token');
      final api = ApiService();
      final ok = await api.respondToInvitation(
        token: token,
        invitationId: id,
        response: newStatus == 'Accepted' ? 'ACCEPTED' : 'DECLINED',
      );
      if (!ok) throw Exception('Failed to update invitation');
      await _fetchInvitations();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to update invitation: ${e.toString()}';
      });
    } finally {
      setState(() {
        _processingId = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: _fetchInvitations,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SelectableText.rich(
            TextSpan(
              text: 'Error: ',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: _errorMessage,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_invitations.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      itemCount: _invitations.length,
      separatorBuilder: (context, index) => const VSpace.mediumPlus(),
      itemBuilder: (context, index) {
        final invitation = _invitations[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InvitationCard(
              invitation: invitation,
              onTap: () => widget.onInvitationTap(invitation),
            ),
            if (invitation.invitationStatus == 'Pending' || invitation.invitationStatus == 'INVITED')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _processingId == invitation.id ? null : () => _updateInvitationStatus(invitation.id, 'Declined'),
                    child: _processingId == invitation.id
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Decline', style: TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _processingId == invitation.id ? null : () => _updateInvitationStatus(invitation.id, 'Accepted'),
                    child: _processingId == invitation.id
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text('Accept'),
                  ),
                ],
              ),
            if (invitation.invitationStatus != 'Pending' && invitation.invitationStatus != 'INVITED')
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  invitation.invitationStatus == 'Accepted' || invitation.invitationStatus == 'ACCEPTED'
                      ? 'Accepted'
                      : 'Declined',
                  style: TextStyle(
                    color: invitation.invitationStatus == 'Accepted' || invitation.invitationStatus == 'ACCEPTED'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
      padding: const EdgeInsets.all(24),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mail_outline,
              size: 80,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            const VSpace.large(),
            Text(
              'No Invitations Yet',
              style: AppTextStyles.h3.copyWith(
                color: AppColors.textSecondary,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const VSpace.medium(),
            Text(
              'When you receive invitations to join projects, they will appear here.',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const VSpace.large(),
            SubmitButton(
              text: 'Refresh',
              isLoading: _isLoading,
              onPressed: _fetchInvitations,
            ),
          ],
        ),
      ),
    );
  }
}
