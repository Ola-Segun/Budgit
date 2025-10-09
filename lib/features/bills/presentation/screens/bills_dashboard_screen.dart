import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/bill.dart';
import '../providers/bill_providers.dart';
import '../widgets/bill_card.dart';

/// Dashboard screen for bills and subscriptions management
class BillsDashboardScreen extends ConsumerWidget {
  const BillsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billState = ref.watch(billNotifierProvider);
    final summary = ref.watch(billsSummaryProvider);
    final upcomingBills = ref.watch(upcomingBillsProvider);
    final overdueCount = ref.watch(overdueBillsCountProvider);
    final totalMonthly = ref.watch(totalMonthlyBillsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bills & Subscriptions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/more/bills/add'),
          ),
        ],
      ),
      body: billState.when(
        initial: () => const LoadingView(),
        loading: () => const LoadingView(),
        loaded: (bills, loadedSummary) => _buildDashboard(
          context,
          ref,
          loadedSummary,
          upcomingBills,
          overdueCount,
          totalMonthly,
        ),
        error: (message, bills, errorSummary) => ErrorView(
          message: message,
          onRetry: () => ref.refresh(billNotifierProvider),
        ),
        billLoaded: (bill, status) => const SizedBox.shrink(), // Not used in dashboard
        billSaved: (bill) => const SizedBox.shrink(), // Not used in dashboard
        billDeleted: () => const SizedBox.shrink(), // Not used in dashboard
        paymentMarked: (bill) => const SizedBox.shrink(), // Not used in dashboard
      ),
    );
  }

  Widget _buildDashboard(
    BuildContext context,
    WidgetRef ref,
    BillsSummary summary,
    List<BillStatus> upcomingBills,
    int overdueCount,
    double totalMonthly,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(billNotifierProvider.notifier).refresh();
      },
      child: ListView(
        padding: AppTheme.screenPaddingAll,
        children: [
          // Summary Cards
          _buildSummaryCards(context, summary, overdueCount, totalMonthly),
          const SizedBox(height: 24),

          // Upcoming Bills
          _buildUpcomingBillsSection(context, upcomingBills),
          const SizedBox(height: 24),

          // All Bills
          _buildAllBillsSection(context, ref),

          // Quick Actions
          _buildQuickActions(context),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(
    BuildContext context,
    BillsSummary summary,
    int overdueCount,
    double totalMonthly,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                context,
                'Total Bills',
                summary.totalBills.toString(),
                Icons.receipt_long,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSummaryCard(
                context,
                'Overdue',
                overdueCount.toString(),
                Icons.warning,
                overdueCount > 0 ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                context,
                'Monthly Total',
                '\$${totalMonthly.toStringAsFixed(2)}',
                Icons.attach_money,
                Colors.purple,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSummaryCard(
                context,
                'Paid',
                '${summary.paidThisMonth}/${summary.dueThisMonth}',
                Icons.check_circle,
                Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingBillsSection(BuildContext context, List<BillStatus> upcomingBills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Bills',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        if (upcomingBills.isEmpty)
          _buildEmptyUpcomingBills(context)
        else
          ...upcomingBills.map((status) => _buildUpcomingBillCard(context, status)),
      ],
    );
  }

  Widget _buildAllBillsSection(BuildContext context, WidgetRef ref) {
    final billState = ref.watch(billNotifierProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Bills',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        billState.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const CircularProgressIndicator(),
          loaded: (bills, summary) {
            if (bills.isEmpty) {
              return _buildEmptyAllBills(context);
            }
            return Column(
              children: bills.map((bill) => _buildAllBillCard(context, bill)).toList(),
            );
          },
          error: (message, bills, summary) => Text('Error: $message'),
          billLoaded: (bill, status) => const SizedBox.shrink(),
          billSaved: (bill) => const SizedBox.shrink(),
          billDeleted: () => const SizedBox.shrink(),
          paymentMarked: (bill) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildEmptyAllBills(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No bills yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first bill to start tracking payments',
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

  Widget _buildAllBillCard(BuildContext context, Bill bill) {
    return BillCard(bill: bill);
  }

  Widget _buildEmptyUpcomingBills(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.event_available,
              size: 48,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No upcoming bills',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'All your bills are paid or no bills are due soon',
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

  Widget _buildUpcomingBillCard(BuildContext context, BillStatus status) {
    final color = _getUrgencyColor(status.urgency);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.1),
          child: Icon(
            Icons.receipt,
            color: color,
          ),
        ),
        title: Text(status.bill.name),
        subtitle: Text(
          '${status.daysUntilDue} days • \$${status.bill.amount.toStringAsFixed(2)}',
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status.urgency.displayName,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: () => context.go('/more/bills/${status.bill.id}'),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionButton(
                context,
                'Add Bill',
                Icons.add,
                Colors.blue,
                () => context.go('/more/bills/add'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildQuickActionButton(
                context,
                'View All',
                Icons.list,
                Colors.green,
                () {
                  // Already on the bills dashboard, maybe scroll to top or refresh
                  // For now, just show a message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All bills shown above')),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: color.withValues(alpha: 0.1),
        foregroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Color _getUrgencyColor(BillUrgency urgency) {
    switch (urgency) {
      case BillUrgency.normal:
        return Colors.grey;
      case BillUrgency.dueSoon:
        return Colors.orange;
      case BillUrgency.dueToday:
        return Colors.red;
      case BillUrgency.overdue:
        return Colors.red.shade900;
    }
  }
}