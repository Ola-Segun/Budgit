import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart' as core_providers;
import '../../domain/entities/debt.dart';
import '../../domain/usecases/create_debt.dart';
import '../../domain/usecases/delete_debt.dart';
import '../../domain/usecases/get_debts.dart';
import '../../domain/usecases/update_debt.dart';
import '../notifiers/debt_notifier.dart';
import '../states/debt_state.dart';

/// Provider for GetDebts use case
final getDebtsProvider = Provider<GetDebts>((ref) {
  return ref.read(core_providers.getDebtsProvider);
});

/// Provider for CreateDebt use case
final createDebtProvider = Provider<CreateDebt>((ref) {
  return ref.read(core_providers.createDebtProvider);
});

/// Provider for UpdateDebt use case
final updateDebtProvider = Provider<UpdateDebt>((ref) {
  return ref.read(core_providers.updateDebtProvider);
});

/// Provider for DeleteDebt use case
final deleteDebtProvider = Provider<DeleteDebt>((ref) {
  return ref.read(core_providers.deleteDebtProvider);
});

/// State notifier provider for debt state management
final debtNotifierProvider =
    StateNotifierProvider<DebtNotifier, AsyncValue<DebtState>>((ref) {
  final getDebts = ref.watch(getDebtsProvider);
  final createDebt = ref.watch(createDebtProvider);
  final updateDebt = ref.watch(updateDebtProvider);
  final deleteDebt = ref.watch(deleteDebtProvider);

  return DebtNotifier(
    getDebts: getDebts,
    createDebt: createDebt,
    updateDebt: updateDebt,
    deleteDebt: deleteDebt,
  );
});

/// Provider for filtered debts
final filteredDebtsProvider = Provider<AsyncValue<List<Debt>>>((ref) {
  final debtState = ref.watch(debtNotifierProvider);

  return debtState.when(
    data: (state) {
      // Apply any filters here if needed
      return AsyncValue.data(state.filteredDebts);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for debt statistics
final debtStatsProvider = Provider<AsyncValue<DebtStats>>((ref) {
  final debtState = ref.watch(debtNotifierProvider);

  return debtState.when(
    data: (state) {
      final debts = state.debts;

      final totalDebt = debts.fold<double>(0, (sum, debt) => sum + debt.amount);
      final totalRemaining = debts.fold<double>(0, (sum, debt) => sum + debt.remainingAmount);
      final totalPaid = totalDebt - totalRemaining;
      final debtCount = debts.length;

      final averageDebtAmount = debtCount > 0 ? totalDebt / debtCount : 0.0;

      final overdueDebts = debts.where((debt) => debt.isOverdue).toList();
      final activeDebts = debts.where((debt) => debt.remainingAmount > 0).toList();

      final stats = DebtStats(
        totalDebt: totalDebt,
        totalRemaining: totalRemaining,
        totalPaid: totalPaid,
        debtCount: debtCount,
        averageDebtAmount: averageDebtAmount,
        overdueCount: overdueDebts.length,
        activeCount: activeDebts.length,
      );

      return AsyncValue.data(stats);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});