import 'package:flutter/material.dart';
import 'package:frontend/models/invitation_model.dart';
import 'package:frontend/theme/colors.dart';
import 'package:frontend/theme/text_styles.dart';
import 'package:frontend/widgets/common/widgets.dart';

class InvitationView extends StatelessWidget {
  final Invitation invitation;
  const InvitationView({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) {
    // Get initials for avatar
    String initials = invitation.recipientName.isNotEmpty
        ? invitation.recipientName
              .trim()
              .split(' ')
              .map((e) => e.isNotEmpty ? e[0] : '')
              .take(2)
              .join()
              .toUpperCase()
        : '?';
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                    child: Text(
                      initials,
                      style: AppTextStyles.h3.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  const VSpace(24),
                  Text(
                    invitation.recipientName,
                    style: AppTextStyles.h3.copyWith(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  const VSpace(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.work_outline,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              invitation.roleName,
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.folder_open,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              invitation.projectTitle,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const VSpace(24),
                  Text(
                    invitation.message,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontSize: 17,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const VSpace(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        invitation.sentAt.toString(),
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const VSpace(16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: invitation.status == 'Accepted'
                          ? AppColors.success.withValues(alpha: 0.12)
                          : invitation.status == 'Declined'
                          ? AppColors.error.withValues(alpha: 0.12)
                          : AppColors.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      invitation.status,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: invitation.status == 'Accepted'
                            ? AppColors.primary
                            : invitation.status == 'Declined'
                            ? AppColors.error
                            : AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
