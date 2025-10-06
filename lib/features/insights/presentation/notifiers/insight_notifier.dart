import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/insight.dart';
import '../../domain/usecases/calculate_financial_health_score.dart';
import '../../domain/usecases/get_insights.dart';
import '../states/insight_state.dart';

/// State notifier for insights management
class InsightNotifier extends StateNotifier<AsyncValue<InsightState>> {
  final GetInsights _getInsights;
  final GetRecentInsights _getRecentInsights;
  final MarkInsightAsRead _markInsightAsRead;
  final GenerateInsightsSummary _generateInsightsSummary;
  final CalculateFinancialHealthScore _calculateFinancialHealthScore;
  final CreateFinancialReport _createFinancialReport;
  final GetFinancialReports _getFinancialReports;

  InsightNotifier({
    required GetInsights getInsights,
    required GetRecentInsights getRecentInsights,
    required MarkInsightAsRead markInsightAsRead,
    required GenerateInsightsSummary generateInsightsSummary,
    required CalculateFinancialHealthScore calculateFinancialHealthScore,
    required CreateFinancialReport createFinancialReport,
    required GetFinancialReports getFinancialReports,
  })  : _getInsights = getInsights,
        _getRecentInsights = getRecentInsights,
        _markInsightAsRead = markInsightAsRead,
        _generateInsightsSummary = generateInsightsSummary,
        _calculateFinancialHealthScore = calculateFinancialHealthScore,
        _createFinancialReport = createFinancialReport,
        _getFinancialReports = getFinancialReports,
        super(const AsyncValue.loading()) {
    loadInsights();
    loadInsightsSummary();
    loadFinancialHealthScore();
    loadFinancialReports();
  }

  /// Load all insights
  Future<void> loadInsights() async {
    final currentState = state.value ?? const InsightState();

    state = AsyncValue.data(currentState.copyWith(isLoading: true));

    final result = await _getInsights();

    result.when(
      success: (insights) {
        final newState = currentState.copyWith(
          insights: insights,
          isLoading: false,
          error: null,
        );
        state = AsyncValue.data(newState);
      },
      error: (failure) {
        final newState = currentState.copyWith(
          isLoading: false,
          error: failure.message,
        );
        state = AsyncValue.data(newState);
      },
    );
  }

  /// Load insights summary
  Future<void> loadInsightsSummary() async {
    final currentState = state.value ?? const InsightState();

    state = AsyncValue.data(currentState.copyWith(isLoadingSummary: true));

    final result = await _generateInsightsSummary();

    result.when(
      success: (summary) {
        final newState = currentState.copyWith(
          insightsSummary: summary,
          isLoadingSummary: false,
          summaryError: null,
        );
        state = AsyncValue.data(newState);
      },
      error: (failure) {
        final newState = currentState.copyWith(
          isLoadingSummary: false,
          summaryError: failure.message,
        );
        state = AsyncValue.data(newState);
      },
    );
  }

  /// Load financial health score
  Future<void> loadFinancialHealthScore() async {
    final currentState = state.value ?? const InsightState();

    state = AsyncValue.data(currentState.copyWith(isLoadingHealthScore: true));

    final result = await _calculateFinancialHealthScore();

    result.when(
      success: (healthScore) {
        final newState = currentState.copyWith(
          healthScore: healthScore,
          isLoadingHealthScore: false,
          healthScoreError: null,
        );
        state = AsyncValue.data(newState);
      },
      error: (failure) {
        final newState = currentState.copyWith(
          isLoadingHealthScore: false,
          healthScoreError: failure.message,
        );
        state = AsyncValue.data(newState);
      },
    );
  }

  /// Load financial reports
  Future<void> loadFinancialReports() async {
    final currentState = state.value ?? const InsightState();

    final result = await _getFinancialReports();

    result.when(
      success: (reports) {
        final newState = currentState.copyWith(reports: reports);
        state = AsyncValue.data(newState);
      },
      error: (failure) {
        // Reports loading failure doesn't block the UI
        final newState = currentState.copyWith(reportError: failure.message);
        state = AsyncValue.data(newState);
      },
    );
  }

  /// Mark insight as read
  Future<bool> markInsightAsRead(String insightId) async {
    final currentState = state.value;
    if (currentState == null) return false;

    final result = await _markInsightAsRead(insightId);

    return result.when(
      success: (updatedInsight) {
        final updatedInsights = currentState.insights.map((insight) {
          return insight.id == insightId ? updatedInsight : insight;
        }).toList();

        final newState = currentState.copyWith(insights: updatedInsights);
        state = AsyncValue.data(newState);
        return true;
      },
      error: (failure) {
        final newState = currentState.copyWith(error: failure.message);
        state = AsyncValue.data(newState);
        return false;
      },
    );
  }

  /// Create financial report
  Future<bool> createFinancialReport(
    String title,
    String description,
    FinancialReportType type,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final currentState = state.value ?? const InsightState();

    state = AsyncValue.data(currentState.copyWith(isCreatingReport: true));

    final result = await _createFinancialReport(
      title,
      description,
      type,
      startDate,
      endDate,
    );

    return result.when(
      success: (report) {
        final updatedReports = [report, ...currentState.reports];
        final newState = currentState.copyWith(
          reports: updatedReports,
          isCreatingReport: false,
          reportError: null,
        );
        state = AsyncValue.data(newState);
        return true;
      },
      error: (failure) {
        final newState = currentState.copyWith(
          isCreatingReport: false,
          reportError: failure.message,
        );
        state = AsyncValue.data(newState);
        return false;
      },
    );
  }

  /// Refresh all data
  Future<void> refresh() async {
    await Future.wait([
      loadInsights(),
      loadInsightsSummary(),
      loadFinancialHealthScore(),
      loadFinancialReports(),
    ]);
  }

  /// Clear errors
  void clearErrors() {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(
      error: null,
      summaryError: null,
      healthScoreError: null,
      reportError: null,
    ));
  }
}