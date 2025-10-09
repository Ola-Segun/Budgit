import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_category_repository.dart';

/// Use case for updating an existing transaction category
class UpdateCategory {
  const UpdateCategory(this._repository);

  final TransactionCategoryRepository _repository;

  /// Execute the use case
  Future<Result<TransactionCategory>> call(TransactionCategory category) async {
    try {
      // Validate category
      final validationResult = _validateCategory(category);
      if (validationResult.isError) {
        return validationResult;
      }

      // Update category
      return await _repository.update(category);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to update category: $e'));
    }
  }

  /// Validate category data
  Result<TransactionCategory> _validateCategory(TransactionCategory category) {
    if (category.name.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Category name cannot be empty',
        {'name': 'Name is required'},
      ));
    }

    if (category.name.length > 50) {
      return Result.error(Failure.validation(
        'Category name too long',
        {'name': 'Name must be 50 characters or less'},
      ));
    }

    return Result.success(category);
  }
}