import '../../../../core/error/result.dart';
import '../entities/account.dart';

/// Repository interface for account operations
/// Defines the contract for account data access
abstract class AccountRepository {
  /// Get all accounts
  Future<Result<List<Account>>> getAll();

  /// Get account by ID
  Future<Result<Account?>> getById(String id);

  /// Get accounts by type
  Future<Result<List<Account>>> getByType(AccountType type);

  /// Get active accounts only
  Future<Result<List<Account>>> getActive();

  /// Add new account
  Future<Result<Account>> add(Account account);

  /// Update existing account
  Future<Result<Account>> update(Account account);

  /// Delete account by ID
  Future<Result<void>> delete(String id);

  /// Get total balance across all accounts
  Future<Result<double>> getTotalBalance();

  /// Get net worth (assets - liabilities)
  Future<Result<double>> getNetWorth();

  /// Get accounts count
  Future<Result<int>> getCount();

  /// Search accounts by name or institution
  Future<Result<List<Account>>> search(String query);
}