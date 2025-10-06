import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';

part 'insight.freezed.dart';

/// Insight entity representing financial insights and recommendations
@freezed
class Insight with _$Insight {
  const factory Insight({
    required String id,
    required String title,
    required String message,
    required InsightType type,
    required DateTime generatedAt,
    String? categoryId,
    String? transactionId,
    double? amount,
    double? percentage,
    @Default(InsightPriority.medium) InsightPriority priority,
    @Default(false) bool isRead,
    @Default(false) bool isArchived,
    Map<String, dynamic>? metadata,
  }) = _Insight;

  const Insight._();

  /// Validate insight data
  Result<Insight> validate() {
    if (title.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Insight title cannot be empty',
        {'title': 'Title is required'},
      ));
    }

    if (message.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Insight message cannot be empty',
        {'message': 'Message is required'},
      ));
    }

    return Result.success(this);
  }
}

/// Insight type enumeration
enum InsightType {
  spendingTrend('Spending Trend'),
  budgetAlert('Budget Alert'),
  savingsOpportunity('Savings Opportunity'),
  unusualActivity('Unusual Activity'),
  goalProgress('Goal Progress'),
  billReminder('Bill Reminder'),
  categoryAnalysis('Category Analysis'),
  monthlySummary('Monthly Summary'),
  comparison('Comparison'),
  recommendation('Recommendation');

  const InsightType(this.displayName);

  final String displayName;
}

/// Insight priority enumeration
enum InsightPriority {
  low('Low'),
  medium('Medium'),
  high('High'),
  urgent('Urgent');

  const InsightPriority(this.displayName);

  final String displayName;

  /// Get priority color
  String get color {
    switch (this) {
      case InsightPriority.low:
        return '#6B7280'; // Gray
      case InsightPriority.medium:
        return '#F59E0B'; // Yellow
      case InsightPriority.high:
        return '#EF4444'; // Red
      case InsightPriority.urgent:
        return '#DC2626'; // Dark Red
    }
  }
}

/// Spending trend analysis
@freezed
class SpendingTrend with _$SpendingTrend {
  const factory SpendingTrend({
    required DateTime period,
    required double amount,
    required double previousAmount,
    required double changeAmount,
    required double changePercentage,
    required TrendDirection direction,
    required String categoryId,
    String? categoryName,
  }) = _SpendingTrend;

  const SpendingTrend._();

  /// Check if trend is significant
  bool get isSignificant => changePercentage.abs() >= 10.0; // 10% change threshold
}

/// Trend direction enumeration
enum TrendDirection {
  increasing('Increasing'),
  decreasing('Decreasing'),
  stable('Stable');

  const TrendDirection(this.displayName);

  final String displayName;
}

/// Category spending analysis
@freezed
class CategoryAnalysis with _$CategoryAnalysis {
  const factory CategoryAnalysis({
    required String categoryId,
    required String categoryName,
    required double totalSpent,
    required double budgetAmount,
    required double percentageOfBudget,
    required double percentageOfTotalSpending,
    required int transactionCount,
    required double averageTransactionAmount,
    required DateTime period,
    required CategoryHealthStatus status,
  }) = _CategoryAnalysis;

  const CategoryAnalysis._();

  /// Check if category is over budget
  bool get isOverBudget => percentageOfBudget > 100.0;

  /// Check if category is approaching budget limit
  bool get isNearLimit => percentageOfBudget >= 75.0 && percentageOfBudget <= 100.0;
}

/// Category health status enumeration
enum CategoryHealthStatus {
  excellent('Excellent'),
  good('Good'),
  warning('Warning'),
  critical('Critical'),
  overBudget('Over Budget');

  const CategoryHealthStatus(this.displayName);

  final String displayName;

  /// Get status color
  String get color {
    switch (this) {
      case CategoryHealthStatus.excellent:
        return '#10B981'; // Green
      case CategoryHealthStatus.good:
        return '#3B82F6'; // Blue
      case CategoryHealthStatus.warning:
        return '#F59E0B'; // Yellow
      case CategoryHealthStatus.critical:
        return '#EF4444'; // Red
      case CategoryHealthStatus.overBudget:
        return '#DC2626'; // Dark Red
    }
  }
}

/// Monthly financial summary
@freezed
class MonthlySummary with _$MonthlySummary {
  const factory MonthlySummary({
    required DateTime month,
    required double totalIncome,
    required double totalExpenses,
    required double totalSavings,
    required double savingsRate,
    required double budgetAdherence,
    required List<CategoryAnalysis> categoryBreakdown,
    required List<SpendingTrend> trends,
    required int totalTransactions,
    required double averageTransactionAmount,
    required double largestExpense,
    required String topSpendingCategory,
  }) = _MonthlySummary;

