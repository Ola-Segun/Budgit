// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_income_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecurringIncomeDtoAdapter extends TypeAdapter<RecurringIncomeDto> {
  @override
  final int typeId = 8;

  @override
  RecurringIncomeDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecurringIncomeDto()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..amount = fields[2] as double
      ..startDate = fields[3] as DateTime
      ..frequency = fields[4] as String
      ..categoryId = fields[5] as String
      ..description = fields[6] as String?
      ..payer = fields[7] as String?
      ..endDate = fields[8] as DateTime?
      ..website = fields[9] as String?
      ..notes = fields[10] as String?
      ..accountId = fields[11] as String?
      ..isVariableAmount = fields[12] as bool
      ..minAmount = fields[13] as double?
      ..maxAmount = fields[14] as double?
      ..currencyCode = fields[15] as String?
      ..recurringIncomeRules =
          (fields[16] as List?)?.cast<RecurringIncomeRuleDto>()
      ..incomeHistory =
          (fields[17] as List?)?.cast<RecurringIncomeInstanceDto>()
      ..lastReceivedDate = fields[18] as DateTime?
      ..nextExpectedDate = fields[19] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, RecurringIncomeDto obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.frequency)
      ..writeByte(5)
      ..write(obj.categoryId)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.payer)
      ..writeByte(8)
      ..write(obj.endDate)
      ..writeByte(9)
      ..write(obj.website)
      ..writeByte(10)
      ..write(obj.notes)
      ..writeByte(11)
      ..write(obj.accountId)
      ..writeByte(12)
      ..write(obj.isVariableAmount)
      ..writeByte(13)
      ..write(obj.minAmount)
      ..writeByte(14)
      ..write(obj.maxAmount)
      ..writeByte(15)
      ..write(obj.currencyCode)
      ..writeByte(16)
      ..write(obj.recurringIncomeRules)
      ..writeByte(17)
      ..write(obj.incomeHistory)
      ..writeByte(18)
      ..write(obj.lastReceivedDate)
      ..writeByte(19)
      ..write(obj.nextExpectedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringIncomeDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecurringIncomeInstanceDtoAdapter
    extends TypeAdapter<RecurringIncomeInstanceDto> {
  @override
  final int typeId = 9;

  @override
  RecurringIncomeInstanceDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecurringIncomeInstanceDto()
      ..id = fields[0] as String
      ..amount = fields[1] as double
      ..receivedDate = fields[2] as DateTime
      ..transactionId = fields[3] as String?
      ..notes = fields[4] as String?
      ..accountId = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, RecurringIncomeInstanceDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.receivedDate)
      ..writeByte(3)
      ..write(obj.transactionId)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.accountId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringIncomeInstanceDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecurringIncomeRuleDtoAdapter
    extends TypeAdapter<RecurringIncomeRuleDto> {
  @override
  final int typeId = 10;

  @override
  RecurringIncomeRuleDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecurringIncomeRuleDto()
      ..id = fields[0] as String
      ..instanceNumber = fields[1] as int
      ..accountId = fields[2] as String?
      ..amount = fields[3] as double?
      ..notes = fields[4] as String?
      ..isEnabled = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, RecurringIncomeRuleDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.instanceNumber)
      ..writeByte(2)
      ..write(obj.accountId)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.isEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringIncomeRuleDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
