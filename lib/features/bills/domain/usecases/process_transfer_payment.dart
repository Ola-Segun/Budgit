import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/domain/repositories/account_repository.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/usecases/add_transaction.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

/// Use case for processing transfer payments for bills
/// Handles complex scenarios where bill payments involve transfers between accounts
class ProcessTransferPayment {
  const ProcessTransferPayment(
    this._billRepository,
    this._accountRepository,
    this._addTransaction,
  );

  final BillRepository _billRepository;
  final AccountRepository _accountRepository;
  final AddTransaction _addTransaction;

  /// Process a transfer payment for a bill
  /// This creates a transfer transaction and updates both accounts
  Future<Result<BillPayment>> call({
    required Bill bill,
    required BillPayment payment,
    required Account sourceAccount,
    required Account destinationAccount,
  }) async {
    // Validate transfer payment
    final validationResult = await _validateTransferPayment(
      bill,
      payment,
      sourceAccount,
      destinationAccount,
    );

    if (validationResult.isError) {
      return Result.error(validationResult.failureOrNull!);
    }

    try {
      // Create transfer transaction - AddTransaction will handle balance updates
      final transferTransaction = Transaction(
        id: _generateId(),
        title: 'Bill Payment Transfer: ${bill.name}',
        amount: payment.amount,
        type: TransactionType.transfer,
        date: payment.paymentDate,
        categoryId: bill.categoryId,
        accountId: sourceAccount.id,
        toAccountId: destinationAccount.id,
        description: 'Transfer payment for bill: ${bill.name}',
        currencyCode: bill.currencyCode ?? 'USD',
      );

      // Add transfer transaction (this handles balance updates per Account-Transaction-Relationship.md)
      final txResult = await _addTransaction(transferTransaction);
      if (txResult.isError) {
        return Result.error(txResult.failureOrNull!);
      }

      final createdTransaction = txResult.dataOrNull!;

      // Create bill payment record with transaction reference
      final billPayment = payment.copyWith(
        transactionId: createdTransaction.id,
      );

      // Mark bill as paid using the existing repository method
      final billResult = await _billRepository.markAsPaid(bill.id, billPayment, accountId: destinationAccount.id);
      if (billResult.isError) {
        return Result.error(billResult.failureOrNull!);
      }

      return Result.success(billPayment);

    } catch (e) {
      return Result.error(Failure.unknown('Transfer payment failed: $e'));
    }
  }

  /// Validate transfer payment parameters
  Future<Result<void>> _validateTransferPayment(
    Bill bill,
    BillPayment payment,
    Account sourceAccount,
    Account destinationAccount,
  ) async {
    // Basic payment validation
    final paymentValidation = payment.validate();
    if (paymentValidation.isError) {
      return Result.error(paymentValidation.failureOrNull!);
    }

    // Validate accounts are different
    if (sourceAccount.id == destinationAccount.id) {
      return Result.error(Failure.validation(
        'Cannot transfer to the same account',
        {'destinationAccount': 'Must be different from source account'},
      ));
    }

    // Validate accounts are active
    if (!sourceAccount.isActive) {
      return Result.error(Failure.validation(
        'Source account is inactive',
        {'sourceAccount': 'Account must be active'},
      ));
    }

    if (!destinationAccount.isActive) {
      return Result.error(Failure.validation(
        'Destination account is inactive',
        {'destinationAccount': 'Account must be active'},
      ));
    }

    // Validate source account has sufficient balance
    if (sourceAccount.availableBalance < payment.amount) {
      return Result.error(Failure.validation(
        'Insufficient balance in source account',
        {
          'sourceAccount': 'Balance: ${sourceAccount.availableBalance.toStringAsFixed(2)}',
          'required': payment.amount.toStringAsFixed(2),
          'shortfall': (payment.amount - sourceAccount.availableBalance).toStringAsFixed(2),
        },
      ));
    }

    // Validate currency compatibility (if both accounts have currency info)
    if (sourceAccount.currency != destinationAccount.currency) {
      // For now, allow cross-currency transfers but log warning
      // In a full implementation, you'd want currency conversion
      // This is just a validation check - we allow it but could warn in UI
    }

    // Validate bill allows this account combination
    final allowedAccounts = bill.allAllowedAccountIds;
    if (allowedAccounts.isNotEmpty &&
        !allowedAccounts.contains(sourceAccount.id) &&
        !allowedAccounts.contains(destinationAccount.id)) {
      // Allow but could warn in UI - for now just proceed
      // In a full implementation, this could return a warning result
    }

    return Result.success(null);
  }

  /// Calculate next due date for recurring bill
  DateTime _calculateNextDueDate(Bill bill) {
    if (bill.nextDueDate != null) return bill.nextDueDate!;

    switch (bill.frequency) {
      case BillFrequency.weekly:
        return bill.dueDate.add(const Duration(days: 7));
      case BillFrequency.biWeekly:
        return bill.dueDate.add(const Duration(days: 14));
      case BillFrequency.monthly:
        return DateTime(bill.dueDate.year, bill.dueDate.month + 1, bill.dueDate.day);
      case BillFrequency.quarterly:
        return DateTime(bill.dueDate.year, bill.dueDate.month + 3, bill.dueDate.day);
      case BillFrequency.annually:
        return DateTime(bill.dueDate.year + 1, bill.dueDate.month, bill.dueDate.day);
      case BillFrequency.custom:
        return bill.dueDate; // Custom logic would be needed
    }
  }

  /// Generate unique ID for transaction
  String _generateId() {
    return 'transfer_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecondsSinceEpoch}';
  }
}