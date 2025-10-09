import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// More menu screen with navigation to sub-features
class MoreMenuScreen extends StatelessWidget {
  const MoreMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: ListView(
        padding: AppSpacing.screenPaddingAll,
        children: [
          _MenuSection(
            title: 'Financial Management',
            items: [
              _MenuItem(
                icon: Icons.account_balance_wallet,
                title: 'Accounts',
                subtitle: 'Manage your bank accounts and cards',
                onTap: () => context.go('/more/accounts'),
              ),
              _MenuItem(
                icon: Icons.receipt_long,
                title: 'Bills & Subscriptions',
                subtitle: 'Track recurring payments',
                onTap: () => context.go('/more/bills'),
              ),
              _MenuItem(
                icon: Icons.account_balance,
                title: 'Debt Manager',
                subtitle: 'Monitor and manage your debts',
                onTap: () => context.go('/more/debt'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _MenuSection(
            title: 'Insights & Analytics',
            items: [
              _MenuItem(
                icon: Icons.insights,
                title: 'Insights & Reports',
                subtitle: 'View spending analytics and trends',
                onTap: () => context.go('/more/insights'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _MenuSection(
            title: 'Settings & Support',
            items: [
              _MenuItem(
                icon: Icons.settings,
                title: 'Settings',
                subtitle: 'App preferences and configuration',
                onTap: () => context.go('/more/settings'),
              ),
              _MenuItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'FAQs, contact support, tutorials',
                onTap: () => context.go('/more/help'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<_MenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppSpacing.md, bottom: AppSpacing.sm),
          child: Text(
            title,
            style: AppTypography.labelLarge.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall,
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[400],
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
    );
  }
}