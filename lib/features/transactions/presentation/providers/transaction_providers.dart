import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart' as core_providers;
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/add_transaction.dart';
import '../../domain/usecases/delete_transaction.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/update_transaction.dart';
import '../notifiers/transaction_notifier.dart';
import '../states/transaction_state.dart';

/// Provider for transaction categories
final transactionCategoriesProvider = Provider<List<TransactionCategory>>((ref) {
  return TransactionCategory.defaultCategories;
});

/// Provider for GetTransactions use case
final getTransactionsProvider = Provider<GetTransactions>((ref) {
  return ref.read(core_providers.getTransactionsProvider);
});

/// Provider for AddTransaction use case
final addTransactionProvider = Provider<AddTransaction>((ref) {
  return ref.read(core_providers.addTransactionProvider);
});

/// Provider for UpdateTransaction use case
final updateTransactionProvider = Provider<UpdateTransaction>((ref) {
  return ref.read(core_providers.updateTransactionProvider);
});

/// Provider for DeleteTransaction use case
final deleteTransactionProvider = Provider<DeleteTransaction>((ref) {
  return ref.read(core_providers.deleteTransactionProvider);
});

/// State notifier provider for transaction state management
final transactionNotifierProvider =
    StateNotifierProvider<TransactionNotifier, AsyncValue<TransactionState>>((ref) {
  final getTransactions = ref.watch(getTransactionsProvider);
  final addTransaction = ref.watch(addTransactionProvider);
  final updateTransaction = ref.watch(updateTransactionProvider);
  final deleteTransaction = ref.watch(deleteTransactionProvider);

  return TransactionNotifier(
    getTransactions: getTransactions,
    addTransaction: addTransaction,
    updateTransaction: updateTransaction,
    deleteTransaction: deleteTransaction,
  );
});

/// Provider for filtered transactions
final filteredTransactionsProvider = Provider<AsyncValue<List<Transaction>>>((ref) {
  debugPrint('filteredTransactionsProvider: Computing filtered transactions');
  final transactionState = ref.watch(transactionNotifierProvider);
  debugPrint('filteredTransactionsProvider: Watched transactionNotifierProvider');

  return transactionState.when(
    data: (state) {
      // Apply any filters here if needed
      return AsyncValue.data(state.filteredTransactions);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for transaction statistics
final transactionStatsProvider = Provider<AsyncValue<TransactionStats>>((ref) {
  final transactionState = ref.watch(transactionNotifierProvider);

  return transactionState.when(
    data: (state) {
      final transactions = state.transactions;

      final totalIncome = transactions
          .where((t) => t.type == TransactionType.income)
          .fold<double>(0, (sum, t) => sum + t.amount);

      final totalExpenses = transactions
          .where((t) => t.type == TransactionType.expense)
          .fold<double>(0, (sum, t) => sum + t.amount);

      final transactionCount = transactions.length;

      final averageTransactionAmount = transactionCount > 0
          ? (totalIncome + totalExpenses) / transactionCount
          : 0.0;

      final largestExpense = transactions
          .where((t) => t.type == TransactionType.expense)
          .fold<double>(0, (max, t) => t.amount > max ? t.amount : max);

      final stats = TransactionStats(
        totalIncome: totalIncome,
        totalExpenses: totalExpenses,
        netAmount: totalIncome - totalExpenses,
        transactionCount: transactionCount,
        averageTransactionAmount: averageTransactionAmount,
        largestExpense: largestExpense,
      );

      return AsyncValue.data(stats);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});