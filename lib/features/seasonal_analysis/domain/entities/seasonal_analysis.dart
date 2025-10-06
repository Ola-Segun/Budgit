import 'package:freezed_annotation/freezed_annotation.dart';

part 'seasonal_analysis.freezed.dart';

/// Seasonal analysis entity for spending patterns
@freezed
class SeasonalAnalysis with _$SeasonalAnalysis {
  const factory SeasonalAnalysis({
    required String id,
    required String userId,
    required AnalysisPeriod period,
    required DateTime startDate,
    required DateTime endDate,
    required List<CategorySpending> categorySpending,
    required List<MonthlyTrend> monthlyTrends,
    required SeasonalInsights insights,
    required DateTime generatedAt,
  }) = _SeasonalAnalysis;

  const SeasonalAnalysis._();

  /// Get total spending for the period
  double get totalSpending => categorySpending.fold(0.0, (sum, cat) => sum + cat.totalAmount);

  /// Get average monthly spending
  double get averageMonthlySpending {
    final months = period == AnalysisPeriod.year ? 12 : 1;
    return totalSpending / months;
  }

  /// Get spending by category as percentage
  Map<String, double> get spendingByCategoryPercentage {
    if (totalSpending == 0) return {};
    return {
      for (final category in categorySpending)
        category.categoryId: (category.totalAmount / totalSpending) * 100
    };
  }

  /// Check if analysis is outdated (older than 30 days)
  bool get isOutdated => DateTime.now().difference(generatedAt).inDays > 30;
}

/// Spending data for a specific category
@freezed
class CategorySpending with _$CategorySpending {
  const factory CategorySpending({
    required String categoryId,
    required String categoryName,
    required double totalAmount,
    required int transactionCount,
    required double averageAmount,
    required List<MonthlySpending> monthlyBreakdown,
  }) = _CategorySpending;

  const CategorySpending._();

  /// Get percentage change from previous period
  double? get percentageChange {
    if (monthlyBreakdown.length < 2) return null;
    final current = monthlyBreakdown.last.totalAmount;
    final previous = monthlyBreakdown[monthlyBreakdown.length - 2].totalAmount;
    if (previous == 0) return null;
    return ((current - previous) / previous) * 100;
  }
}

/// Monthly spending data
@freezed
class MonthlySpending with _$MonthlySpending {
  const factory MonthlySpending({
    required int year,
    required int month,
    required double totalAmount,
    required int transactionCount,
  }) = _MonthlySpending;

  const MonthlySpending._();

  /// Get month name
  String get monthName {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}

/// Monthly trend analysis
@freezed
class MonthlyTrend with _$MonthlyTrend {
  const factory MonthlyTrend({
    required int month,
    required double averageSpending,
    required double medianSpending,
    required TrendDirection direction,
    required double changePercentage,
  }) = _MonthlyTrend;

  const MonthlyTrend._();
}

/// Direction of spending trend
enum TrendDirection {
  increasing,
  decreasing,
  stable;

  String get displayName {
    switch (this) {
      case TrendDirection.increasing:
        return 'Increasing';
      case TrendDirection.decreasing:
        return 'Decreasing';
      case TrendDirection.stable:
        return 'Stable';
    }
  }
}

/// Seasonal insights and recommendations
@freezed
class SeasonalInsights with _$SeasonalInsights {
  const factory SeasonalInsights({
    required List<String> keyFindings,
    required List<BudgetRecommendation> recommendations,
    required List<String> seasonalPatterns,
    required RiskLevel spendingRisk,
  }) = _SeasonalInsights;

  const SeasonalInsights._();
}

/// Budget recommendation
@freezed
class BudgetRecommendation with _$BudgetRecommendation {
  const factory BudgetRecommendation({
    required String categoryId,
    required String categoryName,
    required RecommendationType type,
    required String description,
    required double suggestedAmount,
    required double currentAverage,
  }) = _BudgetRecommendation;

  const BudgetRecommendation._();

  /// Get recommendation priority
  int get priority {
    switch (type) {
      case RecommendationType.increase:
        return 1;
      case RecommendationType.decrease:
        return 2;
      case RecommendationType.monitor:
        return 3;
    }
  }
}

/// Type of budget recommendation
enum RecommendationType {
  increase,
  decrease,
  monitor;

  String get displayName {
    switch (this) {
      case RecommendationType.increase:
        return 'Increase Budget';
      case RecommendationType.decrease:
        return 'Reduce Budget';
      case RecommendationType.monitor:
        return 'Monitor Closely';
    }
  }
}

/// Risk level for spending
enum RiskLevel {
  low,
  medium,
  high;

  String get displayName {
    switch (this) {
      case RiskLevel.low:
        return 'Low Risk';
      case RiskLevel.medium:
        return 'Medium Risk';
      case RiskLevel.high:
        return 'High Risk';
    }
  }
}

/// Analysis period
enum AnalysisPeriod {
  month,
  quarter,
  year;

  String get displayName {
    switch (this) {
      case AnalysisPeriod.month:
        return 'Monthly';
      case AnalysisPeriod.quarter:
        return 'Quarterly';
      case AnalysisPeriod.year:
        return 'Yearly';
    }
  }

  int get monthsCount {
    switch (this) {
      case AnalysisPeriod.month:
        return 1;
      case AnalysisPeriod.quarter:
        return 3;
      case AnalysisPeriod.year:
        return 12;
    }
  }
}