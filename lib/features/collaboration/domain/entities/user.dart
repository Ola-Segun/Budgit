import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// User entity for collaboration features
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String displayName,
    String? avatarUrl,
    required DateTime createdAt,
    DateTime? lastActiveAt,
    @Default(true) bool isActive,
  }) = _User;

  const User._();

  /// Create a user from email (temporary until full user system)
  factory User.fromEmail(String email) {
    final name = email.split('@').first;
    return User(
      id: email, // Temporary: use email as ID
      email: email,
      displayName: name,
      createdAt: DateTime.now(),
      lastActiveAt: DateTime.now(),
    );
  }

  /// Get user's initials for avatar fallback
  String get initials {
    final parts = displayName.split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return displayName.substring(0, min(2, displayName.length)).toUpperCase();
  }
}

/// Helper function for min
int min(int a, int b) => a < b ? a : b;