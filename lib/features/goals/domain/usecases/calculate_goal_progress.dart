import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/goal.dart';
import '../entities/goal_progress.dart';
import '../repositories/goal_repository.dart';

/// Use case for calculating goal progress
class CalculateGoalProgress {
  const CalculateGoalProgress(this._repository);

  final GoalRepository _repository;

  /// Execute the use case
  Future<Result<GoalProgress>> call(String goalId) async {
    try {
      // Validate goal ID
      if (goalId.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Goal ID cannot be empty',
          {'goalId': 'ID is required'},
        ));
      }

      // Get goal
      final goalResult = await _repository.getById(goalId);
      if (goalResult.isError) {
        return Result.error(goalResult.failureOrNull!);
      }

      final goal = goalResult.dataOrNull;
      if (goal == null) {
        return Result.error(Failure.validation(
          'Goal not found',
          {'goalId': 'Goal does not exist'},
        ));
      }

      // Get contributions for this goal
      final contributionsResult = await _repository.getContributions(goalId);
      if (contributionsResult.isError) {
        return Result.error(contributionsResult.failureOrNull!);
      }

      final contributions = contributionsResult.dataOrNull ?? [];

      // Calculate progress metrics
      final percentage = goal.progressPercentage;
      final projectedCompletionDate = goal.projectedCompletionDate;
      final isOnTrack = _calculateIsOnTrack(goal, projectedCompletionDate);
      final requiredMonthlyContribution = goal.requiredMonthlyContribution;
      final totalContributed = contributions.fold<double>(0, (sum, c) => sum + c.amount);
      final totalContributions = contributions.length;

      final progress = GoalProgress(
        goal: goal,
        percentage: percentage,
        projectedCompletionDate: projectedCompletionDate,
        isOnTrack: isOnTrack,
        requiredMonthlyContribution: requiredMonthlyContribution,
        totalContributed: totalContributed,
        totalContributions: totalContributions,
      );

      return Result.success(progress);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to calculate goal progress: $e'));
    }
  }

  /// Calculate if goal is on track
  bool _calculateIsOnTrack(Goal goal, DateTime? projectedCompletionDate) {
    if (projectedCompletionDate == null) return true; // Can't determine

    // Goal is on track if projected completion is before or on target date
    return !projectedCompletionDate.isAfter(goal.targetDate);
  }
}

/// Use case for calculating progress for all active goals
class CalculateAllGoalsProgress {
  const CalculateAllGoalsProgress(this._repository);

  final GoalRepository _repository;

  /// Execute the use case
  Future<Result<List<GoalProgress>>> call() async {
    try {
      // Get all active goals
      final goalsResult = await _repository.getActive();
      if (goalsResult.isError) {
        return Result.error(goalsResult.failureOrNull!);
      }

      final goals = goalsResult.dataOrNull ?? [];
      final progressList = <GoalProgress>[];

      // Calculate progress for each goal
      for (final goal in goals) {
        final progressResult = await CalculateGoalProgress(_repository).call(goal.id);
        if (progressResult.isSuccess) {
          progressList.add(progressResult.dataOrNull!);
        }
      }

      // Sort by priority and progress
      progressList.sort((a, b) {
        // First sort by priority (high first)
        final priorityCompare = b.goal.priority.value.compareTo(a.goal.priority.value);
        if (priorityCompare != 0) return priorityCompare;

        // Then by progress percentage (lower first - needs more attention)
        return a.percentage.compareTo(b.percentage);
      });

      return Result.success(progressList);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to calculate all goals progress: $e'));
    }
  }
}