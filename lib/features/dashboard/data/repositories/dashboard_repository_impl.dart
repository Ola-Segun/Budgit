import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../accounts/domain/repositories/account_repository.dart';
import '../../../bills/domain/entities/bill.dart';
import '../../../bills/domain/repositories/bill_repository.dart';
import '../../../budgets/domain/entities/budget.dart';
import '../../../budgets/domain/repositories/budget_repository.dart';
import '../../../budgets/domain/usecases/calculate_budget_status.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../insights/domain/entities/insight.dart';
import '../../../insights/domain/repositories/insight_repository.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/dashboard_repository.dart';

/// Implementation of dashboard repository that aggregates data from multiple sources
class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl(
    this._transactionRepository,
    this._budgetRepository,
    this._billRepository,
    this._accountRepository,
    this._insightRepository,
    this._calculateBudgetStatus,
  );

  final TransactionRepository _transactionRepository;
  final BudgetRepository _budgetRepository;
  final BillRepository _billRepository;
  final AccountRepository _accountRepository;
  final InsightRepository _insightRepository;
  final CalculateBudgetStatus _calculateBudgetStatus;

  @override
  Future<Result<DashboardData>> getDashboardData() async {
    try {
      // Get all data concurrently
      final results = await Future.wait([
        getFinancialSnapshot(),
        getBudgetOverview(),
        getUpcomingBills(),
        getRecentTransactions(),
        getDashboardInsights(),
      ]);

      // Provide default values for failed operations to make dashboard more resilient
      final financialSnapshotResult = results[0].isSuccess
          ? results[0] as Result<FinancialSnapshot>
          : Result.success(FinancialSnapshot(
              incomeThisMonth: 0.0,
              expensesThisMonth: 0.0,
              balanceThisMonth: 0.0,
              netWorth: 0.0,
            ));

      final budgetOverviewResult = results[1].isSuccess
          ? results[1] as Result<List<BudgetCategoryOverview>>
          : Result.success(<BudgetCategoryOverview>[]);

      final upcomingBillsResult = results[2].isSuccess
          ? results[2] as Result<List<Bill>>
          : Result.success(<Bill>[]);

      final recentTransactionsResult = results[3].isSuccess
          ? results[3] as Result<List<Transaction>>
          : Result.success(<Transaction>[]);

      final insightsResult = results[4].isSuccess
          ? results[4] as Result<List<Insight>>
          : Result.success(<Insight>[]);

      final financialSnapshot = financialSnapshotResult;
      final budgetOverview = budgetOverviewResult;
      final upcomingBills = upcomingBillsResult;
      final recentTransactions = recentTransactionsResult;
      final insights = insightsResult;

      final dashboardData = DashboardData(
        financialSnapshot: financialSnapshot.dataOrNull!,
        budgetOverview: budgetOverview.dataOrNull!,
        upcomingBills: upcomingBills.dataOrNull!,
        recentTransactions: recentTransactions.dataOrNull!,
        insights: insights.dataOrNull!,
        generatedAt: DateTime.now(),
      );

      return Result.success(dashboardData);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get dashboard data: $e'));
    }
  }

  @override
  Future<Result<FinancialSnapshot>> getFinancialSnapshot() async {
    try {
      // Get current month date range
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

      // Get all transactions for current month
      final transactionsResult = await _transactionRepository.getByDateRange(
        startOfMonth,
        endOfMonth,
      );

      if (transactionsResult.isError) {
        return Result.error(transactionsResult.failureOrNull!);
      }

      final transactions = transactionsResult.dataOrNull ?? [];

      // Calculate total income and expenses
      final expensesThisMonth = transactions
          .where((t) => t.type == TransactionType.expense)
          .fold<double>(0.0, (sum, t) => sum + t.amount);

      final incomeThisMonth = transactions
          .where((t) => t.type == TransactionType.income)
          .fold<double>(0.0, (sum, t) => sum + t.amount);

      final balanceThisMonth = incomeThisMonth - expensesThisMonth;

      // Get net worth from accounts
      final netWorthResult = await _accountRepository.getNetWorth();
      final netWorth = netWorthResult.getOrDefault(0.0);

      final snapshot = FinancialSnapshot(
        incomeThisMonth: incomeThisMonth,
        expensesThisMonth: expensesThisMonth,
        balanceThisMonth: balanceThisMonth,
        netWorth: netWorth,
      );

      return Result.success(snapshot);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get financial snapshot: $e'));
    }
  }

  @override
  Future<Result<List<BudgetCategoryOverview>>> getBudgetOverview({int limit = 5}) async {
    try {
      // Get current budgets
      final budgetsResult = await _budgetRepository.getAll();
      if (budgetsResult.isError) {
        return Result.error(budgetsResult.failureOrNull!);
      }

      final budgets = budgetsResult.dataOrNull ?? [];
      if (budgets.isEmpty) {
        return Result.success([]);
      }

      // Use the first active budget (in a real app, you'd have logic to select current budget)
      final currentBudget = budgets.first;

      // Calculate budget status
      final statusResult = await _calculateBudgetStatus(currentBudget);
      if (statusResult.isError) {
        return Result.error(statusResult.failureOrNull!);
      }

      final budgetStatus = statusResult.dataOrNull!;
      final categoryOverviews = budgetStatus.categoryStatuses
          .map((status) => BudgetCategoryOverview(
                categoryId: status.categoryId,
                categoryName: _getCategoryName(status.categoryId), // You'd implement this
                spent: status.spent,
                budget: status.budget,
                percentage: status.percentage,
                status: _mapBudgetHealthToStatus(status.status),
              ))
          .sorted((a, b) => b.spent.compareTo(a.spent)) // Sort by spending amount
          .take(limit)
          .toList();

      return Result.success(categoryOverviews);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get budget overview: $e'));
    }
  }

  @override
  Future<Result<List<Bill>>> getUpcomingBills({int limit = 3}) async {
    try {
      final billsResult = await _billRepository.getAll();
      if (billsResult.isError) {
        return Result.error(billsResult.failureOrNull!);
      }

      final bills = billsResult.dataOrNull ?? [];

      // Filter and sort upcoming bills
      final upcomingBills = bills
          .where((bill) => !bill.isPaid && bill.daysUntilDue >= 0)
          .sorted((a, b) => a.daysUntilDue.compareTo(b.daysUntilDue))
          .take(limit)
          .toList();

      return Result.success(upcomingBills);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get upcoming bills: $e'));
    }
  }

  @override
  Future<Result<List<Transaction>>> getRecentTransactions({int limit = 7}) async {
    try {
      final transactionsResult = await _transactionRepository.getAll();
      if (transactionsResult.isError) {
        return Result.error(transactionsResult.failureOrNull!);
      }

      final transactions = transactionsResult.dataOrNull ?? [];

      // Sort by date descending and take recent ones
      final recentTransactions = transactions
          .sorted((a, b) => b.date.compareTo(a.date))
          .take(limit)
          .toList();

      return Result.success(recentTransactions);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get recent transactions: $e'));
    }
  }

  @override
  Future<Result<List<Insight>>> getDashboardInsights({int limit = 3}) async {
    try {
      final insightsResult = await _insightRepository.getAll();
      if (insightsResult.isError) {
        return Result.error(insightsResult.failureOrNull!);
      }

      final insights = insightsResult.dataOrNull ?? [];

      // Take most recent insights
      final recentInsights = insights
          .sorted((a, b) => b.generatedAt.compareTo(a.generatedAt))
          .take(limit)
          .toList();

      return Result.success(recentInsights);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get dashboard insights: $e'));
    }
  }

  @override
  Future<Result<void>> refreshDashboardData() async {
    // In a real implementation, this might clear caches or force refresh
    // For now, just return success
    return Result.success(null);
  }

  /// Get budget health status based on progress percentage
  BudgetHealthStatus _getBudgetHealthStatus(double percentage) {
    if (percentage > 1.0) return BudgetHealthStatus.overBudget;
    if (percentage > 0.9) return BudgetHealthStatus.critical;
    if (percentage > 0.75) return BudgetHealthStatus.warning;
    return BudgetHealthStatus.healthy;
  }

  /// Map BudgetHealth to BudgetHealthStatus
  BudgetHealthStatus _mapBudgetHealthToStatus(BudgetHealth health) {
    switch (health) {
      case BudgetHealth.healthy:
        return BudgetHealthStatus.healthy;
      case BudgetHealth.warning:
        return BudgetHealthStatus.warning;
      case BudgetHealth.critical:
        return BudgetHealthStatus.critical;
      case BudgetHealth.overBudget:
        return BudgetHealthStatus.overBudget;
    }
  }

  /// Get category name by ID (placeholder implementation)
  String _getCategoryName(String categoryId) {
    // In a real app, you'd have a category repository
    final categoryNames = {
      'food': 'Food & Dining',
      'transportation': 'Transportation',
      'entertainment': 'Entertainment',
      'shopping': 'Shopping',
      'utilities': 'Utilities',
      'healthcare': 'Healthcare',
    };

    return categoryNames[categoryId] ?? categoryId;
  }
}