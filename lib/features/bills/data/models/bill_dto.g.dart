// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillDtoAdapter extends TypeAdapter<BillDto> {
  @override
  final int typeId = 6;

  @override
  BillDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillDto()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..amount = fields[2] as double
      ..dueDate = fields[3] as DateTime
      ..frequency = fields[4] as String
      ..categoryId = fields[5] as String
      ..description = fields[6] as String?
      ..payee = fields[7] as String?
      ..accountId = fields[8] as String?
      ..isAutoPay = fields[9] as bool
      ..isPaid = fields[10] as bool
      ..lastPaidDate = fields[11] as DateTime?
      ..nextDueDate = fields[12] as DateTime?
      ..website = fields[13] as String?
      ..notes = fields[14] as String?
      ..cancellationDifficulty = fields[15] as String
      ..lastPriceIncrease = fields[16] as DateTime?
      ..paymentHistory = (fields[17] as List?)?.cast<BillPaymentDto>();
  }

  @override
  void write(BinaryWriter writer, BillDto obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.dueDate)
      ..writeByte(4)
      ..write(obj.frequency)
      ..writeByte(5)
      ..write(obj.categoryId)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.payee)
      ..writeByte(8)
      ..write(obj.accountId)
      ..writeByte(9)
      ..write(obj.isAutoPay)
      ..writeByte(10)
      ..write(obj.isPaid)
      ..writeByte(11)
      ..write(obj.lastPaidDate)
      ..writeByte(12)
      ..write(obj.nextDueDate)
      ..writeByte(13)
      ..write(obj.website)
      ..writeByte(14)
      ..write(obj.notes)
      ..writeByte(15)
      ..write(obj.cancellationDifficulty)
      ..writeByte(16)
      ..write(obj.lastPriceIncrease)
      ..writeByte(17)
      ..write(obj.paymentHistory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BillPaymentDtoAdapter extends TypeAdapter<BillPaymentDto> {
  @override
  final int typeId = 7;

  @override
  BillPaymentDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillPaymentDto()
      ..id = fields[0] as String
      ..amount = fields[1] as double
      ..paymentDate = fields[2] as DateTime
      ..transactionId = fields[3] as String?
      ..notes = fields[4] as String?
      ..method = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, BillPaymentDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.paymentDate)
      ..writeByte(3)
      ..write(obj.transactionId)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.method);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillPaymentDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
