import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../providers/debt_providers.dart';

/// Screen for displaying debt management dashboard
class DebtDashboardScreen extends ConsumerWidget {
  const DebtDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debtState = ref.watch(debtNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debt Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add debt screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add debt - Coming soon!')),
              );
            },
          ),
        ],
      ),
      body: debtState.when(
        data: (state) => _buildBody(context, state),
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(debtNotifierProvider),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, dynamic state) {
    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Implement refresh
      },
      child: ListView(
        padding: AppTheme.screenPaddingAll,
        children: [
          // Debt Summary Cards
          _buildSummaryCards(context, state),
          const SizedBox(height: 24),

          // Debt List
          _buildDebtList(context, state),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context, dynamic state) {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            context,
            'Total Debt',
            '\$${state.totalDebtAmount.toStringAsFixed(2)}',
            Colors.red,
            Icons.account_balance_wallet,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard(
            context,
            'Remaining',
            '\$${state.totalRemainingAmount.toStringAsFixed(2)}',
            Colors.orange,
            Icons.money_off,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebtList(BuildContext context, dynamic state) {
    if (state.debts.isEmpty) {
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
              'No debts yet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first debt to start tracking',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                // TODO: Navigate to add debt screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add debt - Coming soon!')),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Debt'),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Debts',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 16),
        ...state.debts.map<Widget>((debt) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(debt.type.defaultColor).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  IconData(
                    int.parse(debt.type.icon.replaceFirst('0x', ''), radix: 16),
                    fontFamily: 'MaterialIcons',
                  ),
                  color: Color(debt.type.defaultColor),
                  size: 20,
                ),
              ),
              title: Text(debt.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${debt.type.displayName} • ${debt.priority.displayName}'),
                  Text(
                    'Remaining: \$${debt.remainingAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: debt.isOverdue ? Colors.red : null,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${(debt.payoffProgress * 100).round()}%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (debt.daysRemaining > 0)
                    Text(
                      '${debt.daysRemaining}d left',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                ],
              ),
              onTap: () {
                // TODO: Navigate to debt detail screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('View ${debt.name} - Coming soon!')),
                );
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}