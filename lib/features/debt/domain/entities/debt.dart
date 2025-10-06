import 'package:freezed_annotation/freezed_annotation.dart';

part 'debt.freezed.dart';

/// Debt entity - represents a debt/liability
/// Pure domain entity with no dependencies
@freezed
class Debt with _$Debt {
  const factory Debt({
    required String id,
    required String name,
    required String description,
    required double amount,
    required double remainingAmount,
    required DebtType type,
    required DebtPriority priority,
    required DateTime dueDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? creditor,
    double? interestRate,
    double? minimumPayment,
    String? accountId, // Linked account for payments
    @Default([]) List<String> tags,
  }) = _Debt;

  const Debt._();

  /// Check if debt is paid off
  bool get isPaidOff => remainingAmount <= 0;

  /// Check if debt is overdue
  bool get isOverdue => DateTime.now().isAfter(dueDate) && !isPaidOff;

  /// Get days remaining until due date
  int get daysRemaining {
    final now = DateTime.now();
    final difference = dueDate.difference(now);
    return difference.inDays;
  }

  /// Calculate monthly interest payment if applicable
  double get monthlyInterestPayment {
    if (interestRate == null || interestRate == 0) return 0.0;
    return (remainingAmount * interestRate! / 100) / 12;
  }

  /// Get total monthly payment (principal + interest)
  double get totalMonthlyPayment {
    return (minimumPayment ?? 0.0) + monthlyInterestPayment;
  }

  /// Calculate payoff progress percentage
  double get payoffProgress {
    if (amount <= 0) return 1.0;
    return ((amount - remainingAmount) / amount).clamp(0.0, 1.0);
  }

  /// Get formatted amount
  String get formattedAmount => '\$${amount.toStringAsFixed(2)}';

  /// Get formatted remaining amount
  String get formattedRemainingAmount => '\$${remainingAmount.toStringAsFixed(2)}';

  /// Get formatted minimum payment
  String get formattedMinimumPayment =>
      minimumPayment != null ? '\$${minimumPayment!.toStringAsFixed(2)}' : 'N/A';
}

/// Debt type enum
enum DebtType {
  creditCard,
  personalLoan,
  studentLoan,
  mortgage,
  carLoan,
  medical,
  other;

  String get displayName {
    switch (this) {
      case DebtType.creditCard:
        return 'Credit Card';
      case DebtType.personalLoan:
        return 'Personal Loan';
      case DebtType.studentLoan:
        return 'Student Loan';
      case DebtType.mortgage:
        return 'Mortgage';
      case DebtType.carLoan:
        return 'Car Loan';
      case DebtType.medical:
        return 'Medical';
      case DebtType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case DebtType.creditCard:
        return 'credit_card';
      case DebtType.personalLoan:
        return 'account_balance_wallet';
      case DebtType.studentLoan:
        return 'school';
      case DebtType.mortgage:
        return 'home';
      case DebtType.carLoan:
        return 'directions_car';
      case DebtType.medical:
        return 'local_hospital';
      case DebtType.other:
        return 'account_balance';
    }
  }

  int get defaultColor {
    switch (this) {
      case DebtType.creditCard:
        return 0xFFDC2626; // Red
      case DebtType.personalLoan:
        return 0xFF059669; // Green
      case DebtType.studentLoan:
        return 0xFF7C3AED; // Purple
      case DebtType.mortgage:
        return 0xFFEA580C; // Orange
      case DebtType.carLoan:
        return 0xFF2563EB; // Blue
      case DebtType.medical:
        return 0xFF7C2D12; // Brown
      case DebtType.other:
        return 0xFF64748B; // Gray
    }
  }
}

/// Debt priority enum
enum DebtPriority {
  low,
  medium,
  high,
  critical;

  String get displayName {
    switch (this) {
      case DebtPriority.low:
        return 'Low';
      case DebtPriority.medium:
        return 'Medium';
      case DebtPriority.high:
        return 'High';
      case DebtPriority.critical:
        return 'Critical';
    }
  }

  int get value {
    switch (this) {
      case DebtPriority.low:
        return 1;
      case DebtPriority.medium:
        return 2;
      case DebtPriority.high:
        return 3;
      case DebtPriority.critical:
        return 4;
    }
  }
}