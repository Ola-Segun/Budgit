import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';

part 'bill.freezed.dart';

/// Bill entity representing recurring payments
@freezed
class Bill with _$Bill {
  const factory Bill({
    required String id,
    required String name,
    required double amount,
    required DateTime dueDate,
    required BillFrequency frequency,
    required String categoryId,
    String? description,
    String? payee,
    String? accountId,
    @Default(false) bool isAutoPay,
    @Default(false) bool isPaid,
    DateTime? lastPaidDate,
    DateTime? nextDueDate,
    String? website,
    String? notes,
    @Default(BillDifficulty.easy) BillDifficulty cancellationDifficulty,
    DateTime? lastPriceIncrease,
    @Default([]) List<BillPayment> paymentHistory,
  }) = _Bill;

  const Bill._();

  /// Calculate days until due
  int get daysUntilDue {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(dueDate.year, dueDate.month, dueDate.day);
    return dueDay.difference(today).inDays;
  }

  /// Check if bill is overdue
  bool get isOverdue => daysUntilDue < 0 && !isPaid;

  /// Check if bill is due soon (within 3 days)
  bool get isDueSoon => daysUntilDue >= 0 && daysUntilDue <= 3;

  /// Check if bill is due today
  bool get isDueToday => daysUntilDue == 0;

  /// Calculate next due date based on frequency
  DateTime get calculatedNextDueDate {
    if (nextDueDate != null) return nextDueDate!;

    switch (frequency) {
      case BillFrequency.weekly:
        return dueDate.add(const Duration(days: 7));
      case BillFrequency.biWeekly:
        return dueDate.add(const Duration(days: 14));
      case BillFrequency.monthly:
        return DateTime(dueDate.year, dueDate.month + 1, dueDate.day);
      case BillFrequency.quarterly:
        return DateTime(dueDate.year, dueDate.month + 3, dueDate.day);
      case BillFrequency.annually:
        return DateTime(dueDate.year + 1, dueDate.month, dueDate.day);
      case BillFrequency.custom:
        // For custom frequency, return due date as-is (would need custom logic)
        return dueDate;
    }
  }

  /// Get total amount paid in payment history
  double get totalPaid => paymentHistory.fold(0.0, (sum, payment) => sum + payment.amount);

  /// Get average payment amount
  double get averagePayment => paymentHistory.isEmpty
      ? amount
      : paymentHistory.fold(0.0, (sum, payment) => sum + payment.amount) / paymentHistory.length;

  /// Check if bill has payment history
  bool get hasPaymentHistory => paymentHistory.isNotEmpty;

  /// Validate bill data
  Result<Bill> validate() {
    if (name.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Bill name cannot be empty',
        {'name': 'Name is required'},
      ));
    }

    if (amount <= 0) {
      return Result.error(Failure.validation(
        'Bill amount must be greater than zero',
        {'amount': 'Amount must be positive'},
      ));
    }

    if (categoryId.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Category ID cannot be empty',
        {'categoryId': 'Category is required'},
      ));
    }

    return Result.success(this);
  }
}

/// Bill payment record
@freezed
class BillPayment with _$BillPayment {
  const factory BillPayment({
    required String id,
    required double amount,
    required DateTime paymentDate,
    String? transactionId,
    String? notes,
    @Default(PaymentMethod.other) PaymentMethod method,
  }) = _BillPayment;

  const BillPayment._();

  /// Validate payment data
  Result<BillPayment> validate() {
    if (amount <= 0) {
      return Result.error(Failure.validation(
        'Payment amount must be greater than zero',
        {'amount': 'Amount must be positive'},
      ));
    }

    if (paymentDate.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      return Result.error(Failure.validation(
        'Payment date cannot be in the future',
        {'paymentDate': 'Date cannot be in the future'},
      ));
    }

    return Result.success(this);
  }
}

/// Bill frequency enumeration
enum BillFrequency {
  weekly('Weekly'),
  biWeekly('Bi-weekly'),
  monthly('Monthly'),
  quarterly('Quarterly'),
  annually('Annually'),
  custom('Custom');

  const BillFrequency(this.displayName);

  final String displayName;

  /// Get frequency in days
  int get days {
    switch (this) {
      case BillFrequency.weekly:
        return 7;
      case BillFrequency.biWeekly:
        return 14;
      case BillFrequency.monthly:
        return 30; // Approximate
      case BillFrequency.quarterly:
        return 90; // Approximate
      case BillFrequency.annually:
        return 365; // Approximate
      case BillFrequency.custom:
        return 0; // Custom logic needed
    }
  }
}

/// Payment method enumeration
enum PaymentMethod {
  creditCard('Credit Card'),
  debitCard('Debit Card'),
  bankTransfer('Bank Transfer'),
  check('Check'),
  cash('Cash'),
  other('Other');

  const PaymentMethod(this.displayName);

  final String displayName;
}

/// Bill cancellation difficulty
enum BillDifficulty {
  easy('Easy'),
  moderate('Moderate'),
  difficult('Difficult');

  const BillDifficulty(this.displayName);

  final String displayName;

  /// Get color for difficulty level
  String get color {
    switch (this) {
      case BillDifficulty.easy:
        return '#10B981'; // Green
      case BillDifficulty.moderate:
        return '#F59E0B'; // Yellow
      case BillDifficulty.difficult:
        return '#EF4444'; // Red
    }
  }
}

