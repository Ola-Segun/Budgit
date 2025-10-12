import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../repositories/transaction_category_repository.dart';
import '../validators/category_validator.dart';

/// Use case for deleting a transaction category
class DeleteCategory {
  const DeleteCategory(this._repository);

  final TransactionCategoryRepository _repository;

  /// Execute the use case
  Future<Result<void>> call(String categoryId) async {
    try {
      // Validate category ID
      final idValidation = CategoryValidator.validateCategoryId(categoryId);
      if (idValidation.isError) {
        return idValidation;
      }

      // Check if category is in use
      final inUseResult = await _repository.isCategoryInUse(categoryId);
      if (inUseResult.isError) {
        return Result.error(inUseResult.failureOrNull!);
      }

      // Validate deletion using CategoryValidator
      final deletionValidation = CategoryValidator.validateForDeletion(
        categoryId,
        inUseResult.dataOrNull ?? false,
      );
      if (deletionValidation.isError) {
        return deletionValidation;
      }

      // Delete category
      return await _repository.delete(categoryId);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to delete category: $e'));
    }
  }
}