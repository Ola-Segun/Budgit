import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

/// Account entity - represents a financial account
/// Pure domain entity with no dependencies
@freezed
class Account with _$Account {
  const factory Account({
    required String id,
    required String name,
    required AccountType type,
    required double balance,
    String? description,
    String? institution,
    String? accountNumber,
    @Default('USD') String currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Type-specific fields
    double? creditLimit, // For credit cards
    double? availableCredit, // For credit cards
    double? interestRate, // For loans/investments
    double? minimumPayment, // For loans/credit cards
    DateTime? dueDate, // For loans/credit cards
    @Default(true) bool isActive,
  }) = _Account;

  const Account._();

  /// Check if account is asset (positive balance increases net worth)
  bool get isAsset => type.isAsset;

  /// Check if account is liability (negative balance increases net worth)
  bool get isLiability => type.isLiability;

  /// Get current balance (for liabilities, this is the amount owed)
  double get currentBalance => balance;

  /// Get available balance (for credit cards, this is credit limit - balance)
  double get availableBalance {
    if (type == AccountType.creditCard && creditLimit != null) {
      return creditLimit! - balance;
    }
    return balance;
  }

  /// Get utilization rate for credit cards
  double? get utilizationRate {
    if (type == AccountType.creditCard && creditLimit != null && creditLimit! > 0) {
      return (balance / creditLimit!).clamp(0.0, 1.0);
    }
    return null;
  }

  /// Check if account is overdrawn (for checking/savings)
  bool get isOverdrawn => type == AccountType.bankAccount && balance < 0;

  /// Check if credit card is over limit
  bool get isOverLimit => type == AccountType.creditCard && creditLimit != null && balance > creditLimit!;

  /// Get display name with institution
  String get displayName => institution != null ? '$name ($institution)' : name;

  /// Get formatted balance with currency
  String get formattedBalance => '${isLiability ? '-' : ''}$currency ${currentBalance.abs().toStringAsFixed(2)}';

  /// Get formatted available balance
  String get formattedAvailableBalance => '$currency ${availableBalance.toStringAsFixed(2)}';
}

/// Account type enum
enum AccountType {
  bankAccount,
  creditCard,
  loan,
  investment,
  manualAccount;

  String get displayName {
    switch (this) {
      case AccountType.bankAccount:
        return 'Bank Account';
      case AccountType.creditCard:
        return 'Credit Card';
      case AccountType.loan:
        return 'Loan';
      case AccountType.investment:
        return 'Investment';
      case AccountType.manualAccount:
        return 'Manual Account';
    }
  }

  String get icon {
    switch (this) {
      case AccountType.bankAccount:
        return 'account_balance';
      case AccountType.creditCard:
        return 'credit_card';
      case AccountType.loan:
        return 'account_balance_wallet';
      case AccountType.investment:
        return 'trending_up';
      case AccountType.manualAccount:
        return 'edit';
    }
  }

  int get color {
    switch (this) {
      case AccountType.bankAccount:
        return 0xFF10B981; // Green
      case AccountType.creditCard:
        return 0xFF3B82F6; // Blue
      case AccountType.loan:
        return 0xFFEF4444; // Red
      case AccountType.investment:
        return 0xFF8B5CF6; // Purple
      case AccountType.manualAccount:
        return 0xFF64748B; // Gray
    }
  }

  /// Check if this account type represents an asset
  bool get isAsset => this == AccountType.bankAccount || this == AccountType.investment || this == AccountType.manualAccount;

  /// Check if this account type represents a liability
  bool get isLiability => this == AccountType.creditCard || this == AccountType.loan;
}