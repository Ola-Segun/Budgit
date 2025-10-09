import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/bill.dart';
import '../providers/bill_providers.dart';

/// Card widget for displaying bill information with swipe actions
class BillCard extends ConsumerWidget {
  const BillCard({
    super.key,
    required this.bill,
  });

  final Bill bill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      key: ValueKey(bill.id),
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
        ],
      ),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          // Edit action (blue)
          SlidableAction(
            onPressed: (_) => _editBill(context),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
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
            onTap: () => context.go('/more/bills/${bill.id}'),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getUrgencyColor().withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: Icon(
                          Icons.receipt,
                          color: _getUrgencyColor(),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Bill Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Status
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    bill.name,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (bill.isPaid) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Paid',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ],
                            ),

                            // Description (if available)
                            if (bill.description != null && bill.description!.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                bill.description!,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],

                            // Frequency and Amount
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                // Frequency
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    bill.frequency.displayName,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Amount
                                Text(
                                  '\$${bill.amount.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: _getUrgencyColor(),
                                      ),
                                ),
                              ],
                            ),

                            // Due Date and Days Remaining
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  DateFormat('MMM dd').format(bill.dueDate),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      ),
                                ),
                                if (bill.daysUntilDue != 0) ...[
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
                                  Expanded(
                                    child: Text(
                                      bill.isOverdue
                                          ? '${bill.daysUntilDue.abs()} days overdue'
                                          : '${bill.daysUntilDue} days left',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: bill.isOverdue
                                                ? Colors.red
                                                : Theme.of(context).colorScheme.onSurfaceVariant,
                                            fontWeight: bill.isOverdue ? FontWeight.w500 : FontWeight.normal,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _editBill(BuildContext context) {
    HapticFeedback.lightImpact();
    // TODO: Navigate to edit bill screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit bill - Coming soon!')),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    HapticFeedback.mediumImpact();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Bill'),
        content: Text(
          'Are you sure you want to delete "${bill.name}"?',
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
          .read(billNotifierProvider.notifier)
          .deleteBill(bill.id);

      if (success && context.mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bill deleted')),
            );
          }
        });
      }
    }
  }

  Color _getUrgencyColor() {
    if (bill.isOverdue) return Colors.red;
    if (bill.isDueSoon) return Colors.orange;
    if (bill.isDueToday) return Colors.red;
    return Colors.grey;
  }
}