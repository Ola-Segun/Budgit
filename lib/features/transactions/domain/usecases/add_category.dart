import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_category_repository.dart';
import '../validators/category_validator.dart';

/// Use case for adding a new transaction category
class AddCategory {
  const AddCategory(this._repository);

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
      final validationResult = CategoryValidator.validateForCreation(category, existingCategories);
      if (validationResult.isError) {
        return validationResult;
      }

      // Add category
      return await _repository.add(category);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to add category: $e'));
    }
  }
}