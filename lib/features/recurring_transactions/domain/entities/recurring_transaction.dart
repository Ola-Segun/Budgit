import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurring_transaction.freezed.dart';

/// Recurring transaction entity for automated financial management
@freezed
class RecurringTransaction with _$RecurringTransaction {
  const factory RecurringTransaction({
    required String id,
    required String title,
    required double amount,
    required RecurrenceType recurrenceType,
    required int recurrenceValue, // e.g., every 2 weeks, every 3 months
    required DateTime startDate,
    DateTime? endDate, // null means indefinite
    required String categoryId,
    required String accountId,
    String? description,
    @Default(true) bool isActive,
    @Default('USD') String currencyCode,
    DateTime? lastProcessedDate,
    DateTime? nextDueDate,
    @Default([]) List<String> tags,
  }) = _RecurringTransaction;

  const RecurringTransaction._();

  /// Check if transaction should be processed on given date
  bool shouldProcessOn(DateTime date) {
    if (!isActive) return false;
    if (date.isBefore(startDate)) return false;
    if (endDate != null && date.isAfter(endDate!)) return false;

    final daysSinceStart = date.difference(startDate).inDays;

    switch (recurrenceType) {
      case RecurrenceType.daily:
        return daysSinceStart % recurrenceValue == 0;
      case RecurrenceType.weekly:
        final weeksSinceStart = daysSinceStart ~/ 7;
        return weeksSinceStart % recurrenceValue == 0 && date.weekday == startDate.weekday;
      case RecurrenceType.monthly:
        final monthsSinceStart = (date.year - startDate.year) * 12 + (date.month - startDate.month);
        return monthsSinceStart % recurrenceValue == 0 && date.day == startDate.day;
      case RecurrenceType.yearly:
        final yearsSinceStart = date.year - startDate.year;
        return yearsSinceStart % recurrenceValue == 0 &&
               date.month == startDate.month &&
               date.day == startDate.day;
    }
  }

  /// Calculate next due date after given date
  DateTime? calculateNextDueDate(DateTime afterDate) {
    if (!isActive) return null;
    if (endDate != null && afterDate.isAfter(endDate!)) return null;

    DateTime current = afterDate.isAfter(startDate) ? afterDate : startDate;

    switch (recurrenceType) {
      case RecurrenceType.daily:
        final daysToAdd = recurrenceValue - (current.difference(startDate).inDays % recurrenceValue);
        return current.add(Duration(days: daysToAdd));

      case RecurrenceType.weekly:
        final weeksSinceStart = current.difference(startDate).inDays ~/ 7;
        final nextOccurrence = weeksSinceStart + recurrenceValue;
        final daysToAdd = (nextOccurrence * 7) - current.difference(startDate).inDays;
        return startDate.add(Duration(days: daysToAdd));

      case RecurrenceType.monthly:
        final start = DateTime(startDate.year, startDate.month, startDate.day);
        DateTime next = start;
        while (next.isBefore(current) || next.isAtSameMomentAs(current)) {
          next = DateTime(
            next.year,
            next.month + recurrenceValue,
            next.day,
          );
        }
        return next;

      case RecurrenceType.yearly:
        final start = DateTime(startDate.year, startDate.month, startDate.day);
        DateTime next = start;
        while (next.isBefore(current) || next.isAtSameMomentAs(current)) {
          next = DateTime(
            next.year + recurrenceValue,
            next.month,
            next.day,
          );
        }
        return next;
    }
  }

  /// Get human-readable recurrence description
  String get recurrenceDescription {
    final value = recurrenceValue;
    final type = recurrenceType.name.toLowerCase();

    if (value == 1) {
      return 'Every $type';
    } else {
      return 'Every $value ${type}s';
    }
  }

  /// Check if recurring transaction is expired
  bool get isExpired => endDate != null && DateTime.now().isAfter(endDate!);

  /// Check if transaction is due
  bool get isDue => nextDueDate != null && DateTime.now().isAfter(nextDueDate!);
}

/// Recurrence type for recurring transactions
enum RecurrenceType {
  daily,
  weekly,
  monthly,
  yearly;

  String get displayName {
    switch (this) {
      case RecurrenceType.daily:
        return 'Daily';
      case RecurrenceType.weekly:
        return 'Weekly';
      case RecurrenceType.monthly:
        return 'Monthly';
      case RecurrenceType.yearly:
        return 'Yearly';
    }
  }
}

/// Transaction generated from a recurring transaction
@freezed
class GeneratedTransaction with _$GeneratedTransaction {
  const factory GeneratedTransaction({
    required String id,
    required String recurringTransactionId,
    required String transactionId, // ID of the actual transaction
    required DateTime generatedDate,
    required DateTime dueDate,
    @Default(false) bool isProcessed,
  }) = _GeneratedTransaction;

  const GeneratedTransaction._();
}