import '../../../../core/error/result.dart';
import '../entities/budget.dart';

/// Repository interface for budget operations
abstract class BudgetRepository {
  /// Get all budgets
  Future<Result<List<Budget>>> getAll();

  /// Get budget by ID
  Future<Result<Budget?>> getById(String id);

  /// Get active budgets (currently within their date range)
  Future<Result<List<Budget>>> getActive();

  /// Get budgets by date range
  Future<Result<List<Budget>>> getByDateRange(DateTime start, DateTime end);

  /// Add new budget
  Future<Result<Budget>> add(Budget budget);

  /// Update existing budget
  Future<Result<Budget>> update(Budget budget);

  /// Delete budget by ID
  Future<Result<void>> delete(String id);

  /// Get budget status (with spending data)
  Future<Result<BudgetStatus>> getBudgetStatus(String budgetId);

  /// Get all budget statuses for active budgets
  Future<Result<List<BudgetStatus>>> getAllBudgetStatuses();

  /// Duplicate budget with new date range
  Future<Result<Budget>> duplicate(String budgetId, DateTime newStartDate, DateTime newEndDate);
}