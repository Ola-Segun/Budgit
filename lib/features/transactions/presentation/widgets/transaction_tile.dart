import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_animations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/transaction.dart';

/// Widget for displaying a transaction in a list
class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    this.onTap,
    this.onDelete,
    this.onEdit,
  });

  final Transaction transaction;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await _showDeleteConfirmation(context);
        }
        return false;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete?.call();
        }
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Category Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getCategoryColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Icon(
                    _getCategoryIcon(),
                    color: _getCategoryColor(),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),

                // Transaction Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        transaction.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Description (if available)
                      if (transaction.description != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          transaction.description!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      // Category and Date
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            _getCategoryName(),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('MMM dd').format(transaction.date),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      transaction.signedAmount,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: transaction.isIncome
                                ? Colors.green
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                    ),

                    // Time (if today)
                    if (_isToday(transaction.date)) ...[
                      const SizedBox(height: 2),
                      Text(
                        DateFormat('HH:mm').format(transaction.date),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ).pressEffect();
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) async {
    return showDialog<bool>(
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
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }

  IconData _getCategoryIcon() {
    // Mock category icons - in real app, this would come from category data
    switch (transaction.categoryId) {
      case 'food':
        return Icons.restaurant;
      case 'transport':
        return Icons.directions_car;
      case 'shopping':
        return Icons.shopping_bag;
      case 'entertainment':
        return Icons.movie;
      case 'utilities':
        return Icons.bolt;
      case 'healthcare':
        return Icons.local_hospital;
      case 'salary':
        return Icons.work;
      case 'freelance':
        return Icons.computer;
      case 'investment':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor() {
    // Mock category colors - in real app, this would come from category data
    switch (transaction.categoryId) {
      case 'food':
        return const Color(0xFFF59E0B); // Yellow
      case 'transport':
        return const Color(0xFFEF4444); // Red
      case 'shopping':
        return const Color(0xFFEC4899); // Pink
      case 'entertainment':
        return const Color(0xFFF97316); // Orange
      case 'utilities':
        return const Color(0xFF06B6D4); // Cyan
      case 'healthcare':
        return const Color(0xFFDC2626); // Dark red
      case 'salary':
        return const Color(0xFF10B981); // Green
      case 'freelance':
        return const Color(0xFF3B82F6); // Blue
      case 'investment':
        return const Color(0xFF8B5CF6); // Purple
      default:
        return const Color(0xFF64748B); // Gray
    }
  }

  String _getCategoryName() {
    // Mock category names - in real app, this would come from category data
    switch (transaction.categoryId) {
      case 'food':
        return 'Food & Dining';
      case 'transport':
        return 'Transportation';
      case 'shopping':
        return 'Shopping';
      case 'entertainment':
        return 'Entertainment';
      case 'utilities':
        return 'Utilities';
      case 'healthcare':
        return 'Healthcare';
      case 'salary':
        return 'Salary';
      case 'freelance':
        return 'Freelance';
      case 'investment':
        return 'Investment';
      default:
        return 'Other';
    }
  }
}