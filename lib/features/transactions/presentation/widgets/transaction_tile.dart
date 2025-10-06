import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_animations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../domain/entities/transaction.dart';
import '../providers/transaction_providers.dart';
import 'transaction_detail_bottom_sheet.dart';

/// Widget for displaying a transaction in a list
class TransactionTile extends ConsumerWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      key: ValueKey(transaction.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          // Delete action (red)
          SlidableAction(
            onPressed: (_) => _confirmDelete(context, ref),
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            autoClose: true,
          ),
          // Duplicate action (blue)
          SlidableAction(
            onPressed: (_) => _duplicateTransaction(context, ref),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            icon: Icons.copy,
            label: 'Duplicate',
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            autoClose: true,
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          // Edit action (blue)
          SlidableAction(
            onPressed: (_) => _showEditSheet(context),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            autoClose: true,
          ),
          // Categorize action (green)
          SlidableAction(
            onPressed: (_) => _showCategorizeDialog(context, ref),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.category,
            label: 'Categorize',
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            autoClose: true,
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: InkWell(
          onTap: () => _showDetailSheet(context),
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

                      // Category, Account and Date
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
                          // Account indicator
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceVariant.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              transaction.accountId.isEmpty ? 'No Account' : 'Account ${transaction.accountId}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    fontSize: 10,
                                  ),
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

  void _showDetailSheet(BuildContext context) {
    HapticFeedback.lightImpact();
    AppBottomSheet.show(
      context: context,
      child: TransactionDetailBottomSheet(transaction: transaction),
    );
  }

  void _showEditSheet(BuildContext context) {
    HapticFeedback.lightImpact();
    AppBottomSheet.show(
      context: context,
      child: TransactionDetailBottomSheet(
        transaction: transaction,
        startInEditMode: true,
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    HapticFeedback.mediumImpact();
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

  Future<void> _duplicateTransaction(BuildContext context, WidgetRef ref) async {
    HapticFeedback.lightImpact();

    // Create duplicate with new ID
    final duplicateTransaction = transaction.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '${transaction.title} (Copy)',
    );

    final success = await ref
        .read(transactionNotifierProvider.notifier)
        .addTransaction(duplicateTransaction);

    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction duplicated')),
      );
    }
  }

  Future<void> _showCategorizeDialog(BuildContext context, WidgetRef ref) async {
    HapticFeedback.lightImpact();

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
                return RadioListTile<String>(
                  title: Row(
                    children: [
                      Icon(
                        _getIconFromCategoryId(category.id),
                        size: 20,
                        color: Color(category.color),
                      ),
                      const SizedBox(width: 8),
                      Text(category.name),
                    ],
                  ),
                  value: category.id,
                  groupValue: selectedCategoryId,
                  onChanged: (value) {
                    setState(() {
                      selectedCategoryId = value;
                    });
                    Navigator.pop(context, value);
                  },
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category updated')),
        );
      }
    }
  }

  IconData _getIconFromCategoryId(String categoryId) {
    switch (categoryId) {
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