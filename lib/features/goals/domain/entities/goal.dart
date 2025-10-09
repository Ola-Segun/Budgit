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
    required GoalCategory category,
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

/// Goal category enum
enum GoalCategory {
  emergencyFund,
  vacation,
  homeDownPayment,
  debtPayoff,
  carPurchase,
  education,
  retirement,
  investment,
  wedding,
  custom;

  String get displayName {
    switch (this) {
      case GoalCategory.emergencyFund:
        return 'Emergency Fund';
      case GoalCategory.vacation:
        return 'Vacation';
      case GoalCategory.homeDownPayment:
        return 'Home Down Payment';
      case GoalCategory.debtPayoff:
        return 'Debt Payoff';
      case GoalCategory.carPurchase:
        return 'Car Purchase';
      case GoalCategory.education:
        return 'Education';
      case GoalCategory.retirement:
        return 'Retirement';
      case GoalCategory.investment:
        return 'Investment';
      case GoalCategory.wedding:
        return 'Wedding';
      case GoalCategory.custom:
        return 'Custom';
    }
  }

  String get icon {
    switch (this) {
      case GoalCategory.emergencyFund:
        return 'security';
      case GoalCategory.vacation:
        return 'beach_access';
      case GoalCategory.homeDownPayment:
        return 'home';
      case GoalCategory.debtPayoff:
        return 'credit_card_off';
      case GoalCategory.carPurchase:
        return 'directions_car';
      case GoalCategory.education:
        return 'school';
      case GoalCategory.retirement:
        return 'account_balance';
      case GoalCategory.investment:
        return 'trending_up';
      case GoalCategory.wedding:
        return 'favorite';
      case GoalCategory.custom:
        return 'star';
    }
  }

  int get defaultColor {
    switch (this) {
      case GoalCategory.emergencyFund:
        return 0xFFDC2626; // Red
      case GoalCategory.vacation:
        return 0xFF059669; // Green
      case GoalCategory.homeDownPayment:
        return 0xFF7C3AED; // Purple
      case GoalCategory.debtPayoff:
        return 0xFFEA580C; // Orange
      case GoalCategory.carPurchase:
        return 0xFF2563EB; // Blue
      case GoalCategory.education:
        return 0xFF7C2D12; // Brown
      case GoalCategory.retirement:
        return 0xFF0D9488; // Teal
      case GoalCategory.investment:
        return 0xFF16A34A; // Green
      case GoalCategory.wedding:
        return 0xFFBE185D; // Pink
      case GoalCategory.custom:
        return 0xFF64748B; // Gray
    }
  }
}