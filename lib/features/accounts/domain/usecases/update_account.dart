import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

/// Use case for updating an existing account
class UpdateAccount {
  const UpdateAccount(this._repository);

  final AccountRepository _repository;

  /// Execute the use case
  Future<Result<Account>> call(Account account) async {
    try {
      // Validate account
      final validationResult = _validateAccount(account);
      if (validationResult.isError) {
        return validationResult;
      }

      // Update account with timestamp
      final accountWithTimestamp = account.copyWith(
        updatedAt: DateTime.now(),
      );

      // Update account
      return await _repository.update(accountWithTimestamp);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to update account: $e'));
    }
  }

  /// Validate account data
  Result<Account> _validateAccount(Account account) {
    if (account.id.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Account ID is required',
        {'id': 'ID is required'},
      ));
    }

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

    return Result.success(account);
  }
}