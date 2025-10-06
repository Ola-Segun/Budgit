import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../budgets/domain/entities/budget.dart';
import 'income_source.dart';

part 'onboarding_data.freezed.dart';

/// Onboarding data entity containing all collected information
@freezed
class OnboardingData with _$OnboardingData {
  const factory OnboardingData({
    BudgetType? selectedBudgetType,
    @Default([]) List<IncomeSource> incomeSources,
    @Default([]) List<BudgetCategory> budgetCategories,
    @Default(false) bool wantsBankConnection,
  }) = _OnboardingData;

  const OnboardingData._();

  /// Calculate total monthly income
  double get totalMonthlyIncome =>
      incomeSources.fold(0.0, (sum, source) => sum + source.monthlyAmount);

  /// Check if onboarding data is complete
  bool get isComplete =>
      selectedBudgetType != null &&
      incomeSources.isNotEmpty &&
      budgetCategories.isNotEmpty;

  /// Get default budget categories based on selected type
  List<BudgetCategory> getDefaultCategories() {
    if (selectedBudgetType == null) return [];

    switch (selectedBudgetType!) {
      case BudgetType.fiftyThirtyTwenty:
        final needsAmount = totalMonthlyIncome * 0.50;
        final wantsAmount = totalMonthlyIncome * 0.30;
        final savingsAmount = totalMonthlyIncome * 0.20;
        return [
          BudgetCategory(
            id: 'needs_${DateTime.now().millisecondsSinceEpoch}',
            name: 'Needs',
            amount: needsAmount,
            description: 'Essential expenses (housing, food, utilities, etc.)',
          ),
          BudgetCategory(
            id: 'wants_${DateTime.now().millisecondsSinceEpoch + 1}',
            name: 'Wants',
            amount: wantsAmount,
            description: 'Non-essential expenses (entertainment, dining out, etc.)',
          ),
          BudgetCategory(
            id: 'savings_${DateTime.now().millisecondsSinceEpoch + 2}',
            name: 'Savings & Debt',
            amount: savingsAmount,
            description: 'Savings, investments, and debt repayment',
          ),
        ];

      case BudgetType.zeroBased:
        return [
          BudgetCategory(
            id: 'housing_${DateTime.now().millisecondsSinceEpoch}',
            name: 'Housing',
            amount: totalMonthlyIncome * 0.25,
            description: 'Rent/mortgage, utilities, insurance',
          ),
          BudgetCategory(
            id: 'food_${DateTime.now().millisecondsSinceEpoch + 1}',
            name: 'Food',
            amount: totalMonthlyIncome * 0.15,
            description: 'Groceries and dining out',
          ),
          BudgetCategory(
            id: 'transportation_${DateTime.now().millisecondsSinceEpoch + 2}',
            name: 'Transportation',
            amount: totalMonthlyIncome * 0.10,
            description: 'Car payment, gas, public transit',
          ),
          BudgetCategory(
            id: 'savings_${DateTime.now().millisecondsSinceEpoch + 3}',
            name: 'Savings',
            amount: totalMonthlyIncome * 0.10,
            description: 'Emergency fund and investments',
          ),
          BudgetCategory(
            id: 'entertainment_${DateTime.now().millisecondsSinceEpoch + 4}',
            name: 'Entertainment',
            amount: totalMonthlyIncome * 0.10,
            description: 'Movies, hobbies, subscriptions',
          ),
          BudgetCategory(
            id: 'misc_${DateTime.now().millisecondsSinceEpoch + 5}',
            name: 'Miscellaneous',
            amount: totalMonthlyIncome * 0.30,
            description: 'Everything else',
          ),
        ];

      case BudgetType.envelope:
        return [
          BudgetCategory(
            id: 'groceries_${DateTime.now().millisecondsSinceEpoch}',
            name: 'Groceries',
            amount: totalMonthlyIncome * 0.15,
            description: 'Food and household supplies',
          ),
          BudgetCategory(
            id: 'dining_${DateTime.now().millisecondsSinceEpoch + 1}',
            name: 'Dining Out',
            amount: totalMonthlyIncome * 0.10,
            description: 'Restaurants and takeout',
          ),
          BudgetCategory(
            id: 'entertainment_${DateTime.now().millisecondsSinceEpoch + 2}',
            name: 'Entertainment',
            amount: totalMonthlyIncome * 0.08,
            description: 'Movies, events, hobbies',
          ),
          BudgetCategory(
            id: 'shopping_${DateTime.now().millisecondsSinceEpoch + 3}',
            name: 'Shopping',
            amount: totalMonthlyIncome * 0.07,
            description: 'Clothing, gadgets, personal items',
          ),
          BudgetCategory(
            id: 'utilities_${DateTime.now().millisecondsSinceEpoch + 4}',
            name: 'Utilities',
            amount: totalMonthlyIncome * 0.10,
            description: 'Electricity, water, internet',
          ),
          BudgetCategory(
            id: 'savings_${DateTime.now().millisecondsSinceEpoch + 5}',
            name: 'Savings',
            amount: totalMonthlyIncome * 0.20,
            description: 'Emergency fund and long-term savings',
          ),
          BudgetCategory(
            id: 'misc_${DateTime.now().millisecondsSinceEpoch + 6}',
            name: 'Miscellaneous',
            amount: totalMonthlyIncome * 0.30,
            description: 'Unexpected expenses and other needs',
          ),
        ];

      case BudgetType.custom:
        return [
          BudgetCategory(
            id: 'custom_1_${DateTime.now().millisecondsSinceEpoch}',
            name: 'Housing',
            amount: totalMonthlyIncome * 0.30,
            description: 'Rent, mortgage, utilities',
          ),
          BudgetCategory(
            id: 'custom_2_${DateTime.now().millisecondsSinceEpoch + 1}',
            name: 'Food',
            amount: totalMonthlyIncome * 0.15,
            description: 'Groceries and meals',
          ),
          BudgetCategory(
            id: 'custom_3_${DateTime.now().millisecondsSinceEpoch + 2}',
            name: 'Transportation',
            amount: totalMonthlyIncome * 0.10,
            description: 'Car, gas, public transit',
          ),
          BudgetCategory(
            id: 'custom_4_${DateTime.now().millisecondsSinceEpoch + 3}',
            name: 'Entertainment',
            amount: totalMonthlyIncome * 0.10,
            description: 'Movies, dining, hobbies',
          ),
          BudgetCategory(
            id: 'custom_5_${DateTime.now().millisecondsSinceEpoch + 4}',
            name: 'Savings',
            amount: totalMonthlyIncome * 0.15,
            description: 'Emergency fund and investments',
          ),
          BudgetCategory(
            id: 'custom_6_${DateTime.now().millisecondsSinceEpoch + 5}',
            name: 'Miscellaneous',
            amount: totalMonthlyIncome * 0.20,
            description: 'Other expenses',
          ),
        ];
    }
  }
}