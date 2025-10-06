import 'package:flutter/material.dart';

/// Settings tile for notification preferences
class NotificationSettingsTile extends StatelessWidget {
  const NotificationSettingsTile({
    super.key,
    required this.notificationsEnabled,
    required this.budgetAlertsEnabled,
    required this.billRemindersEnabled,
    required this.budgetAlertThreshold,
    required this.billReminderDays,
    required this.onNotificationsEnabledChanged,
    required this.onBudgetAlertsEnabledChanged,
    required this.onBillRemindersEnabledChanged,
    required this.onBudgetAlertThresholdChanged,
    required this.onBillReminderDaysChanged,
  });

  final bool notificationsEnabled;
  final bool budgetAlertsEnabled;
  final bool billRemindersEnabled;
  final int budgetAlertThreshold;
  final int billReminderDays;
  final ValueChanged<bool> onNotificationsEnabledChanged;
  final ValueChanged<bool> onBudgetAlertsEnabledChanged;
  final ValueChanged<bool> onBillRemindersEnabledChanged;
  final ValueChanged<int> onBudgetAlertThresholdChanged;
  final ValueChanged<int> onBillReminderDaysChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Master notifications toggle
        SwitchListTile(
          secondary: const Icon(Icons.notifications),
          title: const Text('Enable Notifications'),
          subtitle: const Text('Receive alerts and reminders'),
          value: notificationsEnabled,
          onChanged: onNotificationsEnabledChanged,
        ),

        if (notificationsEnabled) ...[
          // Budget alerts
          SwitchListTile(
            secondary: const Icon(Icons.account_balance_wallet),
            title: const Text('Budget Alerts'),
            subtitle: const Text('Get notified when approaching budget limits'),
            value: budgetAlertsEnabled,
            onChanged: onBudgetAlertsEnabledChanged,
          ),

          if (budgetAlertsEnabled) ...[
            ListTile(
              title: const Text('Budget Alert Threshold'),
              subtitle: Text('$budgetAlertThreshold% of budget limit'),
              trailing: DropdownButton<int>(
                value: budgetAlertThreshold,
                onChanged: (value) {
                  if (value != null) {
                    onBudgetAlertThresholdChanged(value);
                  }
                },
                items: [50, 75, 80, 90, 95].map((threshold) {
                  return DropdownMenuItem(
                    value: threshold,
                    child: Text('$threshold%'),
                  );
                }).toList(),
              ),
            ),
          ],

          // Bill reminders
          SwitchListTile(
            secondary: const Icon(Icons.receipt),
            title: const Text('Bill Reminders'),
            subtitle: const Text('Get reminded about upcoming bills'),
            value: billRemindersEnabled,
            onChanged: onBillRemindersEnabledChanged,
          ),

          if (billRemindersEnabled) ...[
            ListTile(
              title: const Text('Reminder Timing'),
              subtitle: Text('$billReminderDays days before due date'),
              trailing: DropdownButton<int>(
                value: billReminderDays,
                onChanged: (value) {
                  if (value != null) {
                    onBillReminderDaysChanged(value);
                  }
                },
                items: [1, 3, 7, 14].map((days) {
                  return DropdownMenuItem(
                    value: days,
                    child: Text('$days day${days == 1 ? '' : 's'}'),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ],
    );
  }
}