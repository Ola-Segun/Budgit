import 'package:flutter/material.dart';

import '../../domain/entities/settings.dart';

/// Widget for managing notification settings
class NotificationSettings extends StatelessWidget {
  const NotificationSettings({
    super.key,
    required this.settings,
    required this.onNotificationsEnabledChanged,
    required this.onBudgetAlertsEnabledChanged,
    required this.onBillRemindersEnabledChanged,
    required this.onBudgetAlertThresholdChanged,
    required this.onBillReminderDaysChanged,
  });

  final AppSettings settings;
  final ValueChanged<bool> onNotificationsEnabledChanged;
  final ValueChanged<bool> onBudgetAlertsEnabledChanged;
  final ValueChanged<bool> onBillRemindersEnabledChanged;
  final ValueChanged<int> onBudgetAlertThresholdChanged;
  final ValueChanged<int> onBillReminderDaysChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // General notifications
        SwitchListTile(
          title: const Text('Enable Notifications'),
          subtitle: const Text('Receive notifications for important events'),
          value: settings.notificationsEnabled,
          onChanged: onNotificationsEnabledChanged,
        ),

        // Budget alerts
        SwitchListTile(
          title: const Text('Budget Alerts'),
          subtitle: const Text('Get notified when approaching budget limits'),
          value: settings.budgetAlertsEnabled,
          onChanged: onBudgetAlertsEnabledChanged,
        ),

        // Bill reminders
        SwitchListTile(
          title: const Text('Bill Reminders'),
          subtitle: const Text('Get reminded about upcoming bills'),
          value: settings.billRemindersEnabled,
          onChanged: onBillRemindersEnabledChanged,
        ),

        // Budget alert threshold
        ListTile(
          title: const Text('Budget Alert Threshold'),
          subtitle: Text('${settings.budgetAlertThreshold}% of budget'),
          trailing: SizedBox(
            width: 120,
            child: Slider(
              value: settings.budgetAlertThreshold.toDouble(),
              min: 50,
              max: 100,
              divisions: 10,
              onChanged: (value) => onBudgetAlertThresholdChanged(value.toInt()),
            ),
          ),
        ),

        // Bill reminder days
        ListTile(
          title: const Text('Bill Reminder Days'),
          subtitle: Text('${settings.billReminderDays} days before due date'),
          trailing: SizedBox(
            width: 120,
            child: Slider(
              value: settings.billReminderDays.toDouble(),
              min: 1,
              max: 14,
              divisions: 13,
              onChanged: (value) => onBillReminderDaysChanged(value.toInt()),
            ),
          ),
        ),
      ],
    );
  }
}