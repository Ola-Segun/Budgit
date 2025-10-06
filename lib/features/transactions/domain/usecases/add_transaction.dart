import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Use case for adding a new transaction
class AddTransaction {
  const AddTransaction(this._repository);

  final TransactionRepository _repository;

  /// Execute the use case
  Future<Result<Transaction>> call(Transaction transaction) async {
    try {
      // Validate transaction
      final validationResult = _validateTransaction(transaction);
      if (validationResult.isError) {
        return validationResult;
      }

      // Add transaction
      return await _repository.add(transaction);
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

    return Result.success(transaction);
  }
}