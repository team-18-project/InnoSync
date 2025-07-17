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

  // Моковые данные для приглашений
  final List<Invitation> _mockInvitations = [
    Invitation(
      id: 1,
      message: 'Join our Flutter project as a developer!',
      projectId: 101,
      projectRoleId: 201,
      projectTitle: 'FlutterApp',
      recipientId: 301,
      recipientName: 'Alice Johnson',
      respondedAt: null,
      roleName: 'Flutter Developer',
      sentAt: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Pending',
    ),
    Invitation(
      id: 2,
      message: 'We need your expertise in backend development.',
      projectId: 102,
      projectRoleId: 202,
      projectTitle: 'BackendAPI',
      recipientId: 302,
      recipientName: 'Bob Smith',
      respondedAt: null,
      roleName: 'Backend Developer',
      sentAt: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Accepted',
    ),
  ];

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

    // Используем моковые данные вместо API
    await Future.delayed(const Duration(seconds: 1)); // имитация загрузки
    setState(() {
      _invitations = _mockInvitations;
      _isLoading = false;
    });
  }

  void _updateInvitationStatus(int id, String newStatus) {
    setState(() {
      _invitations = _invitations.map((inv) {
        if (inv.id == id) {
          return Invitation(
            id: inv.id,
            message: inv.message,
            projectId: inv.projectId,
            projectRoleId: inv.projectRoleId,
            projectTitle: inv.projectTitle,
            recipientId: inv.recipientId,
            recipientName: inv.recipientName,
            respondedAt: DateTime.now(),
            roleName: inv.roleName,
            sentAt: inv.sentAt,
            status: newStatus,
          );
        }
        return inv;
      }).toList();
    });
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
            if (invitation.status == 'Pending')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _updateInvitationStatus(invitation.id, 'Declined'),
                    child: const Text('Decline', style: TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _updateInvitationStatus(invitation.id, 'Accepted'),
                    child: const Text('Accept'),
                  ),
                ],
              ),
            if (invitation.status != 'Pending')
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  invitation.status == 'Accepted' ? 'Accepted' : 'Declined',
                  style: TextStyle(
                    color: invitation.status == 'Accepted'
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
