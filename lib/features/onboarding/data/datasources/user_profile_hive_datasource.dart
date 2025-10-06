import 'package:hive/hive.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../../core/storage/hive_storage.dart';
import '../models/user_profile_dto.dart';
import '../../domain/entities/user_profile.dart';

/// Data source for user profile using Hive
class UserProfileHiveDataSource {
  static const String _boxName = 'user_profile';
  Box<UserProfileDto>? _box;

  /// Initialize the data source
  Future<void> init() async {
    // Wait for Hive to be initialized
    await HiveStorage.init();

    // Register adapter if not already registered
    if (!Hive.isAdapterRegistered(11)) {
      Hive.registerAdapter(UserProfileDtoAdapter());
    }

    // Handle box opening with proper type checking
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<UserProfileDto>(_boxName);
    } else {
      try {
        _box = Hive.box<UserProfileDto>(_boxName);
      } catch (e) {
        // If the box is already open with wrong type, close and reopen
        if (e.toString().contains('Box<dynamic>')) {
          await Hive.box(_boxName).close();
          _box = await Hive.openBox<UserProfileDto>(_boxName);
        } else {
          rethrow;
        }
      }
    }
  }

  /// Save user profile
  Future<Result<void>> saveUserProfile(UserProfile profile) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = UserProfileDto.fromDomain(profile);
      await _box!.put('profile', dto);
      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.cache('Failed to save user profile: $e'));
    }
  }

  /// Get user profile
  Future<Result<UserProfile?>> getUserProfile() async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = _box!.get('profile');
      if (dto == null) {
        return Result.success(null);
      }

      final profile = dto.toDomain();
      return Result.success(profile);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get user profile: $e'));
    }
  }

  /// Check if user has completed onboarding
  Future<Result<bool>> hasCompletedOnboarding() async {
    try {
      final profile = await getUserProfile();
      return profile.when(
        success: (userProfile) => Result.success(userProfile?.hasCompletedOnboarding ?? false),
        error: (failure) => Result.error(failure),
      );
    } catch (e) {
      return Result.error(Failure.cache('Failed to check onboarding status: $e'));
    }
  }

  /// Clear all data (for testing)
  Future<Result<void>> clear() async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      await _box!.clear();
      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.cache('Failed to clear user profile: $e'));
    }
  }
}