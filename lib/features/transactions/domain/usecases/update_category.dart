import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_category_repository.dart';
import '../validators/category_validator.dart';

/// Use case for updating an existing transaction category
class UpdateCategory {
  const UpdateCategory(this._repository);

  final TransactionCategoryRepository _repository;

  /// Execute the use case
  Future<Result<TransactionCategory>> call(TransactionCategory category) async {
    try {
      // Get existing categories for validation
      final existingCategoriesResult = await _repository.getAll();
      if (existingCategoriesResult.isError) {
        return Result.error(existingCategoriesResult.failureOrNull!);
      }

      final existingCategories = existingCategoriesResult.dataOrNull ?? [];

      // Validate category using CategoryValidator
      final validationResult = CategoryValidator.validateForUpdate(category, existingCategories);
      if (validationResult.isError) {
        return validationResult;
      }

      // Update category
      return await _repository.update(category);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to update category: $e'));
    }
  }
}