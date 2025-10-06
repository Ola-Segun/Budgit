import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/transaction.dart';
import '../entities/transaction_filter.dart';
import '../repositories/transaction_repository.dart';

/// Use case for getting paginated transactions
class GetPaginatedTransactions {
  const GetPaginatedTransactions(this._repository);

  final TransactionRepository _repository;

  /// Get paginated transactions
  Future<Result<List<Transaction>>> call({
    int limit = 20,
    int offset = 0,
    TransactionFilter? filter,
  }) async {
    try {
      return await _repository.getTransactionsPaginated(
        limit: limit,
        offset: offset,
        filter: filter,
      );
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get paginated transactions: $e'));
    }
  }

  /// Get paginated transactions by date range
  Future<Result<List<Transaction>>> getByDateRange(
    DateTime start,
    DateTime end, {
    int limit = 20,
    int offset = 0,
    TransactionFilter? filter,
  }) async {
    try {
      return await _repository.getTransactionsPaginatedByDateRange(
        start,
        end,
        limit: limit,
        offset: offset,
        filter: filter,
      );
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get paginated transactions by date range: $e'));
    }
  }

  /// Get filtered count for pagination
  Future<Result<int>> getFilteredCount(TransactionFilter? filter) async {
    try {
      return await _repository.getFilteredCount(filter);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get filtered count: $e'));
    }
  }
}