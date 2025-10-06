import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/goal.dart';
import '../repositories/goal_repository.dart';

/// Use case for updating an existing goal
class UpdateGoal {
  const UpdateGoal(this._repository);

  final GoalRepository _repository;

  /// Execute the use case
  Future<Result<Goal>> call(Goal goal) async {
    try {
      // Validate goal
      final validationResult = _validateGoal(goal);
      if (validationResult.isError) {
        return validationResult;
      }

      // Update goal
      return await _repository.update(goal);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to update goal: $e'));
    }
  }

  /// Validate goal data
  Result<Goal> _validateGoal(Goal goal) {
    if (goal.id.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Goal ID cannot be empty',
        {'id': 'ID is required'},
      ));
    }

    if (goal.title.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Goal title cannot be empty',
        {'title': 'Title is required'},
      ));
    }

    if (goal.targetAmount <= 0) {
      return Result.error(Failure.validation(
        'Goal target amount must be greater than zero',
        {'targetAmount': 'Amount must be positive'},
      ));
    }

    if (goal.deadline.isBefore(DateTime.now())) {
      return Result.error(Failure.validation(
        'Goal deadline cannot be in the past',
        {'deadline': 'Deadline must be in the future'},
      ));
    }

    return Result.success(goal);
  }
}