import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

/// User profile entity for onboarding
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String email,
    String? name,
    String? avatarUrl,
    @Default(false) bool hasCompletedOnboarding,
    DateTime? onboardingCompletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserProfile;

  const UserProfile._();

  /// Create a new user profile
  factory UserProfile.create({
    required String email,
    String? name,
  }) {
    final now = DateTime.now();
    return UserProfile(
      id: 'user_${now.millisecondsSinceEpoch}',
      email: email,
      name: name,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Mark onboarding as completed
  UserProfile completeOnboarding() {
    return copyWith(
      hasCompletedOnboarding: true,
      onboardingCompletedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}