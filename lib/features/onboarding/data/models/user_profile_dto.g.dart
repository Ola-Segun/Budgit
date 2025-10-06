// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileDtoAdapter extends TypeAdapter<UserProfileDto> {
  @override
  final int typeId = 11;

  @override
  UserProfileDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileDto()
      ..id = fields[0] as String
      ..email = fields[1] as String
      ..name = fields[2] as String?
      ..avatarUrl = fields[3] as String?
      ..hasCompletedOnboarding = fields[4] as bool
      ..onboardingCompletedAt = fields[5] as DateTime?
      ..createdAt = fields[6] as DateTime?
      ..updatedAt = fields[7] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, UserProfileDto obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.avatarUrl)
      ..writeByte(4)
      ..write(obj.hasCompletedOnboarding)
      ..writeByte(5)
      ..write(obj.onboardingCompletedAt)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
