import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Use case for getting transactions with various filters
class GetTransactions {
  const GetTransactions(this._repository);

  final TransactionRepository _repository;

  /// Get all transactions
  Future<Result<List<Transaction>>> call() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get transactions: $e'));
    }
  }

  /// Get transactions by date range
  Future<Result<List<Transaction>>> getByDateRange(DateTime start, DateTime end) async {
    try {
      return await _repository.getByDateRange(start, end);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get transactions by date range: $e'));
    }
  }

  /// Get transactions by category
  Future<Result<List<Transaction>>> getByCategory(String categoryId) async {
    try {
      return await _repository.getByCategory(categoryId);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get transactions by category: $e'));
    }
  }

  /// Get transactions by type
  Future<Result<List<Transaction>>> getByType(TransactionType type) async {
    try {
      return await _repository.getByType(type);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get transactions by type: $e'));
    }
  }

  /// Search transactions
  Future<Result<List<Transaction>>> search(String query) async {
    try {
      if (query.trim().isEmpty) {
        return await _repository.getAll();
      }
      return await _repository.search(query);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to search transactions: $e'));
    }
  }

  /// Get transaction count
  Future<Result<int>> getCount() async {
    try {
      return await _repository.getCount();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get transaction count: $e'));
    }
  }

  /// Get total amount for date range
  Future<Result<double>> getTotalAmount(
    DateTime start,
    DateTime end, {
    TransactionType? type,
  }) async {
    try {
      return await _repository.getTotalAmount(start, end, type: type);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get total amount: $e'));
    }
  }
}