import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import 'recurring_income_instance.dart';
export 'recurring_income_instance.dart';

part 'recurring_income.freezed.dart';

/// RecurringIncome entity representing recurring income sources
@freezed
class RecurringIncome with _$RecurringIncome {
  const factory RecurringIncome({
    required String id,
    required String name,
    required double amount,
    required DateTime startDate,
    required RecurringIncomeFrequency frequency,
    required String categoryId,
    String? description,
    String? payer,
    DateTime? endDate, // Optional end date for temporary incomes
    String? website,
    String? notes,
    // ═══ ACCOUNT RELATIONSHIP ═══
    String? defaultAccountId, // Primary account for deposits
    List<String>? allowedAccountIds, // Alternative accounts for deposits
    String? accountId, // Legacy field for backward compatibility
    // ═══ VARIABLE AMOUNT SUPPORT ═══
    @Default(false) bool isVariableAmount,
    double? minAmount,
    double? maxAmount,
    // ═══ CURRENCY SUPPORT ═══
    String? currencyCode,
    // ═══ RECURRING FLEXIBILITY ═══
    @Default([]) List<RecurringIncomeRule> recurringIncomeRules,
    // ═══ TRACKING ═══
    @Default([]) List<RecurringIncomeInstance> incomeHistory,
    DateTime? lastReceivedDate,
    DateTime? nextExpectedDate,
  }) = _RecurringIncome;

  const RecurringIncome._();

  /// Calculate days until next expected income
  int get daysUntilNextExpected {
    if (nextExpectedDate == null) return -1;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expectedDay = DateTime(nextExpectedDate!.year, nextExpectedDate!.month, nextExpectedDate!.day);
    return expectedDay.difference(today).inDays;
  }

  /// Backwards-compatible alias used in other modules
  int get daysUntilExpected => daysUntilNextExpected;

  /// Check if income is expected soon (within 3 days)
  bool get isExpectedSoon => daysUntilNextExpected >= 0 && daysUntilNextExpected <= 3;

  /// Check if income is expected today
  bool get isExpectedToday => daysUntilNextExpected == 0;

  /// Check if income is overdue (expected date has passed)
  bool get isOverdue => daysUntilNextExpected < 0;

  /// Check if income has ended
  bool get hasEnded => endDate != null && DateTime.now().isAfter(endDate!);

  /// Calculate next expected date based on frequency
  DateTime get calculatedNextExpectedDate {
    if (nextExpectedDate != null) return nextExpectedDate!;

    final baseDate = lastReceivedDate ?? startDate;

    switch (frequency) {
      case RecurringIncomeFrequency.daily:
        return baseDate.add(const Duration(days: 1));
      case RecurringIncomeFrequency.weekly:
        return baseDate.add(const Duration(days: 7));
      case RecurringIncomeFrequency.biWeekly:
        return baseDate.add(const Duration(days: 14));
      case RecurringIncomeFrequency.monthly:
        return DateTime(baseDate.year, baseDate.month + 1, baseDate.day);
      case RecurringIncomeFrequency.quarterly:
        return DateTime(baseDate.year, baseDate.month + 3, baseDate.day);
      case RecurringIncomeFrequency.annually:
        return DateTime(baseDate.year + 1, baseDate.month, baseDate.day);
      case RecurringIncomeFrequency.custom:
        // For custom frequency, return base date as-is (would need custom logic)
        return baseDate;
    }
  }

  /// Get total amount received in income history
  double get totalReceived => incomeHistory.fold(0.0, (sum, income) => sum + income.amount);

  /// Get average income amount
  double get averageIncome => incomeHistory.isEmpty
      ? amount
      : incomeHistory.fold(0.0, (sum, income) => sum + income.amount) / incomeHistory.length;

  /// Check if income has history
  bool get hasIncomeHistory => incomeHistory.isNotEmpty;

  /// Get effective account ID (prioritizes defaultAccountId, falls back to accountId)
  String? get effectiveAccountId => defaultAccountId ?? accountId;

  /// Get all allowed account IDs (combines default and allowed accounts)
  List<String> get allAllowedAccountIds {
    final accounts = <String>[];
    if (defaultAccountId != null) accounts.add(defaultAccountId!);
    if (allowedAccountIds != null) accounts.addAll(allowedAccountIds!);
    if (accountId != null && !accounts.contains(accountId!)) accounts.add(accountId!);
    return accounts;
  }

  /// Check if account is allowed for this income
  bool isAccountAllowed(String accountId) {
    return allAllowedAccountIds.contains(accountId);
  }

  /// Get income amount for specific instance (considering variable amounts and recurring rules)
  double getIncomeAmountForInstance(int instanceNumber) {
    // Check recurring income rules first
    final rule = recurringIncomeRules
        .where((rule) => rule.instanceNumber == instanceNumber && rule.isEnabled)
        .firstOrNull;

    if (rule != null && rule.amount != null) {
      return rule.amount!;
    }

    // For variable amount incomes, return current amount
    if (isVariableAmount) {
      return amount;
    }

    return amount;
  }

  /// Get account for specific instance (considering recurring rules)
  String? getAccountForInstance(int instanceNumber) {
    // Check recurring income rules first
    final rule = recurringIncomeRules
        .where((rule) => rule.instanceNumber == instanceNumber && rule.isEnabled)
        .firstOrNull;

    if (rule != null && rule.accountId != null) {
      return rule.accountId;
    }

    // Return default account
    return effectiveAccountId;
  }

