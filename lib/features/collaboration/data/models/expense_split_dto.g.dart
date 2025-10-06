// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_split_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseSplitDtoAdapter extends TypeAdapter<ExpenseSplitDto> {
  @override
  final int typeId = 102;

  @override
  ExpenseSplitDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseSplitDto()
      ..id = fields[0] as String
      ..sharedBudgetId = fields[1] as String
      ..title = fields[2] as String
      ..description = fields[3] as String?
      ..totalAmount = fields[4] as double
      ..paidByUserId = fields[5] as String
      ..participants = (fields[6] as List).cast<SplitParticipantDto>()
      ..createdAt = fields[7] as DateTime
      ..updatedAt = fields[8] as DateTime?
      ..status = fields[9] as int
      ..category = fields[10] as String?
      ..receiptUrl = fields[11] as String?;
  }

  @override
  void write(BinaryWriter writer, ExpenseSplitDto obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sharedBudgetId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.totalAmount)
      ..writeByte(5)
      ..write(obj.paidByUserId)
      ..writeByte(6)
      ..write(obj.participants)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.category)
      ..writeByte(11)
      ..write(obj.receiptUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseSplitDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SplitParticipantDtoAdapter extends TypeAdapter<SplitParticipantDto> {
  @override
  final int typeId = 103;

  @override
  SplitParticipantDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SplitParticipantDto()
      ..userId = fields[0] as String
      ..amount = fields[1] as double
      ..status = fields[2] as int
      ..settledAt = fields[3] as DateTime?
      ..paymentMethod = fields[4] as String?
      ..notes = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, SplitParticipantDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.settledAt)
      ..writeByte(4)
      ..write(obj.paymentMethod)
      ..writeByte(5)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplitParticipantDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SettlementDtoAdapter extends TypeAdapter<SettlementDto> {
  @override
  final int typeId = 104;

  @override
  SettlementDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettlementDto()
      ..id = fields[0] as String
      ..expenseSplitId = fields[1] as String
      ..fromUserId = fields[2] as String
      ..toUserId = fields[3] as String
      ..amount = fields[4] as double
      ..settledAt = fields[5] as DateTime
      ..paymentMethod = fields[6] as String?
      ..notes = fields[7] as String?
      ..isConfirmed = fields[8] as bool;
  }

  @override
  void write(BinaryWriter writer, SettlementDto obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.expenseSplitId)
      ..writeByte(2)
      ..write(obj.fromUserId)
      ..writeByte(3)
      ..write(obj.toUserId)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.settledAt)
      ..writeByte(6)
      ..write(obj.paymentMethod)
      ..writeByte(7)
      ..write(obj.notes)
      ..writeByte(8)
      ..write(obj.isConfirmed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettlementDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
