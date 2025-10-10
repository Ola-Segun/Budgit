import '../../../../core/error/result.dart';
import '../entities/transaction.dart';
import '../entities/transaction_filter.dart';

/// Repository interface for transaction operations
/// Defines the contract for transaction data access
abstract class TransactionRepository {
  /// Get all transactions
  Future<Result<List<Transaction>>> getAll();

  /// Get transaction by ID
  Future<Result<Transaction?>> getById(String id);

  /// Get transactions by date range
  Future<Result<List<Transaction>>> getByDateRange(DateTime start, DateTime end);

  /// Get transactions by category
  Future<Result<List<Transaction>>> getByCategory(String categoryId);

  /// Get transactions by type
  Future<Result<List<Transaction>>> getByType(TransactionType type);

  /// Add new transaction
  Future<Result<Transaction>> add(Transaction transaction);

  /// Update existing transaction
  Future<Result<Transaction>> update(Transaction transaction);

  /// Delete transaction by ID
  Future<Result<void>> delete(String id);

  /// Get total amount for date range
  Future<Result<double>> getTotalAmount(DateTime start, DateTime end, {TransactionType? type});

  /// Search transactions by title or description
  Future<Result<List<Transaction>>> search(String query);

  /// Get transaction count
  Future<Result<int>> getCount();

  /// Get paginated transactions
  Future<Result<List<Transaction>>> getTransactionsPaginated({
    int limit = 20,
    int offset = 0,
    TransactionFilter? filter,
  });

  /// Get paginated transactions by date range
  Future<Result<List<Transaction>>> getTransactionsPaginatedByDateRange(
    DateTime start,
    DateTime end, {
    int limit = 20,
    int offset = 0,
    TransactionFilter? filter,
  });

  /// Get paginated transactions
  Future<Result<List<Transaction>>> getPaginated({
    int limit = 20,
    int offset = 0,
    TransactionFilter? filter,
  });

  /// Get paginated transaction count with filters
  Future<Result<int>> getFilteredCount(TransactionFilter? filter);

  /// Get transactions by account ID (including transfers affecting the account)
  Future<Result<List<Transaction>>> getByAccountId(String accountId);

  /// Get calculated balances for all accounts from transactions
  Future<Result<Map<String, double>>> getBalancesByAccount();

  /// Get calculated balance for a specific account from transactions
  Future<Result<double>> getCalculatedBalance(String accountId);
}

/// Repository interface for transaction categories
abstract class TransactionCategoryRepository {
  /// Get all categories
  Future<Result<List<TransactionCategory>>> getAll();

  /// Get category by ID
  Future<Result<TransactionCategory?>> getById(String id);

  /// Get categories by type
  Future<Result<List<TransactionCategory>>> getByType(TransactionType type);

  /// Add new category
  Future<Result<TransactionCategory>> add(TransactionCategory category);

  /// Update existing category
  Future<Result<TransactionCategory>> update(TransactionCategory category);

  /// Delete category by ID
  Future<Result<void>> delete(String id);

  /// Check if category is in use
  Future<Result<bool>> isCategoryInUse(String categoryId);
}