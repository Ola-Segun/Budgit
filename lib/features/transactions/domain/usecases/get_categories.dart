import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_category_repository.dart';

/// Use case for getting all transaction categories
class GetCategories {
  const GetCategories(this._repository);

  final TransactionCategoryRepository _repository;

  /// Execute the use case
  Future<Result<List<TransactionCategory>>> call() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get categories: $e'));
    }
  }
}