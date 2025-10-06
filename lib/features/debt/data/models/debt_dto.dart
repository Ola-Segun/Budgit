import 'package:hive/hive.dart';

import '../../domain/entities/debt.dart';

part 'debt_dto.g.dart';

/// Data Transfer Object for Debt entity
/// Used for Hive storage - never expose domain entities directly to storage
@HiveType(typeId: 7)
class DebtDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late double amount;

  @HiveField(4)
  late double remainingAmount;

  @HiveField(5)
  late int type; // DebtType as int

  @HiveField(6)
  late int priority; // DebtPriority as int

  @HiveField(7)
  late DateTime dueDate;

  @HiveField(8)
  late DateTime createdAt;

  @HiveField(9)
  late DateTime updatedAt;

  @HiveField(10)
  String? creditor;

  @HiveField(11)
  double? interestRate;

  @HiveField(12)
  double? minimumPayment;

  @HiveField(13)
  String? accountId;

  @HiveField(14)
  List<String>? tags;

  /// Default constructor
  DebtDto();

  /// Named constructor for creating from domain entity
  DebtDto.fromDomain(Debt debt) {
    id = debt.id;
    name = debt.name;
    description = debt.description;
    amount = debt.amount;
    remainingAmount = debt.remainingAmount;
    type = debt.type.index;
    priority = debt.priority.index;
    dueDate = debt.dueDate;
    createdAt = debt.createdAt;
    updatedAt = debt.updatedAt;
    creditor = debt.creditor;
    interestRate = debt.interestRate;
    minimumPayment = debt.minimumPayment;
    accountId = debt.accountId;
    tags = debt.tags;
  }

  /// Convert to domain entity
  Debt toDomain() {
    return Debt(
      id: id,
      name: name,
      description: description,
      amount: amount,
      remainingAmount: remainingAmount,
      type: DebtType.values[type],
      priority: DebtPriority.values[priority],
      dueDate: dueDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
      creditor: creditor,
      interestRate: interestRate,
      minimumPayment: minimumPayment,
      accountId: accountId,
      tags: tags ?? [],
    );
  }
}