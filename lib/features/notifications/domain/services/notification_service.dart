import 'dart:async';

import '../../../../core/error/result.dart';
import '../entities/notification.dart';
import '../usecases/check_all_notifications.dart';

/// Service for managing notifications
class NotificationService {
  NotificationService(this._checkAllNotifications);

  final CheckAllNotifications _checkAllNotifications;

  final StreamController<List<AppNotification>> _notificationsController =
      StreamController<List<AppNotification>>.broadcast();

  /// Stream of current notifications
  Stream<List<AppNotification>> get notifications => _notificationsController.stream;

  Timer? _periodicCheckTimer;

  /// Initialize the notification service
  Future<void> initialize() async {
    // Check for notifications immediately
    await checkForNotifications();

    // Set up periodic checking (every hour)
    _periodicCheckTimer = Timer.periodic(
      const Duration(hours: 1),
      (_) => checkForNotifications(),
    );
  }

  /// Check for new notifications
  Future<Result<List<AppNotification>>> checkForNotifications() async {
    final result = await _checkAllNotifications();

    if (result.isSuccess) {
      final notifications = result.dataOrNull!;
      _notificationsController.add(notifications);

      // Show in-app notifications for high priority items
      _showInAppNotifications(notifications);
    }

    return result;
  }

  /// Get current notifications
  Future<Result<List<AppNotification>>> getCurrentNotifications() async {
    return await _checkAllNotifications();
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    // TODO: Implement marking as read in persistent storage
    // For now, just update the stream
    final currentNotifications = await getCurrentNotifications();
    if (currentNotifications.isSuccess) {
      final updatedNotifications = currentNotifications.dataOrNull!.map((notification) {
        if (notification.id == notificationId) {
          return notification.copyWith(isRead: true);
        }
        return notification;
      }).toList();

      _notificationsController.add(updatedNotifications);
    }
  }

  /// Clear all notifications
  Future<void> clearAllNotifications() async {
    _notificationsController.add([]);
  }

  /// Show in-app notifications for high priority items
  void _showInAppNotifications(List<AppNotification> notifications) {
    final highPriorityNotifications = notifications.where(
      (notification) => notification.priority == NotificationPriority.high ||
                       notification.priority == NotificationPriority.critical,
    );

    for (final notification in highPriorityNotifications) {
      if (notification.isRead != true) {
        // TODO: Show in-app notification using a snackbar or overlay
        // For now, this is just a placeholder
        _showInAppNotification(notification);
      }
    }
  }

  /// Show a single in-app notification
  void _showInAppNotification(AppNotification notification) {
    // This would typically use a notification overlay or snackbar
    // For now, we'll just print to console as a placeholder
    print('🔔 ${notification.priority.name.toUpperCase()}: ${notification.title}');
    print('   ${notification.message}');
  }

  /// Schedule local notification (placeholder for future implementation)
  Future<void> scheduleLocalNotification(AppNotification notification) async {
    // TODO: Implement local notification scheduling using flutter_local_notifications
    // This would require additional packages and platform-specific setup
    print('📅 Scheduling local notification: ${notification.title}');
  }

  /// Cancel scheduled notification (placeholder for future implementation)
  Future<void> cancelScheduledNotification(String notificationId) async {
    // TODO: Implement canceling scheduled notifications
    print('❌ Canceling scheduled notification: $notificationId');
  }

  /// Dispose of the service
  void dispose() {
    _periodicCheckTimer?.cancel();
    _notificationsController.close();
  }
}