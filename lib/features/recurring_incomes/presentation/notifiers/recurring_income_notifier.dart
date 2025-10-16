import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/recurring_income.dart';
import '../../domain/repositories/recurring_income_repository.dart';
import '../../domain/usecases/create_recurring_income.dart';
import '../../domain/usecases/get_recurring_incomes.dart';
import '../../domain/usecases/record_income_receipt.dart';
import '../states/recurring_income_state.dart';

/// State notifier for recurring income management
class RecurringIncomeNotifier extends StateNotifier<RecurringIncomeState> {
  final GetRecurringIncomes _getRecurringIncomes;
  final CreateRecurringIncome _createRecurringIncome;
  final RecordIncomeReceipt _recordIncomeReceipt;

  // Repository access for direct operations
  late final RecurringIncomeRepository _repository;

  RecurringIncomeNotifier({
    required GetRecurringIncomes getRecurringIncomes,
    required CreateRecurringIncome createRecurringIncome,
    required RecordIncomeReceipt recordIncomeReceipt,
    required RecurringIncomeRepository repository,
  })  : _getRecurringIncomes = getRecurringIncomes,
        _createRecurringIncome = createRecurringIncome,
        _recordIncomeReceipt = recordIncomeReceipt,
        _repository = repository,
        super(const RecurringIncomeState.initial()) {
    loadIncomes();
  }

  /// Load all recurring incomes and summary
  Future<void> loadIncomes() async {
    debugPrint('RecurringIncomeNotifier: Loading recurring incomes - current state: ${state.runtimeType}');
    final previousState = state;
    state = const RecurringIncomeState.loading();

    final incomesResult = await _getRecurringIncomes();

    incomesResult.when(
      success: (incomes) {
        debugPrint('RecurringIncomeNotifier: Successfully loaded ${incomes.length} recurring incomes');
        // Calculate summary
        final summary = _calculateSummary(incomes);
        debugPrint('RecurringIncomeNotifier: Calculated summary - total: ${summary.totalIncomes}, active: ${summary.activeIncomes}, expected: ${summary.expectedThisMonth}');
        final newState = RecurringIncomeState.loaded(
          incomes: incomes,
          summary: summary,
        );
        state = newState;
        debugPrint('RecurringIncomeNotifier: State updated from ${previousState.runtimeType} to ${newState.runtimeType}');
      },
      error: (failure) {
        debugPrint('RecurringIncomeNotifier: Failed to load recurring incomes - error: ${failure.message}');
        state = RecurringIncomeState.error(message: failure.message);
        debugPrint('RecurringIncomeNotifier: State updated to error state');
      },
    );
  }

  /// Create a new recurring income
  Future<bool> createIncome(RecurringIncome income) async {
    debugPrint('RecurringIncomeNotifier: Creating recurring income - name: ${income.name}, amount: ${income.amount}, frequency: ${income.frequency}');
    debugPrint('RecurringIncomeNotifier: Current state before creation: ${state.runtimeType}');
    final result = await _createRecurringIncome(income);

    return result.when(
      success: (createdIncome) {
        debugPrint('RecurringIncomeNotifier: Recurring income created successfully - id: ${createdIncome.id}');
        final previousState = state;
        state = RecurringIncomeState.incomeSaved(income: createdIncome);
        debugPrint('RecurringIncomeNotifier: State updated from ${previousState.runtimeType} to incomeSaved');
        debugPrint('RecurringIncomeNotifier: Refreshing income list after creation');
        loadIncomes(); // Refresh the list
        return true;
      },
      error: (failure) {
        debugPrint('RecurringIncomeNotifier: Failed to create recurring income - error: ${failure.message}');
        final previousState = state;
        state = RecurringIncomeState.error(message: failure.message);
        debugPrint('RecurringIncomeNotifier: State updated from ${previousState.runtimeType} to error');
        return false;
      },
    );
  }

  /// Record income receipt
  Future<bool> recordIncomeReceipt(
    String incomeId,
    RecurringIncomeInstance instance, {
    String? accountId,
  }) async {
    debugPrint('RecurringIncomeNotifier: Recording income receipt - incomeId: $incomeId, amount: ${instance.amount}, accountId: $accountId');
    debugPrint('RecurringIncomeNotifier: Current state before receipt recording: ${state.runtimeType}');
    final result = await _recordIncomeReceipt(incomeId, instance, accountId: accountId);

    return result.when(
      success: (updatedIncome) {
        debugPrint('RecurringIncomeNotifier: Income receipt recorded successfully - updated income: ${updatedIncome.name}');
        debugPrint('RecurringIncomeNotifier: Income history now has ${updatedIncome.incomeHistory.length} entries');
        final previousState = state;
        state = RecurringIncomeState.receiptRecorded(income: updatedIncome);
        debugPrint('RecurringIncomeNotifier: State updated from ${previousState.runtimeType} to receiptRecorded');
        debugPrint('RecurringIncomeNotifier: Refreshing income list after receipt recording');
        loadIncomes(); // Refresh the list
        return true;
      },
      error: (failure) {
        debugPrint('RecurringIncomeNotifier: Failed to record income receipt - error: ${failure.message}');
        final previousState = state;
        state = RecurringIncomeState.error(message: failure.message);
        debugPrint('RecurringIncomeNotifier: State updated from ${previousState.runtimeType} to error');
        return false;
      },
    );
  }

