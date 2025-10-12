import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal.freezed.dart';

/// Goal entity - represents a financial goal
/// Pure domain entity with no dependencies
@freezed
class Goal with _$Goal {
  const factory Goal({
    required String id,
    required String title,
    required String description,
    required double targetAmount,
    required double currentAmount,
    required DateTime deadline,
    required GoalPriority priority,
    required String categoryId,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<String> tags,
  }) = _Goal;

  const Goal._();

  /// Calculate progress percentage (0.0 to 1.0)
  double get progressPercentage {
    if (targetAmount <= 0) return 0.0;
    return (currentAmount / targetAmount).clamp(0.0, 1.0);
  }

  /// Check if goal is completed
  bool get isCompleted => currentAmount >= targetAmount;

  /// Check if goal is overdue
  bool get isOverdue => DateTime.now().isAfter(deadline) && !isCompleted;

  /// Get remaining amount to reach target
  double get remainingAmount => (targetAmount - currentAmount).clamp(0.0, double.infinity);

  /// Get days remaining until deadline
  int get daysRemaining {
    final now = DateTime.now();
    final difference = deadline.difference(now);
    return difference.inDays;
  }

  /// Alias for deadline (used in some calculations)
  DateTime get targetDate => deadline;

  /// Calculate projected completion date based on current progress
  DateTime? get projectedCompletionDate {
    if (isCompleted) return null;

    final remaining = remainingAmount;
    if (remaining <= 0) return DateTime.now();

    // Simple projection: assume current contribution rate continues
    // This is a basic calculation - could be enhanced with historical data
    final daysRemaining = deadline.difference(DateTime.now()).inDays;
    if (daysRemaining <= 0) return null;

    final daysPassed = DateTime.now().difference(createdAt).inDays + 1;
    final dailyRate = currentAmount / daysPassed;

    // If no progress has been made (dailyRate <= 0), cannot project completion
    if (dailyRate <= 0) return null;

    final projectedDays = remaining / dailyRate;

    // Ensure projectedDays is finite and reasonable
    if (!projectedDays.isFinite || projectedDays < 0) return null;

    return DateTime.now().add(Duration(days: projectedDays.round()));
  }

  /// Calculate required monthly contribution to meet deadline
  double get requiredMonthlyContribution {
    if (isCompleted) return 0.0;

    final remaining = remainingAmount;
    final monthsRemaining = deadline.difference(DateTime.now()).inDays / 30.0;

    if (monthsRemaining <= 0) return remaining; // Need to contribute everything now

    return remaining / monthsRemaining;
  }

  /// Get formatted progress text
  String get progressText => '${(progressPercentage * 100).round()}%';

  /// Get formatted target amount
  String get formattedTargetAmount => '\$${targetAmount.toStringAsFixed(2)}';

  /// Get formatted current amount
  String get formattedCurrentAmount => '\$${currentAmount.toStringAsFixed(2)}';

  /// Get formatted remaining amount
  String get formattedRemainingAmount => '\$${remainingAmount.toStringAsFixed(2)}';
}

/// Goal priority enum
enum GoalPriority {
  low,
  medium,
  high;

  String get displayName {
    switch (this) {
      case GoalPriority.low:
        return 'Low';
      case GoalPriority.medium:
        return 'Medium';
      case GoalPriority.high:
        return 'High';
    }
  }

  int get value {
    switch (this) {
      case GoalPriority.low:
        return 1;
      case GoalPriority.medium:
        return 2;
      case GoalPriority.high:
        return 3;
    }
  }
}
