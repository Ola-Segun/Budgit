import 'package:hive/hive.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../../core/storage/hive_storage.dart';
import '../models/goal_dto.dart';
import '../models/goal_contribution_dto.dart';
import '../../domain/entities/goal.dart';
import '../../domain/entities/goal_contribution.dart';
import '../../domain/entities/goal_progress.dart';

/// Hive-based data source for goal operations
class GoalHiveDataSource {
  static const String _goalsBoxName = 'goals';
  static const String _contributionsBoxName = 'goal_contributions';

  Box<GoalDto>? _goalsBox;
  Box<GoalContributionDto>? _contributionsBox;

  /// Initialize the data source
  Future<void> init() async {
    // Wait for Hive to be initialized
    await HiveStorage.init();

    // Register adapters if not already registered
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(GoalDtoAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(GoalContributionDtoAdapter());
    }

    // Handle box opening with proper type checking
    if (!Hive.isBoxOpen(_goalsBoxName)) {
      _goalsBox = await Hive.openBox<GoalDto>(_goalsBoxName);
    } else {
      try {
        _goalsBox = Hive.box<GoalDto>(_goalsBoxName);
      } catch (e) {
        // If the box is already open with wrong type, close and reopen
        if (e.toString().contains('Box<dynamic>')) {
          await Hive.box(_goalsBoxName).close();
          _goalsBox = await Hive.openBox<GoalDto>(_goalsBoxName);
        } else {
          rethrow;
        }
      }
    }

    if (!Hive.isBoxOpen(_contributionsBoxName)) {
      _contributionsBox = await Hive.openBox<GoalContributionDto>(_contributionsBoxName);
    } else {
      try {
        _contributionsBox = Hive.box<GoalContributionDto>(_contributionsBoxName);
      } catch (e) {
        // If the box is already open with wrong type, close and reopen
        if (e.toString().contains('Box<dynamic>')) {
          await Hive.box(_contributionsBoxName).close();
          _contributionsBox = await Hive.openBox<GoalContributionDto>(_contributionsBoxName);
        } else {
          rethrow;
        }
      }
    }
  }

