import '../../../../core/error/result.dart';
import '../entities/recurring_income.dart';

/// Repository interface for recurring income operations
abstract class RecurringIncomeRepository {
  /// Get all recurring incomes
  Future<Result<List<RecurringIncome>>> getAll();

  /// Get recurring income by ID
  Future<Result<RecurringIncome?>> getById(String id);

  /// Get incomes expected within specified days
  Future<Result<List<RecurringIncome>>> getExpectedWithin(int days);

  /// Get overdue incomes (expected but not received)
  Future<Result<List<RecurringIncome>>> getOverdue();

  /// Get incomes received this month
  Future<Result<List<RecurringIncome>>> getReceivedThisMonth();

  /// Get incomes expected this month
  Future<Result<List<RecurringIncome>>> getExpectedThisMonth();

  /// Add new recurring income
  Future<Result<RecurringIncome>> add(RecurringIncome income);

  /// Update existing recurring income
  Future<Result<RecurringIncome>> update(RecurringIncome income);

  /// Delete recurring income by ID
  Future<Result<void>> delete(String id);

  /// Record income receipt
  Future<Result<RecurringIncome>> recordIncomeReceipt(
    String incomeId,
    RecurringIncomeInstance instance,
    {String? accountId}
  );

  /// Get income status
  Future<Result<RecurringIncomeStatus>> getIncomeStatus(String incomeId);

  /// Get status for all incomes
  Future<Result<List<RecurringIncomeStatus>>> getAllIncomeStatuses();

  /// Get incomes summary for dashboard
  Future<Result<RecurringIncomesSummary>> getIncomesSummary();

  /// Update next expected date for recurring income
  Future<Result<RecurringIncome>> updateNextExpectedDate(String incomeId);

  /// Check if a recurring income name already exists
  Future<Result<bool>> nameExists(String name, {String? excludeId});
}