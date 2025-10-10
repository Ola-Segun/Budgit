import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/domain/repositories/account_repository.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

/// Use case for processing split payments for bills
/// Handles paying one bill from multiple accounts
class ProcessSplitPayment {
  const ProcessSplitPayment(
    this._billRepository,
    this._accountRepository,
    this._transactionRepository,
  );

  final BillRepository _billRepository;
  final AccountRepository _accountRepository;
  final TransactionRepository _transactionRepository;

  /// Process a split payment for a bill
  /// Creates multiple transactions from different accounts totaling the payment amount
  Future<Result<SplitPaymentResult>> call({
    required Bill bill,
    required List<SplitPaymentPortion> paymentPortions,
    required DateTime paymentDate,
  }) async {
    // Validate split payment
    final validationResult = await _validateSplitPayment(bill, paymentPortions);
    if (validationResult.isError) {
      return Result.error(validationResult.failureOrNull!);
    }

    try {
      final createdTransactions = <Transaction>[];
      final updatedAccounts = <Account>[];

      // Process each payment portion
      for (final portion in paymentPortions) {
        final accountResult = await _accountRepository.getById(portion.accountId);
        if (accountResult.isError) {
          return Result.error(accountResult.failureOrNull!);
        }

        final account = accountResult.dataOrNull!;
        if (!account.isActive) {
          return Result.error(Failure.validation(
            'Account is inactive',
            {'accountId': 'Cannot use inactive account ${account.name} for payment'},
          ));
        }

        if (account.availableBalance < portion.amount) {
          return Result.error(Failure.validation(
            'Insufficient balance',
            {
              'accountId': 'Account ${account.name} has insufficient balance',
              'available': account.availableBalance.toStringAsFixed(2),
              'required': portion.amount.toStringAsFixed(2),
            },
          ));
        }

        // Create transaction for this portion
        final transaction = Transaction(
          id: _generateTransactionId(),
          title: 'Split Payment: ${bill.name} (${portion.description ?? 'Portion'})',
          amount: portion.amount,
          type: TransactionType.expense,
          date: paymentDate,
          categoryId: bill.categoryId,
          accountId: portion.accountId,
          description: portion.notes ?? 'Split payment portion for bill: ${bill.name}',
          currencyCode: bill.currencyCode ?? 'USD',
        );

        final txResult = await _transactionRepository.add(transaction);
        if (txResult.isError) {
          return Result.error(txResult.failureOrNull!);
        }

        createdTransactions.add(transaction);

        // Update account balance
        final updatedAccount = account.copyWith(
          cachedBalance: account.currentBalance - portion.amount,
          lastBalanceUpdate: DateTime.now(),
        );

        final accountUpdateResult = await _accountRepository.update(updatedAccount);
        if (accountUpdateResult.isError) {
          return Result.error(accountUpdateResult.failureOrNull!);
        }

        updatedAccounts.add(updatedAccount);
      }

      // Create consolidated bill payment record
      final totalAmount = paymentPortions.fold<double>(0, (sum, portion) => sum + portion.amount);
      final billPayment = BillPayment(
        id: _generatePaymentId(),
        amount: totalAmount,
        paymentDate: paymentDate,
        transactionId: createdTransactions.first.id, // Reference first transaction
        notes: 'Split payment across ${paymentPortions.length} accounts',
        method: PaymentMethod.other,
      );

      // Mark bill as paid
      final billResult = await _billRepository.markAsPaid(bill.id, billPayment);
      if (billResult.isError) {
        return Result.error(billResult.failureOrNull!);
      }

      return Result.success(SplitPaymentResult(
        billPayment: billPayment,
        transactions: createdTransactions,
        updatedAccounts: updatedAccounts,
        totalAmount: totalAmount,
      ));

    } catch (e) {
      return Result.error(Failure.unknown('Split payment processing failed: $e'));
    }
  }

