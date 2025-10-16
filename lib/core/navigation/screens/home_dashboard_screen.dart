import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

import '../../../features/dashboard/presentation/providers/dashboard_providers.dart';
import '../../../features/dashboard/domain/entities/dashboard_data.dart';
import '../../../features/bills/domain/entities/bill.dart';
import '../../../features/recurring_incomes/domain/entities/recurring_income.dart';
import '../../../features/transactions/domain/entities/transaction.dart';
import '../../../features/insights/domain/entities/insight.dart';
import '../../../features/transactions/presentation/widgets/add_transaction_fab.dart';
import '../../../features/transactions/presentation/widgets/transaction_detail_bottom_sheet.dart';
import '../../../features/transactions/presentation/providers/transaction_providers.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/notification_manager.dart';

/// Header with current period, settings icon, and notification bell
class _DashboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentPeriod = DateFormat('MMMM yyyy').format(now);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Current period
          Text(
            currentPeriod,
            style: AppTypography.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          // Settings and notification icons
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => context.go('/more/settings'),
                tooltip: 'Settings',
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () => context.go('/more/notifications'),
                tooltip: 'Notifications',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Home/Dashboard screen with financial overview and quick actions
class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardDataProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // Header with current period, settings, and notifications
            _DashboardHeader(),
            // Main content
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: constraints.maxWidth,
                      child: dashboardAsync.when(
                        loading: () => _DashboardSkeleton(),
                        error: (error, stack) => Center(
                          child: Text('Error loading dashboard: $error'),
                        ),
                        data: (dashboardData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Financial Snapshot Card
                              _FinancialSnapshotCard(snapshot: dashboardData.financialSnapshot),
                              const SizedBox(height: 24),
                              // Quick Actions Bar
                              _QuickActionsBar(),
                              const SizedBox(height: 24),
                              // Budget Overview
                              _BudgetOverviewWidget(budgetOverview: dashboardData.budgetOverview),
                              const SizedBox(height: 24),
                              // Upcoming Payments & Income Widget
                              _UpcomingPaymentsWidget(
                                upcomingBills: dashboardData.upcomingBills,
                                upcomingIncomes: dashboardData.upcomingIncomes,
                              ),
                              const SizedBox(height: 24),
                              // Recent Transactions
                              _RecentTransactionsWidget(recentTransactions: dashboardData.recentTransactions),
                              const SizedBox(height: 24),
                              // Insights Card
                              _InsightsCard(insights: dashboardData.insights),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const AddTransactionFAB(),
    );
  }
}

/// Financial snapshot card showing income vs expenses and balance
class _FinancialSnapshotCard extends StatelessWidget {
  const _FinancialSnapshotCard({required this.snapshot});

