import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/insight.dart';

part 'insight_state.freezed.dart';

/// State for insights management
@freezed
class InsightState with _$InsightState {
  const factory InsightState({
    @Default([]) List<Insight> insights,
    InsightsSummary? insightsSummary,
    FinancialHealthScore? healthScore,
    @Default([]) List<FinancialReport> reports,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingSummary,
    @Default(false) bool isLoadingHealthScore,
    @Default(false) bool isCreatingReport,
    String? error,
    String? summaryError,
    String? healthScoreError,
    String? reportError,
  }) = _InsightState;

  const InsightState._();

  /// Get unread insights count
  int get unreadCount => insights.where((insight) => !insight.isRead).length;

  /// Get high priority insights
  List<Insight> get highPriorityInsights =>
      insights.where((insight) => insight.priority == InsightPriority.high ||
                                  insight.priority == InsightPriority.urgent).toList();

  /// Get insights by type
  Map<InsightType, List<Insight>> get insightsByType {
    final map = <InsightType, List<Insight>>{};
    for (final insight in insights) {
      map[insight.type] ??= [];
      map[insight.type]!.add(insight);
    }
    return map;
  }

  /// Get recent insights (last 7 days)
  List<Insight> get recentInsights {
    final cutoffDate = DateTime.now().subtract(const Duration(days: 7));
    return insights.where((insight) => insight.generatedAt.isAfter(cutoffDate)).toList()
      ..sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
  }

  /// Check if health score is good
  bool get hasGoodHealthScore => healthScore?.isGood ?? false;

  /// Check if health score needs improvement
  bool get needsHealthScoreImprovement => healthScore?.needsImprovement ?? false;
}

/// Filter for insights
@freezed
class InsightFilter with _$InsightFilter {
  const factory InsightFilter({
    InsightType? type,
    InsightPriority? priority,
    bool? isRead,
    bool? isArchived,
    DateTime? startDate,
    DateTime? endDate,
  }) = _InsightFilter;

  const InsightFilter._();

  /// Check if filter is empty
  bool get isEmpty =>
      type == null &&
      priority == null &&
      isRead == null &&
      isArchived == null &&
      startDate == null &&
      endDate == null;

  /// Check if filter has any active filters
  bool get isNotEmpty => !isEmpty;
}

/// Statistics for insights
@freezed
class InsightStats with _$InsightStats {
  const factory InsightStats({
    @Default(0) int totalInsights,
    @Default(0) int unreadInsights,
    @Default(0) int highPriorityInsights,
    @Default(0) int archivedInsights,
    @Default(0) int totalReports,
    @Default(0.0) double averageHealthScore,
  }) = _InsightStats;

  const InsightStats._();

  /// Get read percentage
  double get readPercentage => totalInsights > 0
      ? ((totalInsights - unreadInsights) / totalInsights) * 100
      : 0.0;

  /// Get high priority percentage
  double get highPriorityPercentage => totalInsights > 0
      ? (highPriorityInsights / totalInsights) * 100
      : 0.0;
}