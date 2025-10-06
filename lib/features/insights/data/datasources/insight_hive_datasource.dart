import 'package:hive/hive.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../../core/storage/hive_storage.dart';
import '../models/insight_dto.dart';
import '../../domain/entities/insight.dart';

/// Hive-based data source for insight operations
class InsightHiveDataSource {
  static const String _insightsBoxName = 'insights';
  static const String _reportsBoxName = 'financial_reports';

  Box<InsightDto>? _insightsBox;
  Box<FinancialReportDto>? _reportsBox;

  /// Initialize the data source
  Future<void> init() async {
    // Wait for Hive to be initialized
    await HiveStorage.init();

    // Register adapters if not already registered
    if (!Hive.isAdapterRegistered(9)) {
      Hive.registerAdapter(InsightDtoAdapter());
    }
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(FinancialReportDtoAdapter());
    }

    // Handle box opening with proper type checking
    if (!Hive.isBoxOpen(_insightsBoxName)) {
      _insightsBox = await Hive.openBox<InsightDto>(_insightsBoxName);
    } else {
      try {
        _insightsBox = Hive.box<InsightDto>(_insightsBoxName);
      } catch (e) {
        // If the box is already open with wrong type, close and reopen
        if (e.toString().contains('Box<dynamic>')) {
          await Hive.box(_insightsBoxName).close();
          _insightsBox = await Hive.openBox<InsightDto>(_insightsBoxName);
        } else {
          rethrow;
        }
      }
    }