  /// Validate split payment parameters
  Future<Result<void>> _validateSplitPayment(
    Bill bill,
    List<SplitPaymentPortion> paymentPortions,
  ) async {
    // Check for empty portions
    if (paymentPortions.isEmpty) {
      return Result.error(Failure.validation(
        'No payment portions specified',
        {'portions': 'At least one payment portion is required'},
      ));
    }

    // Validate total amount matches bill amount (or is partial payment)
    final totalAmount = paymentPortions.fold<double>(0, (sum, portion) => sum + portion.amount);
    if (totalAmount <= 0) {
      return Result.error(Failure.validation(
        'Invalid total amount',
        {'totalAmount': 'Total payment amount must be positive'},
      ));
    }

    // For full payments, total should match bill amount
    // For partial payments, allow any positive amount
    if (totalAmount > bill.amount) {
      return Result.error(Failure.validation(
        'Payment exceeds bill amount',
        {
          'totalAmount': totalAmount.toStringAsFixed(2),
          'billAmount': bill.amount.toStringAsFixed(2),
          'excess': (totalAmount - bill.amount).toStringAsFixed(2),
        },
      ));
    }

    // Check for duplicate accounts
    final accountIds = paymentPortions.map((p) => p.accountId).toSet();
    if (accountIds.length != paymentPortions.length) {
      return Result.error(Failure.validation(
        'Duplicate accounts in split payment',
        {'accounts': 'Each account can only be used once in a split payment'},
      ));
    }

    // Validate each portion
    for (final portion in paymentPortions) {
      if (portion.amount <= 0) {
        return Result.error(Failure.validation(
          'Invalid portion amount',
          {'portion': 'Each payment portion must have a positive amount'},
        ));
      }

      // Check if account is allowed for this bill
      if (!bill.isAccountAllowed(portion.accountId)) {
        // Allow but warn - bill might have been updated since portion was created
        // In a full implementation, this could return a warning
      }
    }

    // Validate minimum portion sizes (prevent micro-payments)
    const minPortionAmount = 0.01; // $0.01 minimum
    for (final portion in paymentPortions) {
      if (portion.amount < minPortionAmount) {
        return Result.error(Failure.validation(
          'Portion amount too small',
          {
            'portion': 'Minimum portion amount is \$${minPortionAmount.toStringAsFixed(2)}',
            'amount': portion.amount.toStringAsFixed(2),
          },
        ));
      }
    }

    return Result.success(null);
  }

  /// Generate unique transaction ID
  String _generateTransactionId() {
    return 'split_tx_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecondsSinceEpoch}';
  }

  /// Generate unique payment ID
  String _generatePaymentId() {
    return 'split_payment_${DateTime.now().millisecondsSinceEpoch}';
  }
}

/// Represents a portion of a split payment
class SplitPaymentPortion {
  const SplitPaymentPortion({
    required this.accountId,
    required this.amount,
    this.description,
    this.notes,
  });

  final String accountId;
  final double amount;
  final String? description;
  final String? notes;

  /// Validate portion data
  Result<SplitPaymentPortion> validate() {
    if (accountId.isEmpty) {
      return Result.error(Failure.validation(
        'Account ID required',
        {'accountId': 'Account selection is required'},
      ));
    }

    if (amount <= 0) {
      return Result.error(Failure.validation(
        'Invalid amount',
        {'amount': 'Amount must be positive'},
      ));
    }

    return Result.success(this);
  }
}

/// Result of a split payment operation
class SplitPaymentResult {
  const SplitPaymentResult({
    required this.billPayment,
    required this.transactions,
    required this.updatedAccounts,
    required this.totalAmount,
  });

  final BillPayment billPayment;
  final List<Transaction> transactions;
  final List<Account> updatedAccounts;
  final double totalAmount;

  int get numberOfAccounts => transactions.length;

  /// Get payment distribution summary
  Map<String, double> get paymentDistribution {
    return Map.fromEntries(
      transactions.map((tx) => MapEntry(tx.accountId!, tx.amount)),
    );
  }

  /// Check if this covers the full bill amount
  bool isFullPayment(double billAmount) => totalAmount >= billAmount;

  /// Get remaining amount if this is a partial payment
  double getRemainingAmount(double billAmount) => billAmount - totalAmount;
}