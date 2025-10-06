import 'package:flutter/material.dart';

/// Settings tile for account management
class AccountSettingsTile extends StatelessWidget {
  const AccountSettingsTile({
    super.key,
    required this.onManageAccounts,
    required this.onSignOut,
  });

  final VoidCallback onManageAccounts;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.account_balance),
          title: const Text('Manage Accounts'),
          subtitle: const Text('Add, edit, or delete accounts'),
          trailing: const Icon(Icons.chevron_right),
          onTap: onManageAccounts,
        ),
        const Divider(height: 1),
        ListTile(
          leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
          title: Text('Sign Out', style: TextStyle(color: Theme.of(context).colorScheme.error)),
          subtitle: const Text('Sign out of your account'),
          onTap: onSignOut,
        ),
      ],
    );
  }
}