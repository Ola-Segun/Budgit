import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../bills/domain/entities/bill.dart';
import '../../../bills/domain/repositories/bill_repository.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../entities/notification.dart';

/// Use case for checking bill reminders
class CheckBillReminders {
  const CheckBillReminders(
    this._billRepository,
    this._settingsRepository,
  );

  final BillRepository _billRepository;
  final SettingsRepository _settingsRepository;

  /// Check for bill reminders and return notifications
  Future<Result<List<AppNotification>>> call() async {
    try {
      // Get settings to check if bill reminders are enabled
      final settingsResult = await _settingsRepository.getSettings();
      if (settingsResult.isError) {
        return Result.error(settingsResult.failureOrNull!);
      }

      final settings = settingsResult.dataOrNull!;
      if (!settings.billRemindersEnabled) {
        return const Result.success([]);
      }

      // Get all bills
      final billsResult = await _billRepository.getAll();
      if (billsResult.isError) {
        return Result.error(billsResult.failureOrNull!);
      }

      final bills = billsResult.dataOrNull!;
      final notifications = <AppNotification>[];

      for (final bill in bills) {
        final reminder = _checkBillReminder(bill, settings.billReminderDays);
        if (reminder != null) {
          notifications.add(reminder);
        }
      }

      return Result.success(notifications);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to check bill reminders: $e'));
    }
  }

  AppNotification? _checkBillReminder(Bill bill, int reminderDays) {
    // Skip if bill is already paid
    if (bill.isPaid) return null;

    final daysUntilDue = bill.daysUntilDue;

    // Check if bill is due within the reminder period
    if (daysUntilDue > reminderDays || daysUntilDue < 0) return null;

    final priority = bill.isOverdue
        ? NotificationPriority.critical
        : bill.isDueToday
            ? NotificationPriority.high
            : NotificationPriority.medium;

    final dueDateStr = bill.dueDate.toString().split(' ')[0]; // YYYY-MM-DD format

    return AppNotification(
      id: 'bill_reminder_${bill.id}_${DateTime.now().millisecondsSinceEpoch}',
      title: bill.isOverdue ? 'Overdue Bill: ${bill.name}' : 'Upcoming Bill: ${bill.name}',
      message: bill.isOverdue
          ? '${bill.name} was due on $dueDateStr. Please pay \$${bill.amount.toStringAsFixed(2)} as soon as possible.'
          : '${bill.name} is due in ${daysUntilDue == 0 ? 'today' : '$daysUntilDue day${daysUntilDue == 1 ? '' : 's'}'} ($dueDateStr). Amount: \$${bill.amount.toStringAsFixed(2)}.',
      type: NotificationType.billReminder,
      priority: priority,
      createdAt: DateTime.now(),
      scheduledFor: bill.dueDate.subtract(Duration(days: reminderDays)),
      metadata: {
        'billId': bill.id,
        'dueDate': dueDateStr,
        'amount': bill.amount,
        'daysUntilDue': daysUntilDue,
        'isOverdue': bill.isOverdue,
      },
    );
  }
}