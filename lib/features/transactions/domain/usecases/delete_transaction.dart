import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../accounts/domain/repositories/account_repository.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Use case for deleting a transaction with balance rollback
/// Follows the Transaction Deletion (Rollback) pattern from Account-Transaction-Relationship.md
class DeleteTransaction {
  const DeleteTransaction(
    this._transactionRepository,
    this._accountRepository,
  );

  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;

  /// Execute the use case with balance rollback
  Future<Result<void>> call(String transactionId) async {
    try {
      // 1. Retrieve transaction details BEFORE deletion
      final existingResult = await _transactionRepository.getById(transactionId);
      if (existingResult.isError) {
        return existingResult.map((_) {}); // Return error
      }

      final transaction = existingResult.dataOrNull;
      if (transaction == null) {
        return Result.error(Failure.validation(
          'Transaction not found',
          {'id': 'Transaction with this ID does not exist'},
        ));
      }

      // 2. Delete transaction from repository
      final deleteResult = await _transactionRepository.delete(transactionId);
      if (deleteResult.isError) {
        return deleteResult;
      }

      // 3. Immediately rollback account balance (reverse the transaction's impact)
      final rollbackResult = await _rollbackAccountBalance(transaction);
      if (rollbackResult.isError) {
        // If balance rollback fails, we should ideally rollback the transaction deletion
        // For now, log the error but return success since transaction was deleted
        // In production, implement proper transaction rollback
        return Result.error(rollbackResult.failureOrNull!);
      }

      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to delete transaction: $e'));
    }
  }

  /// Rollback account balance by reversing transaction impact
  /// For income: decrease account balance
  /// For expense: increase account balance
  /// For transfers: reverse both source and destination account updates (not implemented)
  Future<Result<void>> _rollbackAccountBalance(Transaction transaction) async {
    if (transaction.accountId == null) {
      // Skip balance rollback for transactions without account (shouldn't happen for regular transactions)
      return Result.success(null);
    }

    final accountResult = await _accountRepository.getById(transaction.accountId!);

    return accountResult.when(
      success: (account) async {
        if (account == null) {
          return Result.error(Failure.validation(
            'Account not found for balance rollback',
            {'account': 'Account does not exist'},
          ));
        }

        // Calculate balance delta for rollback (reverse of addition)
        // For income: transaction added money, so rollback decreases balance
        // For expense: transaction subtracted money, so rollback increases balance
        final delta = transaction.isIncome ? -transaction.amount : transaction.amount;

        // Update cached balance and timestamp
        final updatedAccount = account.copyWith(
          cachedBalance: account.currentBalance + delta,
          lastBalanceUpdate: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final updateResult = await _accountRepository.update(updatedAccount);
        return updateResult.when(
          success: (_) => Result.success(null),
          error: (failure) => Result.error(failure),
        );
      },
      error: (failure) => Result.error(failure),
    );
  }
}