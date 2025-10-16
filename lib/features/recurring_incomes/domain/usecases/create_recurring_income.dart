import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../accounts/domain/repositories/account_repository.dart';
import '../entities/recurring_income.dart';
import '../repositories/recurring_income_repository.dart';

/// Use case for creating a new recurring income
class CreateRecurringIncome {
  const CreateRecurringIncome(
    this._repository,
    this._accountRepository,
  );

  final RecurringIncomeRepository _repository;
  final AccountRepository _accountRepository;

  /// Execute the use case
  Future<Result<RecurringIncome>> call(RecurringIncome income) async {
    try {
      // Validate income
      final validationResult = await _validateIncome(income);
      if (validationResult.isError) {
        return Result.error(validationResult.failureOrNull!);
      }

      // Create income
      return await _repository.add(income);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to create recurring income: $e'));
    }
  }

  /// Validate income data including account validation
  Future<Result<RecurringIncome>> _validateIncome(RecurringIncome income) async {
    // First, use the income's built-in validation
    final incomeValidation = income.validate();
    if (incomeValidation.isError) {
      return incomeValidation;
    }

    // Validate income name uniqueness
    final nameValidation = await _repository.nameExists(income.name);
    if (nameValidation.isError) {
      return Result.error(nameValidation.failureOrNull!);
    }

    final nameExists = nameValidation.dataOrNull ?? false;
    if (nameExists) {
      return Result.error(Failure.validation(
        'An income with this name already exists',
        {'name': 'Name must be unique'},
      ));
    }

    // Then validate account if specified
    if (income.accountId != null) {
      final accountValidation = await _validateAccount(income.accountId!, income.amount);
      if (accountValidation.isError) {
        return Result.error(accountValidation.failureOrNull!);
      }
    }

    return Result.success(income);
  }

  /// Validate account for income deposit
  Future<Result<void>> _validateAccount(String accountId, double amount) async {
    try {
      // Check if account exists
      final accountResult = await _accountRepository.getById(accountId);
      if (accountResult.isError) {
        return Result.error(Failure.validation(
          'Selected account is not available',
          {'accountId': 'Account not found'},
        ));
      }

      final account = accountResult.dataOrNull;
      if (account == null) {
        return Result.error(Failure.validation(
          'Selected account does not exist',
          {'accountId': 'Invalid account'},
        ));
      }

      // For income, we don't need to check balance since we're adding money
      // But we could add other validations here if needed

      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to validate account: $e'));
    }
  }
}