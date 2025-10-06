import '../../../../core/error/result.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

/// Use case for getting account balance
class GetAccountBalance {
  const GetAccountBalance(this._repository);

  final AccountRepository _repository;

  /// Get total balance across all accounts
  Future<Result<double>> getTotalBalance() => _repository.getTotalBalance();

  /// Get net worth (assets - liabilities)
  Future<Result<double>> getNetWorth() => _repository.getNetWorth();

  /// Get balance for a specific account
  Future<Result<Account?>> getAccountBalance(String accountId) =>
      _repository.getById(accountId);
}