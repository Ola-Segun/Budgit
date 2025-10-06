// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebtDtoAdapter extends TypeAdapter<DebtDto> {
  @override
  final int typeId = 7;

  @override
  DebtDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DebtDto()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..description = fields[2] as String
      ..amount = fields[3] as double
      ..remainingAmount = fields[4] as double
      ..type = fields[5] as int
      ..priority = fields[6] as int
      ..dueDate = fields[7] as DateTime
      ..createdAt = fields[8] as DateTime
      ..updatedAt = fields[9] as DateTime
      ..creditor = fields[10] as String?
      ..interestRate = fields[11] as double?
      ..minimumPayment = fields[12] as double?
      ..accountId = fields[13] as String?
      ..tags = (fields[14] as List?)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, DebtDto obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.remainingAmount)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.priority)
      ..writeByte(7)
      ..write(obj.dueDate)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.creditor)
      ..writeByte(11)
      ..write(obj.interestRate)
      ..writeByte(12)
      ..write(obj.minimumPayment)
      ..writeByte(13)
      ..write(obj.accountId)
      ..writeByte(14)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
