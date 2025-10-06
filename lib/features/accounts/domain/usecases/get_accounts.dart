import '../../../../core/error/result.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

/// Use case for getting all accounts
class GetAccounts {
  const GetAccounts(this._repository);

  final AccountRepository _repository;

  /// Execute the use case
  Future<Result<List<Account>>> call() => _repository.getAll();
}