import '../../../../core/error/result.dart';
import '../../../bills/domain/entities/bill.dart';
import '../../../insights/domain/entities/insight.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../entities/dashboard_data.dart';

/// Repository interface for dashboard data operations
abstract class DashboardRepository {
  /// Get comprehensive dashboard data
  Future<Result<DashboardData>> getDashboardData();

  /// Get financial snapshot for current month
  Future<Result<FinancialSnapshot>> getFinancialSnapshot();

  /// Get budget overview for top categories
  Future<Result<List<BudgetCategoryOverview>>> getBudgetOverview({int limit = 5});

  /// Get upcoming bills
  Future<Result<List<Bill>>> getUpcomingBills({int limit = 3});

  /// Get recent transactions
  Future<Result<List<Transaction>>> getRecentTransactions({int limit = 7});

  /// Get insights for dashboard
  Future<Result<List<Insight>>> getDashboardInsights({int limit = 3});

  /// Refresh dashboard data
  Future<Result<void>> refreshDashboardData();
}