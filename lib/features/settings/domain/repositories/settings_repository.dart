import '../../../../core/error/result.dart';
import '../entities/settings.dart';

/// Repository interface for settings operations
abstract class SettingsRepository {
  /// Get current app settings
  Future<Result<AppSettings>> getSettings();

  /// Save app settings
  Future<Result<void>> saveSettings(AppSettings settings);

  /// Update specific setting
  Future<Result<void>> updateSetting(String key, dynamic value);

  /// Reset settings to defaults
  Future<Result<void>> resetToDefaults();

  /// Export app data
  Future<Result<String>> exportData(DataExportType type);

  /// Import app data
  Future<Result<void>> importData(String data, DataExportType type);

  /// Clear all app data
  Future<Result<void>> clearAllData();

  /// Get app version
  Future<Result<String>> getAppVersion();

  /// Check if biometric authentication is available
  Future<Result<bool>> isBiometricAvailable();

  /// Authenticate with biometrics
  Future<Result<bool>> authenticateWithBiometrics();
}