import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

/// Card widget for bank connection management
class BankConnectionCard extends ConsumerWidget {
  const BankConnectionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: AppSpacing.elevationSm,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: InkWell(
        onTap: () => _navigateToBankConnection(context),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: AppSpacing.cardPaddingAll,
          child: Row(
            children: [
              Container(
                width: AppSpacing.iconXxl,
                height: AppSpacing.iconXxl,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: AppColors.primary,
                  size: AppSpacing.iconLg,
                ),
              ),
              Gap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connect Bank Accounts',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(AppSpacing.xs),
                    Text(
                      'Automatically sync transactions and get real-time insights',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
                size: AppSpacing.iconMd,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToBankConnection(BuildContext context) {
    // Navigate to bank connection management screen
    context.go('/more/accounts/bank-connection');
  }
}