import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/settings.dart';

part 'settings_state.freezed.dart';

/// State for settings management
@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required AppSettings settings,
    required bool isLoading,
    required String? error,
  }) = _SettingsState;

  factory SettingsState.initial() => SettingsState(
        settings: AppSettings.defaultSettings(),
        isLoading: false,
        error: null,
      );

  factory SettingsState.loading() => SettingsState(
        settings: AppSettings.defaultSettings(),
        isLoading: true,
        error: null,
      );
}