import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

/// Use case for creating a new account
class CreateAccount {
  const CreateAccount(this._repository);

  final AccountRepository _repository;

  /// Execute the use case
  Future<Result<Account>> call(Account account) async {
    try {
      // Validate account
      final validationResult = _validateAccount(account);
      if (validationResult.isError) {
        return validationResult;
      }

      // Create account with timestamps
      final accountWithTimestamps = account.copyWith(
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Add account
      return await _repository.add(accountWithTimestamps);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to create account: $e'));
    }
  }

  /// Validate account data
  Result<Account> _validateAccount(Account account) {
    if (account.name.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Account name cannot be empty',
        {'name': 'Name is required'},
      ));
    }

    if (account.balance.isNaN || account.balance.isInfinite) {
      return Result.error(Failure.validation(
        'Account balance must be a valid number',
        {'balance': 'Invalid balance'},
      ));
    }

    // Validate credit card specific fields
    if (account.type == AccountType.creditCard) {
      if (account.creditLimit == null || account.creditLimit! <= 0) {
        return Result.error(Failure.validation(
          'Credit limit is required for credit cards',
          {'creditLimit': 'Credit limit must be greater than zero'},
        ));
      }

      if (account.balance > account.creditLimit!) {
        return Result.error(Failure.validation(
          'Account balance cannot exceed credit limit',
          {'balance': 'Balance exceeds credit limit'},
        ));
      }
    }

    // Validate loan specific fields
    if (account.type == AccountType.loan) {
      if (account.interestRate != null && (account.interestRate! < 0 || account.interestRate! > 100)) {
        return Result.error(Failure.validation(
          'Interest rate must be between 0 and 100',
          {'interestRate': 'Invalid interest rate'},
        ));
      }
    }

    return Result.success(account);
  }
}