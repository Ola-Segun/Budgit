import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

/// Screen for managing bank account connections
class BankConnectionScreen extends ConsumerStatefulWidget {
  const BankConnectionScreen({super.key});

  @override
  ConsumerState<BankConnectionScreen> createState() => _BankConnectionScreenState();
}

class _BankConnectionScreenState extends ConsumerState<BankConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Connections'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Connect Your Bank Accounts',
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(AppSpacing.md),
            Text(
              'Securely connect your bank accounts to automatically import transactions and get real-time financial insights.',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Gap(AppSpacing.xxxl),

            // Popular Banks Section
            Text(
              'Popular Banks',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(AppSpacing.md),
            _buildPopularBanksGrid(),
            Gap(AppSpacing.xl),

            // Connected Accounts Section
            Text(
              'Connected Accounts',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(AppSpacing.md),
            _buildConnectedAccountsList(),
            Gap(AppSpacing.xl),

            // Security Notice
            Container(
              padding: AppSpacing.cardPaddingAll,
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: AppColors.info,
                    size: AppSpacing.iconMd,
                  ),
                  Gap(AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Your bank data is encrypted and secure. We use read-only access to import transactions and never store your login credentials.',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularBanksGrid() {
    final popularBanks = [
      {'name': 'Chase', 'logo': '🏦'},
      {'name': 'Bank of America', 'logo': '🏦'},
      {'name': 'Wells Fargo', 'logo': '🏦'},
      {'name': 'Citibank', 'logo': '🏦'},
      {'name': 'Capital One', 'logo': '🏦'},
      {'name': 'Discover', 'logo': '🏦'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemCount: popularBanks.length,
      itemBuilder: (context, index) {
        final bank = popularBanks[index];
        return Card(
          elevation: AppSpacing.elevationSm,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: InkWell(
          onTap: () => _connectBank(bank['name']!),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Padding(
            padding: AppSpacing.cardPaddingAll,
              child: Row(
                children: [
                  Text(
                    bank['logo']!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Gap(AppSpacing.sm),
                  Expanded(
                    child: Text(
                      bank['name']!,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.add,
                    color: AppColors.primary,
                    size: AppSpacing.iconMd,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConnectedAccountsList() {
    // TODO: Replace with actual connected accounts from state
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Text(
          'No bank accounts connected yet.\nConnect your first account above.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  void _connectBank(String bankName) {
    // TODO: Implement actual bank connection flow
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connecting to $bankName... (Coming soon)'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}