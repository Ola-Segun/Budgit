import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../states/transaction_state.dart';

/// Widget for displaying transaction statistics
class TransactionStatsCard extends StatelessWidget {
  const TransactionStatsCard({
    super.key,
    required this.stats,
  });

  final TransactionStats stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This Month',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Stats Row
            Row(
              children: [
                // Income
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Income',
                    '\$${stats.totalIncome.toStringAsFixed(2)}',
                    Colors.green,
                    Icons.arrow_upward,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Expenses
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Expenses',
                    '\$${stats.totalExpenses.toStringAsFixed(2)}',
                    Colors.red,
                    Icons.arrow_downward,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Net Amount
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Net',
                    '${stats.netAmount >= 0 ? '+' : ''}\$${stats.netAmount.toStringAsFixed(2)}',
                    stats.netAmount >= 0 ? Colors.green : Colors.red,
                    stats.netAmount >= 0 ? Icons.trending_up : Icons.trending_down,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.md),

            // Savings Rate
            if (stats.totalIncome > 0) ...[
              Row(
                children: [
                  Icon(
                    stats.savingsRate >= 0.2 ? Icons.thumb_up : Icons.thumb_down,
                    size: 16,
                    color: stats.savingsRate >= 0.2 ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Savings Rate: ${(stats.savingsRate * 100).toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: stats.savingsRate >= 0.2 ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ],

            // Transaction Count
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${stats.transactionCount} transactions',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}