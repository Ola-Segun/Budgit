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
import '../../../../core/widgets/notification_manager.dart';
import 'transaction_detail_bottom_sheet.dart';

/// Custom RadioGroup widget for category selection
class RadioGroup<T> extends StatefulWidget {
  const RadioGroup({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.child,
  });

  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Widget child;

  @override
  State<RadioGroup<T>> createState() => _RadioGroupState<T>();
}

class _RadioGroupState<T> extends State<RadioGroup<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Widget for displaying a transaction in a list
class TransactionTile extends ConsumerWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('TransactionTile: Building tile for ${transaction.title}');
    final screenWidth = MediaQuery.of(context).size.width;
    debugPrint('TransactionTile: Screen width: $screenWidth');

    // Get category data using centralized service
    final categoryIconColorService = ref.watch(categoryIconColorServiceProvider);
    final categories = ref.watch(transactionCategoriesProvider);
    final category = categories.where((c) => c.id == transaction.categoryId).firstOrNull;
    final categoryIcon = categoryIconColorService.getIconForCategory(transaction.categoryId);
    final categoryColor = categoryIconColorService.getColorForCategory(transaction.categoryId);
    final categoryName = category != null ? category.name : 'Unknown Category';

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
child: SizedBox(
  width: double.infinity,
  child: Card(
    margin: const EdgeInsets.only(bottom: 8),
    child: InkWell(
      onTap: () => _showDetailSheet(context),
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: categoryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(
                categoryIcon,
                color: categoryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),

            // Transaction Details - Expanded to take remaining space
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Amount Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title - takes available space
                      Expanded(
                        child: Text(
                          transaction.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Amount - fixed width section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            transaction.signedAmount,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: transaction.isIncome
                                      ? Colors.green
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Time (if today)
                          if (_isToday(transaction.date)) ...[
                            const SizedBox(height: 2),
                            Text(
                              DateFormat('HH:mm').format(transaction.date),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                              maxLines: 1,
                            ),
                          ],
                        ],
                      ),
                    ],
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
                      // Category name - flexible
                      Flexible(
                        flex: 2,
                        child: Text(
                          categoryName,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                      // Account indicator - flexible
                      Flexible(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            (transaction.accountId?.isEmpty ?? true) ? 'No Account' : 'Account ${transaction.accountId}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  fontSize: 10,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                      // Date - fixed content, no need for SizedBox
                      Text(
                        DateFormat('MMM dd').format(transaction.date),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
).pressEffect(),
  );
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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            NotificationManager.transactionDeleted(context);
          }
        });
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          NotificationManager.transactionDuplicated(context);
        }
      });
    }
  }

  Future<void> _showCategorizeDialog(BuildContext context, WidgetRef ref) async {
    HapticFeedback.lightImpact();

    final categories = ref.read(transactionCategoriesProvider);
    final categoryIconColorService = ref.read(categoryIconColorServiceProvider);
    String? selectedCategoryId = transaction.categoryId;

    final result = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Change Category'),
          content: RadioGroup<String>(
            groupValue: selectedCategoryId,
            onChanged: (value) {
              setState(() {
                selectedCategoryId = value;
              });
              Navigator.pop(context, value);
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: categories.map((category) {
                  return ListTile(
                    title: Row(
                      children: [
                        Icon(
                          categoryIconColorService.getIconForCategory(category.id),
                          size: 20,
                          color: categoryIconColorService.getColorForCategory(category.id),
                        ),
                        const SizedBox(width: 8),
                        Text(category.name),
                      ],
                    ),
                    leading: Radio<String>(
                      value: category.id,
                    ),
                  );
                }).toList(),
              ),
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

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }
}