import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_hive_datasource.dart';

/// Implementation of TransactionRepository using Hive data source
class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl(this._dataSource);

  final TransactionHiveDataSource _dataSource;

  @override
  Future<Result<List<Transaction>>> getAll() => _dataSource.getAll();

  @override
  Future<Result<Transaction?>> getById(String id) => _dataSource.getById(id);

  @override
  Future<Result<List<Transaction>>> getByDateRange(DateTime start, DateTime end) =>
      _dataSource.getByDateRange(start, end);

  @override
  Future<Result<List<Transaction>>> getByCategory(String categoryId) =>
      _dataSource.getByCategory(categoryId);

  @override
  Future<Result<List<Transaction>>> getByType(TransactionType type) =>
      _dataSource.getByType(type);

  @override
  Future<Result<Transaction>> add(Transaction transaction) =>
      _dataSource.add(transaction);

  @override
  Future<Result<Transaction>> update(Transaction transaction) =>
      _dataSource.update(transaction);

  @override
  Future<Result<void>> delete(String id) => _dataSource.delete(id);

  @override
  Future<Result<double>> getTotalAmount(DateTime start, DateTime end, {TransactionType? type}) =>
      _dataSource.getTotalAmount(start, end, type: type);

  @override
  Future<Result<List<Transaction>>> search(String query) =>
      _dataSource.search(query);

  @override
  Future<Result<int>> getCount() => _dataSource.getCount();


  @override
  Future<Result<List<Transaction>>> getPaginated({
    int limit = 20,
    int offset = 0,
    TransactionFilter? filter,
  }) async {
    return getTransactionsPaginated(limit: limit, offset: offset, filter: filter);
  }

  @override
  Future<Result<List<Transaction>>> getTransactionsPaginated({
    int limit = 20,
    int offset = 0,
    TransactionFilter? filter,
  }) async {
    try {
      // Get all transactions first (in a real app, this would be optimized)
      final allResult = await _dataSource.getAll();
      if (allResult.isError) {
        return Result.error(allResult.failureOrNull!);
      }

      var transactions = allResult.dataOrNull!;

      // Apply filters if provided
      if (filter != null && filter.isNotEmpty) {
        transactions = transactions.where((transaction) {
          // Filter by transaction type
          if (filter.transactionType != null &&
              transaction.type != filter.transactionType) {
            return false;
          }

          // Filter by categories (multi-select)
          if (filter.categoryIds != null && filter.categoryIds!.isNotEmpty &&
              !filter.categoryIds!.contains(transaction.categoryId)) {
            return false;
          }

          // Filter by account
          if (filter.accountId != null &&
              transaction.accountId != filter.accountId) {
            return false;
          }

          // Filter by date range
          if (filter.startDate != null &&
              transaction.date.isBefore(filter.startDate!)) {
            return false;
          }
          if (filter.endDate != null &&
              transaction.date.isAfter(filter.endDate!)) {
            return false;
          }

          // Filter by amount range
          if (filter.minAmount != null &&
              transaction.amount < filter.minAmount!) {
            return false;
          }
          if (filter.maxAmount != null &&
              transaction.amount > filter.maxAmount!) {
            return false;
          }

          return true;
        }).toList();
      }

      // Sort by date (newest first)
      transactions.sort((a, b) => b.date.compareTo(a.date));

      // Apply pagination
      final startIndex = offset;
      final endIndex = (startIndex + limit).clamp(0, transactions.length);

      if (startIndex >= transactions.length) {
        return const Result.success([]);
      }

      final paginatedTransactions = transactions.sublist(startIndex, endIndex);
      return Result.success(paginatedTransactions);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get paginated transactions: $e'));
    }
  }

  @override
  Future<Result<List<Transaction>>> getTransactionsPaginatedByDateRange(
    DateTime start,
    DateTime end, {
    int limit = 20,
    int offset = 0,
    TransactionFilter? filter,
  }) async {
    try {
      // Get transactions by date range first
      final dateRangeResult = await _dataSource.getByDateRange(start, end);
      if (dateRangeResult.isError) {
        return Result.error(dateRangeResult.failureOrNull!);
      }

      var transactions = dateRangeResult.dataOrNull!;

      // Apply additional filters if provided
      if (filter != null && filter.isNotEmpty) {
        transactions = transactions.where((transaction) {
          // Filter by transaction type
          if (filter.transactionType != null &&
              transaction.type != filter.transactionType) {
            return false;
          }

          // Filter by categories (multi-select)
          if (filter.categoryIds != null && filter.categoryIds!.isNotEmpty &&
              !filter.categoryIds!.contains(transaction.categoryId)) {
            return false;
          }

          // Filter by account
          if (filter.accountId != null &&
              transaction.accountId != filter.accountId) {
            return false;
          }

          // Filter by amount range
          if (filter.minAmount != null &&
              transaction.amount < filter.minAmount!) {
            return false;
          }
          if (filter.maxAmount != null &&
              transaction.amount > filter.maxAmount!) {
            return false;
          }

          return true;
        }).toList();
      }

      // Sort by date (newest first)
      transactions.sort((a, b) => b.date.compareTo(a.date));

      // Apply pagination
      final startIndex = offset;
      final endIndex = (startIndex + limit).clamp(0, transactions.length);

      if (startIndex >= transactions.length) {
        return const Result.success([]);
      }

      final paginatedTransactions = transactions.sublist(startIndex, endIndex);
      return Result.success(paginatedTransactions);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get paginated transactions by date range: $e'));
    }
  }

  @override
  Future<Result<int>> getFilteredCount(TransactionFilter? filter) async {
    try {
      // Get all transactions first (in a real app, this would be optimized)
      final allResult = await _dataSource.getAll();
      if (allResult.isError) {
        return Result.error(allResult.failureOrNull!);
      }

      var transactions = allResult.dataOrNull!;

      // Apply filters if provided
      if (filter != null && filter.isNotEmpty) {
        transactions = transactions.where((transaction) {
          // Filter by transaction type
          if (filter.transactionType != null &&
              transaction.type != filter.transactionType) {
            return false;
          }

          // Filter by categories (multi-select)
          if (filter.categoryIds != null && filter.categoryIds!.isNotEmpty &&
              !filter.categoryIds!.contains(transaction.categoryId)) {
            return false;
          }

          // Filter by account
          if (filter.accountId != null &&
              transaction.accountId != filter.accountId) {
            return false;
          }

          // Filter by date range
          if (filter.startDate != null &&
              transaction.date.isBefore(filter.startDate!)) {
            return false;
          }
          if (filter.endDate != null &&
              transaction.date.isAfter(filter.endDate!)) {
            return false;
          }

          // Filter by amount range
          if (filter.minAmount != null &&
              transaction.amount < filter.minAmount!) {
            return false;
          }
          if (filter.maxAmount != null &&
              transaction.amount > filter.maxAmount!) {
            return false;
          }

          return true;
        }).toList();
      }

      return Result.success(transactions.length);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get filtered count: $e'));
    }
  }
}