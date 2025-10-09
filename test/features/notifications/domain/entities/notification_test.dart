import 'package:flutter_test/flutter_test.dart';

import 'package:budget_tracker/features/notifications/domain/entities/notification.dart';

void main() {
  group('AppNotification Entity', () {
    final now = DateTime.now();
    final futureTime = now.add(const Duration(hours: 2));
    final pastTime = now.subtract(const Duration(hours: 1));

    test('should create notification with all fields', () {
      // Act
      final notification = AppNotification(
        id: 'test-id',
        title: 'Test Notification',
        message: 'This is a test message',
        type: NotificationType.budgetAlert,
        priority: NotificationPriority.high,
        createdAt: now,
        scheduledFor: futureTime,
        isRead: false,
        actionUrl: '/budgets',
        metadata: {'budgetId': '123'},
      );

      // Assert
      expect(notification.id, 'test-id');
      expect(notification.title, 'Test Notification');
      expect(notification.message, 'This is a test message');
      expect(notification.type, NotificationType.budgetAlert);
      expect(notification.priority, NotificationPriority.high);
      expect(notification.createdAt, now);
      expect(notification.scheduledFor, futureTime);
      expect(notification.isRead, false);
      expect(notification.actionUrl, '/budgets');
      expect(notification.metadata, {'budgetId': '123'});
    });

    test('should create notification with minimal fields', () {
      // Act
      final notification = AppNotification(
        id: 'minimal-id',
        title: 'Minimal Notification',
        message: 'Minimal message',
        type: NotificationType.systemUpdate,
        priority: NotificationPriority.low,
        createdAt: now,
      );

      // Assert
      expect(notification.id, 'minimal-id');
      expect(notification.title, 'Minimal Notification');
      expect(notification.scheduledFor, isNull);
      expect(notification.isRead, isNull);
      expect(notification.actionUrl, isNull);
      expect(notification.metadata, isNull);
    });

    test('should correctly identify scheduled notifications', () {
      // Arrange
      final scheduledNotification = AppNotification(
        id: 'scheduled',
        title: 'Scheduled',
        message: 'Scheduled message',
        type: NotificationType.billReminder,
        priority: NotificationPriority.medium,
        createdAt: now,
        scheduledFor: futureTime,
      );

      final immediateNotification = AppNotification(
        id: 'immediate',
        title: 'Immediate',
        message: 'Immediate message',
        type: NotificationType.budgetAlert,
        priority: NotificationPriority.high,
        createdAt: now,
      );

      // Assert
      expect(scheduledNotification.isScheduled, true);
      expect(immediateNotification.isScheduled, false);
    });

    test('should correctly identify overdue notifications', () {
      // Arrange
      final overdueNotification = AppNotification(
        id: 'overdue',
        title: 'Overdue',
        message: 'Overdue message',
        type: NotificationType.billReminder,
        priority: NotificationPriority.critical,
        createdAt: now,
        scheduledFor: pastTime,
      );

      final onTimeNotification = AppNotification(
        id: 'on-time',
        title: 'On Time',
        message: 'On time message',
        type: NotificationType.goalMilestone,
        priority: NotificationPriority.medium,
        createdAt: now,
        scheduledFor: futureTime,
      );

      // Assert
      expect(overdueNotification.isOverdue, true);
      expect(onTimeNotification.isOverdue, false);
    });

    test('should calculate time until scheduled correctly', () {
      // Arrange
      final scheduledNotification = AppNotification(
        id: 'timed',
        title: 'Timed',
        message: 'Timed message',
        type: NotificationType.custom,
        priority: NotificationPriority.low,
        createdAt: now,
        scheduledFor: futureTime,
      );

      final immediateNotification = AppNotification(
        id: 'immediate',
        title: 'Immediate',
        message: 'Immediate message',
        type: NotificationType.systemUpdate,
        priority: NotificationPriority.medium,
        createdAt: now,
      );

      // Act
      final timeUntil = scheduledNotification.timeUntilScheduled;
      final noTime = immediateNotification.timeUntilScheduled;

      // Assert
      expect(timeUntil, isNotNull);
      expect(timeUntil!.inHours, greaterThanOrEqualTo(1));
      expect(timeUntil.inHours, lessThanOrEqualTo(2));
      expect(noTime, isNull);
    });

    test('should support copyWith', () {
      // Arrange
      final original = AppNotification(
        id: 'original',
        title: 'Original',
        message: 'Original message',
        type: NotificationType.budgetAlert,
        priority: NotificationPriority.medium,
        createdAt: now,
      );

      // Act
      final updated = original.copyWith(
        title: 'Updated Title',
        isRead: true,
        priority: NotificationPriority.high,
      );

      // Assert
      expect(updated.id, 'original');
      expect(updated.title, 'Updated Title');
      expect(updated.message, 'Original message');
      expect(updated.isRead, true);
      expect(updated.priority, NotificationPriority.high);
    });

    test('should support equality', () {
      // Arrange
      final notification1 = AppNotification(
        id: 'test',
        title: 'Test',
        message: 'Message',
        type: NotificationType.budgetAlert,
        priority: NotificationPriority.medium,
        createdAt: now,
      );

      final notification2 = AppNotification(
        id: 'test',
        title: 'Test',
        message: 'Message',
        type: NotificationType.budgetAlert,
        priority: NotificationPriority.medium,
        createdAt: now,
      );

      final notification3 = notification1.copyWith(title: 'Different');

      // Assert
      expect(notification1, notification2);
      expect(notification1, isNot(notification3));
    });
  });

  group('NotificationType Enum', () {
    test('should have correct values', () {
      // Assert
      expect(NotificationType.budgetAlert.name, 'budgetAlert');
      expect(NotificationType.billReminder.name, 'billReminder');
      expect(NotificationType.goalMilestone.name, 'goalMilestone');
      expect(NotificationType.accountAlert.name, 'accountAlert');
      expect(NotificationType.systemUpdate.name, 'systemUpdate');
      expect(NotificationType.custom.name, 'custom');
    });
  });

  group('NotificationPriority Enum', () {
    test('should have correct values', () {
      // Assert
      expect(NotificationPriority.low.name, 'low');
      expect(NotificationPriority.medium.name, 'medium');
      expect(NotificationPriority.high.name, 'high');
      expect(NotificationPriority.critical.name, 'critical');
    });
  });

  group('NotificationChannel Enum', () {
    test('should have correct values', () {
      // Assert
      expect(NotificationChannel.budget.name, 'budget');
      expect(NotificationChannel.bills.name, 'bills');
      expect(NotificationChannel.goals.name, 'goals');
      expect(NotificationChannel.accounts.name, 'accounts');
      expect(NotificationChannel.system.name, 'system');
    });
  });
}