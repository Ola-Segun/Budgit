// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_budget_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SharedBudgetDtoAdapter extends TypeAdapter<SharedBudgetDto> {
  @override
  final int typeId = 101;

  @override
  SharedBudgetDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SharedBudgetDto()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..description = fields[2] as String?
      ..ownerId = fields[3] as String
      ..memberIds = (fields[4] as List).cast<String>()
      ..pendingInvites = (fields[5] as List).cast<String>()
      ..totalBudget = fields[6] as double
      ..createdAt = fields[7] as DateTime
      ..updatedAt = fields[8] as DateTime
      ..isActive = fields[9] as bool
      ..category = fields[10] as String?;
  }

  @override
  void write(BinaryWriter writer, SharedBudgetDto obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.ownerId)
      ..writeByte(4)
      ..write(obj.memberIds)
      ..writeByte(5)
      ..write(obj.pendingInvites)
      ..writeByte(6)
      ..write(obj.totalBudget)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.isActive)
      ..writeByte(10)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SharedBudgetDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
