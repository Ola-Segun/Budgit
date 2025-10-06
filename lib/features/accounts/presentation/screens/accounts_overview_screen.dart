import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../providers/account_providers.dart';
import '../widgets/account_card.dart';
import '../widgets/add_edit_account_bottom_sheet.dart';
import '../widgets/net_worth_card.dart';

/// Screen for displaying accounts overview with net worth
class AccountsOverviewScreen extends ConsumerWidget {
  const AccountsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountState = ref.watch(accountNotifierProvider);
    final accountsByType = ref.watch(accountsByTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddAccountSheet(context, ref),
          ),
        ],
      ),
      body: accountState.when(
        data: (state) => _buildBody(context, ref, state, accountsByType),
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(accountNotifierProvider),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    dynamic state,
    AsyncValue<Map<dynamic, List<dynamic>>> accountsByType,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(accountNotifierProvider.notifier).loadAccounts();
      },
      child: ListView(
        padding: AppTheme.screenPaddingAll,
        children: [
          // Net Worth Card
          NetWorthCard(
            netWorth: state.netWorth,
            totalAssets: state.totalAssets,
            totalLiabilities: state.totalLiabilities,
          ),
          const SizedBox(height: 24),

          // Accounts by Type
          accountsByType.when(
            data: (accountsMap) => _buildAccountsList(context, ref, accountsMap),
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsList(BuildContext context, WidgetRef ref, Map<dynamic, List<dynamic>> accountsByType) {
    if (accountsByType.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    final widgets = <Widget>[];

    for (final entry in accountsByType.entries) {
      final accountType = entry.key;
      final accounts = entry.value;

      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            accountType.displayName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );

      for (final account in accounts) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AccountCard(
              account: account,
              onTap: () {
                // TODO: Navigate to account detail
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Account: ${account.name}')),
                );
              },
            ),
          ),
        );
      }

      widgets.add(const SizedBox(height: 16));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No accounts yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first account to start tracking your finances',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _showAddAccountSheet(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Add Account'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddAccountSheet(BuildContext context, WidgetRef ref) async {
    await AppBottomSheet.show(
      context: context,
      child: AddEditAccountBottomSheet(
        onSubmit: (account) async {
          final success = await ref
              .read(accountNotifierProvider.notifier)
              .createAccount(account);

          if (success) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account added successfully')),
            );
          }
        },
      ),
    );
  }
}