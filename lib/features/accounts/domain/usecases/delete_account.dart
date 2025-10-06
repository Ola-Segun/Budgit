import '../../../../core/error/result.dart';
import '../repositories/account_repository.dart';

/// Use case for deleting an account
class DeleteAccount {
  const DeleteAccount(this._repository);

  final AccountRepository _repository;

  /// Execute the use case
  Future<Result<void>> call(String accountId) => _repository.delete(accountId);
}