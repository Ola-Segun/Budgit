import '../../../../core/error/result.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/account_hive_datasource.dart';

/// Implementation of AccountRepository using Hive data source
class AccountRepositoryImpl implements AccountRepository {
  const AccountRepositoryImpl(this._dataSource);

  final AccountHiveDataSource _dataSource;

  @override
  Future<Result<List<Account>>> getAll() => _dataSource.getAll();

  @override
  Future<Result<Account?>> getById(String id) => _dataSource.getById(id);

  @override
  Future<Result<List<Account>>> getByType(AccountType type) =>
      _dataSource.getByType(type);

  @override
  Future<Result<List<Account>>> getActive() => _dataSource.getActive();

  @override
  Future<Result<Account>> add(Account account) => _dataSource.add(account);

  @override
  Future<Result<Account>> update(Account account) => _dataSource.update(account);

  @override
  Future<Result<void>> delete(String id) => _dataSource.delete(id);

  @override
  Future<Result<double>> getTotalBalance() => _dataSource.getTotalBalance();

  @override
  Future<Result<double>> getNetWorth() => _dataSource.getNetWorth();

  @override
  Future<Result<List<Account>>> search(String query) => _dataSource.search(query);

  @override
  Future<Result<int>> getCount() => _dataSource.getCount();
}