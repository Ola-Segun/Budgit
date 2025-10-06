import '../../../../core/error/result.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_category_hive_datasource.dart';

/// Implementation of TransactionCategoryRepository using Hive data source
class TransactionCategoryRepositoryImpl implements TransactionCategoryRepository {
  const TransactionCategoryRepositoryImpl(this._dataSource);

  final TransactionCategoryHiveDataSource _dataSource;

  @override
  Future<Result<List<TransactionCategory>>> getAll() => _dataSource.getAll();

  @override
  Future<Result<TransactionCategory?>> getById(String id) => _dataSource.getById(id);

  @override
  Future<Result<List<TransactionCategory>>> getByType(TransactionType type) =>
      _dataSource.getByType(type);

  @override
  Future<Result<TransactionCategory>> add(TransactionCategory category) =>
      _dataSource.add(category);

  @override
  Future<Result<TransactionCategory>> update(TransactionCategory category) =>
      _dataSource.update(category);

  @override
  Future<Result<void>> delete(String id) => _dataSource.delete(id);

  @override
  Future<Result<bool>> isCategoryInUse(String categoryId) =>
      _dataSource.isCategoryInUse(categoryId);
}