import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart' as core_providers;
import '../../domain/entities/insight.dart';
import '../../domain/usecases/get_insights.dart';
import '../../domain/usecases/calculate_financial_health_score.dart';
import '../notifiers/insight_notifier.dart';
import '../states/insight_state.dart';

/// Provider for GetInsights use case
final getInsightsProvider = Provider<GetInsights>((ref) {
  return ref.read(core_providers.getInsightsProvider);
});

/// Provider for GetRecentInsights use case
final getRecentInsightsProvider = Provider<GetRecentInsights>((ref) {
  return ref.read(core_providers.getRecentInsightsProvider);
});

/// Provider for MarkInsightAsRead use case
final markInsightAsReadProvider = Provider<MarkInsightAsRead>((ref) {
  return ref.read(core_providers.markInsightAsReadProvider);
});

/// Provider for GenerateInsightsSummary use case
final generateInsightsSummaryProvider = Provider<GenerateInsightsSummary>((ref) {
  return ref.read(core_providers.generateInsightsSummaryProvider);
});

/// Provider for CalculateFinancialHealthScore use case
final calculateFinancialHealthScoreProvider = Provider<CalculateFinancialHealthScore>((ref) {
  return ref.read(core_providers.calculateFinancialHealthScoreProvider);
});

/// Provider for CreateFinancialReport use case
final createFinancialReportProvider = Provider<CreateFinancialReport>((ref) {
  return ref.read(core_providers.createFinancialReportProvider);
});

/// Provider for GetFinancialReports use case
final getFinancialReportsProvider = Provider<GetFinancialReports>((ref) {
  return ref.read(core_providers.getFinancialReportsProvider);
});

/// State notifier provider for insight state management
final insightNotifierProvider =
    StateNotifierProvider<InsightNotifier, AsyncValue<InsightState>>((ref) {
  final getInsights = ref.watch(getInsightsProvider);
  final getRecentInsights = ref.watch(getRecentInsightsProvider);
  final markInsightAsRead = ref.watch(markInsightAsReadProvider);
  final generateInsightsSummary = ref.watch(generateInsightsSummaryProvider);
  final calculateFinancialHealthScore = ref.watch(calculateFinancialHealthScoreProvider);
  final createFinancialReport = ref.watch(createFinancialReportProvider);
  final getFinancialReports = ref.watch(getFinancialReportsProvider);

  return InsightNotifier(
    getInsights: getInsights,
    getRecentInsights: getRecentInsights,
    markInsightAsRead: markInsightAsRead,
    generateInsightsSummary: generateInsightsSummary,
    calculateFinancialHealthScore: calculateFinancialHealthScore,
    createFinancialReport: createFinancialReport,
    getFinancialReports: getFinancialReports,
  );
});

/// Provider for insights summary
final insightsSummaryProvider = Provider<AsyncValue<InsightsSummary?>>((ref) {
  final insightState = ref.watch(insightNotifierProvider);

  return insightState.when(
    data: (state) => AsyncValue.data(state.insightsSummary),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for financial health score
final financialHealthScoreProvider = Provider<AsyncValue<FinancialHealthScore?>>((ref) {
  final insightState = ref.watch(insightNotifierProvider);

  return insightState.when(
    data: (state) => AsyncValue.data(state.healthScore),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for financial reports
final financialReportsProvider = Provider<AsyncValue<List<FinancialReport>>>((ref) {
  final insightState = ref.watch(insightNotifierProvider);

  return insightState.when(
    data: (state) => AsyncValue.data(state.reports),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for insight statistics
final insightStatsProvider = Provider<AsyncValue<InsightStats>>((ref) {
  final insightState = ref.watch(insightNotifierProvider);

  return insightState.when(
    data: (state) {
      final stats = InsightStats(
        totalInsights: state.insights.length,
        unreadInsights: state.unreadCount,
        highPriorityInsights: state.highPriorityInsights.length,
        archivedInsights: state.insights.where((insight) => insight.isArchived).length,
        totalReports: state.reports.length,
        averageHealthScore: state.healthScore?.overallScore.toDouble() ?? 0.0,
      );

      return AsyncValue.data(stats);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});