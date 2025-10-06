import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_animations.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../domain/entities/transaction.dart';
import '../providers/transaction_providers.dart';
import '../states/transaction_state.dart';
import '../widgets/add_transaction_bottom_sheet.dart';
import '../widgets/transaction_stats_card.dart';
import '../widgets/transaction_tile.dart';
import 'category_management_screen.dart';
import 'transaction_detail_screen.dart';

/// Screen for displaying and managing transactions
class TransactionListScreen extends ConsumerStatefulWidget {
  const TransactionListScreen({super.key});

  @override
  ConsumerState<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends ConsumerState<TransactionListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionState = ref.watch(transactionNotifierProvider);
    final categories = ref.watch(transactionCategoriesProvider);
    final statsState = ref.watch(transactionStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'categories':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoryManagementScreen(),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'categories',
                child: Row(
                  children: [
                    Icon(Icons.category),
                    SizedBox(width: 8),
                    Text('Manage Categories'),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () => _showFilterSheet(context, categories),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search transactions...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(transactionNotifierProvider.notifier).clearSearch();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
              onChanged: (query) {
                ref.read(transactionNotifierProvider.notifier).searchTransactions(query);
              },
            ),
          ),
        ),
      ),
      body: transactionState.when(
        data: (state) => _buildBody(state, statsState),
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(transactionNotifierProvider),
        ),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final isLoading = ref.watch(transactionNotifierProvider).value?.isLoading ?? false;
          return FloatingActionButton.extended(
            onPressed: isLoading ? null : () => _showAddTransactionSheet(context),
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.add_rounded),
            label: Text(isLoading ? 'Adding...' : 'Add'),
          ).pressEffect();
        },
      ),
    );
  }

  Widget _buildBody(TransactionState state, AsyncValue<TransactionStats> statsState) {
    // Show skeleton loading if we have no transactions but are not in initial loading state
    if (state.transactions.isEmpty && !state.isLoading) {
      return _buildEmptyState();
    }

    // Show skeleton loading if we have no transactions but data is being loaded
    if (state.transactions.isEmpty && state.isLoading) {
      return _buildSkeletonLoading();
    }

    final groupedTransactions = state.transactionsByDate;

    if (groupedTransactions.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(transactionNotifierProvider.notifier).loadTransactions();
      },
      child: ListView(
        padding: AppTheme.screenPaddingAll,
        children: [
          // Stats Card
          statsState.when(
            data: (stats) => TransactionStatsCard(stats: stats),
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),

          // Transactions List
          ...groupedTransactions.entries.map((entry) {
            final date = entry.key;
            final dayTransactions = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    _formatDateHeader(date),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                ...dayTransactions.map((transaction) {
                  return TransactionTile(
                    transaction: transaction,
                    onTap: () => _onTransactionTap(transaction),
                    onDelete: () => _confirmDeleteTransaction(transaction),
                  );
                }),
                const SizedBox(height: 16),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No transactions yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first transaction to get started',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _showAddTransactionSheet(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Transaction'),
          ).pressEffect(),
        ],
      ),
    );
  }

  Widget _buildSkeletonLoading() {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(transactionNotifierProvider.notifier).loadTransactions();
      },
      child: ListView(
        padding: AppTheme.screenPaddingAll,
        children: [
          // Stats Card Skeleton
          const StatsCardSkeleton(),
          const SizedBox(height: 16),

          // Transaction List Skeleton
          const TransactionListSkeleton(itemCount: 6),
        ],
      ),
    );
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Today';
    } else if (transactionDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM dd, yyyy').format(date);
    }
  }

  Future<void> _showAddTransactionSheet(BuildContext context) async {
    await AppBottomSheet.show(
      context: context,
      child: AddTransactionBottomSheet(
        onSubmit: (transaction) async {
          final success = await ref
              .read(transactionNotifierProvider.notifier)
              .addTransaction(transaction);

          if (success && mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Transaction added successfully')),
            );
          }
        },
      ),
    );
  }

  Future<void> _showFilterSheet(BuildContext context, List<TransactionCategory> categories) async {
    final currentState = ref.read(transactionNotifierProvider).value;
    if (currentState == null) return;

    await showModalBottomSheet(
      context: context,
      builder: (context) => TransactionFilterBottomSheet(
        currentFilter: currentState.filter,
        categories: categories,
        onApplyFilter: (filter) {
          ref.read(transactionNotifierProvider.notifier).applyFilter(filter);
          Navigator.pop(context);
        },
        onClearFilter: () {
          ref.read(transactionNotifierProvider.notifier).clearFilter();
          Navigator.pop(context);
        },
      ),
    );
  }

  void _onTransactionTap(Transaction transaction) {
    // Navigate to transaction detail screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionDetailScreen(transactionId: transaction.id),
      ),
    );
  }

  Future<void> _confirmDeleteTransaction(Transaction transaction) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: Text(
          'Are you sure you want to delete "${transaction.description ?? 'this transaction'}"?',
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

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction deleted')),
        );
      }
    }
  }
}

