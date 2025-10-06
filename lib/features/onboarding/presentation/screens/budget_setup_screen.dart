import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../budgets/domain/entities/budget.dart';
import '../providers/onboarding_providers.dart';

class BudgetSetupScreen extends ConsumerStatefulWidget {
  const BudgetSetupScreen({super.key});

  @override
  ConsumerState<BudgetSetupScreen> createState() => _BudgetSetupScreenState();
}

class _BudgetSetupScreenState extends ConsumerState<BudgetSetupScreen> {
  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(onboardingProgressProvider);
    final onboardingData = ref.watch(onboardingDataProvider);
    final totalIncome = onboardingData.totalMonthlyIncome;
    final totalBudget = onboardingData.budgetCategories.fold<double>(0, (sum, cat) => sum + cat.amount);

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
                    'Set Up Your Budget',
                    style: AppTypography.headlineMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().slideY(begin: 0.3, duration: 400.ms).fadeIn(),

                  Gap(AppSpacing.md),

                  Text(
                    'We\'ve created a budget based on your income. You can adjust the amounts or add more categories.',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).animate().slideY(begin: 0.2, duration: 500.ms).fadeIn(),

                  Gap(AppSpacing.lg),

                  // Budget summary
                  Container(
                    padding: AppSpacing.cardPaddingAll,
                    decoration: BoxDecoration(
                      color: totalBudget <= totalIncome ? AppColors.success.withOpacity(0.1) : AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(
                        color: totalBudget <= totalIncome ? AppColors.success.withOpacity(0.3) : AppColors.warning.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Monthly Income',
                              style: AppTypography.titleMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '\$${totalIncome.toStringAsFixed(2)}',
                              style: AppTypography.titleMedium.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Gap(AppSpacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Budget',
                              style: AppTypography.titleMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '\$${totalBudget.toStringAsFixed(2)}',
                              style: AppTypography.titleMedium.copyWith(
                                color: totalBudget <= totalIncome ? AppColors.success : AppColors.warning,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        if (totalBudget > totalIncome) ...[
                          Gap(AppSpacing.sm),
                          Text(
                            'Your budget exceeds your income. Consider reducing some amounts.',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.warning,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ).animate().slideY(begin: 0.1, duration: 600.ms).fadeIn(),

                  Gap(AppSpacing.xl),

                  // Budget categories
                  Text(
                    'Budget Categories',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate().fadeIn(duration: 700.ms),

                  Gap(AppSpacing.md),

                  ...onboardingData.budgetCategories.map((category) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: BudgetCategoryCard(
                          category: category,
                          onAmountChanged: (amount) {
                            ref.read(onboardingNotifierProvider.notifier).updateBudgetCategory(category.id, amount);
                          },
                          onRemove: () {
                            ref.read(onboardingNotifierProvider.notifier).removeBudgetCategory(category.id);
                          },
                        ),
                      ).animate().slideX(begin: 0.1, duration: 800.ms).fadeIn()),

                  Gap(AppSpacing.md),

                  // Add category button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showAddCategoryDialog(context),
                      icon: Icon(
                        Icons.add,
                        color: AppColors.primary,
                        size: AppSpacing.iconMd,
                      ),
                      label: Text(
                        'Add Category',
                        style: AppTypography.buttonMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: AppSpacing.buttonPaddingAll,
                        side: BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                      ),
                    ),
                  ).animate().slideY(begin: 0.1, duration: 900.ms).fadeIn(),

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
                  color: Colors.black.withOpacity(0.05),
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
                    onPressed: onboardingData.budgetCategories.isNotEmpty ? _handleContinue : null,
                    style: ElevatedButton.styleFrom(
                      padding: AppSpacing.buttonPaddingAll,
                      backgroundColor: onboardingData.budgetCategories.isNotEmpty ? AppColors.primary : AppColors.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      elevation: AppSpacing.elevationSm,
                    ),
                    child: Text(
                      'Continue to Bank Connection',
                      style: AppTypography.buttonLarge,
                    ),
                  ),
                ).animate().slideY(begin: 0.2, duration: 1000.ms).fadeIn(),

                Gap(AppSpacing.md),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add Budget Category',
          style: AppTypography.headlineSmall,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Category Name',
                hintText: 'e.g., Entertainment, Transportation',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
              style: AppTypography.bodyLarge,
            ),
            Gap(AppSpacing.md),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monthly Amount',
                hintText: '\$0.00',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
              style: AppTypography.bodyLarge,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: AppTypography.buttonMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final amountText = amountController.text.trim();
              final amount = double.tryParse(amountText) ?? 0.0;

              if (name.isNotEmpty && amount > 0) {
                final category = BudgetCategory(
                  id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
                  name: name,
                  amount: amount,
                );

                ref.read(onboardingNotifierProvider.notifier).addBudgetCategory(category);
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Add',
              style: AppTypography.buttonMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _handleContinue() {
    ref.read(onboardingNotifierProvider.notifier).confirmBudgetSetup();
  }
}

class BudgetCategoryCard extends StatefulWidget {
  const BudgetCategoryCard({
    super.key,
    required this.category,
    required this.onAmountChanged,
    required this.onRemove,
  });

  final BudgetCategory category;
  final ValueChanged<double> onAmountChanged;
  final VoidCallback onRemove;

  @override
  State<BudgetCategoryCard> createState() => _BudgetCategoryCardState();
}

class _BudgetCategoryCardState extends State<BudgetCategoryCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.category.amount.toStringAsFixed(2));
  }

  @override
  void didUpdateWidget(BudgetCategoryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category.amount != widget.category.amount) {
      _controller.text = widget.category.amount.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSpacing.elevationXs,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.category.name,
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(AppSpacing.xs),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: '\$',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      style: AppTypography.bodyMedium,
                      onChanged: (value) {
                        final amount = double.tryParse(value) ?? widget.category.amount;
                        widget.onAmountChanged(amount);
                      },
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: widget.onRemove,
              icon: Icon(
                Icons.delete_outline,
                color: AppColors.danger,
                size: AppSpacing.iconMd,
              ),
            ),
          ],
        ),
      ),
    );
  }
}