  const MonthlySummary._();

  /// Calculate net worth change
  double get netIncome => totalIncome - totalExpenses;

  /// Check if savings rate is good (20%+)
  bool get hasGoodSavingsRate => savingsRate >= 20.0;

  /// Check if budget adherence is good (80%+)
  bool get hasGoodBudgetAdherence => budgetAdherence >= 80.0;
}

/// Financial health score
@freezed
class FinancialHealthScore with _$FinancialHealthScore {
  const factory FinancialHealthScore({
    required int overallScore,
    required FinancialHealthGrade grade,
    required Map<String, int> componentScores,
    required List<String> strengths,
    required List<String> weaknesses,
    required List<String> recommendations,
    required DateTime calculatedAt,
  }) = _FinancialHealthScore;

  const FinancialHealthScore._();

  /// Get score percentage
  double get scorePercentage => overallScore / 100.0;

  /// Check if score is excellent
  bool get isExcellent => overallScore >= 90;

  /// Check if score is good
  bool get isGood => overallScore >= 70 && overallScore < 90;

  /// Check if score needs improvement
  bool get needsImprovement => overallScore < 70;
}

/// Financial health grade enumeration
enum FinancialHealthGrade {
  excellent('A - Excellent'),
  good('B - Good'),
  fair('C - Fair'),
  poor('D - Poor'),
  critical('F - Critical');

  const FinancialHealthGrade(this.displayName);

  final String displayName;

  /// Get grade color
  String get color {
    switch (this) {
      case FinancialHealthGrade.excellent:
        return '#10B981'; // Green
      case FinancialHealthGrade.good:
        return '#3B82F6'; // Blue
      case FinancialHealthGrade.fair:
        return '#F59E0B'; // Yellow
      case FinancialHealthGrade.poor:
        return '#EF4444'; // Red
      case FinancialHealthGrade.critical:
        return '#DC2626'; // Dark Red
    }
  }
}

/// Financial report entity for generated reports
@freezed
class FinancialReport with _$FinancialReport {
  const factory FinancialReport({
    required String id,
    required String title,
    required String description,
    required FinancialReportType type,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime generatedAt,
    required Map<String, dynamic> data,
    required List<String> sections,
    String? filePath,
    @Default(false) bool isExported,
    Map<String, dynamic>? metadata,
  }) = _FinancialReport;

  const FinancialReport._();

  /// Validate report data
  Result<FinancialReport> validate() {
    if (title.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Report title cannot be empty',
        {'title': 'Title is required'},
      ));
    }

    if (description.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Report description cannot be empty',
        {'description': 'Description is required'},
      ));
    }

    if (startDate.isAfter(endDate)) {
      return Result.error(Failure.validation(
        'Start date cannot be after end date',
        {'startDate': 'Must be before end date'},
      ));
    }

    return Result.success(this);
  }

  /// Get report duration in days
  int get durationInDays => endDate.difference(startDate).inDays;

  /// Check if report is for current month
  bool get isCurrentMonth {
    final now = DateTime.now();
    return startDate.year == now.year &&
           startDate.month == now.month &&
           endDate.year == now.year &&
           endDate.month == now.month;
  }
}

/// Financial report type enumeration
enum FinancialReportType {
  monthlySummary('Monthly Summary'),
  quarterlyReport('Quarterly Report'),
  yearlyReport('Yearly Report'),
  customPeriod('Custom Period'),
  categoryAnalysis('Category Analysis'),
  spendingTrends('Spending Trends'),
  budgetPerformance('Budget Performance'),
  goalProgress('Goal Progress');

  const FinancialReportType(this.displayName);

  final String displayName;
}

/// Insights summary for dashboard
@freezed
class InsightsSummary with _$InsightsSummary {
  const factory InsightsSummary({
    required List<Insight> recentInsights,
    required FinancialHealthScore healthScore,
    required MonthlySummary currentMonthSummary,
    required List<SpendingTrend> keyTrends,
    required List<CategoryAnalysis> categoryAnalysis,
    required DateTime generatedAt,
  }) = _InsightsSummary;

  const InsightsSummary._();

  /// Get unread insights count
  int get unreadCount => recentInsights.where((insight) => !insight.isRead).length;

  /// Get high priority insights
  List<Insight> get highPriorityInsights =>
      recentInsights.where((insight) => insight.priority == InsightPriority.high ||
                                        insight.priority == InsightPriority.urgent).toList();

  /// Get insights by type
  Map<InsightType, List<Insight>> get insightsByType {
    final map = <InsightType, List<Insight>>{};
    for (final insight in recentInsights) {
      map[insight.type] ??= [];
      map[insight.type]!.add(insight);
    }
    return map;
  }
}