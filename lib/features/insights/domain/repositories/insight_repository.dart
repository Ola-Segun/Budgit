import '../../../../core/error/result.dart';
import '../entities/insight.dart';

/// Repository interface for insight operations
abstract class InsightRepository {
  /// Get all insights
  Future<Result<List<Insight>>> getAll();

  /// Get insight by ID
  Future<Result<Insight?>> getById(String id);

  /// Get recent insights (last 30 days)
  Future<Result<List<Insight>>> getRecent({int limit = 20});

  /// Get unread insights
  Future<Result<List<Insight>>> getUnread();

  /// Get insights by type
  Future<Result<List<Insight>>> getByType(InsightType type);

  /// Get insights by priority
  Future<Result<List<Insight>>> getByPriority(InsightPriority priority);

  /// Mark insight as read
  Future<Result<Insight>> markAsRead(String insightId);

  /// Mark all insights as read
  Future<Result<void>> markAllAsRead();

  /// Archive insight
  Future<Result<Insight>> archive(String insightId);

  /// Delete insight
  Future<Result<void>> delete(String insightId);

  /// Generate insights summary
  Future<Result<InsightsSummary>> generateInsightsSummary();

  /// Generate monthly summary
  Future<Result<MonthlySummary>> generateMonthlySummary(DateTime month);

  /// Calculate financial health score
  Future<Result<FinancialHealthScore>> calculateFinancialHealthScore();

  /// Generate spending trends
  Future<Result<List<SpendingTrend>>> generateSpendingTrends(DateTime startDate, DateTime endDate);

  /// Generate category analysis
  Future<Result<List<CategoryAnalysis>>> generateCategoryAnalysis(DateTime period);

  /// Clear old insights (older than specified days)
  Future<Result<int>> clearOldInsights(int daysOld);

  /// Create financial report
  Future<Result<FinancialReport>> createFinancialReport(
    String title,
    String description,
    FinancialReportType type,
    DateTime startDate,
    DateTime endDate,
  );

  /// Get all financial reports
  Future<Result<List<FinancialReport>>> getAllFinancialReports();

  /// Get financial report by ID
  Future<Result<FinancialReport?>> getFinancialReportById(String id);

  /// Delete financial report
  Future<Result<void>> deleteFinancialReport(String id);

  /// Export financial report
  Future<Result<String>> exportFinancialReport(String reportId, String format);
}