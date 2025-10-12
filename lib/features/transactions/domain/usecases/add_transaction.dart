import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../accounts/domain/repositories/account_repository.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Use case for adding a new transaction with immediate balance updates
/// Follows the Eager Update strategy from Account-Transaction-Relationship.md
class AddTransaction {
  const AddTransaction(
    this._transactionRepository,
    this._accountRepository,
  );

  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;

  /// Execute the use case with immediate balance updates
  /// Follows Eager Update strategy: add transaction then update balances
  Future<Result<Transaction>> call(Transaction transaction) async {
    try {
      // 1. Validate transaction
      final validationResult = _validateTransaction(transaction);
      if (validationResult.isError) {
        return validationResult;
      }

      // 2. Check account balance for expenses and transfers (insufficient funds validation)
      if (transaction.isExpense || transaction.isTransfer) {
        final balanceCheck = await _checkSufficientFunds(transaction);
        if (balanceCheck.isError) {
          return Result.error(balanceCheck.failureOrNull!);
        }
      }

      // 3. Add transaction to repository
      final txResult = await _transactionRepository.add(transaction);
      if (txResult.isError) {
        return txResult;
      }

      final addedTransaction = txResult.dataOrNull!;

      // 4. Update account balance immediately (Eager Update)
      final balanceUpdateResult = await _updateAccountBalance(addedTransaction);
      if (balanceUpdateResult.isError) {
        // If balance update fails, we should ideally rollback the transaction
        // For now, log the error but return success since transaction was added
        // In production, implement proper transaction rollback
        return Result.error(balanceUpdateResult.failureOrNull!);
      }

      return txResult;
    } catch (e) {
      return Result.error(Failure.unknown('Failed to add transaction: $e'));
    }
  }

  /// Validate transaction data
  Result<Transaction> _validateTransaction(Transaction transaction) {
    if (transaction.title.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Transaction title cannot be empty',
        {'title': 'Title is required'},
      ));
    }

    if (transaction.amount <= 0) {
      return Result.error(Failure.validation(
        'Transaction amount must be greater than zero',
        {'amount': 'Amount must be positive'},
      ));
    }

    if (transaction.accountId == null || transaction.accountId!.trim().isEmpty) {
       return Result.error(Failure.validation(
         'Transaction account is required',
         {'accountId': 'Account is required'},
       ));
     }

     if (transaction.categoryId.trim().isEmpty) {
       return Result.error(Failure.validation(
         'Transaction category is required',
         {'categoryId': 'Category is required'},
       ));
     }

    if (transaction.date.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      return Result.error(Failure.validation(
        'Transaction date cannot be in the future',
        {'date': 'Date cannot be in the future'},
      ));
    }

    // Transfer-specific validation
    if (transaction.type == TransactionType.transfer) {
      if (transaction.accountId == null) {
        return Result.error(Failure.validation(
          'Transfer must have a source account',
          {'accountId': 'Source account is required for transfers'},
        ));
      }

      if (transaction.toAccountId == null) {
        return Result.error(Failure.validation(
          'Transfer must have a destination account',
          {'toAccountId': 'Destination account is required for transfers'},
        ));
      }

      if (transaction.accountId == transaction.toAccountId) {
        return Result.error(Failure.validation(
          'Cannot transfer to the same account',
          {'toAccountId': 'Source and destination accounts must be different'},
        ));
      }
    }

    return Result.success(transaction);
  }

  /// Check if account has sufficient funds for expense transactions
   Future<Result<void>> _checkSufficientFunds(Transaction transaction) async {
     final accountResult = await _accountRepository.getById(transaction.accountId!);

    return accountResult.when(
      success: (account) {
        if (account == null) {
          return Result.error(Failure.validation(
            'Account not found',
            {'account': 'Account does not exist'},
          ));
        }

        final currentBalance = account.currentBalance;

        // For transfers, check amount + fee
        final requiredAmount = transaction.isTransfer
            ? transaction.amount + (transaction.transferFee ?? 0)
            : transaction.amount;

        if (currentBalance < requiredAmount) {
          return Result.error(Failure.validation(
            'Insufficient balance in ${account.name}. Available: \$${currentBalance.toStringAsFixed(2)}, Required: \$${requiredAmount.toStringAsFixed(2)}',
            {'balance': 'Insufficient funds'},
          ));
        }

        return Result.success(null);
      },
      error: (failure) => Result.error(failure),
    );
  }

  /// Update account balance immediately after transaction (Eager Update strategy)
  Future<Result<void>> _updateAccountBalance(Transaction transaction) async {
    // Handle transfers (update both source and destination accounts)
    if (transaction.isTransfer) {
      return await _updateTransferBalances(transaction);
    }

    // Handle regular transactions (income/expense)
    final accountResult = await _accountRepository.getById(transaction.accountId!);

    return accountResult.when(
      success: (account) async {
        if (account == null) {
          return Result.error(Failure.validation(
            'Account not found for balance update',
            {'account': 'Account does not exist'},
          ));
        }

        // Calculate balance delta based on transaction type
        final delta = transaction.isIncome ? transaction.amount : -transaction.amount;

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

  /// Update balances for transfer transactions (both source and destination)
  Future<Result<void>> _updateTransferBalances(Transaction transaction) async {
    // Update source account (money leaving)
    final sourceResult = await _accountRepository.getById(transaction.accountId!);
    if (sourceResult.isError) {
      return Result.error(sourceResult.failureOrNull!);
    }

    final sourceAccount = sourceResult.dataOrNull!;

    // Calculate source delta: -(amount + fee)
    final sourceDelta = -(transaction.amount + (transaction.transferFee ?? 0));
    final updatedSourceAccount = sourceAccount.copyWith(
      cachedBalance: sourceAccount.currentBalance + sourceDelta,
      lastBalanceUpdate: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final sourceUpdateResult = await _accountRepository.update(updatedSourceAccount);
    if (sourceUpdateResult.isError) {
      return Result.error(sourceUpdateResult.failureOrNull!);
    }

    // Update destination account (money arriving)
    final destResult = await _accountRepository.getById(transaction.toAccountId!);
    if (destResult.isError) {
      // If destination update fails, we should rollback source update
      // For now, just return the error
      return Result.error(destResult.failureOrNull!);
    }

    final destAccount = destResult.dataOrNull!;

    // Calculate destination delta: +amount
    final destDelta = transaction.amount;
    final updatedDestAccount = destAccount.copyWith(
      cachedBalance: destAccount.currentBalance + destDelta,
      lastBalanceUpdate: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final destUpdateResult = await _accountRepository.update(updatedDestAccount);
    return destUpdateResult.when(
      success: (_) => Result.success(null),
      error: (failure) => Result.error(failure),
    );
  }
}