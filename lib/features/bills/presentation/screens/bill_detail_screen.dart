import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/bill.dart';
import '../providers/bill_providers.dart';
import '../widgets/edit_bill_bottom_sheet.dart';
import '../widgets/payment_recording_bottom_sheet.dart';

/// Screen for displaying detailed bill information and managing bill actions
class BillDetailScreen extends ConsumerStatefulWidget {
  const BillDetailScreen({
    super.key,
    required this.billId,
  });

  final String billId;

  @override
  ConsumerState<BillDetailScreen> createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends ConsumerState<BillDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final billAsync = ref.watch(billProvider(widget.billId));

    return Scaffold(
      appBar: AppBar(
        title: billAsync.when(
          data: (bill) => Text(bill?.name ?? 'Bill Details'),
          loading: () => const Text('Loading...'),
          error: (error, stack) => const Text('Bill Details'),
        ),
        actions: [
          billAsync.when(
            data: (bill) {
              if (bill == null) return const SizedBox.shrink();
              return PopupMenuButton<String>(
                onSelected: (value) => _handleMenuAction(context, ref, bill, value),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Edit Bill'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete Bill', style: TextStyle(color: Colors.red)),
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
      body: billAsync.when(
        data: (bill) {
          if (bill == null) {
            return const Center(
              child: Text('Bill not found'),
            );
          }

          return _buildBillDetail(context, ref, bill);
        },
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(billProvider(widget.billId)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMarkAsPaidSheet(context, ref),
        tooltip: 'Mark as Paid',
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget _buildBillDetail(
    BuildContext context,
    WidgetRef ref,
    Bill bill,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(billNotifierProvider.notifier).refresh();
      },
      child: ListView(
        padding: AppTheme.screenPaddingAll,
        children: [
          // Bill Status Card
          _buildBillStatusCard(context, bill),
          const SizedBox(height: 24),

          // Bill Information
          _buildBillInfo(context, bill),
          const SizedBox(height: 24),

          // Payment History
          _buildPaymentHistory(context, bill),
        ],
      ),
    );
  }

  Widget _buildBillStatusCard(BuildContext context, Bill bill) {
    final color = _getUrgencyColor(bill);
    final statusText = _getStatusText(bill);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '\$${bill.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Due Date',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  DateFormat('MMM dd, yyyy').format(bill.dueDate),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            if (bill.daysUntilDue != 0) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Days Until Due',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${bill.daysUntilDue.abs()} days ${bill.isOverdue ? 'overdue' : 'remaining'}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: bill.isOverdue ? Colors.red : Colors.green,
                        ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBillInfo(BuildContext context, Bill bill) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bill Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),

            // Name
            _buildInfoRow('Name', bill.name),

            // Amount
            _buildInfoRow('Amount', '\$${bill.amount.toStringAsFixed(2)}'),

            // Frequency
            _buildInfoRow('Frequency', bill.frequency.displayName),

            // Due Date
            _buildInfoRow('Due Date', DateFormat('MMM dd, yyyy').format(bill.dueDate)),

            // Payee
            if (bill.payee != null && bill.payee!.isNotEmpty)
              _buildInfoRow('Payee', bill.payee!),

            // Auto Pay
            _buildInfoRow('Auto Pay', bill.isAutoPay ? 'Enabled' : 'Disabled'),

            // Description
            if (bill.description != null && bill.description!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Description',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                bill.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],

            // Website
            if (bill.website != null && bill.website!.isNotEmpty)
              _buildInfoRow('Website', bill.website!),

            // Notes
            if (bill.notes != null && bill.notes!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Notes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                bill.notes!,
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

  Widget _buildPaymentHistory(BuildContext context, Bill bill) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Payment History',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                // TODO: Navigate to full payment history
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Full payment history - Coming soon!')),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        if (bill.paymentHistory.isEmpty) ...[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(
                    Icons.history_outlined,
                    size: 48,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No payment history',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Payment history will appear here',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          ...bill.paymentHistory.take(5).map((payment) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                  title: Text(
                    '\$${payment.amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('MMM dd, yyyy').format(payment.paymentDate)),
                      if (payment.notes != null && payment.notes!.isNotEmpty)
                        Text(payment.notes!),
                    ],
                  ),
                  trailing: Text(
                    payment.method.displayName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              )),
        ],
      ],
    );
  }

  void _handleMenuAction(
    BuildContext context,
    WidgetRef ref,
    Bill bill,
    String action,
  ) {
    switch (action) {
      case 'edit':
        _showEditBillSheet(context, ref, bill);
        break;
      case 'delete':
        _showDeleteConfirmation(context, ref, bill);
        break;
    }
  }

  Future<void> _showMarkAsPaidSheet(BuildContext context, WidgetRef ref) async {
    final billAsync = ref.read(billProvider(widget.billId));
    final bill = billAsync.value;

    if (bill == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bill not found')),
      );
      return;
    }

    await PaymentRecordingBottomSheet.show(
      context: context,
      bill: bill,
      onPaymentRecorded: () {
        // Refresh the bill data
        ref.invalidate(billProvider(widget.billId));
        ref.read(billNotifierProvider.notifier).refresh();
      },
    );
  }

  Future<void> _showEditBillSheet(
    BuildContext context,
    WidgetRef ref,
    Bill bill,
  ) async {
    await AppBottomSheet.show(
      context: context,
      child: EditBillBottomSheet(
        bill: bill,
        onSubmit: (updatedBill) async {
          final success = await ref
              .read(billNotifierProvider.notifier)
              .updateBill(updatedBill);

          if (success && mounted) {
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bill updated successfully')),
            );
          } else if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to update bill'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    Bill bill,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Bill'),
        content: Text(
          'Are you sure you want to delete "${bill.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => context.pop(true),
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

      if (success && mounted) {
        context.go('/more/bills'); // Go back to bills list
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bill deleted successfully')),
        );
      }
    }
  }

  Color _getUrgencyColor(Bill bill) {
    if (bill.isOverdue) return Colors.red;
    if (bill.isDueSoon) return Colors.orange;
    if (bill.isDueToday) return Colors.red;
    return Colors.green;
  }

  String _getStatusText(Bill bill) {
    if (bill.isPaid) return 'Paid';
    if (bill.isOverdue) return 'Overdue';
    if (bill.isDueToday) return 'Due Today';
    if (bill.isDueSoon) return 'Due Soon';
    return 'Upcoming';
  }
}