import 'package:hive/hive.dart';

import '../../domain/entities/budget.dart';

part 'budget_dto.g.dart';

/// Hive DTO for Budget entity
@HiveType(typeId: 2)
class BudgetDto extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String type; // BudgetType.name

  @HiveField(3)
  int startDate; // milliseconds since epoch

  @HiveField(4)
  int endDate; // milliseconds since epoch

  @HiveField(5)
  List<BudgetCategoryDto> categories;

  @HiveField(6)
  String? description;

  @HiveField(7)
  bool isActive;

  BudgetDto({
    required this.id,
    required this.name,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.categories,
    this.description,
    this.isActive = false,
  });

  /// Convert from domain entity
  factory BudgetDto.fromDomain(Budget budget) {
    return BudgetDto(
      id: budget.id,
      name: budget.name,
      type: budget.type.name,
      startDate: budget.startDate.millisecondsSinceEpoch,
      endDate: budget.endDate.millisecondsSinceEpoch,
      categories: budget.categories.map(BudgetCategoryDto.fromDomain).toList(),
      description: budget.description,
      isActive: budget.isActive,
    );
  }

  /// Convert to domain entity
  Budget toDomain() {
    return Budget(
      id: id,
      name: name,
      type: BudgetType.values.firstWhere(
        (t) => t.name == type,
        orElse: () => BudgetType.custom,
      ),
      startDate: DateTime.fromMillisecondsSinceEpoch(startDate),
      endDate: DateTime.fromMillisecondsSinceEpoch(endDate),
      categories: categories.map((c) => c.toDomain()).toList(),
      description: description,
      isActive: isActive,
    );
  }
}

/// Hive DTO for BudgetCategory entity
@HiveType(typeId: 3)
class BudgetCategoryDto extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? icon;

  @HiveField(5)
  int? color;

  @HiveField(6)
  List<String> subcategories;

  BudgetCategoryDto({
    required this.id,
    required this.name,
    required this.amount,
    this.description,
    this.icon,
    this.color,
    this.subcategories = const [],
  });

  /// Convert from domain entity
  factory BudgetCategoryDto.fromDomain(BudgetCategory category) {
    return BudgetCategoryDto(
      id: category.id,
      name: category.name,
      amount: category.amount,
      description: category.description,
      icon: category.icon,
      color: category.color,
      subcategories: category.subcategories,
    );
  }

  /// Convert to domain entity
  BudgetCategory toDomain() {
    return BudgetCategory(
      id: id,
      name: name,
      amount: amount,
      description: description,
      icon: icon,
      color: color,
      subcategories: subcategories,
    );
  }
}