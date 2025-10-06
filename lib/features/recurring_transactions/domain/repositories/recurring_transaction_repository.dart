import '../../../../core/error/result.dart';
import '../entities/recurring_transaction.dart';

/// Repository interface for recurring transaction management
abstract class RecurringTransactionRepository {
  /// Get recurring transaction by ID
  Future<Result<RecurringTransaction?>> getRecurringTransactionById(String id);

  /// Get all recurring transactions for a user
  Future<Result<List<RecurringTransaction>>> getRecurringTransactionsForUser(String userId);

  /// Get all active recurring transactions
  Future<Result<List<RecurringTransaction>>> getActiveRecurringTransactions();

  /// Create a new recurring transaction
  Future<Result<RecurringTransaction>> createRecurringTransaction(RecurringTransaction transaction);

  /// Update recurring transaction
  Future<Result<RecurringTransaction>> updateRecurringTransaction(RecurringTransaction transaction);

  /// Delete recurring transaction
  Future<Result<void>> deleteRecurringTransaction(String id);

  /// Update last processed date
  Future<Result<void>> updateLastProcessedDate(String id, DateTime date);

  /// Get recurring transactions due on a specific date
  Future<Result<List<RecurringTransaction>>> getRecurringTransactionsDueOn(DateTime date);

  /// Pause recurring transaction
  Future<Result<RecurringTransaction>> pauseRecurringTransaction(String id);

  /// Resume recurring transaction
  Future<Result<RecurringTransaction>> resumeRecurringTransaction(String id);
}