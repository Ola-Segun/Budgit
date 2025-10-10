import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import '../../../transactions/presentation/widgets/transaction_tile.dart';
import '../../domain/entities/account.dart';
import '../providers/account_providers.dart';
import '../widgets/add_edit_account_bottom_sheet.dart';
import '../widgets/account_balance_card.dart';

/// Screen for displaying detailed account information and transactions
class AccountDetailScreen extends ConsumerStatefulWidget {
  const AccountDetailScreen({
    super.key,
    required this.accountId,
  });

  final String accountId;

  @override
  ConsumerState<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends ConsumerState<AccountDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final accountAsync = ref.watch(accountProvider(widget.accountId));
    final accountTransactionsAsync = ref.watch(accountTransactionsProvider(widget.accountId));

    return Scaffold(
      appBar: AppBar(
        title: accountAsync.when(
          data: (account) => Text(account?.name ?? 'Account Details'),
          loading: () => const Text('Loading...'),
          error: (error, stack) => const Text('Account Details'),
        ),
        actions: [
          accountAsync.when(
            data: (account) {
              if (account == null) return const SizedBox.shrink();
              return PopupMenuButton<String>(
                onSelected: (value) => _handleMenuAction(context, ref, account, value),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Edit Account'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete Account', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: accountAsync.when(
        data: (account) {
          if (account == null) {
            return const Center(
              child: Text('Account not found'),
            );
          }

          return _buildAccountDetail(context, ref, account, accountTransactionsAsync);
        },
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(accountProvider(widget.accountId)),
        ),
      ),
    );
  }

  Widget _buildAccountDetail(
    BuildContext context,
    WidgetRef ref,
    Account account,
    AsyncValue<List<Transaction>> transactionsAsync,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          ref.read(accountNotifierProvider.notifier).loadAccounts(),
          ref.read(transactionNotifierProvider.notifier).loadTransactions(),
        ]);
      },
      child: ListView(
        padding: AppTheme.screenPaddingAll,
        children: [
          // Account Balance Card
          AccountBalanceCard(account: account),
          const SizedBox(height: 24),

          // Account Information
          _buildAccountInfo(context, account),
          const SizedBox(height: 24),

          // Recent Transactions
          _buildRecentTransactions(context, transactionsAsync),
        ],
      ),
    );
  }

  Widget _buildAccountInfo(BuildContext context, Account account) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),

            // Account Type
            _buildInfoRow('Type', account.type.displayName),

            // Institution
            if (account.institution != null)
              _buildInfoRow('Institution', account.institution!),

            // Account Number
            if (account.accountNumber != null)
              _buildInfoRow('Account Number', account.accountNumber!),

            // Currency
            _buildInfoRow('Currency', account.currency),

            // Status
            _buildInfoRow('Status', account.isActive ? 'Active' : 'Inactive'),

            // Created Date
            if (account.createdAt != null)
              _buildInfoRow(
                'Created',
                DateFormat('MMM dd, yyyy').format(account.createdAt!),
              ),

            // Description
            if (account.description != null && account.description!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                account.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],

            // Type-specific information
            ..._buildTypeSpecificInfo(context, account),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTypeSpecificInfo(BuildContext context, Account account) {
    switch (account.type) {
      case AccountType.creditCard:
        return [
          if (account.creditLimit != null) ...[
            const SizedBox(height: 16),
            Text(
              'Credit Card Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            _buildInfoRow('Credit Limit', '${account.currency} ${account.creditLimit!.toStringAsFixed(2)}'),
            if (account.availableCredit != null)
              _buildInfoRow('Available Credit', '${account.currency} ${account.availableCredit!.toStringAsFixed(2)}'),
            if (account.utilizationRate != null)
              _buildInfoRow('Utilization', '${(account.utilizationRate! * 100).toStringAsFixed(1)}%'),
            if (account.minimumPayment != null)
              _buildInfoRow('Minimum Payment', '${account.currency} ${account.minimumPayment!.toStringAsFixed(2)}'),
          ],
        ];

      case AccountType.loan:
        return [
          if (account.interestRate != null || account.minimumPayment != null) ...[
            const SizedBox(height: 16),
            Text(
              'Loan Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            if (account.interestRate != null)
              _buildInfoRow('Interest Rate', '${account.interestRate!.toStringAsFixed(2)}%'),
            if (account.minimumPayment != null)
              _buildInfoRow('Monthly Payment', '${account.currency} ${account.minimumPayment!.toStringAsFixed(2)}'),
          ],
        ];

      default:
        return [];
    }
  }

  Widget _buildRecentTransactions(
    BuildContext context,
    AsyncValue<List<Transaction>> transactionsAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                // TODO: Navigate to full transaction list for this account
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('View all transactions - Coming soon!')),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        transactionsAsync.when(
          data: (transactions) {
            if (transactions.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 48,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No transactions yet',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Transactions for this account will appear here',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            // Show only recent 10 transactions
            final recentTransactions = transactions.take(10).toList();

            return Column(
              children: recentTransactions.map((transaction) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TransactionTile(transaction: transaction),
                );
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Failed to load transactions: $error'),
          ),
        ),
      ],
    );
  }

  void _handleMenuAction(
    BuildContext context,
    WidgetRef ref,
    Account account,
    String action,
  ) {
    switch (action) {
      case 'edit':
        _showEditAccountSheet(context, ref, account);
        break;
      case 'delete':
        _showDeleteConfirmation(context, ref, account);
        break;
    }
  }

  Future<void> _showEditAccountSheet(
    BuildContext context,
    WidgetRef ref,
    Account account,
  ) async {
    await AppBottomSheet.show(
      context: context,
      child: AddEditAccountBottomSheet(
        account: account,
        onSubmit: (updatedAccount) async {
          final success = await ref
              .read(accountNotifierProvider.notifier)
              .updateAccount(updatedAccount);

          if (success && mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account updated successfully')),
            );
          }
        },
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    Account account,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: Text(
          'Are you sure you want to delete "${account.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await ref
          .read(accountNotifierProvider.notifier)
          .deleteAccount(account.id);

      if (success && mounted) {
        context.go('/more/accounts'); // Go back to accounts list
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted successfully')),
        );
      }
    }
  }
}