  final FinancialSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
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
              children: [
                Expanded(
                  child: _SnapshotItem(
                    label: 'Income',
                    amount: '\$${snapshot.incomeThisMonth.toStringAsFixed(2)}',
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _SnapshotItem(
                    label: 'Expenses',
                    amount: '\$${snapshot.expensesThisMonth.toStringAsFixed(2)}',
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: _SnapshotItem(
                    label: 'Net Worth',
                    amount: '\$${snapshot.netWorth.toStringAsFixed(2)}',
                    color: snapshot.netWorth >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            // Visual progress bar showing income vs expenses
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: snapshot.balancePercentage.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: snapshot.isPositive ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Large bold net worth amount
            Center(
              child: Text(
                '\$${snapshot.netWorth.toStringAsFixed(2)}',
                style: AppTypography.displaySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: snapshot.netWorth >= 0 ? Colors.green : Colors.red,
                ),
              ),
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            amount,
            style: AppTypography.titleLarge.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _QuickActionButton(
                    icon: Icons.add,
                    label: 'Add Transaction',
                    onPressed: () => context.go('/transactions/add'),
                  ),
                  const SizedBox(width: 8),
                  _QuickActionButton(
                    icon: Icons.account_balance_wallet,
                    label: 'View Accounts',
                    onPressed: () => context.go('/more/accounts'),
                  ),
                  const SizedBox(width: 8),
                  _QuickActionButton(
                    icon: Icons.trending_up,
                    label: 'Recurring Income',
                    onPressed: () {
                      developer.log('Navigating to recurring incomes dashboard', name: 'Navigation');
                      context.go('/more/incomes');
                    },
                  ),
                  const SizedBox(width: 8),
                  _QuickActionButton(
                    icon: Icons.camera_alt,
                    label: 'Scan Receipt',
                    onPressed: () => context.go('/scan-receipt'),
                  ),
                ],
              ),
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
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Budget overview showing top spending categories with progress bars
class _BudgetOverviewWidget extends StatelessWidget {
  const _BudgetOverviewWidget({required this.budgetOverview});

  final List<BudgetCategoryOverview> budgetOverview;

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
                Expanded(
                  child: Text(
                    'Budget Overview',
                    style: AppTypography.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/budgets'),
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (budgetOverview.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No budget data available'),
                ),
              )
            else
              ...budgetOverview.take(5).map((category) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _BudgetCategoryItem(
                  category: category.categoryName,
                  spent: category.spent,
                  budget: category.budget,
                  status: category.status,
                ),
              )),
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
    required this.status,
  });

  final String category;
  final double spent;
  final double budget;
  final BudgetHealthStatus status;

  @override
  Widget build(BuildContext context) {
    final percentage = spent / budget;
    final progressColor = _getProgressColor(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                category,
                style: AppTypography.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '\$${spent.toStringAsFixed(0)} / \$${budget.toStringAsFixed(0)}',
              style: AppTypography.bodySmall.copyWith(
                color: status == BudgetHealthStatus.overBudget ? Colors.red : Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        LinearProgressIndicator(
          value: percentage.clamp(0.0, 1.0),
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        ),
      ],
    );
  }

  Color _getProgressColor(BudgetHealthStatus status) {
    switch (status) {
      case BudgetHealthStatus.healthy:
        return Colors.green;
      case BudgetHealthStatus.warning:
        return Colors.yellow;
      case BudgetHealthStatus.critical:
        return Colors.orange;
      case BudgetHealthStatus.overBudget:
        return Colors.red;
    }
  }
}

/// Upcoming payments and income widget
class _UpcomingPaymentsWidget extends StatelessWidget {
  const _UpcomingPaymentsWidget({
    required this.upcomingBills,
    required this.upcomingIncomes,
  });

  final List<Bill> upcomingBills;
  final List<RecurringIncomeStatus> upcomingIncomes;

  @override
  Widget build(BuildContext context) {
    final combinedItems = _combineAndSortItems();

    return Card(
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Upcoming Payments & Income',
                    style: AppTypography.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        developer.log('Navigating to bills dashboard from upcoming payments', name: 'Navigation');
                        context.go('/more/bills');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: const Size(0, 36),
                      ),
                      child: const Text('Bills'),
                    ),
                    TextButton(
                      onPressed: () {
                        developer.log('Navigating to incomes dashboard from upcoming payments', name: 'Navigation');
                        context.go('/more/incomes');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: const Size(0, 36),
                      ),
                      child: const Text('Income'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (combinedItems.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No upcoming payments or income'),
                ),
              )
            else
              ...combinedItems.take(5).map((item) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: item.isBill
                    ? _BillItem(bill: item.bill!)
                    : _IncomeItem(incomeStatus: item.incomeStatus!),
              )),
          ],
        ),
      ),
    );
  }

  List<_CombinedItem> _combineAndSortItems() {
    final items = <_CombinedItem>[];

    // Add bills
    for (final bill in upcomingBills) {
      items.add(_CombinedItem(
        date: bill.dueDate,
        isBill: true,
        bill: bill,
      ));
    }

    // Add incomes
    for (final incomeStatus in upcomingIncomes) {
      items.add(_CombinedItem(
        date: incomeStatus.income.nextExpectedDate ?? DateTime.now(),
        isBill: false,
        incomeStatus: incomeStatus,
      ));
    }

    // Sort by urgency first, then by date
    items.sort((a, b) {
      // Get urgency level for comparison
      final aUrgency = _getItemUrgency(a);
      final bUrgency = _getItemUrgency(b);

      // Compare urgency levels (higher urgency first)
      final urgencyComparison = bUrgency.index.compareTo(aUrgency.index);
      if (urgencyComparison != 0) return urgencyComparison;

      // If same urgency, sort by date
      return a.date.compareTo(b.date);
    });

    return items;
  }

  /// Get urgency level for an item
  _ItemUrgency _getItemUrgency(_CombinedItem item) {
    if (item.isBill) {
      final bill = item.bill!;
      if (bill.isOverdue) return _ItemUrgency.overdue;
      if (bill.isDueToday) return _ItemUrgency.dueToday;
      if (bill.isDueSoon) return _ItemUrgency.dueSoon;
      return _ItemUrgency.normal;
    } else {
      final incomeStatus = item.incomeStatus!;
      if (incomeStatus.isOverdue) return _ItemUrgency.overdue;
      if (incomeStatus.isExpectedToday) return _ItemUrgency.dueToday;
      if (incomeStatus.isExpectedSoon) return _ItemUrgency.dueSoon;
      return _ItemUrgency.normal;
    }
  }
}