/// Bill status summary
@freezed
class BillStatus with _$BillStatus {
  const factory BillStatus({
    required Bill bill,
    required int daysUntilDue,
    required bool isOverdue,
    required bool isDueSoon,
    required bool isDueToday,
    required BillUrgency urgency,
  }) = _BillStatus;

  const BillStatus._();
}

/// Bill urgency level
enum BillUrgency {
  normal('Normal'),
  dueSoon('Due Soon'),
  dueToday('Due Today'),
  overdue('Overdue');

  const BillUrgency(this.displayName);

  final String displayName;

  /// Get color for urgency level
  String get color {
    switch (this) {
      case BillUrgency.normal:
        return '#6B7280'; // Gray
      case BillUrgency.dueSoon:
        return '#F59E0B'; // Yellow
      case BillUrgency.dueToday:
        return '#EF4444'; // Red
      case BillUrgency.overdue:
        return '#DC2626'; // Dark Red
    }
  }
}

/// Subscription entity - special type of bill with cancellation tracking
@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    required String id,
    required String name,
    required double amount,
    required DateTime dueDate,
    required BillFrequency frequency,
    required String categoryId,
    String? description,
    String? payee,
    String? accountId,
    @Default(false) bool isAutoPay,
    @Default(false) bool isPaid,
    DateTime? lastPaidDate,
    DateTime? nextDueDate,
    String? website,
    String? notes,
    @Default(BillDifficulty.easy) BillDifficulty cancellationDifficulty,
    DateTime? lastPriceIncrease,
    @Default([]) List<BillPayment> paymentHistory,
    // Subscription-specific fields
    @Default(false) bool isCancelled,
    DateTime? cancellationDate,
    String? cancellationReason,
    @Default([]) List<String> alternativeProviders,
    DateTime? trialEndDate,
    @Default(false) bool hasFreeTrial,
  }) = _Subscription;

  const Subscription._();

  /// Convert to Bill entity
  Bill toBill() {
    return Bill(
      id: id,
      name: name,
      amount: amount,
      dueDate: dueDate,
      frequency: frequency,
      categoryId: categoryId,
      description: description,
      payee: payee,
      accountId: accountId,
      isAutoPay: isAutoPay,
      isPaid: isPaid,
      lastPaidDate: lastPaidDate,
      nextDueDate: nextDueDate,
      website: website,
      notes: notes,
      cancellationDifficulty: cancellationDifficulty,
      lastPriceIncrease: lastPriceIncrease,
      paymentHistory: paymentHistory,
    );
  }

  /// Create from Bill entity
  factory Subscription.fromBill(Bill bill) {
    return Subscription(
      id: bill.id,
      name: bill.name,
      amount: bill.amount,
      dueDate: bill.dueDate,
      frequency: bill.frequency,
      categoryId: bill.categoryId,
      description: bill.description,
      payee: bill.payee,
      accountId: bill.accountId,
      isAutoPay: bill.isAutoPay,
      isPaid: bill.isPaid,
      lastPaidDate: bill.lastPaidDate,
      nextDueDate: bill.nextDueDate,
      website: bill.website,
      notes: bill.notes,
      cancellationDifficulty: bill.cancellationDifficulty,
      lastPriceIncrease: bill.lastPriceIncrease,
      paymentHistory: bill.paymentHistory,
    );
  }

  /// Calculate days until due
  int get daysUntilDue => toBill().daysUntilDue;

  /// Check if subscription is overdue
  bool get isOverdue => toBill().isOverdue;

  /// Check if subscription is due soon
  bool get isDueSoon => toBill().isDueSoon;

  /// Check if subscription is due today
  bool get isDueToday => toBill().isDueToday;

  /// Calculate next due date based on frequency
  DateTime get calculatedNextDueDate => toBill().calculatedNextDueDate;

  /// Get total amount paid in payment history
  double get totalPaid => toBill().totalPaid;

  /// Get average payment amount
  double get averagePayment => toBill().averagePayment;

  /// Check if subscription has payment history
  bool get hasPaymentHistory => toBill().hasPaymentHistory;

  /// Validate subscription data
  Result<Subscription> validate() {
    final billResult = toBill().validate();
    if (billResult.isError) {
      return Result.error(billResult.failureOrNull!);
    }

    if (isCancelled && cancellationDate == null) {
      return Result.error(Failure.validation(
        'Cancellation date is required when subscription is cancelled',
        {'cancellationDate': 'Required when cancelled'},
      ));
    }

    return Result.success(this);
  }
}

/// Bills summary for dashboard
@freezed
class BillsSummary with _$BillsSummary {
  const factory BillsSummary({
    required int totalBills,
    required int paidThisMonth,
    required int dueThisMonth,
    required int overdue,
    required double totalMonthlyAmount,
    required double paidAmount,
    required double remainingAmount,
    required List<BillStatus> upcomingBills,
  }) = _BillsSummary;

  const BillsSummary._();

  /// Calculate payment progress percentage
  double get paymentProgress => totalMonthlyAmount > 0
      ? (paidAmount / totalMonthlyAmount).clamp(0.0, 1.0)
      : 0.0;
}