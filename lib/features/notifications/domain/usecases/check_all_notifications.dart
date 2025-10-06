import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import 'check_bill_reminders.dart';
import 'check_budget_alerts.dart';
import '../entities/notification.dart';

/// Use case for checking all types of notifications
class CheckAllNotifications {
  const CheckAllNotifications(
    this._checkBudgetAlerts,
    this._checkBillReminders,
  );

  final CheckBudgetAlerts _checkBudgetAlerts;
  final CheckBillReminders _checkBillReminders;

  /// Check for all types of notifications
  Future<Result<List<AppNotification>>> call() async {
    try {
      final budgetAlertsResult = await _checkBudgetAlerts();
      final billRemindersResult = await _checkBillReminders();

      if (budgetAlertsResult.isError) {
        return Result.error(budgetAlertsResult.failureOrNull!);
      }

      if (billRemindersResult.isError) {
        return Result.error(billRemindersResult.failureOrNull!);
      }

      final allNotifications = [
        ...budgetAlertsResult.dataOrNull!,
        ...billRemindersResult.dataOrNull!,
      ];

      // Sort by priority (critical first) and then by creation time
      allNotifications.sort((a, b) {
        // First sort by priority (higher priority first)
        final priorityComparison = b.priority.index.compareTo(a.priority.index);
        if (priorityComparison != 0) return priorityComparison;

        // Then sort by creation time (newest first)
        return b.createdAt.compareTo(a.createdAt);
      });

      return Result.success(allNotifications);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to check all notifications: $e'));
    }
  }
}