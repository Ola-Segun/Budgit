import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../bills/domain/entities/bill.dart';
import '../../../insights/domain/entities/insight.dart';
import '../../../transactions/domain/entities/transaction.dart';

part 'dashboard_data.freezed.dart';

/// Dashboard data entity containing all information needed for the home screen
@freezed
class DashboardData with _$DashboardData {
  const factory DashboardData({
    required FinancialSnapshot financialSnapshot,
    required List<BudgetCategoryOverview> budgetOverview,
    required List<Bill> upcomingBills,
    required List<Transaction> recentTransactions,
    required List<Insight> insights,
    required DateTime generatedAt,
  }) = _DashboardData;

  const DashboardData._();
}

/// Financial snapshot showing current month income vs expenses and net worth
@freezed
class FinancialSnapshot with _$FinancialSnapshot {
  const factory FinancialSnapshot({
    required double incomeThisMonth,
    required double expensesThisMonth,
    required double balanceThisMonth,
    required double netWorth,
  }) = _FinancialSnapshot;

  const FinancialSnapshot._();

  /// Check if balance is positive (surplus)
  bool get isPositive => balanceThisMonth >= 0;

  /// Calculate balance percentage relative to income
  double get balancePercentage => incomeThisMonth > 0 ? (balanceThisMonth / incomeThisMonth) : 0.0;
}

/// Budget category overview for dashboard
@freezed
class BudgetCategoryOverview with _$BudgetCategoryOverview {
  const factory BudgetCategoryOverview({
    required String categoryId,
    required String categoryName,
    required double spent,
    required double budget,
    required double percentage,
    required BudgetHealthStatus status,
  }) = _BudgetCategoryOverview;

  const BudgetCategoryOverview._();

  /// Check if over budget
  bool get isOverBudget => percentage > 100;

  /// Check if near limit (75-100%)
  bool get isNearLimit => percentage >= 75 && percentage <= 100;

  /// Check if healthy (< 75%)
  bool get isHealthy => percentage < 75;
}

/// Budget health status enumeration
enum BudgetHealthStatus {
  healthy('Healthy'),
  warning('Warning'),
  critical('Critical'),
  overBudget('Over Budget');

  const BudgetHealthStatus(this.displayName);

  final String displayName;

  /// Get color for status
  String get color {
    switch (this) {
      case BudgetHealthStatus.healthy:
        return '#10B981'; // Green
      case BudgetHealthStatus.warning:
        return '#F59E0B'; // Yellow
      case BudgetHealthStatus.critical:
        return '#EF4444'; // Red
      case BudgetHealthStatus.overBudget:
        return '#DC2626'; // Dark Red
    }
  }
}

/// Dashboard summary for quick overview
@freezed
class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    required int totalTransactions,
    required int upcomingBillsCount,
    required int unreadInsightsCount,
    required double monthlySavings,
    required DateTime lastUpdated,
  }) = _DashboardSummary;

  const DashboardSummary._();
}