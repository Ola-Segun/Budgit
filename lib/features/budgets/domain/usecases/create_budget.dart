import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/budget.dart';
import '../repositories/budget_repository.dart';

/// Use case for creating a new budget
class CreateBudget {
  const CreateBudget(this._repository);

  final BudgetRepository _repository;

  /// Execute the use case
  Future<Result<Budget>> call(Budget budget) async {
    try {
      // Validate budget
      final validationResult = _validateBudget(budget);
      if (validationResult.isError) {
        return validationResult;
      }

      // Create budget
      return await _repository.add(budget);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to create budget: $e'));
    }
  }

  /// Validate budget data
  Result<Budget> _validateBudget(Budget budget) {
    // Use the budget's built-in validation
    return budget.validate();
  }
}