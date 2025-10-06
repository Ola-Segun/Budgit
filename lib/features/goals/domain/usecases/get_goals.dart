import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/goal.dart';
import '../repositories/goal_repository.dart';

/// Use case for getting all goals
class GetGoals {
  const GetGoals(this._repository);

  final GoalRepository _repository;

  /// Execute the use case
  Future<Result<List<Goal>>> call() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get goals: $e'));
    }
  }
}

/// Use case for getting active goals
class GetActiveGoals {
  const GetActiveGoals(this._repository);

  final GoalRepository _repository;

  /// Execute the use case
  Future<Result<List<Goal>>> call() async {
    try {
      return await _repository.getActive();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get active goals: $e'));
    }
  }
}

/// Use case for getting goal by ID
class GetGoalById {
  const GetGoalById(this._repository);

  final GoalRepository _repository;

  /// Execute the use case
  Future<Result<Goal?>> call(String id) async {
    try {
      if (id.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Goal ID cannot be empty',
          {'id': 'ID is required'},
        ));
      }

      return await _repository.getById(id);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get goal: $e'));
    }
  }
}

/// Use case for getting completed goals
class GetCompletedGoals {
  const GetCompletedGoals(this._repository);

  final GoalRepository _repository;

  /// Execute the use case
  Future<Result<List<Goal>>> call() async {
    try {
      final result = await _repository.getAll();
      if (result.isError) {
        return Result.error(result.failureOrNull!);
      }

      final goals = result.dataOrNull ?? [];
      final completedGoals = goals.where((goal) => goal.isCompleted).toList();

      return Result.success(completedGoals);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get completed goals: $e'));
    }
  }
}