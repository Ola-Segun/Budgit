import '../../../../core/error/result.dart';
import '../../domain/entities/transaction.dart';
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
}