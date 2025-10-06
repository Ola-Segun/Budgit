import '../../../../core/error/result.dart';
import '../../domain/entities/insight.dart';
import '../../domain/repositories/insight_repository.dart';
import '../datasources/insight_hive_datasource.dart';

/// Implementation of InsightRepository using Hive data source
class InsightRepositoryImpl implements InsightRepository {
  const InsightRepositoryImpl(this._dataSource);

  final InsightHiveDataSource _dataSource;

  @override
  Future<Result<List<Insight>>> getAll() => _dataSource.getAllInsights();

  @override
  Future<Result<Insight?>> getById(String id) => _dataSource.getInsightById(id);

  @override
  Future<Result<List<Insight>>> getRecent({int limit = 20}) =>
      _dataSource.getRecentInsights(limit: limit);

  @override
  Future<Result<List<Insight>>> getUnread() => _dataSource.getUnreadInsights();

  @override
  Future<Result<List<Insight>>> getByType(InsightType type) =>
      _dataSource.getInsightsByType(type);

  @override
  Future<Result<List<Insight>>> getByPriority(InsightPriority priority) =>
      _dataSource.getInsightsByPriority(priority);

  @override
  Future<Result<Insight>> markAsRead(String insightId) =>
      _dataSource.markInsightAsRead(insightId);

  @override
  Future<Result<void>> markAllAsRead() => _dataSource.markAllInsightsAsRead();

  @override
  Future<Result<Insight>> archive(String insightId) =>
      _dataSource.archiveInsight(insightId);

  @override
  Future<Result<void>> delete(String insightId) =>
      _dataSource.deleteInsight(insightId);

  @override
  Future<Result<InsightsSummary>> generateInsightsSummary() =>
      _dataSource.generateInsightsSummary();

  @override
  Future<Result<MonthlySummary>> generateMonthlySummary(DateTime month) =>
      _dataSource.generateMonthlySummary(month);

  @override
  Future<Result<FinancialHealthScore>> calculateFinancialHealthScore() =>
      _dataSource.calculateFinancialHealthScore();

  @override
  Future<Result<List<SpendingTrend>>> generateSpendingTrends(DateTime startDate, DateTime endDate) =>
      _dataSource.generateSpendingTrends(startDate, endDate);

  @override
  Future<Result<List<CategoryAnalysis>>> generateCategoryAnalysis(DateTime period) =>
      _dataSource.generateCategoryAnalysis(period);

  @override
  Future<Result<int>> clearOldInsights(int daysOld) =>
      _dataSource.clearOldInsights(daysOld);

  @override
  Future<Result<FinancialReport>> createFinancialReport(
    String title,
    String description,
    FinancialReportType type,
    DateTime startDate,
    DateTime endDate,
  ) async {
    // Generate report data based on type
    final data = await _generateReportData(type, startDate, endDate);
    final sections = _getReportSections(type);

    final report = FinancialReport(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      type: type,
      startDate: startDate,
      endDate: endDate,
      generatedAt: DateTime.now(),
      data: data,
      sections: sections,
      filePath: null,
      isExported: false,
      metadata: null,
    );

    return _dataSource.createFinancialReport(report);
  }

  @override
  Future<Result<List<FinancialReport>>> getAllFinancialReports() =>
      _dataSource.getAllFinancialReports();

  @override
  Future<Result<FinancialReport?>> getFinancialReportById(String id) =>
      _dataSource.getFinancialReportById(id);

  @override
  Future<Result<void>> deleteFinancialReport(String reportId) =>
      _dataSource.deleteFinancialReport(reportId);

  @override
  Future<Result<String>> exportFinancialReport(String reportId, String format) =>
      _dataSource.exportFinancialReport(reportId, format);

  /// Generate report data based on type
  Future<Map<String, dynamic>> _generateReportData(
    FinancialReportType type,
    DateTime startDate,
    DateTime endDate,
  ) async {
    switch (type) {
      case FinancialReportType.monthlySummary:
        final summaryResult = await generateMonthlySummary(startDate);
        final summary = summaryResult.dataOrNull;
        return {
          'monthly_summary': summary != null ? {
            'total_income': summary.totalIncome,
            'total_expenses': summary.totalExpenses,
            'total_savings': summary.totalSavings,
            'savings_rate': summary.savingsRate,
            'budget_adherence': summary.budgetAdherence,
            'total_transactions': summary.totalTransactions,
            'top_spending_category': summary.topSpendingCategory,
          } : {},
        };

      case FinancialReportType.spendingTrends:
        final trendsResult = await generateSpendingTrends(startDate, endDate);
        final trends = trendsResult.dataOrNull ?? [];
        return {
          'spending_trends': trends.map((t) => {
            'category': t.categoryName,
            'amount': t.amount,
            'change_percentage': t.changePercentage,
            'direction': t.direction.name,
          }).toList(),
        };

      case FinancialReportType.categoryAnalysis:
        final analysisResult = await generateCategoryAnalysis(startDate);
        final analysis = analysisResult.dataOrNull ?? [];
        return {
          'category_analysis': analysis.map((c) => {
            'category': c.categoryName,
            'total_spent': c.totalSpent,
            'budget_amount': c.budgetAmount,
            'percentage_of_budget': c.percentageOfBudget,
            'status': c.status.name,
          }).toList(),
        };

      default:
        return {
          'generated_at': DateTime.now().toIso8601String(),
          'period': {
            'start': startDate.toIso8601String(),
            'end': endDate.toIso8601String(),
          },
        };
    }
  }

  /// Get report sections based on type
  List<String> _getReportSections(FinancialReportType type) {
    switch (type) {
      case FinancialReportType.monthlySummary:
        return ['Overview', 'Income vs Expenses', 'Category Breakdown', 'Trends'];
      case FinancialReportType.spendingTrends:
        return ['Trend Analysis', 'Period Comparison', 'Category Trends'];
      case FinancialReportType.categoryAnalysis:
        return ['Category Performance', 'Budget vs Actual', 'Recommendations'];
      default:
        return ['Summary', 'Details', 'Recommendations'];
    }
  }
}