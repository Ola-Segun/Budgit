import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/debt.dart';

part 'debt_state.freezed.dart';

/// State for debt management
@freezed
class DebtState with _$DebtState {
  const factory DebtState({
    @Default([]) List<Debt> debts,
    @Default([]) List<Debt> filteredDebts,
    @Default([]) List<Debt> activeDebts,
    @Default([]) List<Debt> overdueDebts,
    Debt? selectedDebt,
    String? searchQuery,
    DebtFilter? filter,
    @Default(false) bool isLoading,
    String? error,
  }) = _DebtState;

  const DebtState._();

  /// Get total debt amount
  double get totalDebtAmount => debts.fold(0, (sum, debt) => sum + debt.amount);

  /// Get total remaining amount
  double get totalRemainingAmount => debts.fold(0, (sum, debt) => sum + debt.remainingAmount);

  /// Get monthly payment total
  double get totalMonthlyPayments => debts.fold(0, (sum, debt) => sum + debt.totalMonthlyPayment);

  /// Get debt payoff progress percentage
  double get overallProgressPercentage {
    if (totalDebtAmount <= 0) return 1.0;
    return ((totalDebtAmount - totalRemainingAmount) / totalDebtAmount).clamp(0.0, 1.0);
  }
}

/// Filter options for debt list
enum DebtFilter {
  all,
  active,
  overdue,
  paidOff,
  byType,
  byPriority;

  String get displayName {
    switch (this) {
      case DebtFilter.all:
        return 'All Debts';
      case DebtFilter.active:
        return 'Active';
      case DebtFilter.overdue:
        return 'Overdue';
      case DebtFilter.paidOff:
        return 'Paid Off';
      case DebtFilter.byType:
        return 'By Type';
      case DebtFilter.byPriority:
        return 'By Priority';
    }
  }
}

/// Statistics for debts
@freezed
class DebtStats with _$DebtStats {
  const factory DebtStats({
    @Default(0.0) double totalDebt,
    @Default(0.0) double totalRemaining,
    @Default(0.0) double totalPaid,
    @Default(0) int debtCount,
    @Default(0.0) double averageDebtAmount,
    @Default(0) int overdueCount,
    @Default(0) int activeCount,
  }) = _DebtStats;

  const DebtStats._();

  /// Get debt payoff progress percentage
  double get payoffProgress => totalDebt > 0
      ? ((totalDebt - totalRemaining) / totalDebt).clamp(0.0, 1.0)
      : 0.0;

  /// Get monthly debt load (estimated)
  double get estimatedMonthlyPayment => activeCount > 0
      ? totalRemaining / (activeCount * 12) // Rough estimate
      : 0.0;

  /// Check if user has high debt load
  bool get hasHighDebtLoad => totalDebt > 50000; // Arbitrary threshold

  /// Get debt to income ratio (would need income data)
  double getDebtToIncomeRatio(double monthlyIncome) =>
      monthlyIncome > 0 ? (estimatedMonthlyPayment / monthlyIncome) : 0.0;
}