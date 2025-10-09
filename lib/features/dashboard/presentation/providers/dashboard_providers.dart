import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

import '../../../../core/di/providers.dart' as core_providers;
import '../../../transactions/domain/entities/transaction.dart';
import '../../../budgets/domain/entities/budget.dart';
import '../../../bills/domain/entities/bill.dart';
import '../../../insights/domain/entities/insight.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/usecases/get_dashboard_data.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import '../../../budgets/presentation/providers/budget_providers.dart';
import '../../../bills/presentation/providers/bill_providers.dart';

// Repository providers
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(
    ref.watch(core_providers.transactionRepositoryProvider),
    ref.watch(core_providers.budgetRepositoryProvider),
    ref.watch(core_providers.billRepositoryProvider),
    ref.watch(core_providers.insightRepositoryProvider),
    ref.watch(core_providers.calculateBudgetStatusProvider),
  );
});

// Use case providers
final getDashboardDataUseCaseProvider = Provider<GetDashboardData>((ref) {
  return GetDashboardData(ref.watch(dashboardRepositoryProvider));
});

// State providers
final dashboardDataProvider = Provider<AsyncValue<DashboardData>>((ref) {
  // Watch reactive providers to trigger rebuilds when data changes
  final transactionState = ref.watch(transactionNotifierProvider);
  final budgetState = ref.watch(budgetNotifierProvider);
  final billState = ref.watch(billNotifierProvider);

  print('DashboardDataProvider: Recomputing - transactionState: $transactionState');

  // Return loading if any provider is loading
  if (transactionState.isLoading || budgetState.isLoading) {
    return const AsyncValue.loading();
  }

  // Handle bill state separately since it's not AsyncValue
  final billData = billState.maybeWhen(
    loaded: (bills, summary) => bills,
    orElse: () => <Bill>[],
  );

  // Return error if transaction or budget providers have error
  if (transactionState.hasError || budgetState.hasError) {
    final error = transactionState.error ?? budgetState.error;
    return AsyncValue.error(error!, StackTrace.current);
  }

  // All data is available, compute dashboard data synchronously
  try {
    final transactionData = transactionState.value!;
    final budgetData = budgetState.value!;

    // Get current month date range for filtering
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    // Calculate financial snapshot
    final monthlyTransactions = transactionData.transactions
        .where((t) => t.date.isAfter(startOfMonth.subtract(const Duration(days: 1))) &&
                      t.date.isBefore(endOfMonth.add(const Duration(days: 1))))
        .toList();

    print('DashboardDataProvider: Found ${monthlyTransactions.length} monthly transactions');

    final expensesThisMonth = monthlyTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold<double>(0.0, (sum, t) => sum + t.amount);

    final incomeThisMonth = monthlyTransactions
        .where((t) => t.type == TransactionType.income)
        .fold<double>(0.0, (sum, t) => sum + t.amount);

    final balanceThisMonth = incomeThisMonth - expensesThisMonth;

    print('DashboardDataProvider: incomeThisMonth: $incomeThisMonth, expensesThisMonth: $expensesThisMonth, balanceThisMonth: $balanceThisMonth');

    final financialSnapshot = FinancialSnapshot(
      incomeThisMonth: incomeThisMonth,
      expensesThisMonth: expensesThisMonth,
      balanceThisMonth: balanceThisMonth,
    );

    // Get budget overview (simplified)
    final budgetOverview = budgetData.budgetStatuses
        .map((status) => BudgetCategoryOverview(
              categoryId: status.categoryStatuses.firstOrNull?.categoryId ?? 'unknown',
              categoryName: status.categoryStatuses.firstOrNull?.categoryId ?? 'Unknown',
              spent: status.categoryStatuses.firstOrNull?.spent ?? 0.0,
              budget: status.categoryStatuses.firstOrNull?.budget ?? 0.0,
              percentage: status.categoryStatuses.firstOrNull?.percentage ?? 0.0,
              status: _mapBudgetHealthToStatus(status.overallHealth),
            ))
        .take(5)
        .toList();

    // Get upcoming bills
    final upcomingBills = billData
        .where((bill) => !bill.isPaid && bill.daysUntilDue >= 0)
        .sorted((a, b) => a.daysUntilDue.compareTo(b.daysUntilDue))
        .take(3)
        .toList();

    // Get recent transactions
    final recentTransactions = transactionData.transactions
        .sorted((a, b) => b.date.compareTo(a.date))
        .take(7)
        .toList();

    // For now, empty insights (could be computed from data)
    final insights = <Insight>[];

    final dashboardData = DashboardData(
      financialSnapshot: financialSnapshot,
      budgetOverview: budgetOverview,
      upcomingBills: upcomingBills,
      recentTransactions: recentTransactions,
      insights: insights,
      generatedAt: DateTime.now(),
    );

    return AsyncValue.data(dashboardData);
  } catch (e, stack) {
    return AsyncValue.error(e, stack);
  }
});

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