class _CombinedItem {
  const _CombinedItem({
    required this.date,
    required this.isBill,
    this.bill,
    this.incomeStatus,
  });

  final DateTime date;
  final bool isBill;
  final Bill? bill;
  final RecurringIncomeStatus? incomeStatus;
}

/// Urgency levels for sorting upcoming payments
enum _ItemUrgency {
  overdue,    // Highest priority
  dueToday,   // Second highest
  dueSoon,    // Third highest
  normal,     // Lowest priority
}

class _BillItem extends StatelessWidget {
  const _BillItem({required this.bill});

  final Bill bill;

  @override
  Widget build(BuildContext context) {
    final daysUntilDue = bill.daysUntilDue;
    final isOverdue = bill.isOverdue;
    final isDueSoon = bill.isDueSoon;

    String dueText;
    Color indicatorColor;
    Color textColor = Colors.grey[600]!;

    if (isOverdue) {
      dueText = '${daysUntilDue.abs()}d overdue';
      indicatorColor = Colors.red;
      textColor = Colors.red;
    } else if (daysUntilDue == 0) {
      dueText = 'Due today';
      indicatorColor = Colors.red;
      textColor = Colors.red;
    } else if (daysUntilDue == 1) {
      dueText = 'Due tomorrow';
      indicatorColor = Colors.orange;
      textColor = Colors.orange[700]!;
    } else if (isDueSoon) {
      dueText = 'Due in $daysUntilDue days';
      indicatorColor = Colors.orange;
      textColor = Colors.orange[700]!;
    } else {
      dueText = 'Due in $daysUntilDue days';
      indicatorColor = Colors.blue;
      textColor = Colors.grey[600]!;
    }

    return Row(
      children: [
        // Indicator bar
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: indicatorColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bill.name,
                style: AppTypography.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                dueText,
                style: AppTypography.caption.copyWith(
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        // Amount
        SizedBox(
          width: 70,
          child: Text(
            '\$${bill.amount.toStringAsFixed(2)}',
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
        // Mark as paid button
        IconButton(
          icon: const Icon(Icons.check_circle_outline, size: 20),
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: () {
            // TODO: Implement mark as paid functionality
          },
          tooltip: 'Mark as Paid',
        ),
      ],
    );
  }
}

class _IncomeItem extends StatelessWidget {
  const _IncomeItem({required this.incomeStatus});

  final RecurringIncomeStatus incomeStatus;

  @override
  Widget build(BuildContext context) {
    final urgencyColor = switch (incomeStatus.urgency) {
      RecurringIncomeUrgency.overdue => Colors.red,
      RecurringIncomeUrgency.expectedToday => Colors.red,
      RecurringIncomeUrgency.expectedSoon => Colors.orange,
      RecurringIncomeUrgency.normal => Colors.green,
    };

    String dueText;
    Color textColor = Colors.grey[600]!;

    if (incomeStatus.isOverdue) {
      dueText = '${incomeStatus.daysUntilExpected.abs()}d overdue';
      textColor = Colors.red;
    } else if (incomeStatus.daysUntilExpected == 0) {
      dueText = 'Expected today';
      textColor = Colors.red;
    } else if (incomeStatus.isExpectedSoon) {
      dueText = 'In ${incomeStatus.daysUntilExpected}d';
      textColor = Colors.orange[700]!;
    } else {
      dueText = 'In ${incomeStatus.daysUntilExpected}d';
      textColor = Colors.grey[600]!;
    }

    return Row(
      children: [
        // Indicator bar
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: urgencyColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                incomeStatus.income.name,
                style: AppTypography.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                dueText,
                style: AppTypography.caption.copyWith(
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        // Amount
        SizedBox(
          width: 70,
          child: Text(
            '+\$${incomeStatus.income.amount.toStringAsFixed(2)}',
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
        // Record receipt button
        IconButton(
          icon: const Icon(Icons.add_circle_outline, size: 20),
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: () {
            // Navigate to income detail screen with receipt recording
            context.go('/more/incomes/${incomeStatus.income.id}');
          },
          tooltip: 'Record Receipt',
        ),
      ],
    );
  }
}

/// Recent transactions list
class _RecentTransactionsWidget extends StatelessWidget {
  const _RecentTransactionsWidget({required this.recentTransactions});

  final List<Transaction> recentTransactions;

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
            if (recentTransactions.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No recent transactions'),
                ),
              )
            else
              _buildGroupedTransactions(context, recentTransactions.take(7).toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupedTransactions(BuildContext context, List<Transaction> transactions) {
    // Group transactions by date
    final grouped = <String, List<Transaction>>{};
    for (final transaction in transactions) {
      final dateKey = DateFormat('yyyy-MM-dd').format(transaction.date);
      grouped[dateKey] ??= [];
      grouped[dateKey]!.add(transaction);
    }

    // Sort dates in descending order
    final sortedDates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return Column(
      children: sortedDates.map((dateKey) {
        final dayTransactions = grouped[dateKey]!;
        final date = DateTime.parse(dateKey);
        final formattedDate = _formatDateHeader(date);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                formattedDate,
                style: AppTypography.labelMedium.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ...dayTransactions.map((transaction) => _TransactionTile(transaction: transaction)),
          ],
        );
      }).toList(),
    );
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) return 'Today';
    if (transactionDate == yesterday) return 'Yesterday';
    return DateFormat('MMMM dd, yyyy').format(date);
  }
}

/// Transaction tile with swipe actions
class _TransactionTile extends ConsumerWidget {
  const _TransactionTile({required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpense = transaction.type == TransactionType.expense;
    final amountColor = isExpense ? Colors.red : Colors.green;
    final amountPrefix = isExpense ? '-' : '+';

    return Slidable(
      key: ValueKey(transaction.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => _editTransaction(context),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () => _deleteTransaction(context, ref)),
        children: [
          SlidableAction(
            onPressed: (_) => _deleteTransaction(context, ref),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (_) => _categorizeTransaction(context, ref),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            icon: Icons.category,
            label: 'Categorize',
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          child: Icon(
            isExpense ? Icons.arrow_downward : Icons.arrow_upward,
            color: amountColor,
          ),
        ),
        title: Text(
          transaction.description ?? 'Transaction',
          style: AppTypography.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${transaction.categoryId ?? 'Unknown'} • ${DateFormat('HH:mm').format(transaction.date)}',
          style: AppTypography.caption.copyWith(color: Colors.grey[600]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: Text(
            '$amountPrefix\$${transaction.amount.abs().toStringAsFixed(2)}',
            style: AppTypography.bodyMedium.copyWith(
              color: amountColor,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
        onTap: () => context.push('/transactions/${transaction.id}'),
      ),
    );
  }

  void _editTransaction(BuildContext context) {
    AppBottomSheet.show(
      context: context,
      child: TransactionDetailBottomSheet(
        transaction: transaction,
        startInEditMode: true,
      ),
    );
  }

  Future<void> _deleteTransaction(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: Text(
          'Are you sure you want to delete "${transaction.title}"?',
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
          .read(transactionNotifierProvider.notifier)
          .deleteTransaction(transaction.id);

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction deleted')),
        );
      }
    }
  }

  Future<void> _categorizeTransaction(BuildContext context, WidgetRef ref) async {
    final categories = ref.read(transactionCategoriesProvider);
    String? selectedCategoryId = transaction.categoryId;

    final result = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Change Category'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: categories.map((category) {
                final iconColorService = ref.watch(categoryIconColorServiceProvider);
                return RadioListTile<String>(
                  value: category.id,
                  groupValue: selectedCategoryId,
                  onChanged: (value) {
                    setState(() {
                      selectedCategoryId = value;
                    });
                    Navigator.pop(context, value);
                  },
                  title: Row(
                    children: [
                      Icon(
                        iconColorService.getIconForCategory(category.id),
                        size: 20,
                        color: Color(category.color),
                      ),
                      const SizedBox(width: 8),
                      Text(category.name),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );

    if (result != null && result != transaction.categoryId) {
      final updatedTransaction = transaction.copyWith(categoryId: result);
      final success = await ref
          .read(transactionNotifierProvider.notifier)
          .updateTransaction(updatedTransaction);

      if (success && context.mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            NotificationManager.categoryUpdated(context);
          }
        });
      }
    }
  }

}

/// Insights card with rotating insights
class _InsightsCard extends StatefulWidget {
  const _InsightsCard({required this.insights});

  final List<Insight> insights;

  @override
  State<_InsightsCard> createState() => _InsightsCardState();
}

class _InsightsCardState extends State<_InsightsCard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.insights.isEmpty) {
      return Card(
        child: Padding(
          padding: AppSpacing.cardPaddingAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Insights',
                style: AppTypography.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No insights available'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final currentInsight = widget.insights[_currentIndex];

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
                  'Insights',
                  style: AppTypography.titleLarge,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _previousInsight,
                      iconSize: 20,
                    ),
                    Text(
                      '${_currentIndex + 1}/${widget.insights.length}',
                      style: AppTypography.caption,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _nextInsight,
                      iconSize: 20,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            // Insight content
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getInsightColor(currentInsight.type).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getInsightColor(currentInsight.type).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getInsightIcon(currentInsight.type),
                        color: _getInsightColor(currentInsight.type),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        currentInsight.title,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentInsight.message,
                    style: AppTypography.bodyMedium,
                  ),
                  if (currentInsight.amount != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      '\$${currentInsight.amount!.toStringAsFixed(2)}',
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _getInsightColor(currentInsight.type),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Swipe indicators
            if (widget.insights.length > 1) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.insights.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _nextInsight() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.insights.length;
    });
  }

  void _previousInsight() {
    setState(() {
      _currentIndex = _currentIndex > 0 ? _currentIndex - 1 : widget.insights.length - 1;
    });
  }

  Color _getInsightColor(InsightType type) {
    switch (type) {
      case InsightType.spendingTrend:
        return Colors.blue;
      case InsightType.budgetAlert:
        return Colors.red;
      case InsightType.savingsOpportunity:
        return Colors.green;
      case InsightType.unusualActivity:
        return Colors.orange;
      case InsightType.goalProgress:
        return Colors.purple;
      case InsightType.billReminder:
        return Colors.yellow;
      case InsightType.categoryAnalysis:
        return Colors.teal;
      case InsightType.monthlySummary:
        return Colors.indigo;
      case InsightType.comparison:
        return Colors.cyan;
      case InsightType.recommendation:
        return Colors.pink;
    }
  }

  IconData _getInsightIcon(InsightType type) {
    switch (type) {
      case InsightType.spendingTrend:
        return Icons.trending_up;
      case InsightType.budgetAlert:
        return Icons.warning;
      case InsightType.savingsOpportunity:
        return Icons.savings;
      case InsightType.unusualActivity:
        return Icons.error_outline;
      case InsightType.goalProgress:
        return Icons.flag;
      case InsightType.billReminder:
        return Icons.receipt;
      case InsightType.categoryAnalysis:
        return Icons.pie_chart;
      case InsightType.monthlySummary:
        return Icons.calendar_month;
      case InsightType.comparison:
        return Icons.compare_arrows;
      case InsightType.recommendation:
        return Icons.lightbulb;
    }
  }
}

/// Dashboard skeleton loading
class _DashboardSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Financial Snapshot Card Skeleton
        Card(
          child: Padding(
            padding: AppSpacing.cardPaddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(child: Container(height: 24, width: 120, color: Colors.white)),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SnapshotItemSkeleton(),
                    _SnapshotItemSkeleton(),
                    _SnapshotItemSkeleton(),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                SkeletonLoader(child: Container(height: 8, color: Colors.white)),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: SkeletonLoader(child: Container(height: 32, width: 100, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Quick Actions Bar Skeleton
        Card(
          child: Padding(
            padding: AppSpacing.cardPaddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(child: Container(height: 24, width: 140, color: Colors.white)),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) => _QuickActionSkeleton()),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Budget Overview Skeleton
        Card(
          child: Padding(
            padding: AppSpacing.cardPaddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonLoader(child: Container(height: 24, width: 150, color: Colors.white)),
                    SkeletonLoader(child: Container(height: 16, width: 80, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ...List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _BudgetCategorySkeleton(),
                )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Upcoming Bills Skeleton
        Card(
          child: Padding(
            padding: AppSpacing.cardPaddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonLoader(child: Container(height: 24, width: 140, color: Colors.white)),
                    SkeletonLoader(child: Container(height: 16, width: 80, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ...List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _BillItemSkeleton(),
                )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Recent Transactions Skeleton
        Card(
          child: Padding(
            padding: AppSpacing.cardPaddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonLoader(child: Container(height: 24, width: 180, color: Colors.white)),
                    SkeletonLoader(child: Container(height: 16, width: 70, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ...List.generate(5, (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _TransactionListItemSkeleton(),
                )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Insights Card Skeleton
        Card(
          child: Padding(
            padding: AppSpacing.cardPaddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonLoader(child: Container(height: 24, width: 80, color: Colors.white)),
                    Row(
                      children: [
                        SkeletonLoader(child: Container(width: 20, height: 20, color: Colors.white)),
                        const SizedBox(width: 8),
                        SkeletonLoader(child: Container(width: 30, height: 16, color: Colors.white)),
                        const SizedBox(width: 8),
                        SkeletonLoader(child: Container(width: 20, height: 20, color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SkeletonLoader(child: Container(width: 20, height: 20, color: Colors.white)),
                          const SizedBox(width: 8),
                          SkeletonLoader(child: Container(height: 20, width: 120, color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SkeletonLoader(child: Container(height: 16, width: double.infinity, color: Colors.white)),
                      const SizedBox(height: 4),
                      SkeletonLoader(child: Container(height: 16, width: 200, color: Colors.white)),
                      const SizedBox(height: 8),
                      SkeletonLoader(child: Container(height: 18, width: 80, color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SnapshotItemSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SkeletonLoader(child: Container(height: 14, width: 60, color: Colors.white)),
        const SizedBox(height: AppSpacing.xs),
        SkeletonLoader(child: Container(height: 24, width: 80, color: Colors.white)),
      ],
    );
  }
}

class _QuickActionSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SkeletonLoader(child: Container(width: 48, height: 48, color: Colors.white)),
        const SizedBox(height: 4),
        SkeletonLoader(child: Container(height: 12, width: 60, color: Colors.white)),
      ],
    );
  }
}

class _BudgetCategorySkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SkeletonLoader(child: Container(height: 16, width: 100, color: Colors.white)),
            SkeletonLoader(child: Container(height: 16, width: 80, color: Colors.white)),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        SkeletonLoader(child: Container(height: 6, color: Colors.white)),
      ],
    );
  }
}

class _BillItemSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SkeletonLoader(child: Container(width: 4, height: 40, color: Colors.white)),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLoader(child: Container(height: 16, width: 120, color: Colors.white)),
              const SizedBox(height: 4),
              SkeletonLoader(child: Container(height: 14, width: 80, color: Colors.white)),
            ],
          ),
        ),
        SkeletonLoader(child: Container(width: 60, height: 16, color: Colors.white)),
      ],
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
