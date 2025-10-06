import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/presentation/providers/account_providers.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_filter.dart';
import '../providers/transaction_providers.dart';
import '../states/transaction_state.dart';

/// Horizontal scrollable filters bar for transactions
class TransactionFiltersBar extends ConsumerStatefulWidget {
  const TransactionFiltersBar({super.key});

  @override
  ConsumerState<TransactionFiltersBar> createState() => _TransactionFiltersBarState();
}

class _TransactionFiltersBarState extends ConsumerState<TransactionFiltersBar> {
  bool _isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(transactionCategoriesProvider);
    final accounts = ref.watch(filteredAccountsProvider);
    final currentFilter = ref.watch(transactionNotifierProvider).value?.filter;

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Search
          _buildSearchField(),

          const SizedBox(width: 8),

          // All Accounts
          _buildAccountsDropdown(accounts),

          const SizedBox(width: 8),

          // Date Range
          _buildDateRangePicker(),

          const SizedBox(width: 8),

          // Categories
          _buildCategoriesFilter(categories),

          const SizedBox(width: 8),

          // Amount Range
          _buildAmountRangeFilter(),

          const SizedBox(width: 8),

          // Clear Filters
          if (currentFilter != null && !currentFilter.isEmpty)
            _buildClearFiltersButton(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    if (_isSearchExpanded) {
      return SizedBox(
        width: 200,
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search, size: 20),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () {
                setState(() {
                  _isSearchExpanded = false;
                  _searchController.clear();
                });
                ref.read(transactionNotifierProvider.notifier).clearSearch();
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          onChanged: (query) {
            ref.read(transactionNotifierProvider.notifier).searchTransactions(query);
          },
        ),
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          setState(() {
            _isSearchExpanded = true;
          });
        },
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      );
    }
  }

  Widget _buildAccountsDropdown(AsyncValue<List<Account>> accounts) {
    return accounts.when(
      data: (accountsList) => SizedBox(
        width: 120,
        child: DropdownButtonFormField<String?>(
          isDense: true,
          decoration: InputDecoration(
            labelText: 'Account',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('All Accounts', style: TextStyle(fontSize: 12)),
            ),
            ...accountsList.map((account) => DropdownMenuItem(
              value: account.id,
              child: Text(account.name, style: const TextStyle(fontSize: 12)),
            )),
          ],
          onChanged: (value) {
            final currentFilter = ref.read(transactionNotifierProvider).value?.filter;
            final newFilter = currentFilter?.copyWith(accountId: value) ??
                TransactionFilter(accountId: value);
            ref.read(transactionNotifierProvider.notifier).applyFilter(newFilter);
          },
        ),
      ),
      loading: () => const SizedBox(width: 120, child: CircularProgressIndicator()),
      error: (error, stack) => const SizedBox(width: 120, child: Icon(Icons.error)),
    );
  }

  Widget _buildDateRangePicker() {
    return OutlinedButton.icon(
      onPressed: () => _showDateRangePicker(),
      icon: const Icon(Icons.date_range, size: 16),
      label: const Text('Date', style: TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    );
  }

  Widget _buildCategoriesFilter(List<TransactionCategory> categories) {
    return OutlinedButton.icon(
      onPressed: () => _showCategoriesMultiSelect(categories),
      icon: const Icon(Icons.category, size: 16),
      label: const Text('Categories', style: TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    );
  }

  Widget _buildAmountRangeFilter() {
    return OutlinedButton.icon(
      onPressed: () => _showAmountRangePicker(),
      icon: const Icon(Icons.attach_money, size: 16),
      label: const Text('Amount', style: TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    );
  }

  Widget _buildClearFiltersButton() {
    return TextButton.icon(
      onPressed: () {
        ref.read(transactionNotifierProvider.notifier).clearFilter();
        setState(() {
          _isSearchExpanded = false;
          _searchController.clear();
        });
      },
      icon: const Icon(Icons.clear, size: 16),
      label: const Text('Clear', style: TextStyle(fontSize: 12)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    );
  }

  void _showDateRangePicker() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 30)),
        end: DateTime.now(),
      ),
    );

    if (picked != null) {
      final currentFilter = ref.read(transactionNotifierProvider).value?.filter;
      final newFilter = currentFilter?.copyWith(
        startDate: picked.start,
        endDate: picked.end,
      ) ?? TransactionFilter(startDate: picked.start, endDate: picked.end);
      ref.read(transactionNotifierProvider.notifier).applyFilter(newFilter);
    }
  }

  void _showCategoriesMultiSelect(List<TransactionCategory> categories) {
    final currentFilter = ref.read(transactionNotifierProvider).value?.filter;
    final selectedIds = currentFilter?.categoryIds ?? [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Select Categories'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: categories.map((category) {
                final isSelected = selectedIds.contains(category.id);
                return CheckboxListTile(
                  title: Row(
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
                  value: isSelected,
                  onChanged: (selected) {
                    setState(() {
                      if (selected == true) {
                        selectedIds.add(category.id);
                      } else {
                        selectedIds.remove(category.id);
                      }
                    });
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
            TextButton(
              onPressed: () {
                final currentFilter = ref.read(transactionNotifierProvider).value?.filter;
                final newFilter = currentFilter?.copyWith(
                  categoryIds: selectedIds.isEmpty ? null : selectedIds,
                ) ?? TransactionFilter(categoryIds: selectedIds.isEmpty ? null : selectedIds);
                ref.read(transactionNotifierProvider.notifier).applyFilter(newFilter);
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAmountRangePicker() {
    final currentFilter = ref.read(transactionNotifierProvider).value?.filter;
    double minAmount = currentFilter?.minAmount ?? 0;
    double maxAmount = currentFilter?.maxAmount ?? 1000;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Amount Range'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Min: \$${minAmount.toStringAsFixed(0)}'),
              Slider(
                value: minAmount,
                min: 0,
                max: 10000,
                onChanged: (value) => setState(() => minAmount = value),
              ),
              Text('Max: \$${maxAmount.toStringAsFixed(0)}'),
              Slider(
                value: maxAmount,
                min: 0,
                max: 10000,
                onChanged: (value) => setState(() => maxAmount = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final currentFilter = ref.read(transactionNotifierProvider).value?.filter;
                final newFilter = currentFilter?.copyWith(
                  minAmount: minAmount,
                  maxAmount: maxAmount,
                ) ?? TransactionFilter(minAmount: minAmount, maxAmount: maxAmount);
                ref.read(transactionNotifierProvider.notifier).applyFilter(newFilter);
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        ),
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