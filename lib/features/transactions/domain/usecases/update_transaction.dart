import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Use case for updating an existing transaction
class UpdateTransaction {
  const UpdateTransaction(this._repository);

  final TransactionRepository _repository;

  /// Execute the use case
  Future<Result<Transaction>> call(Transaction transaction) async {
    try {
      // Validate transaction exists
      final existingResult = await _repository.getById(transaction.id);
      if (existingResult.isError) {
        return existingResult.map((_) => transaction); // Return error
      }

      if (existingResult.dataOrNull == null) {
        return Result.error(Failure.validation(
          'Transaction not found',
          {'id': 'Transaction with this ID does not exist'},
        ));
      }

      // Validate transaction data
      final validationResult = _validateTransaction(transaction);
      if (validationResult.isError) {
        return validationResult;
      }

      // Update transaction
      return await _repository.update(transaction);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to update transaction: $e'));
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