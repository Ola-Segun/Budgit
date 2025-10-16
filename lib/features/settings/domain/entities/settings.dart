import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

/// Settings entity representing user preferences and app configuration
@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    /// Theme mode preference
    required ThemeMode themeMode,

    /// Currency code (e.g., 'USD', 'EUR', 'NGN')
    required String currencyCode,

    /// Date format preference
    required String dateFormat,

    /// Enable/disable notifications
    required bool notificationsEnabled,

    /// Enable/disable budget alerts
    required bool budgetAlertsEnabled,

    /// Enable/disable bill reminders
    required bool billRemindersEnabled,

    /// Enable/disable income reminders
    required bool incomeRemindersEnabled,

    /// Budget alert threshold percentage (0-100)
    required int budgetAlertThreshold,

    /// Days before bill due date to show reminder
    required int billReminderDays,

    /// Days before income expected to show reminder
    required int incomeReminderDays,

    /// Enable/disable biometric authentication
    required bool biometricEnabled,

    /// Enable/disable data backup
    required bool autoBackupEnabled,

    /// App language/locale
    required String languageCode,

    /// First time user flag
    required bool isFirstTime,

    /// App version (for display purposes)
    required String appVersion,
  }) = _AppSettings;

  factory AppSettings.defaultSettings() => const AppSettings(
        themeMode: ThemeMode.system,
        currencyCode: 'USD',
        dateFormat: 'MM/dd/yyyy',
        notificationsEnabled: true,
        budgetAlertsEnabled: true,
        billRemindersEnabled: true,
        incomeRemindersEnabled: true,
        budgetAlertThreshold: 80,
        billReminderDays: 3,
        incomeReminderDays: 1,
        biometricEnabled: false,
        autoBackupEnabled: false,
        languageCode: 'en',
        isFirstTime: true,
        appVersion: '1.0.0',
      );
}

// Using Flutter's ThemeMode

/// Export/Import data types
enum DataExportType {
  json,
  csv,
  pdf,
}

/// Settings section types for UI organization
enum SettingsSection {
  appearance,
  notifications,
  data,
  privacy,
  account,
  about,
}