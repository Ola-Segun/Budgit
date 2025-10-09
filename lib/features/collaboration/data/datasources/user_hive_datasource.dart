import 'package:hive/hive.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/user.dart';
import '../models/user_dto.dart';

/// Data source for user data using Hive
class UserHiveDataSource {
  UserHiveDataSource(this._box);

  final Box<UserDto> _box;

  /// Get user by ID
  Future<Result<User?>> getUserById(String userId) async {
    try {
      final dto = _box.get(userId);
      if (dto == null) {
        return const Result.success(null);
      }
      return Result.success(dto.toDomain());
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get user by ID: $e'));
    }
  }

  /// Get user by email
  Future<Result<User?>> getUserByEmail(String email) async {
    try {
      final dto = _box.values.firstWhere(
        (user) => user.email == email,
        orElse: () => null as UserDto,
      );
      return Result.success(dto.toDomain());
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get user by email: $e'));
    }
  }

  /// Get all users
  Future<Result<List<User>>> getAllUsers() async {
    try {
      final users = _box.values.map((dto) => dto.toDomain()).toList();
      return Result.success(users);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get all users: $e'));
    }
  }

  /// Create a new user
  Future<Result<User>> createUser(User user) async {
    try {
      final dto = UserDto.fromDomain(user);
      await _box.put(user.id, dto);
      return Result.success(user);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to create user: $e'));
    }
  }

  /// Update user
  Future<Result<User>> updateUser(User user) async {
    try {
      final dto = UserDto.fromDomain(user);
      await _box.put(user.id, dto);
      return Result.success(user);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to update user: $e'));
    }
  }

  /// Delete user
  Future<Result<void>> deleteUser(String userId) async {
    try {
      await _box.delete(userId);
      return const Result.success(null);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to delete user: $e'));
    }
  }

  /// Search users by name or email
  Future<Result<List<User>>> searchUsers(String query) async {
    try {
      final lowerQuery = query.toLowerCase();
      final users = _box.values
          .where((dto) =>
              dto.displayName.toLowerCase().contains(lowerQuery) ||
              dto.email.toLowerCase().contains(lowerQuery))
          .map((dto) => dto.toDomain())
          .toList();
      return Result.success(users);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to search users: $e'));
    }
  }

  /// Get users by IDs
  Future<Result<List<User>>> getUsersByIds(List<String> userIds) async {
    try {
      final users = userIds
          .map((id) => _box.get(id))
          .where((dto) => dto != null)
          .map((dto) => dto!.toDomain())
          .toList();
      return Result.success(users);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get users by IDs: $e'));
    }
  }

  /// Check if user exists
  Future<Result<bool>> userExists(String userId) async {
    try {
      final exists = _box.containsKey(userId);
      return Result.success(exists);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to check if user exists: $e'));
    }
  }
}