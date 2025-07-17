import 'package:flutter/material.dart';
import 'package:frontend/models/invitation_model.dart';
import 'package:frontend/theme/colors.dart';
import 'package:frontend/theme/text_styles.dart';
import 'package:frontend/widgets/common/widgets.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/token_storage.dart';
import 'package:frontend/utils/ui_helpers.dart';

class InvitationCard extends StatefulWidget {
  final Invitation invitation;
  final VoidCallback? onTap;
  final VoidCallback? onActionCompleted;

  const InvitationCard({super.key, required this.invitation, this.onTap, this.onActionCompleted});

  @override
  State<InvitationCard> createState() => _InvitationCardState();
}

class _InvitationCardState extends State<InvitationCard> {
  bool _loading = false;

  Future<void> _respond(String response) async {
    setState(() => _loading = true);
    final token = await getToken();
    if (token == null) {
      UIHelpers.showError(context, 'Не удалось получить токен');
      setState(() => _loading = false);
      return;
    }
    try {
      final api = ApiService();
      final ok = await api.respondToInvitation(
        token: token,
        invitationId: widget.invitation.id,
        response: response,
      );
      if (ok) {
        UIHelpers.showSuccess(context, response == 'ACCEPTED' ? 'Приглашение принято' : 'Приглашение отклонено');
        widget.onActionCompleted?.call();
      } else {
        UIHelpers.showError(context, 'Ошибка при отправке ответа');
      }
    } catch (e) {
      UIHelpers.showError(context, 'Ошибка: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String initials = widget.invitation.recipientName.isNotEmpty
        ? widget.invitation.recipientName
              .trim()
              .split(' ')
              .map((e) => e.isNotEmpty ? e[0] : '')
              .take(2)
              .join()
              .toUpperCase()
        : '?';
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with initials
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                child: Text(
                  initials,
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const HSpace.medium(),
              // Name, description, and details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.invitation.recipientName,
                            style: AppTextStyles.h3.copyWith(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    const VSpace.small(),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.work_outline,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.invitation.roleName,
                                style: AppTextStyles.bodyLarge.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.invitation.projectTitle,
                                style: AppTextStyles.bodyLarge.copyWith(
                                  color: AppColors.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const VSpace.small(),
                    Text(
                      widget.invitation.message ?? '',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                    if (widget.invitation.roleName.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: widget.invitation.roleName
                            .split(' ')
                            .take(3)
                            .map(
                              (skill) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  skill,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                    // Кнопки принятия/отклонения
                    if (widget.invitation.invitationStatus == 'INVITED') ...[
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: SubmitButton(
                              text: 'Принять',
                              isLoading: _loading,
                              onPressed: _loading ? null : () => _respond('ACCEPTED'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SubmitButton(
                              text: 'Отклонить',
                              isLoading: _loading,
                              onPressed: _loading ? null : () => _respond('DECLINED'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
