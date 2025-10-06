import '../../../../core/error/result.dart';
import '../entities/user.dart';

/// Repository interface for user management
abstract class UserRepository {
  /// Get user by ID
  Future<Result<User?>> getUserById(String userId);

  /// Get user by email
  Future<Result<User?>> getUserByEmail(String email);

  /// Get all users
  Future<Result<List<User>>> getAllUsers();

  /// Create a new user
  Future<Result<User>> createUser(User user);

  /// Update user information
  Future<Result<User>> updateUser(User user);

  /// Delete user
  Future<Result<void>> deleteUser(String userId);

  /// Search users by name or email
  Future<Result<List<User>>> searchUsers(String query);

  /// Get users by IDs
  Future<Result<List<User>>> getUsersByIds(List<String> userIds);
}