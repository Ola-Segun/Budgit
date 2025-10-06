import 'package:freezed_annotation/freezed_annotation.dart';

import 'goal.dart';

part 'goal_progress.freezed.dart';

/// Goal progress entity - represents calculated progress metrics for a goal
/// Pure domain entity with no dependencies
@freezed
class GoalProgress with _$GoalProgress {
  const factory GoalProgress({
    required Goal goal,
    required double percentage,
    DateTime? projectedCompletionDate,
    required bool isOnTrack,
    required double requiredMonthlyContribution,
    required double totalContributed,
    required int totalContributions,
  }) = _GoalProgress;

  const GoalProgress._();

  /// Get formatted percentage
  String get formattedPercentage => '${(percentage * 100).round()}%';

  /// Get formatted required monthly contribution
  String get formattedRequiredMonthlyContribution => '\$${requiredMonthlyContribution.toStringAsFixed(2)}';

  /// Get formatted total contributed
  String get formattedTotalContributed => '\$${totalContributed.toStringAsFixed(2)}';

  /// Check if goal is behind schedule
  bool get isBehindSchedule => !isOnTrack && percentage < 1.0;

  /// Check if goal is ahead of schedule
  bool get isAheadOfSchedule => isOnTrack && percentage < 1.0 && projectedCompletionDate != null;

  /// Get progress status message
  String get statusMessage {
    if (goal.isCompleted) {
      return 'Goal completed!';
    } else if (isBehindSchedule) {
      return 'Behind schedule';
    } else if (isAheadOfSchedule) {
      return 'Ahead of schedule';
    } else {
      return 'On track';
    }
  }

  /// Get days until projected completion
  int? get daysToProjectedCompletion {
    if (projectedCompletionDate == null) return null;
    final now = DateTime.now();
    return projectedCompletionDate!.difference(now).inDays;
  }
}