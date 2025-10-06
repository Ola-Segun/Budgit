import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart' as core_providers;
import '../../domain/entities/budget.dart';
import '../../domain/usecases/calculate_budget_status.dart';
import '../../domain/usecases/create_budget.dart';
import '../../domain/usecases/delete_budget.dart';
import '../../domain/usecases/get_budgets.dart';
import '../../domain/usecases/update_budget.dart';
import '../notifiers/budget_notifier.dart';
import '../states/budget_state.dart';

/// Provider for GetBudgets use case
final getBudgetsProvider = Provider<GetBudgets>((ref) {
  return ref.read(core_providers.getBudgetsProvider);
});

/// Provider for GetActiveBudgets use case
final getActiveBudgetsProvider = Provider<GetActiveBudgets>((ref) {
  return ref.read(core_providers.getActiveBudgetsProvider);
});

/// Provider for CreateBudget use case
final createBudgetProvider = Provider<CreateBudget>((ref) {
  return ref.read(core_providers.createBudgetProvider);
});

/// Provider for UpdateBudget use case
final updateBudgetProvider = Provider<UpdateBudget>((ref) {
  return ref.read(core_providers.updateBudgetProvider);
});

/// Provider for DeleteBudget use case
final deleteBudgetProvider = Provider<DeleteBudget>((ref) {
  return ref.read(core_providers.deleteBudgetProvider);
});

/// Provider for CalculateBudgetStatus use case
final calculateBudgetStatusProvider = Provider<CalculateBudgetStatus>((ref) {
  return ref.read(core_providers.calculateBudgetStatusProvider);
});

/// State notifier provider for budget state management
final budgetNotifierProvider =
    StateNotifierProvider<BudgetNotifier, AsyncValue<BudgetState>>((ref) {
  final getBudgets = ref.watch(getBudgetsProvider);
  final getActiveBudgets = ref.watch(getActiveBudgetsProvider);
  final createBudget = ref.watch(createBudgetProvider);
  final updateBudget = ref.watch(updateBudgetProvider);
  final deleteBudget = ref.watch(deleteBudgetProvider);
  final calculateBudgetStatus = ref.watch(calculateBudgetStatusProvider);

  return BudgetNotifier(
    getBudgets: getBudgets,
    getActiveBudgets: getActiveBudgets,
    createBudget: createBudget,
    updateBudget: updateBudget,
    deleteBudget: deleteBudget,
    calculateBudgetStatus: calculateBudgetStatus,
  );
});

/// Provider for filtered budgets
final filteredBudgetsProvider = Provider<AsyncValue<List<Budget>>>((ref) {
  final budgetState = ref.watch(budgetNotifierProvider);

  return budgetState.when(
    data: (state) {
      return AsyncValue.data(state.filteredBudgets);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for active budgets
final activeBudgetsProvider = Provider<AsyncValue<List<Budget>>>((ref) {
  final budgetState = ref.watch(budgetNotifierProvider);

  return budgetState.when(
    data: (state) {
      return AsyncValue.data(state.activeBudgets);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for budget statuses
final budgetStatusesProvider = Provider<AsyncValue<List<BudgetStatus>>>((ref) {
  final budgetState = ref.watch(budgetNotifierProvider);

  return budgetState.when(
    data: (state) {
      return AsyncValue.data(state.budgetStatuses);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for selected budget
final selectedBudgetProvider = Provider<AsyncValue<Budget?>>((ref) {
  final budgetState = ref.watch(budgetNotifierProvider);

  return budgetState.when(
    data: (state) => AsyncValue.data(state.selectedBudget),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for budget statistics
final budgetStatsProvider = Provider<AsyncValue<BudgetStats>>((ref) {
  final budgetState = ref.watch(budgetNotifierProvider);

  return budgetState.when(
    data: (state) {
      final budgets = state.budgets;
      final activeBudgets = state.activeBudgets;
      final totalBudgetAmount = budgets.fold<double>(0.0, (sum, budget) => sum + budget.totalBudget);
      final activeBudgetAmount = activeBudgets.fold<double>(0.0, (sum, budget) => sum + budget.totalBudget);

      final healthyBudgets = state.budgetStatuses.where((status) => status.overallHealth == BudgetHealth.healthy).length;
      final warningBudgets = state.budgetStatuses.where((status) => status.overallHealth == BudgetHealth.warning).length;
      final criticalBudgets = state.budgetStatuses.where((status) => status.overallHealth == BudgetHealth.critical).length;
      final overBudgetCount = state.budgetStatuses.where((status) => status.overallHealth == BudgetHealth.overBudget).length;

      final stats = BudgetStats(
        totalBudgets: budgets.length,
        activeBudgets: activeBudgets.length,
        totalBudgetAmount: totalBudgetAmount,
        activeBudgetAmount: activeBudgetAmount,
        healthyBudgets: healthyBudgets,
        warningBudgets: warningBudgets,
        criticalBudgets: criticalBudgets,
        overBudgetCount: overBudgetCount,
      );

      return AsyncValue.data(stats);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Budget statistics
class BudgetStats {
  const BudgetStats({
    required this.totalBudgets,
    required this.activeBudgets,
    required this.totalBudgetAmount,
    required this.activeBudgetAmount,
    required this.healthyBudgets,
    required this.warningBudgets,
    required this.criticalBudgets,
    required this.overBudgetCount,
  });

  final int totalBudgets;
  final int activeBudgets;
  final double totalBudgetAmount;
  final double activeBudgetAmount;
  final int healthyBudgets;
  final int warningBudgets;
  final int criticalBudgets;
  final int overBudgetCount;

  /// Get percentage of healthy budgets
  double get healthyPercentage => activeBudgets > 0 ? (healthyBudgets / activeBudgets) * 100 : 0.0;

  /// Get percentage of budgets in warning
  double get warningPercentage => activeBudgets > 0 ? (warningBudgets / activeBudgets) * 100 : 0.0;

  /// Get percentage of budgets in critical state
  double get criticalPercentage => activeBudgets > 0 ? (criticalBudgets / activeBudgets) * 100 : 0.0;

  /// Get percentage of over-budget budgets
  double get overBudgetPercentage => activeBudgets > 0 ? (overBudgetCount / activeBudgets) * 100 : 0.0;
}