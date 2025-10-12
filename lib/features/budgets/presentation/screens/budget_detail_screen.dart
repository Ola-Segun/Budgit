import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import '../../domain/entities/budget.dart';
import '../providers/budget_providers.dart';
import 'budget_edit_screen.dart';

/// Screen for displaying detailed budget information and managing budget
class BudgetDetailScreen extends ConsumerStatefulWidget {
  const BudgetDetailScreen({
    super.key,
    required this.budgetId,
  });

  final String budgetId;

  @override
  ConsumerState<BudgetDetailScreen> createState() => _BudgetDetailScreenState();
}

class _BudgetDetailScreenState extends ConsumerState<BudgetDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final budgetAsync = ref.watch(budgetProvider(widget.budgetId));
    final budgetStatusAsync = ref.watch(budgetStatusProvider(widget.budgetId));

    return Scaffold(
      appBar: AppBar(
        title: budgetAsync.when(
          data: (budget) => Text(budget?.name ?? 'Budget Details'),
          loading: () => const Text('Loading...'),
          error: (error, stack) => const Text('Budget Details'),
        ),
        actions: [
          budgetAsync.when(
            data: (budget) {
              if (budget == null) return const SizedBox.shrink();
              return PopupMenuButton<String>(
                onSelected: (value) => _handleMenuAction(context, ref, budget, value),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Edit Budget'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete Budget', style: TextStyle(color: Colors.red)),
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
      body: budgetAsync.when(
        data: (budget) {
          if (budget == null) {
            return const Center(
              child: Text('Budget not found'),
            );
          }

          return _buildBudgetDetail(context, ref, budget, budgetStatusAsync);
        },
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(budgetProvider(widget.budgetId)),
        ),
      ),
    );
  }

  Widget _buildBudgetDetail(
    BuildContext context,
    WidgetRef ref,
    Budget budget,
    AsyncValue<BudgetStatus?> budgetStatusAsync,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          ref.read(budgetNotifierProvider.notifier).loadBudgets(),
        ]);
      },
      child: ListView(
        padding: AppTheme.screenPaddingAll,
        children: [
          // Budget Overview Card
          _buildBudgetOverviewCard(context, budget, budgetStatusAsync),
          const SizedBox(height: 24),

          // Category Breakdown
          _buildCategoryBreakdown(context, budget, budgetStatusAsync),
          const SizedBox(height: 24),

          // Budget Information
          _buildBudgetInfo(context, budget),
          const SizedBox(height: 24),

          // Transaction History
          _buildTransactionHistory(context, ref, budget),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown(
    BuildContext context,
    Budget budget,
    AsyncValue<BudgetStatus?> budgetStatusAsync,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category Breakdown',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),

            budgetStatusAsync.when(
              data: (status) {
                if (status == null || status.categoryStatuses.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No spending data available'),
                    ),
                  );
                }

                return Column(
                  children: status.categoryStatuses.map((categoryStatus) {
                    final category = budget.categories.firstWhere(
                      (cat) => cat.id == categoryStatus.categoryId,
                      orElse: () => BudgetCategory(
                        id: categoryStatus.categoryId,
                        name: 'Unknown Category',
                        amount: categoryStatus.budget,
                      ),
                    );

                    return _buildCategoryProgressItem(context, category, categoryStatus);
                  }).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Failed to load category data: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryProgressItem(
    BuildContext context,
    BudgetCategory category,
    CategoryStatus status,
  ) {
    final progress = status.spent / status.budget;
    final health = status.status;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(1)}%',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getHealthColor(health),
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress Bar
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(_getHealthColor(health)),
          ),

          const SizedBox(height: 8),

          // Amount Details
          Row(
            children: [
              Expanded(
                child: Text(
                  'Spent: ${NumberFormat.currency(symbol: '\$').format(status.spent)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              Text(
                'Budget: ${NumberFormat.currency(symbol: '\$').format(status.budget)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),

          if (status.isOverBudget) ...[
            const SizedBox(height: 4),
            Text(
              'Over budget by ${NumberFormat.currency(symbol: '\$').format(status.spent - status.budget)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBudgetInfo(BuildContext context, Budget budget) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Budget Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),

            // Type
            _buildInfoRow('Type', budget.type.displayName),

            // Period
            _buildInfoRow('Period',
              '${DateFormat('MMM dd, yyyy').format(budget.startDate)} - ${DateFormat('MMM dd, yyyy').format(budget.endDate)}'
            ),

            // Total Budget
            _buildInfoRow('Total Budget', NumberFormat.currency(symbol: '\$').format(budget.totalBudget)),

            // Status
            _buildInfoRow('Status', budget.isActive ? 'Active' : 'Inactive'),

            // Description
            if (budget.description != null && budget.description!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                budget.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
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
            width: 100,
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

  Widget _buildBudgetOverviewCard(
    BuildContext context,
    Budget budget,
    AsyncValue<BudgetStatus?> budgetStatusAsync,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Budget Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),

            budgetStatusAsync.when(
              data: (status) {
                if (status == null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No spending data available'),
                    ),
                  );
                }

                final progress = status.totalSpent / status.totalBudget;
                final health = status.overallHealth;

                return Column(
                  children: [
                    // Progress visualization
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween<double>(
                                    begin: 0.0,
                                    end: progress.clamp(0.0, 1.0),
                                  ),
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeOut,
                                  builder: (context, animatedProgress, child) {
                                    return LinearProgressIndicator(
                                      value: animatedProgress,
                                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                                      valueColor: AlwaysStoppedAnimation<Color>(_getHealthColor(health)),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: 0.0,
                                  end: progress,
                                ),
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeOut,
                                builder: (context, animatedProgress, child) {
                                  return Text(
                                    '${(animatedProgress * 100).toStringAsFixed(1)}%',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Amount details
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Spent',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                                          ),
                                    ),
                                    Text(
                                      NumberFormat.currency(symbol: '\$').format(status.totalSpent),
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: _getHealthColor(health),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Budget',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                                          ),
                                    ),
                                    Text(
                                      NumberFormat.currency(symbol: '\$').format(status.totalBudget),
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Status and remaining
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getHealthColor(health).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  health.displayName,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: _getHealthColor(health),
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                status.remainingAmount >= 0 ? Icons.arrow_downward : Icons.arrow_upward,
                                size: 16,
                                color: status.remainingAmount >= 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                status.remainingAmount >= 0
                                    ? '${NumberFormat.currency(symbol: '\$').format(status.remainingAmount)} remaining'
                                    : '${NumberFormat.currency(symbol: '\$').format(-status.remainingAmount)} over budget',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: status.remainingAmount >= 0
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Days remaining
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${status.daysRemaining} days left',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Failed to load budget status: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionHistory(BuildContext context, WidgetRef ref, Budget budget) {
    // Get transactions filtered by budget categories and date range
    final categoryIds = budget.categories.map((c) => c.id).toSet();
    final transactionStateAsync = ref.watch(transactionNotifierProvider);

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
                // Navigate to transaction list with budget filter
                context.push('/transactions', extra: {
                  'budgetFilter': budget,
                });
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Transaction list
        transactionStateAsync.when(
          data: (state) {
            final transactions = state.transactions.where((transaction) {
              // Filter by category
              if (!categoryIds.contains(transaction.categoryId)) {
                return false;
              }
              // Filter by date range
              return transaction.date.isAfter(budget.startDate.subtract(const Duration(days: 1))) &&
                     transaction.date.isBefore(budget.endDate.add(const Duration(days: 1))) &&
                     transaction.type == TransactionType.expense;
            }).toList()
              ..sort((a, b) => b.date.compareTo(a.date)); // Most recent first

            if (transactions.isEmpty) {
              return Card(
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
                        'No transactions found',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Transactions related to this budget will appear here',
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

            // Show only the first 5 transactions
            final recentTransactions = transactions.take(5).toList();

            return Column(
              children: recentTransactions.map((transaction) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: Text(
                      transaction.description ?? 'Transaction',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      DateFormat('MMM dd, yyyy').format(transaction.date),
                    ),
                    trailing: Text(
                      NumberFormat.currency(symbol: '\$').format(transaction.amount),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                    onTap: () {
                      // Navigate to transaction detail
                      context.push('/transactions/${transaction.id}');
                    },
                  ),
                );
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load transactions',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleMenuAction(
    BuildContext context,
    WidgetRef ref,
    Budget budget,
    String action,
  ) {
    switch (action) {
      case 'edit':
        _showEditBudgetSheet(context, ref, budget);
        break;
      case 'delete':
        _showDeleteConfirmation(context, ref, budget);
        break;
    }
  }

  Future<void> _showEditBudgetSheet(
    BuildContext context,
    WidgetRef ref,
    Budget budget,
  ) async {
    // Navigate to edit budget screen
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BudgetEditScreen(budget: budget),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    Budget budget,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Budget'),
        content: Text(
          'Are you sure you want to delete "${budget.name}"? This action cannot be undone.',
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
          .read(budgetNotifierProvider.notifier)
          .deleteBudget(budget.id);

      if (success && mounted) {
        context.go('/budgets'); // Go back to budgets list
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Budget deleted successfully')),
        );
      }
    }
  }

  Color _getHealthColor(BudgetHealth health) {
    switch (health) {
      case BudgetHealth.healthy:
        return const Color(0xFF10B981); // Green
      case BudgetHealth.warning:
        return const Color(0xFFF59E0B); // Yellow
      case BudgetHealth.critical:
        return const Color(0xFFEF4444); // Red
      case BudgetHealth.overBudget:
        return const Color(0xFFDC2626); // Dark Red
    }
  }
}