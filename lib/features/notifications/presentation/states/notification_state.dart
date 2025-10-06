import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notification.dart';

part 'notification_state.freezed.dart';

/// State for notification management
@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    required List<AppNotification> notifications,
    required bool isLoading,
    required String? error,
    required DateTime? lastChecked,
  }) = _NotificationState;

  factory NotificationState.initial() => NotificationState(
        notifications: [],
        isLoading: false,
        error: null,
        lastChecked: null,
      );

  factory NotificationState.loading() => NotificationState(
        notifications: [],
        isLoading: true,
        error: null,
        lastChecked: null,
      );
}