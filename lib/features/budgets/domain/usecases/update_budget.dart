import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/budget.dart';
import '../repositories/budget_repository.dart';

/// Use case for updating an existing budget
class UpdateBudget {
  const UpdateBudget(this._repository);

  final BudgetRepository _repository;

  /// Execute the use case
  Future<Result<Budget>> call(Budget budget) async {
    try {
      // Validate budget
      final validationResult = _validateBudget(budget);
      if (validationResult.isError) {
        return validationResult;
      }

      // Update budget
      return await _repository.update(budget);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to update budget: $e'));
    }
  }

  /// Validate budget data
  Result<Budget> _validateBudget(Budget budget) {
    // Use the budget's built-in validation
    return budget.validate();
  }
}