/// Bottom sheet for transaction filters
class TransactionFilterBottomSheet extends StatefulWidget {
  const TransactionFilterBottomSheet({
    super.key,
    this.currentFilter,
    required this.categories,
    required this.onApplyFilter,
    required this.onClearFilter,
  });

  final TransactionFilter? currentFilter;
  final List<TransactionCategory> categories;
  final void Function(TransactionFilter) onApplyFilter;
  final VoidCallback onClearFilter;

  @override
  State<TransactionFilterBottomSheet> createState() => _TransactionFilterBottomSheetState();
}

class _TransactionFilterBottomSheetState extends State<TransactionFilterBottomSheet> {
  late TransactionType? _selectedType;
  late String? _selectedCategoryId;
  late DateTime? _startDate;
  late DateTime? _endDate;
  late double? _minAmount;
  late double? _maxAmount;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.currentFilter?.transactionType;
    _selectedCategoryId = widget.currentFilter?.categoryId;
    _startDate = widget.currentFilter?.startDate;
    _endDate = widget.currentFilter?.endDate;
    _minAmount = widget.currentFilter?.minAmount;
    _maxAmount = widget.currentFilter?.maxAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Filter Transactions',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),

          // Transaction Type
          Text(
            'Transaction Type',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SegmentedButton<TransactionType?>(
            segments: const [
              ButtonSegment(
                value: null,
                label: Text('All'),
              ),
              ButtonSegment(
                value: TransactionType.income,
                label: Text('Income'),
              ),
              ButtonSegment(
                value: TransactionType.expense,
                label: Text('Expense'),
              ),
            ],
            selected: {_selectedType},
            onSelectionChanged: (selected) {
              setState(() {
                _selectedType = selected.first;
              });
            },
          ),

          const SizedBox(height: 24),

          // Category Filter
          Text(
            'Category',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String?>(
            value: _selectedCategoryId,
            decoration: const InputDecoration(
              labelText: 'Select Category',
            ),
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('All Categories'),
              ),
              ...widget.categories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Row(
                    children: [
                      Icon(
                        _getIconFromString(category.icon),
                        size: 20,
                        color: Color(category.color),
                      ),
                      const SizedBox(width: 8),
                      Text(category.name),
                    ],
                  ),
                );
              }),
            ],
            onChanged: (value) {
              setState(() {
                _selectedCategoryId = value;
              });
            },
          ),

          const SizedBox(height: 24),

          // Date Range
          Text(
            'Date Range',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _startDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() {
                        _startDate = date;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _startDate != null
                        ? DateFormat('MMM dd').format(_startDate!)
                        : 'Start Date',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _endDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() {
                        _endDate = date;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _endDate != null
                        ? DateFormat('MMM dd').format(_endDate!)
                        : 'End Date',
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Amount Range
          Text(
            'Amount Range',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Min Amount',
                    prefixText: '\$',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _minAmount = value.isEmpty ? null : double.tryParse(value);
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Max Amount',
                    prefixText: '\$',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _maxAmount = value.isEmpty ? null : double.tryParse(value);
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onClearFilter,
                  child: const Text('Clear'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    final filter = TransactionFilter(
                      transactionType: _selectedType,
                      categoryId: _selectedCategoryId,
                      startDate: _startDate,
                      endDate: _endDate,
                      minAmount: _minAmount,
                      maxAmount: _maxAmount,
                    );
                    widget.onApplyFilter(filter);
                  },
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'restaurant':
        return Icons.restaurant;
      case 'directions_car':
        return Icons.directions_car;
      case 'shopping_bag':
        return Icons.shopping_bag;
      case 'movie':
        return Icons.movie;
      case 'bolt':
        return Icons.bolt;
      case 'local_hospital':
        return Icons.local_hospital;
      case 'work':
        return Icons.work;
      case 'computer':
        return Icons.computer;
      case 'trending_up':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
  }
}