  /// Validate recurring income data
  Result<RecurringIncome> validate() {
    if (name.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Income name cannot be empty',
        {'name': 'Name is required'},
      ));
    }

    if (amount <= 0) {
      return Result.error(Failure.validation(
        'Income amount must be greater than zero',
        {'amount': 'Amount must be positive'},
      ));
    }

    if (categoryId.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Category ID cannot be empty',
        {'categoryId': 'Category is required'},
      ));
    }

    if (startDate.isAfter(DateTime.now())) {
      return Result.error(Failure.validation(
        'Start date cannot be in the future',
        {'startDate': 'Must be today or earlier'},
      ));
    }

    if (endDate != null && endDate!.isBefore(startDate)) {
      return Result.error(Failure.validation(
        'End date must be after start date',
        {'endDate': 'Must be after start date'},
      ));
    }

    // Validate variable amount constraints
    if (isVariableAmount) {
      if (minAmount != null && maxAmount != null && minAmount! >= maxAmount!) {
        return Result.error(Failure.validation(
          'Minimum amount must be less than maximum amount',
          {'minAmount': 'Must be < maxAmount', 'maxAmount': 'Must be > minAmount'},
        ));
      }

      if (minAmount != null && minAmount! <= 0) {
        return Result.error(Failure.validation(
          'Minimum amount must be positive',
          {'minAmount': 'Must be > 0'},
        ));
      }

      if (maxAmount != null && maxAmount! <= 0) {
        return Result.error(Failure.validation(
          'Maximum amount must be positive',
          {'maxAmount': 'Must be > 0'},
        ));
      }
    }

    // Validate recurring income rules
    for (final rule in recurringIncomeRules) {
      final ruleResult = rule.validate();
      if (ruleResult.isError) {
        return Result.error(Failure.validation(
          'Invalid recurring income rule: ${ruleResult.failureOrNull!.message}',
          {'recurringIncomeRules': (ruleResult.failureOrNull as ValidationFailure?)?.errors ?? {}},
        ));
      }
    }

    return Result.success(this);
  }
}


/// Recurring income frequency enumeration
enum RecurringIncomeFrequency {
  daily('Daily'),
  weekly('Weekly'),
  biWeekly('Bi-weekly'),
  monthly('Monthly'),
  quarterly('Quarterly'),
  annually('Annually'),
  custom('Custom');

  const RecurringIncomeFrequency(this.displayName);

  final String displayName;

  /// Get frequency in days (approximate for months/quarters/years)
  int get approximateDays {
    switch (this) {
      case RecurringIncomeFrequency.daily:
        return 1;
      case RecurringIncomeFrequency.weekly:
        return 7;
      case RecurringIncomeFrequency.biWeekly:
        return 14;
      case RecurringIncomeFrequency.monthly:
        return 30; // Approximate
      case RecurringIncomeFrequency.quarterly:
        return 90; // Approximate
      case RecurringIncomeFrequency.annually:
        return 365; // Approximate
      case RecurringIncomeFrequency.custom:
        return 0; // Custom logic needed
    }
  }
}

/// Recurring income rule for flexible income patterns
@freezed
class RecurringIncomeRule with _$RecurringIncomeRule {
  const factory RecurringIncomeRule({
    required String id,
    required int instanceNumber, // Which occurrence (1st, 2nd, etc.)
    String? accountId, // Specific account for this instance
    double? amount, // Specific amount for this instance (overrides income amount)
    String? notes,
    @Default(true) bool isEnabled,
  }) = _RecurringIncomeRule;

  const RecurringIncomeRule._();

  /// Validate rule data
  Result<RecurringIncomeRule> validate() {
    if (instanceNumber < 1) {
      return Result.error(Failure.validation(
        'Instance number must be positive',
        {'instanceNumber': 'Must be >= 1'},
      ));
    }

    if (amount != null && amount! <= 0) {
      return Result.error(Failure.validation(
        'Amount must be positive if specified',
        {'amount': 'Must be > 0'},
      ));
    }

    return Result.success(this);
  }
}

/// Recurring incomes summary for dashboard
@freezed
class RecurringIncomesSummary with _$RecurringIncomesSummary {
  const factory RecurringIncomesSummary({
    required int totalIncomes,
    required int activeIncomes,
    required int expectedThisMonth,
    required double totalMonthlyAmount,
    required double receivedThisMonth,
    required double expectedAmount,
    required List<RecurringIncomeStatus> upcomingIncomes,
  }) = _RecurringIncomesSummary;

  const RecurringIncomesSummary._();

  /// Calculate income progress percentage
  double get incomeProgress => totalMonthlyAmount > 0
      ? (receivedThisMonth / totalMonthlyAmount).clamp(0.0, 1.0)
      : 0.0;
}

/// Recurring income status summary
@freezed
class RecurringIncomeStatus with _$RecurringIncomeStatus {
  const factory RecurringIncomeStatus({
    required RecurringIncome income,
    required int daysUntilExpected,
    required bool isExpectedSoon,
    required bool isExpectedToday,
    required bool isOverdue,
    required RecurringIncomeUrgency urgency,
  }) = _RecurringIncomeStatus;

  const RecurringIncomeStatus._();
}

/// Recurring income urgency level
enum RecurringIncomeUrgency {
  normal('Normal'),
  expectedSoon('Expected Soon'),
  expectedToday('Expected Today'),
  overdue('Overdue');

  const RecurringIncomeUrgency(this.displayName);

  final String displayName;

  /// Get color for urgency level
  String get color {
    switch (this) {
      case RecurringIncomeUrgency.normal:
        return '#6B7280'; // Gray
      case RecurringIncomeUrgency.expectedSoon:
        return '#F59E0B'; // Yellow
      case RecurringIncomeUrgency.expectedToday:
        return '#10B981'; // Green
      case RecurringIncomeUrgency.overdue:
        return '#EF4444'; // Red
    }
  }
}