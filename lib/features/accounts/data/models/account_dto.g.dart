// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountDtoAdapter extends TypeAdapter<AccountDto> {
  @override
  final int typeId = 8;

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
      ..balance = fields[3] as double
      ..description = fields[4] as String?
      ..institution = fields[5] as String?
      ..accountNumber = fields[6] as String?
      ..currency = fields[7] as String?
      ..createdAt = fields[8] as DateTime?
      ..updatedAt = fields[9] as DateTime?
      ..creditLimit = fields[10] as double?
      ..availableCredit = fields[11] as double?
      ..interestRate = fields[12] as double?
      ..minimumPayment = fields[13] as double?
      ..dueDate = fields[14] as DateTime?
      ..isActive = fields[15] as bool?;
  }

  @override
  void write(BinaryWriter writer, AccountDto obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.balance)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.institution)
      ..writeByte(6)
      ..write(obj.accountNumber)
      ..writeByte(7)
      ..write(obj.currency)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.creditLimit)
      ..writeByte(11)
      ..write(obj.availableCredit)
      ..writeByte(12)
      ..write(obj.interestRate)
      ..writeByte(13)
      ..write(obj.minimumPayment)
      ..writeByte(14)
      ..write(obj.dueDate)
      ..writeByte(15)
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
}
