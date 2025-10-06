import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/debt.dart';
import '../../domain/usecases/create_debt.dart';
import '../../domain/usecases/delete_debt.dart';
import '../../domain/usecases/get_debts.dart';
import '../../domain/usecases/update_debt.dart';
import '../states/debt_state.dart';

/// State notifier for debt management
class DebtNotifier extends StateNotifier<AsyncValue<DebtState>> {
  final GetDebts _getDebts;
  final CreateDebt _createDebt;
  final UpdateDebt _updateDebt;
  final DeleteDebt _deleteDebt;

  DebtNotifier({
    required GetDebts getDebts,
    required CreateDebt createDebt,
    required UpdateDebt updateDebt,
    required DeleteDebt deleteDebt,
  })  : _getDebts = getDebts,
        _createDebt = createDebt,
        _updateDebt = updateDebt,
        _deleteDebt = deleteDebt,
        super(const AsyncValue.loading()) {
    loadDebts();
  }

  /// Load all debts
  Future<void> loadDebts() async {
    debugPrint('DebtNotifier: Loading debts');
    state = const AsyncValue.loading();

    final result = await _getDebts();

    result.when(
      success: (debts) {
        state = AsyncValue.data(DebtState(
          debts: debts,
          isLoading: false,
        ));
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
    );
  }

  /// Add a new debt
  Future<bool> addDebt(Debt debt) async {
    final currentState = state.value;
    if (currentState == null) return false;

    // Set loading state
    state = AsyncValue.data(currentState.copyWith(isLoading: true));

    final result = await _createDebt(debt);

    return result.when(
      success: (addedDebt) {
        // Update with server response
        final updatedDebts = [addedDebt, ...currentState.debts];
        state = AsyncValue.data(currentState.copyWith(
          debts: updatedDebts,
          isLoading: false,
        ));
        return true;
      },
      error: (failure) {
        // Revert to original state with error
        state = AsyncValue.data(currentState.copyWith(
          isLoading: false,
          error: failure.message,
        ));
        return false;
      },
    );
  }

  /// Update an existing debt
  Future<bool> updateDebt(Debt debt) async {
    final currentState = state.value;
    if (currentState == null) return false;

    final result = await _updateDebt(debt);

    return result.when(
      success: (updatedDebt) {
        final updatedDebts = currentState.debts.map((d) {
          return d.id == debt.id ? updatedDebt : d;
        }).toList();
        state = AsyncValue.data(currentState.copyWith(debts: updatedDebts));
        return true;
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
    );
  }

  /// Delete a debt
  Future<bool> deleteDebt(String debtId) async {
    final currentState = state.value;
    if (currentState == null) return false;

    final result = await _deleteDebt(debtId);

    return result.when(
      success: (_) {
        final updatedDebts = currentState.debts
            .where((d) => d.id != debtId)
            .toList();
        state = AsyncValue.data(currentState.copyWith(debts: updatedDebts));
        return true;
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
    );
  }

  /// Search debts
  void searchDebts(String query) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(searchQuery: query));
  }

  /// Apply filter
  void applyFilter(DebtFilter filter) {
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
}