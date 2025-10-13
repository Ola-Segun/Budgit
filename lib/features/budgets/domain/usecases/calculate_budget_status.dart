import 'dart:developer';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../entities/budget.dart';

/// Use case for calculating budget status with spending data
class CalculateBudgetStatus {
  const CalculateBudgetStatus(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  /// Execute the use case with a budget object
  Future<Result<BudgetStatus>> call(Budget budget) async {
    try {
      // Calculate spending for each category
      final categoryStatuses = <CategoryStatus>[];

      for (final category in budget.categories) {
        final spentResult = await _getCategorySpending(
          category.id,
          budget.startDate,
          budget.endDate,
          budget.createdAt,
        );

        if (spentResult.isError) {
          return Result.error(spentResult.failureOrNull!);
        }

        final spent = spentResult.dataOrNull ?? 0.0;
        final percentage = category.amount > 0 ? (spent / category.amount) * 100 : 0.0;

        final status = _getBudgetHealth(percentage);

        categoryStatuses.add(CategoryStatus(
          categoryId: category.id,
          spent: spent,
          budget: category.amount,
          percentage: percentage,
          status: status,
        ));
      }

      // Calculate overall totals
      final totalSpent = categoryStatuses.fold<double>(0.0, (sum, status) => sum + status.spent);
      final totalBudget = budget.totalBudget;
      final daysRemaining = budget.remainingDays;

      // Apply rollover logic if enabled
      final adjustedTotalSpent = budget.allowRollover
          ? _calculateRolloverAdjustedSpending(totalSpent, totalBudget, budget)
          : totalSpent;

      final budgetStatus = BudgetStatus(
        budget: budget,
        totalSpent: adjustedTotalSpent,
        totalBudget: totalBudget,
        categoryStatuses: categoryStatuses,
        daysRemaining: daysRemaining,
      );

      return Result.success(budgetStatus);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to calculate budget status: $e'));
    }
  }

  /// Get spending amount for a category within date range, starting from budget creation
  Future<Result<double>> _getCategorySpending(
    String categoryId,
    DateTime startDate,
    DateTime endDate,
    DateTime? budgetCreatedAt,
  ) async {
    try {
      log('CalculateBudgetStatus: Querying transactions for category: $categoryId, date range: $startDate to $endDate, created at: $budgetCreatedAt');

      final transactionsResult = await _transactionRepository.getByCategory(categoryId);

      if (transactionsResult.isError) {
        log('CalculateBudgetStatus: Error getting transactions for category $categoryId: ${transactionsResult.failureOrNull}');
        return Result.error(transactionsResult.failureOrNull!);
      }

      final allTransactions = transactionsResult.dataOrNull ?? [];
      log('CalculateBudgetStatus: Found ${allTransactions.length} total transactions for category $categoryId');

      // Filter by date range and sum expenses, but only include transactions on or after budget creation
      final effectiveStartDate = budgetCreatedAt ?? startDate;

      final filteredTransactions = allTransactions
          .where((transaction) =>
              transaction.date.compareTo(effectiveStartDate) >= 0 &&
              transaction.date.isBefore(endDate.add(const Duration(days: 1))) &&
              transaction.type == TransactionType.expense)
          .toList();

      log('CalculateBudgetStatus: Found ${filteredTransactions.length} expense transactions in date range for category $categoryId (effective start: $effectiveStartDate)');

      final spending = filteredTransactions.fold<double>(0.0, (sum, transaction) => sum + transaction.amount);
      log('CalculateBudgetStatus: Total spending for category $categoryId: \$${spending.toStringAsFixed(2)}');

      return Result.success(spending);
    } catch (e) {
      log('CalculateBudgetStatus: Exception getting category spending for $categoryId: $e');
      return Result.error(Failure.unknown('Failed to get category spending: $e'));
    }
  }

  /// Determine budget health based on spending percentage
  BudgetHealth _getBudgetHealth(double percentage) {
    if (percentage > 100) return BudgetHealth.overBudget;
    if (percentage > 90) return BudgetHealth.critical;
    if (percentage > 75) return BudgetHealth.warning;
    return BudgetHealth.healthy;
  }

  /// Calculate rollover-adjusted spending for budgets with rollover enabled
  double _calculateRolloverAdjustedSpending(double totalSpent, double totalBudget, Budget budget) {
    // If rollover is enabled and budget period has ended, calculate rollover amount
    final now = DateTime.now();
    if (now.isAfter(budget.endDate)) {
      // Calculate how much was under-spent in the previous period
      final underSpent = totalBudget - totalSpent;
      if (underSpent > 0) {
        // Add rollover amount to current spending calculation
        // This effectively reduces the "spent" amount for health calculations
        // since rollover funds are available
        return (totalSpent - underSpent).clamp(0.0, double.infinity);
      }
    }
    return totalSpent;
  }
}