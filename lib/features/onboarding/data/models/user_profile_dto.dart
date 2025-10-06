import 'package:hive/hive.dart';

import '../../domain/entities/user_profile.dart';

part 'user_profile_dto.g.dart';

/// Data Transfer Object for UserProfile entity
/// Used for Hive storage - never expose domain entities directly to storage
@HiveType(typeId: 11)
class UserProfileDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String email;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? avatarUrl;

  @HiveField(4)
  late bool hasCompletedOnboarding;

  @HiveField(5)
  DateTime? onboardingCompletedAt;

  @HiveField(6)
  DateTime? createdAt;

  @HiveField(7)
  DateTime? updatedAt;

  /// Default constructor
  UserProfileDto();

  /// Named constructor for creating from domain entity
  UserProfileDto.fromDomain(UserProfile userProfile) {
    id = userProfile.id;
    email = userProfile.email;
    name = userProfile.name;
    avatarUrl = userProfile.avatarUrl;
    hasCompletedOnboarding = userProfile.hasCompletedOnboarding;
    onboardingCompletedAt = userProfile.onboardingCompletedAt;
    createdAt = userProfile.createdAt;
    updatedAt = userProfile.updatedAt;
  }

  /// Convert to domain entity
  UserProfile toDomain() {
    return UserProfile(
      id: id,
      email: email,
      name: name,
      avatarUrl: avatarUrl,
      hasCompletedOnboarding: hasCompletedOnboarding,
      onboardingCompletedAt: onboardingCompletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}