    if (!Hive.isBoxOpen(_reportsBoxName)) {
      _reportsBox = await Hive.openBox<FinancialReportDto>(_reportsBoxName);
    } else {
      try {
        _reportsBox = Hive.box<FinancialReportDto>(_reportsBoxName);
      } catch (e) {
        // If the box is already open with wrong type, close and reopen
        if (e.toString().contains('Box<dynamic>')) {
          await Hive.box(_reportsBoxName).close();
          _reportsBox = await Hive.openBox<FinancialReportDto>(_reportsBoxName);
        } else {
          rethrow;
        }
      }
    }
  }

  // ===== INSIGHT OPERATIONS =====

  /// Get all insights
  Future<Result<List<Insight>>> getAllInsights() async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _insightsBox!.values.toList();
      final insights = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by generated date (newest first)
      insights.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));

      return Result.success(insights);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get insights: $e'));
    }
  }

  /// Get insight by ID
  Future<Result<Insight?>> getInsightById(String id) async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = _insightsBox!.get(id);
      if (dto == null) {
        return Result.success(null);
      }

      return Result.success(dto.toDomain());
    } catch (e) {
      return Result.error(Failure.cache('Failed to get insight: $e'));
    }
  }

  /// Get recent insights
  Future<Result<List<Insight>>> getRecentInsights({int limit = 20}) async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _insightsBox!.values.toList();
      final insights = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by generated date (newest first) and take limit
      insights.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));
      final recent = insights.take(limit).toList();

      return Result.success(recent);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get recent insights: $e'));
    }
  }

  /// Get unread insights
  Future<Result<List<Insight>>> getUnreadInsights() async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _insightsBox!.values.where((dto) => !dto.isRead).toList();
      final insights = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by generated date (newest first)
      insights.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));

      return Result.success(insights);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get unread insights: $e'));
    }
  }

  /// Get insights by type
  Future<Result<List<Insight>>> getInsightsByType(InsightType type) async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _insightsBox!.values.where((dto) => dto.type == type.name).toList();
      final insights = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by generated date (newest first)
      insights.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));

      return Result.success(insights);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get insights by type: $e'));
    }
  }

  /// Get insights by priority
  Future<Result<List<Insight>>> getInsightsByPriority(InsightPriority priority) async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _insightsBox!.values.where((dto) => dto.priority == priority.name).toList();
      final insights = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by generated date (newest first)
      insights.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));

      return Result.success(insights);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get insights by priority: $e'));
    }
  }

  /// Mark insight as read
  Future<Result<Insight>> markInsightAsRead(String insightId) async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = _insightsBox!.get(insightId);
      if (dto == null) {
        return Result.error(Failure.notFound('Insight not found'));
      }

      dto.isRead = true;
      await _insightsBox!.put(insightId, dto);

      return Result.success(dto.toDomain());
    } catch (e) {
      return Result.error(Failure.cache('Failed to mark insight as read: $e'));
    }
  }

  /// Mark all insights as read
  Future<Result<void>> markAllInsightsAsRead() async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _insightsBox!.values.toList();
      for (final dto in dtos) {
        dto.isRead = true;
        await _insightsBox!.put(dto.id, dto);
      }

      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.cache('Failed to mark all insights as read: $e'));
    }
  }

  /// Archive insight
  Future<Result<Insight>> archiveInsight(String insightId) async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = _insightsBox!.get(insightId);
      if (dto == null) {
        return Result.error(Failure.notFound('Insight not found'));
      }

      dto.isArchived = true;
      await _insightsBox!.put(insightId, dto);

      return Result.success(dto.toDomain());
    } catch (e) {
      return Result.error(Failure.cache('Failed to archive insight: $e'));
    }
  }

  /// Delete insight
  Future<Result<void>> deleteInsight(String insightId) async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      await _insightsBox!.delete(insightId);
      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.cache('Failed to delete insight: $e'));
    }
  }

  /// Clear old insights
  Future<Result<int>> clearOldInsights(int daysOld) async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final cutoffDate = DateTime.now().subtract(Duration(days: daysOld));
      final dtos = _insightsBox!.values.where((dto) => dto.generatedAt.isBefore(cutoffDate)).toList();

      for (final dto in dtos) {
        await _insightsBox!.delete(dto.id);
      }

      return Result.success(dtos.length);
    } catch (e) {
      return Result.error(Failure.cache('Failed to clear old insights: $e'));
    }
  }

  // ===== FINANCIAL REPORT OPERATIONS =====

  /// Create financial report
  Future<Result<FinancialReport>> createFinancialReport(FinancialReport report) async {
    try {
      if (_reportsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = FinancialReportDto.fromDomain(report);
      await _reportsBox!.put(report.id, dto);

      return Result.success(report);
    } catch (e) {
      return Result.error(Failure.cache('Failed to create financial report: $e'));
    }
  }

  /// Get all financial reports
  Future<Result<List<FinancialReport>>> getAllFinancialReports() async {
    try {
      if (_reportsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _reportsBox!.values.toList();
      final reports = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by generated date (newest first)
      reports.sort((a, b) => b.generatedAt.compareTo(a.generatedAt));

      return Result.success(reports);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get financial reports: $e'));
    }
  }

  /// Get financial report by ID
  Future<Result<FinancialReport?>> getFinancialReportById(String id) async {
    try {
      if (_reportsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = _reportsBox!.get(id);
      if (dto == null) {
        return Result.success(null);
      }

      return Result.success(dto.toDomain());
    } catch (e) {
      return Result.error(Failure.cache('Failed to get financial report: $e'));
    }
  }

  /// Delete financial report
  Future<Result<void>> deleteFinancialReport(String reportId) async {
    try {
      if (_reportsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      await _reportsBox!.delete(reportId);
      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.cache('Failed to delete financial report: $e'));
    }
  }

  /// Export financial report (placeholder - would implement actual export logic)
  Future<Result<String>> exportFinancialReport(String reportId, String format) async {
    try {
      if (_reportsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = _reportsBox!.get(reportId);
      if (dto == null) {
        return Result.error(Failure.notFound('Financial report not found'));
      }

      // Mark as exported
      dto.isExported = true;
      await _reportsBox!.put(reportId, dto);

      // Placeholder for actual export logic
      // In a real implementation, this would generate and save the file
      final filePath = '/exports/report_$reportId.$format';

      return Result.success(filePath);
    } catch (e) {
      return Result.error(Failure.cache('Failed to export financial report: $e'));
    }
  }

  // ===== BUSINESS LOGIC METHODS =====

  /// Generate insights summary (complex business logic)
  Future<Result<InsightsSummary>> generateInsightsSummary() async {
    try {
      if (_insightsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      // Get recent insights
      final recentInsightsResult = await getRecentInsights(limit: 10);
      if (recentInsightsResult.isError) {
        return Result.error(recentInsightsResult.failureOrNull!);
      }

      // Calculate financial health score
      final healthScoreResult = await calculateFinancialHealthScore();
      if (healthScoreResult.isError) {
        return Result.error(healthScoreResult.failureOrNull!);
      }

      // Generate current month summary
      final now = DateTime.now();
      final monthStart = DateTime(now.year, now.month, 1);
      final monthlySummaryResult = await generateMonthlySummary(monthStart);
      if (monthlySummaryResult.isError) {
        return Result.error(monthlySummaryResult.failureOrNull!);
      }

      // Get key spending trends (last 3 months)
      final trendsStart = DateTime(now.year, now.month - 3, 1);
      final trendsResult = await generateSpendingTrends(trendsStart, now);
      if (trendsResult.isError) {
        return Result.error(trendsResult.failureOrNull!);
      }

      // Get category analysis for current month
      final categoryAnalysisResult = await generateCategoryAnalysis(monthStart);
      if (categoryAnalysisResult.isError) {
        return Result.error(categoryAnalysisResult.failureOrNull!);
      }

      final summary = InsightsSummary(
        recentInsights: recentInsightsResult.dataOrNull!,
        healthScore: healthScoreResult.dataOrNull!,
        currentMonthSummary: monthlySummaryResult.dataOrNull!,
        keyTrends: trendsResult.dataOrNull!,
        categoryAnalysis: categoryAnalysisResult.dataOrNull!,
        generatedAt: DateTime.now(),
      );

      return Result.success(summary);
    } catch (e) {
      return Result.error(Failure.cache('Failed to generate insights summary: $e'));
    }
  }

  /// Generate monthly summary
  Future<Result<MonthlySummary>> generateMonthlySummary(DateTime month) async {
    try {
      // This would integrate with transaction data source
      // For now, return a placeholder
      final summary = MonthlySummary(
        month: month,
        totalIncome: 0.0,
        totalExpenses: 0.0,
        totalSavings: 0.0,
        savingsRate: 0.0,
        budgetAdherence: 0.0,
        categoryBreakdown: [],
        trends: [],
        totalTransactions: 0,
        averageTransactionAmount: 0.0,
        largestExpense: 0.0,
        topSpendingCategory: '',
      );

      return Result.success(summary);
    } catch (e) {
      return Result.error(Failure.cache('Failed to generate monthly summary: $e'));
    }
  }

  /// Calculate financial health score
  Future<Result<FinancialHealthScore>> calculateFinancialHealthScore() async {
    try {
      // Placeholder implementation - would analyze transaction data
      final score = FinancialHealthScore(
        overallScore: 75,
        grade: FinancialHealthGrade.good,
        componentScores: {
          'savings_rate': 70,
          'budget_adherence': 80,
          'spending_patterns': 75,
          'income_stability': 85,
        },
        strengths: ['Good budget adherence', 'Stable income'],
        weaknesses: ['Could save more', 'High entertainment spending'],
        recommendations: [
          'Try to increase savings rate to 20%',
          'Consider reducing entertainment expenses',
        ],
        calculatedAt: DateTime.now(),
      );

      return Result.success(score);
    } catch (e) {
      return Result.error(Failure.cache('Failed to calculate financial health score: $e'));
    }
  }

  /// Generate spending trends
  Future<Result<List<SpendingTrend>>> generateSpendingTrends(DateTime startDate, DateTime endDate) async {
    try {
      // Placeholder implementation - would analyze transaction data
      final trends = <SpendingTrend>[];

      return Result.success(trends);
    } catch (e) {
      return Result.error(Failure.cache('Failed to generate spending trends: $e'));
    }
  }

  /// Generate category analysis
  Future<Result<List<CategoryAnalysis>>> generateCategoryAnalysis(DateTime period) async {
    try {
      // Placeholder implementation - would analyze transaction data
      final analysis = <CategoryAnalysis>[];

      return Result.success(analysis);
    } catch (e) {
      return Result.error(Failure.cache('Failed to generate category analysis: $e'));
    }
  }

  /// Close the boxes
  Future<void> close() async {
    await _insightsBox?.close();
    await _reportsBox?.close();
    _insightsBox = null;
    _reportsBox = null;
  }
}