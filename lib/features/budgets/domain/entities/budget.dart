import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';

part 'budget.freezed.dart';

/// Budget entity representing a spending plan
@freezed
class Budget with _$Budget {
  const factory Budget({
    required String id,
    required String name,
    required BudgetType type,
    required DateTime startDate,
    required DateTime endDate,
    required List<BudgetCategory> categories,
    String? description,
    @Default(false) bool isActive,
  }) = _Budget;

  const Budget._();

  /// Calculate total budgeted amount
  double get totalBudget => categories.fold(0.0, (sum, category) => sum + category.amount);

  /// Get budget period in days
  int get periodInDays => endDate.difference(startDate).inDays;

  /// Check if budget is currently active
  bool get isCurrentlyActive {
    final now = DateTime.now();
    return isActive && now.isAfter(startDate) && now.isBefore(endDate);
  }

  /// Get remaining days in budget period
  int get remainingDays {
    final now = DateTime.now();
    if (now.isBefore(startDate)) return periodInDays;
    if (now.isAfter(endDate)) return 0;
    return endDate.difference(now).inDays;
  }

  /// Validate budget data
  Result<Budget> validate() {
    if (name.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Budget name cannot be empty',
        {'name': 'Name is required'},
      ));
    }

    if (categories.isEmpty) {
      return Result.error(Failure.validation(
        'Budget must have at least one category',
        {'categories': 'At least one category required'},
      ));
    }

    if (totalBudget <= 0) {
      return Result.error(Failure.validation(
        'Total budget amount must be greater than zero',
        {'amount': 'Total budget must be positive'},
      ));
    }

    if (endDate.isBefore(startDate)) {
      return Result.error(Failure.validation(
        'End date must be after start date',
        {'endDate': 'End date must be after start date'},
      ));
    }

    return Result.success(this);
  }
}

/// Budget category representing a spending category within a budget
@freezed
class BudgetCategory with _$BudgetCategory {
  const factory BudgetCategory({
    required String id,
    required String name,
    required double amount,
    String? description,
    String? icon,
    int? color,
    @Default([]) List<String> subcategories,
  }) = _BudgetCategory;

  const BudgetCategory._();

  /// Validate category data
  Result<BudgetCategory> validate() {
    if (name.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Category name cannot be empty',
        {'name': 'Name is required'},
      ));
    }

    if (amount < 0) {
      return Result.error(Failure.validation(
        'Category amount cannot be negative',
        {'amount': 'Amount must be non-negative'},
      ));
    }

    return Result.success(this);
  }
}

/// Budget type enumeration
enum BudgetType {
  zeroBased('Zero-Based'),
  fiftyThirtyTwenty('50/30/20'),
  envelope('Envelope'),
  custom('Custom');

  const BudgetType(this.displayName);

  final String displayName;

  /// Get description for budget type
  String get description {
    switch (this) {
      case BudgetType.zeroBased:
        return 'Every dollar is assigned to a job. Income minus expenses equals zero.';
      case BudgetType.fiftyThirtyTwenty:
        return '50% needs, 30% wants, 20% savings and debt repayment.';
      case BudgetType.envelope:
        return 'Cash-based system with physical envelopes for each category.';
      case BudgetType.custom:
        return 'Create your own budget structure.';
    }
  }

  /// Get recommended allocation percentages
  Map<String, double> get recommendedAllocations {
    switch (this) {
      case BudgetType.fiftyThirtyTwenty:
        return {
          'needs': 0.50,
          'wants': 0.30,
          'savings': 0.20,
        };
      default:
        return {};
    }
  }
}

/// Budget status representing current budget state
@freezed
class BudgetStatus with _$BudgetStatus {
  const factory BudgetStatus({
    required Budget budget,
    required double totalSpent,
    required double totalBudget,
    required List<CategoryStatus> categoryStatuses,
    required int daysRemaining,
  }) = _BudgetStatus;

  const BudgetStatus._();

  /// Calculate overall budget health
  BudgetHealth get overallHealth {
    final spentPercentage = totalSpent / totalBudget;
    if (spentPercentage > 1.0) return BudgetHealth.overBudget;
    if (spentPercentage > 0.9) return BudgetHealth.critical;
    if (spentPercentage > 0.75) return BudgetHealth.warning;
    return BudgetHealth.healthy;
  }

  /// Get remaining budget amount
  double get remainingAmount => totalBudget - totalSpent;

  /// Get spent percentage
  double get spentPercentage => totalSpent / totalBudget;

  /// Check if budget is on track
  bool get isOnTrack => overallHealth != BudgetHealth.overBudget;
}

/// Category status within a budget
@freezed
class CategoryStatus with _$CategoryStatus {
  const factory CategoryStatus({
    required String categoryId,
    required double spent,
    required double budget,
    required double percentage,
    required BudgetHealth status,
  }) = _CategoryStatus;

  const CategoryStatus._();

  /// Get remaining amount for category
  double get remaining => budget - spent;

  /// Check if category is over budget
  bool get isOverBudget => spent > budget;
}

/// Budget health enumeration
enum BudgetHealth {
  healthy('Healthy'),
  warning('Warning'),
  critical('Critical'),
  overBudget('Over Budget');

  const BudgetHealth(this.displayName);

  final String displayName;

  /// Get color for health status
  String get color {
    switch (this) {
      case BudgetHealth.healthy:
        return '#10B981'; // Green
      case BudgetHealth.warning:
        return '#F59E0B'; // Yellow
      case BudgetHealth.critical:
        return '#EF4444'; // Red
      case BudgetHealth.overBudget:
        return '#DC2626'; // Dark Red
    }
  }
}