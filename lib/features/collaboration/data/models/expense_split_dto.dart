import 'package:hive/hive.dart';

import '../../domain/entities/expense_split.dart';

part 'expense_split_dto.g.dart';

/// Data Transfer Object for ExpenseSplit entity
@HiveType(typeId: 102)
class ExpenseSplitDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String sharedBudgetId;

  @HiveField(2)
  late String title;

  @HiveField(3)
  String? description;

  @HiveField(4)
  late double totalAmount;

  @HiveField(5)
  late String paidByUserId;

  @HiveField(6)
  late List<SplitParticipantDto> participants;

  @HiveField(7)
  late DateTime createdAt;

  @HiveField(8)
  DateTime? updatedAt;

  @HiveField(9)
  late int status; // Store as int for enum

  @HiveField(10)
  String? category;

  @HiveField(11)
  String? receiptUrl;

  ExpenseSplitDto();

  /// Create DTO from domain entity
  factory ExpenseSplitDto.fromDomain(ExpenseSplit split) {
    return ExpenseSplitDto()
      ..id = split.id
      ..sharedBudgetId = split.sharedBudgetId
      ..title = split.title
      ..description = split.description
      ..totalAmount = split.totalAmount
      ..paidByUserId = split.paidByUserId
      ..participants = split.participants
          .map((p) => SplitParticipantDto.fromDomain(p))
          .toList()
      ..createdAt = split.createdAt
      ..updatedAt = split.updatedAt
      ..status = split.status.index
      ..category = split.category
      ..receiptUrl = split.receiptUrl;
  }

  /// Convert to domain entity
  ExpenseSplit toDomain() {
    return ExpenseSplit(
      id: id,
      sharedBudgetId: sharedBudgetId,
      title: title,
      description: description,
      totalAmount: totalAmount,
      paidByUserId: paidByUserId,
      participants: participants.map((p) => p.toDomain()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: SplitStatus.values[status],
      category: category,
      receiptUrl: receiptUrl,
    );
  }
}

/// Data Transfer Object for SplitParticipant
@HiveType(typeId: 103)
class SplitParticipantDto extends HiveObject {
  @HiveField(0)
  late String userId;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late int status; // Store as int for enum

  @HiveField(3)
  DateTime? settledAt;

  @HiveField(4)
  String? paymentMethod;

  @HiveField(5)
  String? notes;

  SplitParticipantDto();

  /// Create DTO from domain entity
  factory SplitParticipantDto.fromDomain(SplitParticipant participant) {
    return SplitParticipantDto()
      ..userId = participant.userId
      ..amount = participant.amount
      ..status = participant.status.index
      ..settledAt = participant.settledAt
      ..paymentMethod = participant.paymentMethod
      ..notes = participant.notes;
  }

  /// Convert to domain entity
  SplitParticipant toDomain() {
    return SplitParticipant(
      userId: userId,
      amount: amount,
      status: SplitStatus.values[status],
      settledAt: settledAt,
      paymentMethod: paymentMethod,
      notes: notes,
    );
  }
}

/// Data Transfer Object for Settlement
@HiveType(typeId: 104)
class SettlementDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String expenseSplitId;

  @HiveField(2)
  late String fromUserId;

  @HiveField(3)
  late String toUserId;

  @HiveField(4)
  late double amount;

  @HiveField(5)
  late DateTime settledAt;

  @HiveField(6)
  String? paymentMethod;

  @HiveField(7)
  String? notes;

  @HiveField(8)
  late bool isConfirmed;

  SettlementDto();

  /// Create DTO from domain entity
  factory SettlementDto.fromDomain(Settlement settlement) {
    return SettlementDto()
      ..id = settlement.id
      ..expenseSplitId = settlement.expenseSplitId
      ..fromUserId = settlement.fromUserId
      ..toUserId = settlement.toUserId
      ..amount = settlement.amount
      ..settledAt = settlement.settledAt
      ..paymentMethod = settlement.paymentMethod
      ..notes = settlement.notes
      ..isConfirmed = settlement.isConfirmed;
  }

  /// Convert to domain entity
  Settlement toDomain() {
    return Settlement(
      id: id,
      expenseSplitId: expenseSplitId,
      fromUserId: fromUserId,
      toUserId: toUserId,
      amount: amount,
      settledAt: settledAt,
      paymentMethod: paymentMethod,
      notes: notes,
      isConfirmed: isConfirmed,
    );
  }
}