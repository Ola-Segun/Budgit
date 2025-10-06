import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/settings.dart';
import '../repositories/settings_repository.dart';

/// Use case for updating app settings
class UpdateSettings {
  const UpdateSettings(this._repository);

  final SettingsRepository _repository;

  /// Update app settings
  Future<Result<void>> call(AppSettings settings) async {
    try {
      return await _repository.saveSettings(settings);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to update settings: $e'));
    }
  }

  /// Update a specific setting
  Future<Result<void>> updateSetting(String key, dynamic value) async {
    try {
      return await _repository.updateSetting(key, value);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to update setting: $e'));
    }
  }
}