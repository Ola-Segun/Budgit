import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../repositories/transaction_repository.dart';

/// Use case for deleting a transaction
class DeleteTransaction {
  const DeleteTransaction(this._repository);

  final TransactionRepository _repository;

  /// Execute the use case
  Future<Result<void>> call(String transactionId) async {
    try {
      // Validate transaction exists
      final existingResult = await _repository.getById(transactionId);
      if (existingResult.isError) {
        return existingResult.map((_) {}); // Return error
      }

      if (existingResult.dataOrNull == null) {
        return Result.error(Failure.validation(
          'Transaction not found',
          {'id': 'Transaction with this ID does not exist'},
        ));
      }

      // Delete transaction
      final result = await _repository.delete(transactionId);
      return result;
    } catch (e) {
      return Result.error(Failure.unknown('Failed to delete transaction: $e'));
    }
  }
}