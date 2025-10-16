import 'package:hive/hive.dart';

import '../../domain/entities/account.dart';

// Custom adapter to handle backward compatibility for balance fields
class AccountDtoAdapter extends TypeAdapter<AccountDto> {
  @override
  final int typeId = 12; // Changed from 8 to avoid conflict with RecurringIncomeDtoAdapter

  @override
  AccountDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountDto()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..type = fields[2] as String
      ..cachedBalance = _parseDouble(fields[3]) // Handle string to double conversion
      ..lastBalanceUpdate = fields[4] as DateTime?
      ..reconciledBalance = _parseDouble(fields[5]) // Handle string to double conversion
      ..lastReconciliation = fields[6] as DateTime?
      ..balance = _parseDouble(fields[7]) // Handle legacy balance field
      ..description = fields[8] as String?
      ..institution = fields[9] as String?
      ..accountNumber = fields[10] as String?
      ..currency = fields[11] as String?
      ..createdAt = fields[12] as DateTime?
      ..updatedAt = fields[13] as DateTime?
      ..creditLimit = _parseDouble(fields[14])
      ..availableCredit = _parseDouble(fields[15])
      ..interestRate = _parseDouble(fields[16])
      ..minimumPayment = _parseDouble(fields[17])
      ..dueDate = fields[18] as DateTime?
      ..isActive = fields[19] as bool?;
  }

  @override
  void write(BinaryWriter writer, AccountDto obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.cachedBalance)
      ..writeByte(4)
      ..write(obj.lastBalanceUpdate)
      ..writeByte(5)
      ..write(obj.reconciledBalance)
      ..writeByte(6)
      ..write(obj.lastReconciliation)
      ..writeByte(7)
      ..write(obj.balance)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.institution)
      ..writeByte(10)
      ..write(obj.accountNumber)
      ..writeByte(11)
      ..write(obj.currency)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.creditLimit)
      ..writeByte(15)
      ..write(obj.availableCredit)
      ..writeByte(16)
      ..write(obj.interestRate)
      ..writeByte(17)
      ..write(obj.minimumPayment)
      ..writeByte(18)
      ..write(obj.dueDate)
      ..writeByte(19)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  // Helper method to safely parse double values, handling both double and string inputs
  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        // If parsing fails, return null for safety
        return null;
      }
    }
    // For any other type, try to convert to string first then parse
    try {
      return double.parse(value.toString());
    } catch (e) {
      return null;
    }
  }
}

/// Data Transfer Object for Account entity
/// Used for Hive storage - never expose domain entities directly to storage
class AccountDto {
  late String id;
  late String name;
  late String type; // Store as string for Hive compatibility

  // Hybrid balance system
  double? cachedBalance; // Eager updated on transactions
  DateTime? lastBalanceUpdate;
  double? reconciledBalance; // Calculated from transactions
  DateTime? lastReconciliation;

  // Backward compatibility
  double? balance;
  String? description;
  String? institution;
  String? accountNumber;
  String? currency;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Type-specific fields
  double? creditLimit;
  double? availableCredit;
  double? interestRate;
  double? minimumPayment;
  DateTime? dueDate;
  bool? isActive;

  /// Default constructor
  AccountDto();

  /// Named constructor for creating from domain entity
  AccountDto.fromDomain(Account account) {
    id = account.id;
    name = account.name;
    type = account.type.name; // Convert enum to string
    // Hybrid balance system
    cachedBalance = account.cachedBalance;
    lastBalanceUpdate = account.lastBalanceUpdate;
    reconciledBalance = account.reconciledBalance;
    lastReconciliation = account.lastReconciliation;
    // Backward compatibility
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
      // Hybrid balance system
      cachedBalance: cachedBalance,
      lastBalanceUpdate: lastBalanceUpdate,
      reconciledBalance: reconciledBalance,
      lastReconciliation: lastReconciliation,
      // Backward compatibility
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