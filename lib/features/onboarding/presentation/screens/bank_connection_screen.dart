import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/onboarding_providers.dart';

class BankConnectionScreen extends ConsumerStatefulWidget {
  const BankConnectionScreen({super.key});

  @override
  ConsumerState<BankConnectionScreen> createState() => _BankConnectionScreenState();
}

class _BankConnectionScreenState extends ConsumerState<BankConnectionScreen> {
  bool _wantsConnection = false;

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(onboardingProgressProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.border,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ).animate().fadeIn(duration: 300.ms),

              Gap(AppSpacing.xxl),

              // Header
              Text(
                'Connect Your Bank (Optional)',
                style: AppTypography.headlineMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ).animate().slideY(begin: 0.3, duration: 400.ms).fadeIn(),

              Gap(AppSpacing.md),

              Text(
                'Automatically import transactions and stay on top of your spending. You can always do this later.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ).animate().slideY(begin: 0.2, duration: 500.ms).fadeIn(),

              Gap(AppSpacing.xxxl),

              // Bank connection option
              Card(
                elevation: AppSpacing.elevationSm,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  side: BorderSide(
                    color: _wantsConnection ? AppColors.primary : AppColors.border,
                    width: _wantsConnection ? 2 : 1,
                  ),
                ),
                child: InkWell(
                  onTap: () => setState(() => _wantsConnection = true),
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
                                'Connect Bank Account',
                                style: AppTypography.titleMedium.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gap(AppSpacing.xs),
                              Text(
                                'Securely import transactions and get real-time insights',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_wantsConnection)
                          Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                            size: AppSpacing.iconLg,
                          ),
                      ],
                    ),
                  ),
                ),
              ).animate().slideY(begin: 0.1, duration: 600.ms).fadeIn(),

              Gap(AppSpacing.lg),

              // Manual entry option
              Card(
                elevation: AppSpacing.elevationSm,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  side: BorderSide(
                    color: !_wantsConnection ? AppColors.primary : AppColors.border,
                    width: !_wantsConnection ? 2 : 1,
                  ),
                ),
                child: InkWell(
                  onTap: () => setState(() => _wantsConnection = false),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  child: Padding(
                    padding: AppSpacing.cardPaddingAll,
                    child: Row(
                      children: [
                        Container(
                          width: AppSpacing.iconXxl,
                          height: AppSpacing.iconXxl,
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: AppColors.secondary,
                            size: AppSpacing.iconLg,
                          ),
                        ),
                        Gap(AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Transactions Manually',
                                style: AppTypography.titleMedium.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gap(AppSpacing.xs),
                              Text(
                                'Enter transactions yourself for full control',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!_wantsConnection)
                          Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                            size: AppSpacing.iconLg,
                          ),
                      ],
                    ),
                  ),
                ),
              ).animate().slideY(begin: 0.1, duration: 700.ms).fadeIn(),

              Gap(AppSpacing.xl),

              // Security note
              Container(
                padding: AppSpacing.cardPaddingAll,
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(color: AppColors.info.withOpacity(0.3)),
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
                        'Your bank data is encrypted and secure. We use read-only access to import transactions.',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 800.ms),

              Gap(AppSpacing.xxxl),

              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleContinue,
                  style: ElevatedButton.styleFrom(
                    padding: AppSpacing.buttonPaddingAll,
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    elevation: AppSpacing.elevationSm,
                  ),
                  child: Text(
                    'Complete Setup',
                    style: AppTypography.buttonLarge,
                  ),
                ),
              ).animate().slideY(begin: 0.2, duration: 900.ms).fadeIn(),

              Gap(AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }

  void _handleContinue() {
    ref.read(onboardingNotifierProvider.notifier).setBankConnectionPreference(_wantsConnection);
  }
}