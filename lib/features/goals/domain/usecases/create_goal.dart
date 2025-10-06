import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/goal.dart';
import '../entities/goal_contribution.dart';
import '../repositories/goal_repository.dart';

/// Use case for creating a new goal
class CreateGoal {
  const CreateGoal(this._repository);

  final GoalRepository _repository;

  /// Execute the use case
  Future<Result<Goal>> call(Goal goal) async {
    try {
      // Validate goal
      final validationResult = _validateGoal(goal);
      if (validationResult.isError) {
        return validationResult;
      }

      // Create goal
      return await _repository.add(goal);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to create goal: $e'));
    }
  }

  /// Validate goal data
  Result<Goal> _validateGoal(Goal goal) {
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

/// Use case for adding contribution to a goal
class AddGoalContribution {
  const AddGoalContribution(this._repository);

  final GoalRepository _repository;

  /// Execute the use case
  Future<Result<Goal>> call(String goalId, GoalContribution contribution) async {
    try {
      // Validate contribution
      final validationResult = _validateContribution(contribution);
      if (validationResult.isError) {
        return Result.error(validationResult.failureOrNull!);
      }

      // Add contribution
      return await _repository.addContribution(goalId, contribution);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to add contribution: $e'));
    }
  }

  /// Validate contribution data
  Result<GoalContribution> _validateContribution(GoalContribution contribution) {
    if (contribution.amount <= 0) {
      return Result.error(Failure.validation(
        'Contribution amount must be greater than zero',
        {'amount': 'Amount must be positive'},
      ));
    }

    if (contribution.date.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      return Result.error(Failure.validation(
        'Contribution date cannot be in the future',
        {'date': 'Date cannot be in the future'},
      ));
    }

    return Result.success(contribution);
  }
}