  /// Update an existing recurring income
  Future<bool> updateIncome(RecurringIncome income) async {
    // For now, we'll use the repository directly since we don't have an update use case
    // TODO: Create UpdateRecurringIncome use case
    final result = await _repository.update(income);

    return result.when(
      success: (updatedIncome) {
        state = RecurringIncomeState.incomeSaved(income: updatedIncome);
        loadIncomes(); // Refresh the list
        return true;
      },
      error: (failure) {
        state = RecurringIncomeState.error(message: failure.message);
        return false;
      },
    );
  }

  /// Delete a recurring income
  Future<bool> deleteIncome(String incomeId) async {
    // For now, we'll use the repository directly since we don't have a delete use case
    // TODO: Create DeleteRecurringIncome use case
    final result = await _repository.delete(incomeId);

    return result.when(
      success: (_) {
        state = RecurringIncomeState.incomeDeleted();
        loadIncomes(); // Refresh the list
        return true;
      },
      error: (failure) {
        state = RecurringIncomeState.error(message: failure.message);
        return false;
      },
    );
  }

  /// Calculate summary from incomes
  RecurringIncomesSummary _calculateSummary(List<RecurringIncome> incomes) {
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);

    // Calculate metrics
    final totalIncomes = incomes.length;
    final activeIncomes = incomes.where((income) => !income.hasEnded).length;

    final expectedThisMonth = incomes.where((income) {
      if (income.nextExpectedDate == null) return false;
      final expectedMonth = DateTime(income.nextExpectedDate!.year, income.nextExpectedDate!.month);
      return expectedMonth == currentMonth;
    }).length;

    final totalMonthlyAmount = incomes.fold<double>(0.0, (sum, income) => sum + income.amount);
    final receivedThisMonth = incomes.fold<double>(0.0, (sum, income) {
      return sum + income.incomeHistory.where((instance) {
        final receivedMonth = DateTime(instance.receivedDate.year, instance.receivedDate.month);
        return receivedMonth == currentMonth;
      }).fold(0.0, (sum, instance) => sum + instance.amount);
    });
    final expectedAmount = incomes.fold<double>(0.0, (sum, income) {
      if (income.nextExpectedDate != null) {
        final expectedMonth = DateTime(income.nextExpectedDate!.year, income.nextExpectedDate!.month);
        if (expectedMonth == currentMonth) {
          return sum + income.amount;
        }
      }
      return sum;
    });

    // Get upcoming incomes (next 30 days)
    final upcomingIncomes = incomes.where((income) {
      if (income.nextExpectedDate == null) return false;
      final daysUntilExpected = income.nextExpectedDate!.difference(now).inDays;
      return daysUntilExpected >= 0 && daysUntilExpected <= 30;
    }).take(5).map((income) {
      // Create status for each income
      final daysUntilExpected = income.nextExpectedDate!.difference(now).inDays;
      final isExpectedSoon = daysUntilExpected <= 7;
      final isExpectedToday = daysUntilExpected == 0;
      final isOverdue = daysUntilExpected < 0;

      RecurringIncomeUrgency urgency;
      if (isOverdue) {
        urgency = RecurringIncomeUrgency.overdue;
      } else if (isExpectedToday) {
        urgency = RecurringIncomeUrgency.expectedToday;
      } else if (isExpectedSoon) {
        urgency = RecurringIncomeUrgency.expectedSoon;
      } else {
        urgency = RecurringIncomeUrgency.normal;
      }

      return RecurringIncomeStatus(
        income: income,
        daysUntilExpected: daysUntilExpected,
        isExpectedSoon: isExpectedSoon,
        isExpectedToday: isExpectedToday,
        isOverdue: isOverdue,
        urgency: urgency,
      );
    }).toList();

    return RecurringIncomesSummary(
      totalIncomes: totalIncomes,
      activeIncomes: activeIncomes,
      expectedThisMonth: expectedThisMonth,
      totalMonthlyAmount: totalMonthlyAmount,
      receivedThisMonth: receivedThisMonth,
      expectedAmount: expectedAmount,
      upcomingIncomes: upcomingIncomes,
    );
  }

  /// Refresh incomes data
  Future<void> refresh() async {
    await loadIncomes();
  }

  /// Clear error state
  Future<void> clearError() async {
    await loadIncomes();
  }
}