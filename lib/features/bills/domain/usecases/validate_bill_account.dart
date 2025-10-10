import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/domain/repositories/account_repository.dart';

/// Use case for validating account selection in bills
/// Ensures data integrity and prevents invalid operations
class ValidateBillAccount {
  const ValidateBillAccount(this._accountRepository);

  final AccountRepository _accountRepository;

  /// Validate account for bill creation/editing
  Future<Result<void>> call(String? accountId, double billAmount) async {
    // Account is optional for bills, but if provided, must be valid
    if (accountId == null) {
      return Result.success(null);
    }

    // 1. Account existence validation
    final accountResult = await _accountRepository.getById(accountId);
    if (accountResult.isError) {
      return Result.error(Failure.validation(
        'Account not found',
        {'accountId': 'The selected account does not exist'},
      ));
    }

    final account = accountResult.dataOrNull;
    if (account == null) {
      return Result.error(Failure.validation(
        'Account not found',
        {'accountId': 'The selected account does not exist'},
      ));
    }

    // 2. Account activity validation
    if (!account.isActive) {
      return Result.error(Failure.validation(
        'Inactive account',
        {'accountId': 'Cannot use inactive or deleted accounts'},
      ));
    }

    // 3. Balance sufficiency validation for bill amount
    final availableBalance = account.availableBalance;
    if (availableBalance < billAmount) {
      return Result.error(Failure.validation(
        'Insufficient balance',
        {
          'accountId': 'Account "${account.name}" has insufficient funds',
          'availableBalance': availableBalance.toString(),
          'requiredAmount': billAmount.toString(),
          'shortfall': (billAmount - availableBalance).toString(),
        },
      ));
    }

    return Result.success(null);
  }

  /// Validate account for bill payment
  Future<Result<void>> callForPayment(String accountId, double paymentAmount) async {
    // For payments, account is required
    if (accountId.isEmpty) {
      return Result.error(Failure.validation(
        'Account required',
        {'accountId': 'Account selection is required for bill payments'},
      ));
    }

    // 1. Account existence validation
    final accountResult = await _accountRepository.getById(accountId);
    if (accountResult.isError) {
      return Result.error(Failure.validation(
        'Account not found',
        {'accountId': 'The selected account does not exist'},
      ));
    }

    final account = accountResult.dataOrNull;
    if (account == null) {
      return Result.error(Failure.validation(
        'Account not found',
        {'accountId': 'The selected account does not exist'},
      ));
    }

    // 2. Account activity validation
    if (!account.isActive) {
      return Result.error(Failure.validation(
        'Inactive account',
        {'accountId': 'Cannot make payments from inactive accounts'},
      ));
    }

    // 3. Balance sufficiency validation
    final availableBalance = account.availableBalance;
    if (availableBalance < paymentAmount) {
      final shortfall = paymentAmount - availableBalance;
      return Result.error(Failure.validation(
        'Insufficient funds for payment',
        {
          'accountId': 'Account "${account.name}" has insufficient funds for this payment',
          'availableBalance': availableBalance.toStringAsFixed(2),
          'paymentAmount': paymentAmount.toStringAsFixed(2),
          'shortfall': shortfall.toStringAsFixed(2),
          'accountType': account.type.displayName,
        },
      ));
    }

    // 4. Additional validation for credit cards
    if (account.type == AccountType.creditCard) {
      if (account.isOverLimit) {
        return Result.error(Failure.validation(
          'Credit card over limit',
          {
            'accountId': 'Credit card "${account.name}" is already over its credit limit',
            'currentBalance': account.currentBalance.toStringAsFixed(2),
            'creditLimit': account.creditLimit?.toStringAsFixed(2) ?? 'Unknown',
          },
        ));
      }

      // Check if payment would put card closer to limit
      final utilizationAfterPayment = (account.currentBalance + paymentAmount) /
          (account.creditLimit ?? double.infinity);
      if (utilizationAfterPayment > 0.95) { // Over 95% utilization
        return Result.error(Failure.validation(
          'High credit utilization warning',
          {
            'accountId': 'Payment would result in very high credit utilization',
            'projectedUtilization': '${(utilizationAfterPayment * 100).toStringAsFixed(1)}%',
            'warning': 'Consider using a different payment method',
          },
        ));
      }
    }

    return Result.success(null);
  }

  /// Get account details for validation display
  Future<Result<AccountValidationDetails>> getAccountDetails(String accountId) async {
    final accountResult = await _accountRepository.getById(accountId);
    if (accountResult.isError) {
      return Result.error(accountResult.failureOrNull!);
    }

    final account = accountResult.dataOrNull;
    if (account == null) {
      return Result.error(Failure.validation('Account not found', {'accountId': 'Account does not exist'}));
    }

    return Result.success(AccountValidationDetails(
      account: account,
      availableBalance: account.availableBalance,
      isActive: account.isActive,
      canMakePayment: account.isActive && account.availableBalance > 0,
      warnings: _getAccountWarnings(account),
    ));
  }

  List<String> _getAccountWarnings(Account account) {
    final warnings = <String>[];

    if (!account.isActive) {
      warnings.add('Account is inactive');
    }

    if (account.availableBalance < 0) {
      warnings.add('Account has negative balance');
    }

    if (account.type == AccountType.creditCard) {
      final utilization = account.utilizationRate;
      if (utilization != null) {
        if (utilization > 0.9) {
          warnings.add('Credit utilization over 90%');
        } else if (utilization > 0.7) {
          warnings.add('Credit utilization over 70%');
        }
      }

      if (account.isOverLimit) {
        warnings.add('Credit card is over limit');
      }
    }

    if (account.needsReconciliation) {
      warnings.add('Account balance may need reconciliation');
    }

    return warnings;
  }
}

/// Details about account validation status
class AccountValidationDetails {
  const AccountValidationDetails({
    required this.account,
    required this.availableBalance,
    required this.isActive,
    required this.canMakePayment,
    required this.warnings,
  });

  final Account account;
  final double availableBalance;
  final bool isActive;
  final bool canMakePayment;
  final List<String> warnings;

  bool get hasWarnings => warnings.isNotEmpty;
  bool get hasCriticalWarnings => warnings.any((w) =>
      w.contains('inactive') ||
      w.contains('negative') ||
      w.contains('over limit'));
}