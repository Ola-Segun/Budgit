import 'package:hive/hive.dart';

import '../../domain/entities/user.dart';

part 'user_dto.g.dart';

/// Data Transfer Object for User entity
@HiveType(typeId: 100) // Use high typeId to avoid conflicts
class UserDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late String displayName;

  @HiveField(3)
  String? avatarUrl;

  @HiveField(4)
  late DateTime createdAt;

  @HiveField(5)
  DateTime? lastActiveAt;

  @HiveField(6)
  late bool isActive;

  UserDto();

  /// Create DTO from domain entity
  factory UserDto.fromDomain(User user) {
    return UserDto()
      ..id = user.id
      ..email = user.email
      ..displayName = user.displayName
      ..avatarUrl = user.avatarUrl
      ..createdAt = user.createdAt
      ..lastActiveAt = user.lastActiveAt
      ..isActive = user.isActive;
  }

  /// Convert to domain entity
  User toDomain() {
    return User(
      id: id,
      email: email,
      displayName: displayName,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      lastActiveAt: lastActiveAt,
      isActive: isActive,
    );
  }
}