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
      final validationResult = await _validateBudget(budget);
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
  Future<Result<Budget>> _validateBudget(Budget budget) async {
    // First use the budget's built-in validation
    final basicValidation = budget.validate();
    if (basicValidation.isError) {
      return basicValidation;
    }

    // Check for duplicate name
    final nameExistsResult = await _repository.nameExists(budget.name);
    if (nameExistsResult.isError) {
      return Result.error(nameExistsResult.failureOrNull!);
    }

    final nameExists = nameExistsResult.dataOrNull ?? false;
    if (nameExists) {
      return Result.error(Failure.validation(
        'Budget names must be unique. This name is already in use by another budget. Please choose a different name.',
        {'name': 'Budget name must be unique'},
      ));
    }

    return Result.success(budget);
  }
}