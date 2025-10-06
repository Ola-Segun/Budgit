import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/budget.dart';

part 'budget_state.freezed.dart';

/// State for budget management
@freezed
class BudgetState with _$BudgetState {
  const factory BudgetState({
    @Default([]) List<Budget> budgets,
    @Default([]) List<BudgetStatus> budgetStatuses,
    @Default(false) bool isLoading,
    String? error,
    String? searchQuery,
    BudgetFilter? filter,
    Budget? selectedBudget,
  }) = _BudgetState;

  const BudgetState._();

  /// Get filtered budgets based on search query and filter
  List<Budget> get filteredBudgets {
    var filtered = budgets;

    // Apply search filter
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      filtered = filtered.where((budget) {
        return budget.name.toLowerCase().contains(query) ||
               budget.description?.toLowerCase().contains(query) == true ||
               budget.categories.any((category) =>
                   category.name.toLowerCase().contains(query));
      }).toList();
    }

    // Apply budget filter
    if (filter != null) {
      filtered = filtered.where((budget) {
        // Filter by budget type
        if (filter!.budgetType != null &&
            budget.type != filter!.budgetType) {
          return false;
        }

        // Filter by active status
        if (filter!.isActive != null &&
            budget.isActive != filter!.isActive) {
          return false;
        }

        // Filter by date range
        if (filter!.startDate != null &&
            budget.startDate.isBefore(filter!.startDate!)) {
          return false;
        }
        if (filter!.endDate != null &&
            budget.endDate.isAfter(filter!.endDate!)) {
          return false;
        }

        return true;
      }).toList();
    }

    return filtered;
  }

  /// Get active budgets
  List<Budget> get activeBudgets =>
      budgets.where((budget) => budget.isActive).toList();

  /// Get budgets grouped by type
  Map<BudgetType, List<Budget>> get budgetsByType {
    final grouped = <BudgetType, List<Budget>>{};

    for (final budget in filteredBudgets) {
      grouped[budget.type] ??= [];
      grouped[budget.type]!.add(budget);
    }

    return grouped;
  }
}

/// Filter for budgets
@freezed
class BudgetFilter with _$BudgetFilter {
  const factory BudgetFilter({
    BudgetType? budgetType,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
  }) = _BudgetFilter;

  const BudgetFilter._();

  /// Check if filter is empty (no filters applied)
  bool get isEmpty =>
      budgetType == null &&
      isActive == null &&
      startDate == null &&
      endDate == null;

  /// Check if filter has any active filters
  bool get isNotEmpty => !isEmpty;
}