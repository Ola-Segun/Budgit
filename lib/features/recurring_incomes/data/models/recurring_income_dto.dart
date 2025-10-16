import 'package:hive/hive.dart';

import '../../domain/entities/recurring_income.dart';

part 'recurring_income_dto.g.dart';

/// Data Transfer Object for RecurringIncome entity
/// Used for Hive storage - never expose domain entities directly to storage
@HiveType(typeId: 8)
class RecurringIncomeDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late double amount;

  @HiveField(3)
  late DateTime startDate;

  @HiveField(4)
  late String frequency; // Store as string for Hive compatibility

  @HiveField(5)
  late String categoryId;

  @HiveField(6)
  String? description;

  @HiveField(7)
  String? payer;

  @HiveField(8)
  DateTime? endDate;

  @HiveField(9)
  String? website;

  @HiveField(10)
  String? notes;

  @HiveField(11)
  String? accountId;

  @HiveField(12)
  late bool isVariableAmount;

  @HiveField(13)
  double? minAmount;

  @HiveField(14)
  double? maxAmount;

  @HiveField(15)
  String? currencyCode;

  @HiveField(16)
  List<RecurringIncomeRuleDto>? recurringIncomeRules;

  @HiveField(17)
  List<RecurringIncomeInstanceDto>? incomeHistory;

  @HiveField(18)
  DateTime? lastReceivedDate;

  @HiveField(19)
  DateTime? nextExpectedDate;

  /// Default constructor
  RecurringIncomeDto();

  /// Named constructor for creating from domain entity
  RecurringIncomeDto.fromDomain(RecurringIncome income) {
    id = income.id;
    name = income.name;
    amount = income.amount;
    startDate = income.startDate;
    frequency = income.frequency.name; // Convert enum to string
    categoryId = income.categoryId;
    description = income.description;
    payer = income.payer;
    endDate = income.endDate;
    website = income.website;
    notes = income.notes;
    accountId = income.accountId;
    isVariableAmount = income.isVariableAmount;
    minAmount = income.minAmount;
    maxAmount = income.maxAmount;
    currencyCode = income.currencyCode;
    recurringIncomeRules = income.recurringIncomeRules
        .map((rule) => RecurringIncomeRuleDto.fromDomain(rule))
        .toList();
    incomeHistory = income.incomeHistory
        .map((instance) => RecurringIncomeInstanceDto.fromDomain(instance))
        .toList();
    lastReceivedDate = income.lastReceivedDate;
    nextExpectedDate = income.nextExpectedDate;
  }

  /// Convert to domain entity
  RecurringIncome toDomain() {
    return RecurringIncome(
      id: id,
      name: name,
      amount: amount,
      startDate: startDate,
      frequency: RecurringIncomeFrequency.values.firstWhere(
        (e) => e.name == frequency,
        orElse: () => RecurringIncomeFrequency.monthly, // Default fallback
      ),
      categoryId: categoryId,
      description: description,
      payer: payer,
      endDate: endDate,
      website: website,
      notes: notes,
      accountId: accountId,
      isVariableAmount: isVariableAmount,
      minAmount: minAmount,
      maxAmount: maxAmount,
      currencyCode: currencyCode,
      recurringIncomeRules: recurringIncomeRules
          ?.map((dto) => dto.toDomain())
          .toList() ?? [],
      incomeHistory: incomeHistory
          ?.map((dto) => dto.toDomain())
          .toList() ?? [],
      lastReceivedDate: lastReceivedDate,
      nextExpectedDate: nextExpectedDate,
    );
  }
}

/// Data Transfer Object for RecurringIncomeInstance entity
@HiveType(typeId: 9)
class RecurringIncomeInstanceDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late DateTime receivedDate;

  @HiveField(3)
  String? transactionId;

  @HiveField(4)
  String? notes;

  @HiveField(5)
  String? accountId;

  /// Default constructor
  RecurringIncomeInstanceDto();

  /// Named constructor for creating from domain entity
  RecurringIncomeInstanceDto.fromDomain(RecurringIncomeInstance instance) {
    id = instance.id;
    amount = instance.amount;
    receivedDate = instance.receivedDate;
    transactionId = instance.transactionId;
    notes = instance.notes;
    accountId = instance.accountId;
  }

  /// Convert to domain entity
  RecurringIncomeInstance toDomain() {
    return RecurringIncomeInstance(
      id: id,
      amount: amount,
      receivedDate: receivedDate,
      transactionId: transactionId,
      notes: notes,
      accountId: accountId,
    );
  }
}

/// Data Transfer Object for RecurringIncomeRule entity
@HiveType(typeId: 10)
class RecurringIncomeRuleDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late int instanceNumber;

  @HiveField(2)
  String? accountId;

  @HiveField(3)
  double? amount;

  @HiveField(4)
  String? notes;

  @HiveField(5)
  late bool isEnabled;

  /// Default constructor
  RecurringIncomeRuleDto();

  /// Named constructor for creating from domain entity
  RecurringIncomeRuleDto.fromDomain(RecurringIncomeRule rule) {
    id = rule.id;
    instanceNumber = rule.instanceNumber;
    accountId = rule.accountId;
    amount = rule.amount;
    notes = rule.notes;
    isEnabled = rule.isEnabled;
  }

  /// Convert to domain entity
  RecurringIncomeRule toDomain() {
    return RecurringIncomeRule(
      id: id,
      instanceNumber: instanceNumber,
      accountId: accountId,
      amount: amount,
      notes: notes,
      isEnabled: isEnabled,
    );
  }
}