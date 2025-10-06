import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../features/transactions/presentation/providers/transaction_providers.dart';
import '../../../features/transactions/presentation/widgets/add_transaction_fab.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_animations.dart';
import '../../../core/widgets/skeleton_loader.dart';

/// Home/Dashboard screen with financial overview and quick actions
class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('HomeDashboardScreen: Building dashboard');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FinancialSnapshotCard(),
            const SizedBox(height: 24),
            _QuickActionsBar(),
            const SizedBox(height: 24),
            _BudgetOverviewWidget(),
            const SizedBox(height: 24),
            _RecentTransactionsWidget(),
            const SizedBox(height: 24),
            _InsightsCard(),
          ],
        ),
      ),
      floatingActionButton: const AddTransactionFAB(),
    );
  }
}

/// Financial snapshot card showing spent vs budget and remaining amount
class _FinancialSnapshotCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Implement with actual budget and spending data
    return Card(
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This Month',
              style: AppTypography.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SnapshotItem(
                  label: 'Spent',
                  amount: '\$1,250.00',
                  color: Colors.red,
                ),
                _SnapshotItem(
                  label: 'Budget',
                  amount: '\$2,000.00',
                  color: Colors.blue,
                ),
                _SnapshotItem(
                  label: 'Remaining',
                  amount: '\$750.00',
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            LinearProgressIndicator(
              value: 0.625, // 1250/2000
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class _SnapshotItem extends StatelessWidget {
  const _SnapshotItem({
    required this.label,
    required this.amount,
    required this.color,
  });

  final String label;
  final String amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTypography.caption.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          amount,
          style: AppTypography.titleLarge.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// Quick actions bar with common actions
class _QuickActionsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: AppTypography.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _QuickActionButton(
                  icon: Icons.add,
                  label: 'Add Transaction',
                  onPressed: () => context.go('/transactions/add'),
                ),
                _QuickActionButton(
                  icon: Icons.account_balance_wallet,
                  label: 'View Accounts',
                  onPressed: () => context.go('/accounts'),
                ),
                _QuickActionButton(
                  icon: Icons.camera_alt,
                  label: 'Scan Receipt',
                  onPressed: () {
                    // TODO: Implement receipt scanning
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.sm),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Budget overview showing top spending categories with progress bars
class _BudgetOverviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Budget Overview',
                  style: AppTypography.titleLarge,
                ),
                TextButton(
                  onPressed: () => context.go('/budgets'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            // TODO: Replace with actual budget data
            _BudgetCategoryItem(
              category: 'Food & Dining',
              spent: 450.00,
              budget: 600.00,
              color: Colors.orange,
            ),
            const SizedBox(height: AppSpacing.sm),
            _BudgetCategoryItem(
              category: 'Transportation',
              spent: 280.00,
              budget: 400.00,
              color: Colors.blue,
            ),
            const SizedBox(height: AppSpacing.sm),
            _BudgetCategoryItem(
              category: 'Entertainment',
              spent: 150.00,
              budget: 200.00,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}

class _BudgetCategoryItem extends StatelessWidget {
  const _BudgetCategoryItem({
    required this.category,
    required this.spent,
    required this.budget,
    required this.color,
  });

  final String category;
  final double spent;
  final double budget;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final percentage = spent / budget;
    final isOverBudget = percentage > 1.0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: AppTypography.bodyMedium,
            ),
            Text(
              '\$${spent.toStringAsFixed(0)} / \$${budget.toStringAsFixed(0)}',
              style: AppTypography.bodyMedium.copyWith(
                color: isOverBudget ? Colors.red : Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        LinearProgressIndicator(
          value: percentage.clamp(0.0, 1.0),
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            isOverBudget ? Colors.red : color,
          ),
        ),
      ],
    );
  }
}

/// Upcoming bills widget
class _UpcomingBillsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Bills',
                  style: AppTypography.titleLarge,
                ),
                TextButton(
                  onPressed: () => context.go('/bills'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            // TODO: Replace with actual bills data
            _BillItem(
              title: 'Electricity Bill',
              amount: 85.50,
              dueDate: 'Due in 3 days',
              isOverdue: false,
            ),
            const SizedBox(height: AppSpacing.sm),
            _BillItem(
              title: 'Internet Bill',
              amount: 65.00,
              dueDate: 'Due in 7 days',
              isOverdue: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _BillItem extends StatelessWidget {
  const _BillItem({
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.isOverdue,
  });

  final String title;
  final double amount;
  final String dueDate;
  final bool isOverdue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: isOverdue ? Colors.red : Colors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodyMedium,
              ),
              Text(
                dueDate,
                style: AppTypography.caption.copyWith(
                  color: isOverdue ? Colors.red : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// Recent transactions list
class _RecentTransactionsWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(filteredTransactionsProvider);

    return Card(
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: AppTypography.titleLarge,
                ),
                TextButton(
                  onPressed: () => context.go('/transactions'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            transactionsAsync.when(
              loading: () => _RecentTransactionsSkeleton(),
              error: (error, stack) => Center(
                child: Text('Error loading transactions: $error'),
              ),
              data: (transactions) {
                if (transactions.isEmpty) {
                  return const Center(
                    child: Text('No transactions yet'),
                  );
                }

                final recentTransactions = transactions.take(5).toList();
                return Column(
                  children: recentTransactions.map((transaction) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        child: Icon(
                          transaction.amount < 0 ? Icons.arrow_upward : Icons.arrow_downward,
                          color: transaction.amount < 0 ? Colors.red : Colors.green,
                        ),
                      ),
                      title: Text(transaction.title),
                      subtitle: Text(
                        '${transaction.categoryId} • ${transaction.date.toString().split(' ')[0]}',
                      ),
                      trailing: Text(
                        '${transaction.amount < 0 ? '-' : '+'}\$${transaction.amount.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: transaction.amount < 0 ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () => context.go('/transactions/${transaction.id}'),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Rotating insights card
class _InsightsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Insight',
                  style: AppTypography.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'You\'ve saved 15% more this month compared to last month. Great job!',
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.go('/insights'),
                child: const Text('View Insights'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton loading for recent transactions
class _RecentTransactionsSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      child: Column(
        children: List.generate(
          5,
          (index) => const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: _TransactionListItemSkeleton(),
          ),
        ),
      ),
    );
  }
}

class _TransactionListItemSkeleton extends StatelessWidget {
  const _TransactionListItemSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const SkeletonCircle(size: 40),
      title: const SkeletonText(width: 120, height: 16),
      subtitle: const SkeletonText(width: 80, height: 14),
      trailing: const SkeletonText(width: 60, height: 16),
    );
  }
}
