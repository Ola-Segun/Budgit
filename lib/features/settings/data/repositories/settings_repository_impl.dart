import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_hive_datasource.dart';
import '../models/settings_dto.dart';

/// Implementation of SettingsRepository
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsHiveDataSource _dataSource;

  SettingsRepositoryImpl(this._dataSource);

  @override
  Future<Result<AppSettings>> getSettings() async {
    final result = await _dataSource.getSettings();
    return result.when(
      success: (dto) => Result.success(dto.toDomain()),
      error: (failure) => Result.error(failure),
    );
  }

  @override
  Future<Result<void>> saveSettings(AppSettings settings) async {
    final dto = SettingsDto.fromDomain(settings);
    return await _dataSource.saveSettings(dto);
  }

  @override
  Future<Result<void>> updateSetting(String key, dynamic value) async {
    // Get current settings
    final currentResult = await getSettings();
    if (currentResult.isError) {
      return Result.error(currentResult.failureOrNull!);
    }

    final currentSettings = currentResult.dataOrNull!;
    AppSettings updatedSettings;

    // Update the specific setting based on key
    switch (key) {
      case 'themeMode':
        updatedSettings = currentSettings.copyWith(themeMode: value as ThemeMode);
        break;
      case 'currencyCode':
        updatedSettings = currentSettings.copyWith(currencyCode: value as String);
        break;
      case 'dateFormat':
        updatedSettings = currentSettings.copyWith(dateFormat: value as String);
        break;
      case 'notificationsEnabled':
        updatedSettings = currentSettings.copyWith(notificationsEnabled: value as bool);
        break;
      case 'budgetAlertsEnabled':
        updatedSettings = currentSettings.copyWith(budgetAlertsEnabled: value as bool);
        break;
      case 'billRemindersEnabled':
        updatedSettings = currentSettings.copyWith(billRemindersEnabled: value as bool);
        break;
      case 'budgetAlertThreshold':
        updatedSettings = currentSettings.copyWith(budgetAlertThreshold: value as int);
        break;
      case 'billReminderDays':
        updatedSettings = currentSettings.copyWith(billReminderDays: value as int);
        break;
      case 'biometricEnabled':
        updatedSettings = currentSettings.copyWith(biometricEnabled: value as bool);
        break;
      case 'autoBackupEnabled':
        updatedSettings = currentSettings.copyWith(autoBackupEnabled: value as bool);
        break;
      case 'languageCode':
        updatedSettings = currentSettings.copyWith(languageCode: value as String);
        break;
      case 'isFirstTime':
        updatedSettings = currentSettings.copyWith(isFirstTime: value as bool);
        break;
      default:
        return Result.error(Failure.unknown('Unknown setting key: $key'));
    }

    return await saveSettings(updatedSettings);
  }

  @override
  Future<Result<void>> resetToDefaults() async {
    final defaultSettings = AppSettings.defaultSettings();
    return await saveSettings(defaultSettings);
  }

  @override
  Future<Result<String>> exportData(DataExportType type) async {
    try {
      // For now, just export settings as JSON
      // TODO: Implement full data export including transactions, budgets, etc.
      final settingsResult = await getSettings();
      if (settingsResult.isError) {
        return Result.error(settingsResult.failureOrNull!);
      }

      final settings = settingsResult.dataOrNull!;
      final data = {
        'settings': {
          'themeMode': settings.themeMode.name,
          'currencyCode': settings.currencyCode,
          'dateFormat': settings.dateFormat,
          'notificationsEnabled': settings.notificationsEnabled,
          'budgetAlertsEnabled': settings.budgetAlertsEnabled,
          'billRemindersEnabled': settings.billRemindersEnabled,
          'budgetAlertThreshold': settings.budgetAlertThreshold,
          'billReminderDays': settings.billReminderDays,
          'biometricEnabled': settings.biometricEnabled,
          'autoBackupEnabled': settings.autoBackupEnabled,
          'languageCode': settings.languageCode,
          'isFirstTime': settings.isFirstTime,
          'appVersion': settings.appVersion,
        },
        'exportedAt': DateTime.now().toIso8601String(),
        'version': settings.appVersion,
      };

      String exportedData;

      switch (type) {
        case DataExportType.json:
          exportedData = jsonEncode(data);
          break;
        case DataExportType.csv:
          // TODO: Implement CSV export
          return Result.error(Failure.unknown('CSV export not yet implemented'));
        case DataExportType.pdf:
          // TODO: Implement PDF export
          return Result.error(Failure.unknown('PDF export not yet implemented'));
      }

      return Result.success(exportedData);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to export data: $e'));
    }
  }

  @override
  Future<Result<void>> importData(String data, DataExportType type) async {
    try {
      // TODO: Implement full data import
      return Result.error(Failure.unknown('Data import not yet implemented'));
    } catch (e) {
      return Result.error(Failure.unknown('Failed to import data: $e'));
    }
  }

  @override
  Future<Result<void>> clearAllData() async {
    return await _dataSource.clearAllData();
  }

  @override
  Future<Result<String>> getAppVersion() async {
    try {
      // For now, return hardcoded version
      // TODO: Use package_info_plus when available
      return const Result.success('1.0.0');
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get app version: $e'));
    }
  }

  @override
  Future<Result<bool>> isBiometricAvailable() async {
    // TODO: Implement biometric availability check
    // For now, return false
    return const Result.success(false);
  }

  @override
  Future<Result<bool>> authenticateWithBiometrics() async {
    // TODO: Implement biometric authentication
    // For now, return false
    return const Result.success(false);
  }
}