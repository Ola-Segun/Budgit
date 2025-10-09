import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../budgets/domain/entities/budget.dart';
import '../providers/onboarding_providers.dart';

class BudgetTypeSelectionScreen extends ConsumerStatefulWidget {
  const BudgetTypeSelectionScreen({super.key});

  @override
  ConsumerState<BudgetTypeSelectionScreen> createState() => _BudgetTypeSelectionScreenState();
}

class _BudgetTypeSelectionScreenState extends ConsumerState<BudgetTypeSelectionScreen> {
  BudgetType? _selectedType;

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(onboardingProgressProvider);

    return SafeArea(
      child: Column(
        children: [
          Expanded(
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
                    'Choose Your Budget Style',
                    style: AppTypography.headlineMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().slideY(begin: 0.3, duration: 400.ms).fadeIn(),

                  Gap(AppSpacing.md),

                  Text(
                    'Select the budgeting method that works best for you. You can change this later.',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).animate().slideY(begin: 0.2, duration: 500.ms).fadeIn(),

                  Gap(AppSpacing.xxxl),

                  // Budget type cards
                  ...BudgetType.values.map((type) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: BudgetTypeCard(
                          type: type,
                          isSelected: _selectedType == type,
                          onTap: () => setState(() => _selectedType = type),
                        ),
                      ).animate().slideY(begin: 0.1, duration: 600.ms + (BudgetType.values.indexOf(type) * 100).ms).fadeIn()),

                  // Add bottom padding to ensure content doesn't get cut off
                  Gap(AppSpacing.xxxl),
                ],
              ),
            ),
          ),
          Container(
            padding: AppSpacing.screenPaddingAll,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Continue button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedType != null ? _handleContinue : null,
                    style: ElevatedButton.styleFrom(
                      padding: AppSpacing.buttonPaddingAll,
                      backgroundColor: _selectedType != null ? AppColors.primary : AppColors.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      elevation: AppSpacing.elevationSm,
                    ),
                    child: Text(
                      'Continue',
                      style: AppTypography.buttonLarge,
                    ),
                  ),
                ).animate().slideY(begin: 0.2, duration: 1000.ms).fadeIn(),

                Gap(AppSpacing.lg),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleContinue() {
    if (_selectedType != null) {
      ref.read(onboardingNotifierProvider.notifier).selectBudgetType(_selectedType!);
    }
  }
}

class BudgetTypeCard extends StatelessWidget {
  const BudgetTypeCard({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  final BudgetType type;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? AppSpacing.elevationMd : AppSpacing.elevationXs,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: AppSpacing.cardPaddingAll,
          child: Row(
            children: [
              // Icon
              Container(
                width: AppSpacing.iconXxl,
                height: AppSpacing.iconXxl,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Icon(
                  _getTypeIcon(type),
                  color: isSelected ? AppColors.primary : AppColors.secondary,
                  size: AppSpacing.iconLg,
                ),
              ),

              Gap(AppSpacing.md),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type.displayName,
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(AppSpacing.xs),
                    Text(
                      type.description,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Selection indicator
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: AppSpacing.iconLg,
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTypeIcon(BudgetType type) {
    switch (type) {
      case BudgetType.zeroBased:
        return Icons.account_balance_wallet;
      case BudgetType.fiftyThirtyTwenty:
        return Icons.pie_chart;
      case BudgetType.envelope:
        return Icons.mail;
      case BudgetType.custom:
        return Icons.settings;
    }
  }
}