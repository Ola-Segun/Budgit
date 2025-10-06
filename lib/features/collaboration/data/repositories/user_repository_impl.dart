import '../../../../core/error/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_hive_datasource.dart';

/// Implementation of UserRepository using Hive data source
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._dataSource);

  final UserHiveDataSource _dataSource;

  @override
  Future<Result<User?>> getUserById(String userId) => _dataSource.getUserById(userId);

  @override
  Future<Result<User?>> getUserByEmail(String email) => _dataSource.getUserByEmail(email);

  @override
  Future<Result<List<User>>> getAllUsers() => _dataSource.getAllUsers();

  @override
  Future<Result<User>> createUser(User user) => _dataSource.createUser(user);

  @override
  Future<Result<User>> updateUser(User user) => _dataSource.updateUser(user);

  @override
  Future<Result<void>> deleteUser(String userId) => _dataSource.deleteUser(userId);

  @override
  Future<Result<List<User>>> searchUsers(String query) => _dataSource.searchUsers(query);

  @override
  Future<Result<List<User>>> getUsersByIds(List<String> userIds) => _dataSource.getUsersByIds(userIds);
}