  /// Get all goals
  Future<Result<List<Goal>>> getAll() async {
    try {
      if (_goalsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _goalsBox!.values.toList();
      final goals = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by priority (high first) then by deadline
      goals.sort((a, b) {
        final priorityCompare = b.priority.value.compareTo(a.priority.value);
        if (priorityCompare != 0) return priorityCompare;
        return a.deadline.compareTo(b.deadline);
      });

      return Result.success(goals);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get goals: $e'));
    }
  }

  /// Get goal by ID
  Future<Result<Goal?>> getById(String id) async {
    try {
      if (_goalsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = _goalsBox!.get(id);
      if (dto == null) {
        return Result.success(null);
      }

      return Result.success(dto.toDomain());
    } catch (e) {
      return Result.error(Failure.cache('Failed to get goal: $e'));
    }
  }

  /// Get active goals (not completed)
  Future<Result<List<Goal>>> getActive() async {
    try {
      if (_goalsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _goalsBox!.values.toList();
      final goals = dtos.map((dto) => dto.toDomain()).toList();
      final activeGoals = goals.where((goal) => !goal.isCompleted).toList();

      // Sort by priority (high first) then by deadline
      activeGoals.sort((a, b) {
        final priorityCompare = b.priority.value.compareTo(a.priority.value);
        if (priorityCompare != 0) return priorityCompare;
        return a.deadline.compareTo(b.deadline);
      });

      return Result.success(activeGoals);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get active goals: $e'));
    }
  }

  /// Get goals by priority
  Future<Result<List<Goal>>> getByPriority(GoalPriority priority) async {
    try {
      if (_goalsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _goalsBox!.values.where((dto) => dto.priority == priority.name).toList();
      final goals = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by deadline
      goals.sort((a, b) => a.deadline.compareTo(b.deadline));

      return Result.success(goals);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get goals by priority: $e'));
    }
  }

  /// Get goals by category
  Future<Result<List<Goal>>> getByCategory(GoalCategory category) async {
    try {
      if (_goalsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _goalsBox!.values.where((dto) => dto.category == category.name).toList();
      final goals = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by priority then deadline
      goals.sort((a, b) {
        final priorityCompare = b.priority.value.compareTo(a.priority.value);
        if (priorityCompare != 0) return priorityCompare;
        return a.deadline.compareTo(b.deadline);
      });

      return Result.success(goals);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get goals by category: $e'));
    }
  }

  /// Add new goal
  Future<Result<Goal>> add(Goal goal) async {
    try {
      if (_goalsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = GoalDto.fromDomain(goal);
      await _goalsBox!.put(goal.id, dto);

      return Result.success(goal);
    } catch (e) {
      return Result.error(Failure.cache('Failed to add goal: $e'));
    }
  }

  /// Update existing goal
  Future<Result<Goal>> update(Goal goal) async {
    try {
      if (_goalsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = GoalDto.fromDomain(goal);
      await _goalsBox!.put(goal.id, dto);

      return Result.success(goal);
    } catch (e) {
      return Result.error(Failure.cache('Failed to update goal: $e'));
    }
  }

  /// Delete goal by ID
  Future<Result<void>> delete(String id) async {
    try {
      if (_goalsBox == null || _contributionsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      // Delete the goal
      await _goalsBox!.delete(id);

      // Delete all contributions for this goal
      final contributionKeys = _contributionsBox!.keys.where((key) {
        final dto = _contributionsBox!.get(key);
        return dto?.goalId == id;
      }).toList();

      await _contributionsBox!.deleteAll(contributionKeys);

      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.cache('Failed to delete goal: $e'));
    }
  }

  /// Get contributions for a specific goal
  Future<Result<List<GoalContribution>>> getContributions(String goalId) async {
    try {
      if (_contributionsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _contributionsBox!.values.where((dto) => dto.goalId == goalId).toList();
      final contributions = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by date (newest first)
      contributions.sort((a, b) => b.date.compareTo(a.date));

      return Result.success(contributions);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get contributions: $e'));
    }
  }

  /// Add contribution to a goal
  Future<Result<Goal>> addContribution(String goalId, GoalContribution contribution) async {
    try {
      if (_goalsBox == null || _contributionsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      // Get the goal
      final goalResult = await getById(goalId);
      if (goalResult.isError) {
        return Result.error(goalResult.failureOrNull!);
      }

      final goal = goalResult.dataOrNull;
      if (goal == null) {
        return Result.error(Failure.validation('Goal not found', {'goalId': 'Goal does not exist'}));
      }

      // Add the contribution
      final dto = GoalContributionDto.fromDomain(contribution);
      await _contributionsBox!.put(contribution.id, dto);

      // Update goal's current amount
      final updatedGoal = goal.copyWith(
        currentAmount: goal.currentAmount + contribution.amount,
        updatedAt: DateTime.now(),
      );

      return await update(updatedGoal);
    } catch (e) {
      return Result.error(Failure.cache('Failed to add contribution: $e'));
    }
  }

  /// Delete contribution by ID
  Future<Result<void>> deleteContribution(String contributionId) async {
    try {
      if (_contributionsBox == null || _goalsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      // Get the contribution to find the goal
      final dto = _contributionsBox!.get(contributionId);
      if (dto == null) {
        return Result.error(Failure.validation('Contribution not found', {'contributionId': 'Contribution does not exist'}));
      }

      final goalId = dto.goalId;

      // Delete the contribution
      await _contributionsBox!.delete(contributionId);

      // Update goal's current amount
      final goalResult = await getById(goalId);
      if (goalResult.isSuccess && goalResult.dataOrNull != null) {
        final goal = goalResult.dataOrNull!;
        final contributionsResult = await getContributions(goalId);
        if (contributionsResult.isSuccess) {
          final contributions = contributionsResult.dataOrNull ?? [];
          final totalContributed = contributions.fold<double>(0, (sum, c) => sum + c.amount);

          final updatedGoal = goal.copyWith(
            currentAmount: totalContributed,
            updatedAt: DateTime.now(),
          );

          await update(updatedGoal);
        }
      }

      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.cache('Failed to delete contribution: $e'));
    }
  }

  /// Get goal progress for a specific goal
  Future<Result<GoalProgress>> getGoalProgress(String goalId) async {
    try {
      // Get goal
      final goalResult = await getById(goalId);
      if (goalResult.isError) {
        return Result.error(goalResult.failureOrNull!);
      }

      final goal = goalResult.dataOrNull;
      if (goal == null) {
        return Result.error(Failure.validation('Goal not found', {'goalId': 'Goal does not exist'}));
      }

      // Get contributions
      final contributionsResult = await getContributions(goalId);
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
      return Result.error(Failure.cache('Failed to get goal progress: $e'));
    }
  }

  /// Get progress for all goals
  Future<Result<List<GoalProgress>>> getAllGoalProgress() async {
    try {
      final goalsResult = await getAll();
      if (goalsResult.isError) {
        return Result.error(goalsResult.failureOrNull!);
      }

      final goals = goalsResult.dataOrNull ?? [];
      final progressList = <GoalProgress>[];

      // Calculate progress for each goal
      for (final goal in goals) {
        final progressResult = await getGoalProgress(goal.id);
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
      return Result.error(Failure.cache('Failed to get all goal progress: $e'));
    }
  }

  /// Search goals by title or description
  Future<Result<List<Goal>>> search(String query) async {
    try {
      if (_goalsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final lowerQuery = query.toLowerCase();
      final dtos = _goalsBox!.values.where((dto) {
        return dto.title.toLowerCase().contains(lowerQuery) ||
               dto.description.toLowerCase().contains(lowerQuery);
      }).toList();

      final goals = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by priority then deadline
      goals.sort((a, b) {
        final priorityCompare = b.priority.value.compareTo(a.priority.value);
        if (priorityCompare != 0) return priorityCompare;
        return a.deadline.compareTo(b.deadline);
      });

      return Result.success(goals);
    } catch (e) {
      return Result.error(Failure.cache('Failed to search goals: $e'));
    }
  }

  /// Get goal count
  Future<Result<int>> getCount() async {
    try {
      if (_goalsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      return Result.success(_goalsBox!.length);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get goal count: $e'));
    }
  }

  /// Calculate if goal is on track
  bool _calculateIsOnTrack(Goal goal, DateTime? projectedCompletionDate) {
    if (projectedCompletionDate == null) return true; // Can't determine

    // Goal is on track if projected completion is before or on target date
    return !projectedCompletionDate.isAfter(goal.deadline);
  }

  /// Clear all goals and contributions
  Future<Result<void>> clear() async {
    try {
      if (_goalsBox == null || _contributionsBox == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      await _goalsBox!.clear();
      await _contributionsBox!.clear();
      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.cache('Failed to clear goals: $e'));
    }
  }

  /// Close the boxes
  Future<void> close() async {
    await _goalsBox?.close();
    await _contributionsBox?.close();
    _goalsBox = null;
    _contributionsBox = null;
  }
}