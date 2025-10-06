// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InsightDtoAdapter extends TypeAdapter<InsightDto> {
  @override
  final int typeId = 9;

  @override
  InsightDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InsightDto()
      ..id = fields[0] as String
      ..title = fields[1] as String
      ..message = fields[2] as String
      ..type = fields[3] as String
      ..generatedAt = fields[4] as DateTime
      ..categoryId = fields[5] as String?
      ..transactionId = fields[6] as String?
      ..amount = fields[7] as double?
      ..percentage = fields[8] as double?
      ..priority = fields[9] as String?
      ..isRead = fields[10] as bool
      ..isArchived = fields[11] as bool
      ..metadata = (fields[12] as Map?)?.cast<String, dynamic>();
  }

  @override
  void write(BinaryWriter writer, InsightDto obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.generatedAt)
      ..writeByte(5)
      ..write(obj.categoryId)
      ..writeByte(6)
      ..write(obj.transactionId)
      ..writeByte(7)
      ..write(obj.amount)
      ..writeByte(8)
      ..write(obj.percentage)
      ..writeByte(9)
      ..write(obj.priority)
      ..writeByte(10)
      ..write(obj.isRead)
      ..writeByte(11)
      ..write(obj.isArchived)
      ..writeByte(12)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsightDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FinancialReportDtoAdapter extends TypeAdapter<FinancialReportDto> {
  @override
  final int typeId = 10;

  @override
  FinancialReportDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FinancialReportDto()
      ..id = fields[0] as String
      ..title = fields[1] as String
      ..description = fields[2] as String
      ..type = fields[3] as String
      ..startDate = fields[4] as DateTime
      ..endDate = fields[5] as DateTime
      ..generatedAt = fields[6] as DateTime
      ..data = (fields[7] as Map).cast<String, dynamic>()
      ..sections = (fields[8] as List).cast<String>()
      ..filePath = fields[9] as String?
      ..isExported = fields[10] as bool
      ..metadata = (fields[11] as Map?)?.cast<String, dynamic>();
  }

  @override
  void write(BinaryWriter writer, FinancialReportDto obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.endDate)
      ..writeByte(6)
      ..write(obj.generatedAt)
      ..writeByte(7)
      ..write(obj.data)
      ..writeByte(8)
      ..write(obj.sections)
      ..writeByte(9)
      ..write(obj.filePath)
      ..writeByte(10)
      ..write(obj.isExported)
      ..writeByte(11)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinancialReportDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
