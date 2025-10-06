import 'package:hive/hive.dart';

import '../../domain/entities/account.dart';

part 'account_dto.g.dart';

/// Data Transfer Object for Account entity
/// Used for Hive storage - never expose domain entities directly to storage
@HiveType(typeId: 8)
class AccountDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String type; // Store as string for Hive compatibility

  @HiveField(3)
  late double balance;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String? institution;

  @HiveField(6)
  String? accountNumber;

  @HiveField(7)
  String? currency;

  @HiveField(8)
  DateTime? createdAt;

  @HiveField(9)
  DateTime? updatedAt;

  // Type-specific fields
  @HiveField(10)
  double? creditLimit;

  @HiveField(11)
  double? availableCredit;

  @HiveField(12)
  double? interestRate;

  @HiveField(13)
  double? minimumPayment;

  @HiveField(14)
  DateTime? dueDate;

  @HiveField(15)
  bool? isActive;

  /// Default constructor
  AccountDto();

  /// Named constructor for creating from domain entity
  AccountDto.fromDomain(Account account) {
    id = account.id;
    name = account.name;
    type = account.type.name; // Convert enum to string
    balance = account.balance;
    description = account.description;
    institution = account.institution;
    accountNumber = account.accountNumber;
    currency = account.currency;
    createdAt = account.createdAt;
    updatedAt = account.updatedAt;
    creditLimit = account.creditLimit;
    availableCredit = account.availableCredit;
    interestRate = account.interestRate;
    minimumPayment = account.minimumPayment;
    dueDate = account.dueDate;
    isActive = account.isActive;
  }

  /// Convert to domain entity
  Account toDomain() {
    return Account(
      id: id,
      name: name,
      type: AccountType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => AccountType.bankAccount, // Default fallback
      ),
      balance: balance,
      description: description,
      institution: institution,
      accountNumber: accountNumber,
      currency: currency ?? 'USD',
      createdAt: createdAt,
      updatedAt: updatedAt,
      creditLimit: creditLimit,
      availableCredit: availableCredit,
      interestRate: interestRate,
      minimumPayment: minimumPayment,
      dueDate: dueDate,
      isActive: isActive ?? true,
    );
  }
}