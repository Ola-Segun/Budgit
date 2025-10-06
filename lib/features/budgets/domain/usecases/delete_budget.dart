import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../repositories/budget_repository.dart';

/// Use case for deleting a budget
class DeleteBudget {
  const DeleteBudget(this._repository);

  final BudgetRepository _repository;

  /// Execute the use case
  Future<Result<void>> call(String budgetId) async {
    try {
      // Validate budget ID
      if (budgetId.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Budget ID cannot be empty',
          {'budgetId': 'ID is required'},
        ));
      }

      // Delete budget
      return await _repository.delete(budgetId);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to delete budget: $e'));
    }
  }
}