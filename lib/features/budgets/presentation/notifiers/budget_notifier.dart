import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/budget.dart';
import '../../domain/usecases/calculate_budget_status.dart';
import '../../domain/usecases/create_budget.dart';
import '../../domain/usecases/delete_budget.dart';
import '../../domain/usecases/get_budgets.dart';
import '../../domain/usecases/update_budget.dart';
import '../states/budget_state.dart';

/// State notifier for budget management
class BudgetNotifier extends StateNotifier<AsyncValue<BudgetState>> {
  final GetBudgets _getBudgets;
  final GetActiveBudgets _getActiveBudgets;
  final CreateBudget _createBudget;
  final UpdateBudget _updateBudget;
  final DeleteBudget _deleteBudget;
  final CalculateBudgetStatus _calculateBudgetStatus;

  BudgetNotifier({
    required GetBudgets getBudgets,
    required GetActiveBudgets getActiveBudgets,
    required CreateBudget createBudget,
    required UpdateBudget updateBudget,
    required DeleteBudget deleteBudget,
    required CalculateBudgetStatus calculateBudgetStatus,
  })  : _getBudgets = getBudgets,
        _getActiveBudgets = getActiveBudgets,
        _createBudget = createBudget,
        _updateBudget = updateBudget,
        _deleteBudget = deleteBudget,
        _calculateBudgetStatus = calculateBudgetStatus,
        super(const AsyncValue.loading()) {
    loadBudgets();
  }

  /// Load all budgets
  Future<void> loadBudgets() async {
    state = const AsyncValue.loading();

    final result = await _getBudgets();

    result.when(
      success: (budgets) async {
        // Load budget statuses for active budgets
        final activeBudgets = budgets.where((budget) => budget.isActive).toList();
        final budgetStatuses = <BudgetStatus>[];

        for (final budget in activeBudgets) {
          final statusResult = await _calculateBudgetStatus(budget);
          statusResult.when(
            success: (status) => budgetStatuses.add(status),
            error: (_) {}, // Skip failed status calculations
          );
        }

        state = AsyncValue.data(BudgetState(
          budgets: budgets,
          budgetStatuses: budgetStatuses,
        ));
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
    );
  }

  /// Load active budgets with statuses
  Future<void> loadActiveBudgets() async {
    final currentState = state.value;
    if (currentState == null) return;

    final result = await _getActiveBudgets();

    result.when(
      success: (activeBudgets) async {
        final budgetStatuses = <BudgetStatus>[];

        for (final budget in activeBudgets) {
          final statusResult = await _calculateBudgetStatus(budget);
          statusResult.when(
            success: (status) => budgetStatuses.add(status),
            error: (_) {}, // Skip failed status calculations
          );
        }

        state = AsyncValue.data(currentState.copyWith(
          budgetStatuses: budgetStatuses,
        ));
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
    );
  }

  /// Create a new budget
  Future<bool> createBudget(Budget budget) async {
    final currentState = state.value;
    if (currentState == null) return false;

    // Set loading state
    state = AsyncValue.data(currentState.copyWith(isLoading: true));

    final result = await _createBudget(budget);

    return result.when(
      success: (createdBudget) {
        final updatedBudgets = [createdBudget, ...currentState.budgets];
        state = AsyncValue.data(currentState.copyWith(
          budgets: updatedBudgets,
          isLoading: false,
        ));

        // If budget is active, refresh statuses
        if (createdBudget.isActive) {
          loadActiveBudgets();
        }

        return true;
      },
      error: (failure) {
        state = AsyncValue.data(currentState.copyWith(
          isLoading: false,
          error: failure.message,
        ));
        return false;
      },
    );
  }

  /// Update an existing budget
  Future<bool> updateBudget(Budget budget) async {
    final currentState = state.value;
    if (currentState == null) return false;

    final result = await _updateBudget(budget);

    return result.when(
      success: (updatedBudget) {
        final updatedBudgets = currentState.budgets.map((b) {
          return b.id == budget.id ? updatedBudget : b;
        }).toList();

        state = AsyncValue.data(currentState.copyWith(budgets: updatedBudgets));

        // Refresh statuses if budget is active
        if (updatedBudget.isActive) {
          loadActiveBudgets();
        }

        return true;
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
    );
  }

  /// Delete a budget
  Future<bool> deleteBudget(String budgetId) async {
    final currentState = state.value;
    if (currentState == null) return false;

    final result = await _deleteBudget(budgetId);

    return result.when(
      success: (_) {
        final updatedBudgets = currentState.budgets
            .where((b) => b.id != budgetId)
            .toList();

        final updatedStatuses = currentState.budgetStatuses
            .where((s) => s.budget.id != budgetId)
            .toList();

        state = AsyncValue.data(currentState.copyWith(
          budgets: updatedBudgets,
          budgetStatuses: updatedStatuses,
        ));

        return true;
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
    );
  }

  /// Get budget status for a specific budget
  Future<BudgetStatus?> getBudgetStatus(String budgetId) async {
    // Get budget first
    final budgets = state.value?.budgets ?? [];
    final budget = budgets.where((b) => b.id == budgetId).firstOrNull;

    if (budget == null) return null;

    final result = await _calculateBudgetStatus(budget);

    return result.when(
      success: (status) => status,
      error: (_) => null,
    );
  }

  /// Search budgets
  void searchBudgets(String query) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(searchQuery: query));
  }

  /// Apply filter
  void applyFilter(BudgetFilter filter) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(filter: filter));
  }

  /// Clear filter
  void clearFilter() {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(filter: null));
  }

  /// Clear search
  void clearSearch() {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(searchQuery: null));
  }

  /// Select a budget
  void selectBudget(Budget? budget) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(selectedBudget: budget));
  }
}