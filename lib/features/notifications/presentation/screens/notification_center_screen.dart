import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/notification.dart';
import '../providers/notification_providers.dart';

/// Screen for displaying notification center with all notifications
class NotificationCenterScreen extends ConsumerStatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  ConsumerState<NotificationCenterScreen> createState() => _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends ConsumerState<NotificationCenterScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(currentNotificationsProvider);
    final unreadCount = ref.watch(unreadNotificationsCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$unreadCount',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          // TODO: Add mark all as read functionality
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Unread'),
            Tab(text: 'Read'),
          ],
        ),
      ),
      body: notificationsAsync.when(
        data: (notifications) => _buildNotificationList(context, notifications),
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(notificationNotifierProvider),
        ),
      ),
    );
  }

  Widget _buildNotificationList(BuildContext context, List<AppNotification> allNotifications) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildFilteredList(allNotifications, (n) => true), // All
        _buildFilteredList(allNotifications, (n) => !(n.isRead ?? false)), // Unread
        _buildFilteredList(allNotifications, (n) => n.isRead ?? false), // Read
      ],
    );
  }

  Widget _buildFilteredList(
    List<AppNotification> notifications,
    bool Function(AppNotification) filter,
  ) {
    final filteredNotifications = notifications.where(filter).toList();

    if (filteredNotifications.isEmpty) {
      return _buildEmptyState();
    }

    // Group by date
    final groupedNotifications = _groupNotificationsByDate(filteredNotifications);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(notificationNotifierProvider.notifier).checkForNotifications();
      },
      child: ListView.builder(
        padding: AppTheme.screenPaddingAll,
        itemCount: groupedNotifications.length,
        itemBuilder: (context, index) {
          final entry = groupedNotifications.entries.elementAt(index);
          return _buildNotificationGroup(context, entry.key, entry.value);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re all caught up!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Map<String, List<AppNotification>> _groupNotificationsByDate(List<AppNotification> notifications) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final groups = <String, List<AppNotification>>{};

    for (final notification in notifications) {
      final notificationDate = DateTime(
        notification.createdAt.year,
        notification.createdAt.month,
        notification.createdAt.day,
      );

      String dateKey;
      if (notificationDate == today) {
        dateKey = 'Today';
      } else if (notificationDate == yesterday) {
        dateKey = 'Yesterday';
      } else {
        dateKey = DateFormat('MMM dd, yyyy').format(notification.createdAt);
      }

      groups.putIfAbsent(dateKey, () => []).add(notification);
    }

    return groups;
  }

  Widget _buildNotificationGroup(BuildContext context, String date, List<AppNotification> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            date,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        ...notifications.map((notification) => _buildNotificationTile(context, notification)),
      ],
    );
  }

  Widget _buildNotificationTile(BuildContext context, AppNotification notification) {
    final isUnread = !(notification.isRead ?? false);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isUnread ? Theme.of(context).primaryColor.withOpacity(0.05) : null,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getNotificationColor(notification.type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getNotificationIcon(notification.type),
            color: _getNotificationColor(notification.type),
          ),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            const SizedBox(height: 4),
            Text(
              _formatTime(notification.createdAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        trailing: isUnread
            ? Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: () => _handleNotificationTap(context, notification),
        onLongPress: () => _showNotificationActions(context, notification),
      ),
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.budgetAlert:
        return Colors.orange;
      case NotificationType.billReminder:
        return Colors.blue;
      case NotificationType.goalMilestone:
        return Colors.green;
      case NotificationType.accountAlert:
        return Colors.red;
      case NotificationType.systemUpdate:
        return Colors.purple;
      case NotificationType.custom:
        return Colors.grey;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.budgetAlert:
        return Icons.warning;
      case NotificationType.billReminder:
        return Icons.schedule;
      case NotificationType.goalMilestone:
        return Icons.flag;
      case NotificationType.accountAlert:
        return Icons.account_balance;
      case NotificationType.systemUpdate:
        return Icons.system_update;
      case NotificationType.custom:
        return Icons.notifications;
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return DateFormat('MMM dd').format(dateTime);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void _handleNotificationTap(BuildContext context, AppNotification notification) {
    // Mark as read if not already
    if (!(notification.isRead ?? false)) {
      ref.read(notificationNotifierProvider.notifier).markAsRead(notification.id);
    }

    // Handle action URL or specific navigation
    if (notification.actionUrl != null) {
      // TODO: Navigate to action URL
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Navigate to: ${notification.actionUrl}')),
      );
    }
  }

  void _showNotificationActions(BuildContext context, AppNotification notification) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.check),
            title: const Text('Mark as read'),
            onTap: () {
              ref.read(notificationNotifierProvider.notifier).markAsRead(notification.id);
              Navigator.pop(context);
            },
          ),
          // TODO: Add delete functionality when implemented
        ],
      ),
    );
  }
}