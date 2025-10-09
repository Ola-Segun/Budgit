import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../repositories/transaction_category_repository.dart';

/// Use case for deleting a transaction category
class DeleteCategory {
  const DeleteCategory(this._repository);

  final TransactionCategoryRepository _repository;

  /// Execute the use case
  Future<Result<void>> call(String categoryId) async {
    try {
      if (categoryId.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Category ID cannot be empty',
          {'categoryId': 'ID is required'},
        ));
      }

      // Check if category is in use
      final inUseResult = await _repository.isCategoryInUse(categoryId);
      if (inUseResult.isError) {
        return Result.error(inUseResult.failureOrNull!);
      }

      if (inUseResult.dataOrNull == true) {
        return Result.error(Failure.validation(
          'Cannot delete category that is in use by transactions',
          {'categoryId': 'Category is currently assigned to transactions'},
        ));
      }

      // Delete category
      return await _repository.delete(categoryId);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to delete category: $e'));
    }
  }
}