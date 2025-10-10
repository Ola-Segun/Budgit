import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../repositories/account_repository.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';

/// Use case for reconciling account balance
/// Compares cached balance with calculated balance from transactions
/// Updates cached balance and reconciliation fields if discrepancies found
class ReconcileAccountBalance {
  const ReconcileAccountBalance(
    this._accountRepository,
    this._transactionRepository,
  );

  final AccountRepository _accountRepository;
  final TransactionRepository _transactionRepository;

  /// Execute balance reconciliation for a specific account
  /// Returns success if reconciliation completes (even if no changes made)
  /// Logs discrepancies and failures without failing the operation
  Future<Result<void>> call(String accountId) async {
    try {
      // 1. Get account details
      final accountResult = await _accountRepository.getById(accountId);
      if (accountResult.isError) {
        _logReconciliationFailure(accountId, 'Account not found: ${accountResult.failureOrNull}');
        return Result.error(accountResult.failureOrNull!);
      }

      final account = accountResult.dataOrNull;
      if (account == null) {
        _logReconciliationFailure(accountId, 'Account is null');
        return Result.error(Failure.notFound('Account not found'));
      }

      // 2. Get calculated balance from transactions
      final calculatedResult = await _transactionRepository.getCalculatedBalance(accountId);
      if (calculatedResult.isError) {
        _logReconciliationFailure(accountId, 'Failed to calculate balance: ${calculatedResult.failureOrNull}');
        // Don't fail the operation, just log and continue
        return Result.success(null);
      }

      final calculatedBalance = calculatedResult.dataOrNull!;

      // 3. Compare with cached balance
      final cachedBalance = account.cachedBalance ?? account.balance ?? 0.0;
      final discrepancy = (cachedBalance - calculatedBalance).abs();

      // 4. Update reconciliation fields
      final now = DateTime.now();
      final updatedAccount = account.copyWith(
        reconciledBalance: calculatedBalance,
        lastReconciliation: now,
        lastBalanceUpdate: now, // Also update this for consistency
      );

      final updateResult = await _accountRepository.update(updatedAccount);
      if (updateResult.isError) {
        _logReconciliationFailure(accountId, 'Failed to update account: ${updateResult.failureOrNull}');
        return Result.error(updateResult.failureOrNull!);
      }

      // 5. Check for discrepancies and update cached balance if needed
      if (discrepancy > 0.01) {
        _logDiscrepancy(accountId, cachedBalance, calculatedBalance, discrepancy);

        // Update cached balance to match calculated
        final correctedAccount = updatedAccount.copyWith(
          cachedBalance: calculatedBalance,
          lastBalanceUpdate: now,
        );

        final correctionResult = await _accountRepository.update(correctedAccount);
        if (correctionResult.isError) {
          _logReconciliationFailure(accountId, 'Failed to correct balance: ${correctionResult.failureOrNull}');
          // Still return success since reconciliation data was updated
        } else {
          _logReconciliationSuccess(accountId, cachedBalance, calculatedBalance);
        }
      } else {
        _logReconciliationSuccess(accountId, cachedBalance, calculatedBalance);
      }

      return Result.success(null);

    } catch (e) {
      _logReconciliationFailure(accountId, 'Unexpected error: $e');
      // Don't fail the operation for unexpected errors
      return Result.success(null);
    }
  }

  /// Log successful reconciliation
  void _logReconciliationSuccess(String accountId, double cachedBalance, double calculatedBalance) {
    print('[RECONCILIATION] SUCCESS - Account: $accountId, Cached: $cachedBalance, Calculated: $calculatedBalance');
  }

  /// Log discrepancies found and corrected
  void _logDiscrepancy(String accountId, double cachedBalance, double calculatedBalance, double discrepancy) {
    print('[RECONCILIATION] DISCREPANCY - Account: $accountId, Cached: $cachedBalance, Calculated: $calculatedBalance, Difference: $discrepancy');
  }

  /// Log reconciliation failures
  void _logReconciliationFailure(String accountId, String reason) {
    print('[RECONCILIATION] FAILURE - Account: $accountId, Reason: $reason');
  }
}