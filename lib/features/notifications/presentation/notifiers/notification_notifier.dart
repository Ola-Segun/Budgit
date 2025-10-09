import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/notification_service.dart';
import '../states/notification_state.dart';

/// State notifier for notification management
class NotificationNotifier extends StateNotifier<AsyncValue<NotificationState>> {
  final NotificationService _notificationService;

  NotificationNotifier(this._notificationService)
      : super(AsyncValue.data(NotificationState.initial())) {
    _initialize();
  }

  Future<void> _initialize() async {
    await _notificationService.initialize();

    // Listen to notification service stream
    _notificationService.notifications.listen(
      (notifications) {
        final currentState = state.value;
        if (currentState != null) {
          state = AsyncValue.data(currentState.copyWith(
            notifications: notifications,
            isLoading: false,
            lastChecked: DateTime.now(),
          ));
        }
      },
      onError: (error) {
        state = AsyncValue.error(error, StackTrace.current);
      },
    );
  }

  /// Check for notifications manually
  Future<void> checkForNotifications() async {
    final currentState = state.value;
    if (currentState != null) {
      state = AsyncValue.data(currentState.copyWith(isLoading: true));
    }

    final result = await _notificationService.checkForNotifications();

    result.when(
      success: (notifications) {
        // The stream listener will handle updating the state
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
    );
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    await _notificationService.markAsRead(notificationId);
  }

  /// Clear all notifications
  Future<void> clearAllNotifications() async {
    await _notificationService.clearAllNotifications();
  }

  /// Get current notifications count
  int get unreadCount {
    final currentState = state.value;
    if (currentState == null) return 0;

    return currentState.notifications
        .where((notification) => notification.isRead != true)
        .length;
  }

  @override
  void dispose() {
    _notificationService.dispose();
    super.dispose();
  }
}