import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/income_source.dart';
import '../providers/onboarding_providers.dart';

class IncomeEntryScreen extends ConsumerStatefulWidget {
  const IncomeEntryScreen({super.key});

  @override
  ConsumerState<IncomeEntryScreen> createState() => _IncomeEntryScreenState();
}

class _IncomeEntryScreenState extends ConsumerState<IncomeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  PayFrequency _selectedFrequency = PayFrequency.monthly;
  final bool _isAddingIncome = false;

  final _currencyFormatter = CurrencyTextInputFormatter.currency(
    locale: 'en_US',
    decimalDigits: 2,
    symbol: '\$',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _addIncomeSource() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final amountText = _amountController.text.replaceAll('\$', '').replaceAll(',', '').trim();
    final amount = double.tryParse(amountText) ?? 0.0;

    if (amount <= 0) return;

    final incomeSource = IncomeSource(
      id: 'income_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      amount: amount,
      frequency: _selectedFrequency,
    );

    ref.read(onboardingNotifierProvider.notifier).addIncomeSource(incomeSource);

    // Clear form
    _nameController.clear();
    _amountController.clear();
    setState(() => _selectedFrequency = PayFrequency.monthly);
  }

  void _removeIncomeSource(String id) {
    ref.read(onboardingNotifierProvider.notifier).removeIncomeSource(id);
  }

  void _handleContinue() {
    final onboardingData = ref.read(onboardingDataProvider);
    if (onboardingData.incomeSources.isNotEmpty) {
      ref.read(onboardingNotifierProvider.notifier).confirmIncome();
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(onboardingProgressProvider);
    final onboardingData = ref.watch(onboardingDataProvider);
    final totalMonthlyIncome = onboardingData.totalMonthlyIncome;

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
                    'Tell us about your income',
                    style: AppTypography.headlineMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().slideY(begin: 0.3, duration: 400.ms).fadeIn(),

                  Gap(AppSpacing.md),

                  Text(
                    'Add all your income sources to help us create the perfect budget for you.',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).animate().slideY(begin: 0.2, duration: 500.ms).fadeIn(),

                  Gap(AppSpacing.lg),

                  // Total monthly income display
                  if (totalMonthlyIncome > 0)
                    Container(
                      padding: AppSpacing.cardPaddingAll,
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        border: Border.all(color: AppColors.success.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: AppColors.success,
                            size: AppSpacing.iconMd,
                          ),
                          Gap(AppSpacing.sm),
                          Text(
                            'Monthly Income: \$${totalMonthlyIncome.toStringAsFixed(2)}',
                            style: AppTypography.titleMedium.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ).animate().slideY(begin: 0.1, duration: 600.ms).fadeIn(),

                  Gap(AppSpacing.xl),

                  // Existing income sources
                  if (onboardingData.incomeSources.isNotEmpty) ...[
                    Text(
                      'Your Income Sources',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fadeIn(duration: 700.ms),

                    Gap(AppSpacing.md),

                    ...onboardingData.incomeSources.map((source) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: IncomeSourceCard(
                            source: source,
                            onRemove: () => _removeIncomeSource(source.id),
                          ),
                        ).animate().slideX(begin: 0.1, duration: 800.ms).fadeIn()),
                  ],

                  Gap(AppSpacing.xl),

                  // Add new income form
                  Text(
                    'Add Income Source',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate().fadeIn(duration: 900.ms),

                  Gap(AppSpacing.md),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Income name
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Income Source Name',
                            hintText: 'e.g., Salary, Freelance, Business',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                            ),
                            contentPadding: AppSpacing.inputPaddingAll,
                          ),
                          style: AppTypography.bodyLarge,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter an income source name';
                            }
                            return null;
                          },
                        ).animate().slideX(begin: 0.1, duration: 1000.ms).fadeIn(),

                        Gap(AppSpacing.md),

                        // Amount and frequency row
                        Row(
                          children: [
                            // Amount
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [_currencyFormatter],
                                decoration: InputDecoration(
                                  labelText: 'Amount',
                                  hintText: '\$0.00',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                  ),
                                  contentPadding: AppSpacing.inputPaddingAll,
                                ),
                                style: AppTypography.bodyLarge,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter an amount';
                                  }
                                  final amountText = value.replaceAll('\$', '').replaceAll(',', '').trim();
                                  final amount = double.tryParse(amountText) ?? 0.0;
                                  if (amount <= 0) {
                                    return 'Amount must be greater than 0';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            Gap(AppSpacing.sm),

                            // Frequency
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<PayFrequency>(
                                initialValue: _selectedFrequency,
                                decoration: InputDecoration(
                                  labelText: 'Frequency',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                  ),
                                  contentPadding: AppSpacing.inputPaddingAll,
                                ),
                                items: PayFrequency.values.map((frequency) {
                                  return DropdownMenuItem(
                                    value: frequency,
                                    child: Text(
                                      frequency.displayName,
                                      style: AppTypography.bodyMedium,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() => _selectedFrequency = value);
                                  }
                                },
                              ),
                            ),
                          ],
                        ).animate().slideX(begin: 0.1, duration: 1100.ms).fadeIn(),

                        Gap(AppSpacing.md),

                        // Add button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: _addIncomeSource,
                            style: OutlinedButton.styleFrom(
                              padding: AppSpacing.buttonPaddingAll,
                              side: BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                              ),
                            ),
                            child: Text(
                              'Add Income Source',
                              style: AppTypography.buttonMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ).animate().slideY(begin: 0.1, duration: 1200.ms).fadeIn(),
                      ],
                    ),
                  ),

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
                    onPressed: onboardingData.incomeSources.isNotEmpty ? _handleContinue : null,
                    style: ElevatedButton.styleFrom(
                      padding: AppSpacing.buttonPaddingAll,
                      backgroundColor: onboardingData.incomeSources.isNotEmpty ? AppColors.primary : AppColors.secondary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      elevation: AppSpacing.elevationSm,
                    ),
                    child: Text(
                      'Continue to Budget Setup',
                      style: AppTypography.buttonLarge,
                    ),
                  ),
                ).animate().slideY(begin: 0.2, duration: 1300.ms).fadeIn(),

                Gap(AppSpacing.md),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IncomeSourceCard extends StatelessWidget {
  const IncomeSourceCard({
    super.key,
    required this.source,
    required this.onRemove,
  });

  final IncomeSource source;
  final VoidCallback onRemove;

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
                    source.name,
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(AppSpacing.xs),
                  Text(
                    '\$${source.amount.toStringAsFixed(2)} ${source.frequency.displayName.toLowerCase()}',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'Monthly: \$${source.monthlyAmount.toStringAsFixed(2)}',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onRemove,
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