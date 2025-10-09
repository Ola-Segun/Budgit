import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart' as core_providers;
import '../../../settings/presentation/providers/settings_providers.dart' as settings_providers;
import '../../domain/entities/notification.dart';
import '../../domain/services/notification_service.dart';
import '../../domain/usecases/check_all_notifications.dart';
import '../../domain/usecases/check_bill_reminders.dart';
import '../../domain/usecases/check_budget_alerts.dart';
import '../notifiers/notification_notifier.dart';
import '../states/notification_state.dart';

// Use case providers
final checkBudgetAlertsProvider = Provider<CheckBudgetAlerts>((ref) {
  final budgetRepository = ref.watch(core_providers.budgetRepositoryProvider);
  final settingsRepository = ref.watch(settings_providers.settingsRepositoryProvider);
  final calculateBudgetStatus = ref.watch(core_providers.calculateBudgetStatusProvider);

  return CheckBudgetAlerts(
    budgetRepository,
    settingsRepository,
    calculateBudgetStatus,
  );
});

final checkBillRemindersProvider = Provider<CheckBillReminders>((ref) {
  final billRepository = ref.watch(core_providers.billRepositoryProvider);
  final settingsRepository = ref.watch(settings_providers.settingsRepositoryProvider);

  return CheckBillReminders(billRepository, settingsRepository);
});

final checkAllNotificationsProvider = Provider<CheckAllNotifications>((ref) {
  final checkBudgetAlerts = ref.watch(checkBudgetAlertsProvider);
  final checkBillReminders = ref.watch(checkBillRemindersProvider);

  return CheckAllNotifications(checkBudgetAlerts, checkBillReminders);
});

// Notification service provider
final notificationServiceProvider = Provider<NotificationService>((ref) {
  final checkAllNotifications = ref.watch(checkAllNotificationsProvider);
  return NotificationService(checkAllNotifications);
});

// State notifier provider
final notificationNotifierProvider = StateNotifierProvider<NotificationNotifier, AsyncValue<NotificationState>>((ref) {
  final notificationService = ref.watch(notificationServiceProvider);
  return NotificationNotifier(notificationService);
});

// Convenience providers
final currentNotificationsProvider = Provider<AsyncValue<List<AppNotification>>>((ref) {
  final notificationState = ref.watch(notificationNotifierProvider);
  return notificationState.when(
    data: (state) => AsyncValue.data(state.notifications),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final unreadNotificationsCountProvider = Provider<int>((ref) {
  final notificationsAsync = ref.watch(currentNotificationsProvider);
  return notificationsAsync.maybeWhen(
    data: (notifications) => notifications.where((n) => !(n.isRead ?? false)).length,
    orElse: () => 0,
  );
});