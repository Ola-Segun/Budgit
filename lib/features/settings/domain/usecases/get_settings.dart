import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/settings.dart';
import '../repositories/settings_repository.dart';

/// Use case for getting app settings
class GetSettings {
  const GetSettings(this._repository);

  final SettingsRepository _repository;

  /// Get current app settings
  Future<Result<AppSettings>> call() async {
    try {
      return await _repository.getSettings();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get settings: $e'));
    }
  }
}