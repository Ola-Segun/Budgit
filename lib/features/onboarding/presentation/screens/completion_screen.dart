import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/onboarding_providers.dart';

class CompletionScreen extends ConsumerStatefulWidget {
  const CompletionScreen({super.key});

  @override
  ConsumerState<CompletionScreen> createState() => _CompletionScreenState();
}

class _CompletionScreenState extends ConsumerState<CompletionScreen> {
  bool _isCompleting = false;

  @override
  Widget build(BuildContext context) {
    final onboardingData = ref.watch(onboardingDataProvider);
    final userProfile = ref.watch(userProfileProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(AppSpacing.xxxl),

              // Success animation
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 80,
                ),
              ).animate().scale(duration: 500.ms).then().shake(duration: 300.ms),

              Gap(AppSpacing.xl),

              // Congratulations text
              Text(
                'Congratulations${userProfile?.name != null ? ', ${userProfile!.name}' : ''}!',
                style: AppTypography.headlineLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ).animate().slideY(begin: 0.3, duration: 600.ms).fadeIn(),

              Gap(AppSpacing.md),

              Text(
                'Your budget is ready to go. You\'re all set to take control of your finances!',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ).animate().slideY(begin: 0.2, duration: 700.ms).fadeIn(),

              Gap(AppSpacing.xxxl),

              // Summary cards
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.account_balance_wallet,
                      title: 'Budget Created',
                      value: onboardingData.selectedBudgetType?.displayName ?? 'Custom',
                    ),
                  ),
                  Gap(AppSpacing.md),
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.attach_money,
                      title: 'Monthly Income',
                      value: '\$${onboardingData.totalMonthlyIncome.toStringAsFixed(0)}',
                    ),
                  ),
                ],
              ).animate().slideX(begin: 0.1, duration: 800.ms).fadeIn(),

              Gap(AppSpacing.md),

              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.pie_chart,
                      title: 'Categories',
                      value: '${onboardingData.budgetCategories.length}',
                    ),
                  ),
                  Gap(AppSpacing.md),
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.account_balance,
                      title: 'Bank Sync',
                      value: onboardingData.wantsBankConnection ? 'Enabled' : 'Manual',
                    ),
                  ),
                ],
              ).animate().slideX(begin: 0.1, duration: 900.ms).fadeIn(),

              Gap(AppSpacing.xxxl),

              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isCompleting ? null : _completeOnboarding,
                  icon: _isCompleting
                      ? SizedBox(
                          width: AppSpacing.iconMd,
                          height: AppSpacing.iconMd,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Icon(Icons.rocket_launch, size: AppSpacing.iconMd),
                  label: Text(
                    _isCompleting ? 'Setting up...' : 'Get Started',
                    style: AppTypography.buttonLarge,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: AppSpacing.buttonPaddingAll,
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    elevation: AppSpacing.elevationSm,
                  ),
                ).animate().slideY(begin: 0.2, duration: 1000.ms).fadeIn(),
              ),

              Gap(AppSpacing.xl),

              // Tips
              Container(
                padding: AppSpacing.cardPaddingAll,
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: AppColors.info,
                          size: AppSpacing.iconMd,
                        ),
                        Gap(AppSpacing.sm),
                        Text(
                          'Quick Tips',
                          style: AppTypography.titleSmall.copyWith(
                            color: AppColors.info,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gap(AppSpacing.sm),
                    Text(
                      '• Add your first transaction to see your budget in action\n'
                      '• Set up spending alerts to stay on track\n'
                      '• Review your budget weekly to make adjustments',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 1200.ms),

              Gap(AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    setState(() => _isCompleting = true);

    try {
      final success = await ref.read(onboardingNotifierProvider.notifier).completeOnboarding();

      if (success && mounted) {
        // Navigation will be handled automatically by main.dart when hasCompletedOnboarding changes
        // The provider will trigger a rebuild and show the main app
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Welcome to Budget Tracker!')),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to complete setup. Please try again.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error completing setup: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCompleting = false);
      }
    }
  }

}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSpacing.elevationXs,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: AppSpacing.iconLg,
            ),
            Gap(AppSpacing.sm),
            Text(
              title,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.xs),
            Text(
              value,
              style: AppTypography.titleSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}