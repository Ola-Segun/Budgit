import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/usecases/add_transaction.dart';
import '../../domain/usecases/delete_transaction.dart';
import '../../domain/usecases/get_paginated_transactions.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/update_transaction.dart';
import '../states/transaction_state.dart';

/// State notifier for transaction management
class TransactionNotifier extends StateNotifier<AsyncValue<TransactionState>> {
  final GetTransactions _getTransactions;
  final GetPaginatedTransactions _getPaginatedTransactions;
  final AddTransaction _addTransaction;
  final UpdateTransaction _updateTransaction;
  final DeleteTransaction _deleteTransaction;

  TransactionNotifier({
    required GetTransactions getTransactions,
    required GetPaginatedTransactions getPaginatedTransactions,
    required AddTransaction addTransaction,
    required UpdateTransaction updateTransaction,
    required DeleteTransaction deleteTransaction,
  })  : _getTransactions = getTransactions,
        _getPaginatedTransactions = getPaginatedTransactions,
        _addTransaction = addTransaction,
        _updateTransaction = updateTransaction,
        _deleteTransaction = deleteTransaction,
        super(const AsyncValue.loading()) {
    loadTransactions();
  }

  /// Load all transactions (legacy method for backward compatibility)
  Future<void> loadTransactions() async {
    debugPrint('TransactionNotifier: Loading transactions');
    state = const AsyncValue.loading();

    final result = await _getTransactions();

    result.when(
      success: (transactions) {
        state = AsyncValue.data(TransactionState(
          transactions: transactions,
          isInitialized: true,
          hasMoreData: false, // All data loaded at once
        ));
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
    );
  }

  /// Initialize with paginated transactions
  Future<void> initializeWithPagination() async {
    debugPrint('TransactionNotifier: Initializing with pagination');
    state = const AsyncValue.loading();

    final result = await _getPaginatedTransactions(
      limit: 20,
      offset: 0,
      filter: null,
    );

    result.when(
      success: (transactions) async {
        // Check if there's more data
        final countResult = await _getPaginatedTransactions.getFilteredCount(null);
        final totalCount = countResult.getOrDefault(0);

        state = AsyncValue.data(TransactionState(
          transactions: transactions,
          isInitialized: true,
          hasMoreData: transactions.length < totalCount,
          currentOffset: transactions.length,
        ));
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
    );
  }

  /// Load more transactions (pagination)
  Future<void> loadMoreTransactions() async {
    final currentState = state.value;
    if (currentState == null || currentState.isLoadingMore || !currentState.hasMoreData) {
      return;
    }

    // Set loading more state
    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final result = await _getPaginatedTransactions(
      limit: currentState.pageSize,
      offset: currentState.currentOffset,
      filter: currentState.filter,
    );

    result.when(
      success: (newTransactions) async {
        if (newTransactions.isEmpty) {
          // No more data
          state = AsyncValue.data(currentState.copyWith(
            isLoadingMore: false,
            hasMoreData: false,
          ));
          return;
        }

        // Check if there's still more data
        final countResult = await _getPaginatedTransactions.getFilteredCount(currentState.filter);
        final totalCount = countResult.getOrDefault(0);
        final allTransactions = [...currentState.transactions, ...newTransactions];

        state = AsyncValue.data(currentState.copyWith(
          transactions: allTransactions,
          isLoadingMore: false,
          hasMoreData: allTransactions.length < totalCount,
          currentOffset: allTransactions.length,
        ));
      },
      error: (failure) {
        state = AsyncValue.data(currentState.copyWith(
          isLoadingMore: false,
          error: failure.message,
        ));
      },
    );
  }

  /// Add a new transaction
  Future<bool> addTransaction(Transaction transaction) async {
    final currentState = state.value;
    if (currentState == null) return false;

    // Set loading state
    state = AsyncValue.data(currentState.copyWith(isLoading: true));

    final result = await _addTransaction(transaction);

    return result.when(
      success: (addedTransaction) {
        // Update with server response
        final updatedTransactions = [addedTransaction, ...currentState.transactions];
        state = AsyncValue.data(currentState.copyWith(
          transactions: updatedTransactions,
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

  /// Update an existing transaction
  Future<bool> updateTransaction(Transaction transaction) async {
    final currentState = state.value;
    if (currentState == null) return false;

    final result = await _updateTransaction(transaction);

    return result.when(
      success: (updatedTransaction) {
        final updatedTransactions = currentState.transactions.map((t) {
          return t.id == transaction.id ? updatedTransaction : t;
        }).toList();
        state = AsyncValue.data(currentState.copyWith(transactions: updatedTransactions));
        return true;
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
    );
  }

  /// Delete a transaction
  Future<bool> deleteTransaction(String transactionId) async {
    final currentState = state.value;
    if (currentState == null) return false;

    final result = await _deleteTransaction(transactionId);

    return result.when(
      success: (_) {
        final updatedTransactions = currentState.transactions
            .where((t) => t.id != transactionId)
            .toList();
        state = AsyncValue.data(currentState.copyWith(transactions: updatedTransactions));
        return true;
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
    );
  }

  /// Search transactions
  void searchTransactions(String query) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(searchQuery: query));
  }

  /// Apply filter
  void applyFilter(TransactionFilter filter) {
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