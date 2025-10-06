import 'package:hive/hive.dart';

import '../../domain/entities/shared_budget.dart';

part 'shared_budget_dto.g.dart';

/// Data Transfer Object for SharedBudget entity
@HiveType(typeId: 101)
class SharedBudgetDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  late String ownerId;

  @HiveField(4)
  late List<String> memberIds;

  @HiveField(5)
  late List<String> pendingInvites;

  @HiveField(6)
  late double totalBudget;

  @HiveField(7)
  late DateTime createdAt;

  @HiveField(8)
  late DateTime updatedAt;

  @HiveField(9)
  late bool isActive;

  @HiveField(10)
  String? category;

  SharedBudgetDto();

  /// Create DTO from domain entity
  factory SharedBudgetDto.fromDomain(SharedBudget budget) {
    return SharedBudgetDto()
      ..id = budget.id
      ..name = budget.name
      ..description = budget.description
      ..ownerId = budget.ownerId
      ..memberIds = List<String>.from(budget.memberIds)
      ..pendingInvites = List<String>.from(budget.pendingInvites)
      ..totalBudget = budget.totalBudget
      ..createdAt = budget.createdAt
      ..updatedAt = budget.updatedAt
      ..isActive = budget.isActive
      ..category = budget.category;
  }

  /// Convert to domain entity
  SharedBudget toDomain() {
    return SharedBudget(
      id: id,
      name: name,
      description: description,
      ownerId: ownerId,
      memberIds: List<String>.from(memberIds),
      pendingInvites: List<String>.from(pendingInvites),
      totalBudget: totalBudget,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isActive: isActive,
      category: category,
    );
  }
}