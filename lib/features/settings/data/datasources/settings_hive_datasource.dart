import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../models/settings_dto.dart';

/// Hive-based data source for settings
class SettingsHiveDataSource {
  static const String _settingsBoxName = 'settings';
  static const String _settingsKey = 'app_settings';

  late Box<SettingsDto> _settingsBox;

  /// Initialize the data source
  Future<void> init() async {
    _settingsBox = await Hive.openBox<SettingsDto>(_settingsBoxName);
  }

  /// Get current settings
  Future<Result<SettingsDto>> getSettings() async {
    try {
      final settings = _settingsBox.get(_settingsKey);
      if (settings != null) {
        return Result.success(settings);
      } else {
        // Return default settings if none exist
        final defaultSettings = SettingsDto.defaultSettings();
        await _settingsBox.put(_settingsKey, defaultSettings);
        return Result.success(defaultSettings);
      }
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get settings: $e'));
    }
  }

  /// Save settings
  Future<Result<void>> saveSettings(SettingsDto settings) async {
    try {
      await _settingsBox.put(_settingsKey, settings);
      return const Result.success(null);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to save settings: $e'));
    }
  }

  /// Clear all settings data
  Future<Result<void>> clearAllData() async {
    try {
      await _settingsBox.clear();
      return const Result.success(null);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to clear settings data: $e'));
    }
  }
}