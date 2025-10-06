import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/budget.dart';
import '../providers/budget_providers.dart';
import '../states/budget_state.dart';
import '../widgets/budget_card.dart';
import '../widgets/budget_stats_card.dart';
import 'budget_creation_screen.dart';
import 'budget_detail_screen.dart';

/// Screen for displaying and managing budgets
class BudgetListScreen extends ConsumerStatefulWidget {
  const BudgetListScreen({super.key});

  @override
  ConsumerState<BudgetListScreen> createState() => _BudgetListScreenState();
}

class _BudgetListScreenState extends ConsumerState<BudgetListScreen> {
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
    final budgetState = ref.watch(budgetNotifierProvider);
    final statsState = ref.watch(budgetStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () => _showFilterSheet(context),
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
                hintText: 'Search budgets...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(budgetNotifierProvider.notifier).clearSearch();
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
                ref.read(budgetNotifierProvider.notifier).searchBudgets(query);
              },
            ),
          ),
        ),
      ),
      body: budgetState.when(
        data: (state) => _buildBody(state, statsState),
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(budgetNotifierProvider),
        ),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final isLoading = ref.watch(budgetNotifierProvider).value?.isLoading ?? false;
          return FloatingActionButton.extended(
            onPressed: isLoading ? null : () => _navigateToBudgetCreation(context),
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
            label: Text(isLoading ? 'Creating...' : 'Create Budget'),
          );
        },
      ),
    );
  }

  Widget _buildBody(BudgetState state, AsyncValue<BudgetStats> statsState) {
    if (state.budgets.isEmpty) {
      return _buildEmptyState();
    }

    final filteredBudgets = state.filteredBudgets;
    final activeBudgets = state.activeBudgets;

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(budgetNotifierProvider.notifier).loadBudgets();
      },
      child: ListView(
        padding: AppTheme.screenPaddingAll,
        children: [
          // Stats Card
          statsState.when(
            data: (stats) => BudgetStatsCard(stats: stats),
            loading: () => const SizedBox.shrink(),
            error: (error, stack) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),

          // Active Budgets Section
          if (activeBudgets.isNotEmpty) ...[
            _buildSectionHeader('Active Budgets', activeBudgets.length),
            const SizedBox(height: 8),
            ...activeBudgets.map((budget) => BudgetCard(
              budget: budget,
              status: state.budgetStatuses
                  .where((s) => s.budget.id == budget.id)
                  .firstOrNull,
              onTap: () => _onBudgetTap(budget),
            )),
            const SizedBox(height: 24),
          ],

          // All Budgets Section
          if (filteredBudgets.isNotEmpty) ...[
            _buildSectionHeader('All Budgets', filteredBudgets.length),
            const SizedBox(height: 8),
            ...filteredBudgets.map((budget) => BudgetCard(
              budget: budget,
              status: state.budgetStatuses
                  .where((s) => s.budget.id == budget.id)
                  .firstOrNull,
              onTap: () => _onBudgetTap(budget),
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count.toString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No budgets yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first budget to start tracking your spending',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _navigateToBudgetCreation(context),
            icon: const Icon(Icons.add),
            label: const Text('Create Budget'),
          ),
        ],
      ),
    );
  }

  Future<void> _showFilterSheet(BuildContext context) async {
    final currentState = ref.read(budgetNotifierProvider).value;
    if (currentState == null) return;

    await showModalBottomSheet(
      context: context,
      builder: (context) => BudgetFilterBottomSheet(
        currentFilter: currentState.filter,
        onApplyFilter: (filter) {
          ref.read(budgetNotifierProvider.notifier).applyFilter(filter);
          Navigator.pop(context);
        },
        onClearFilter: () {
          ref.read(budgetNotifierProvider.notifier).clearFilter();
          Navigator.pop(context);
        },
      ),
    );
  }

  void _onBudgetTap(Budget budget) {
    // Navigate to budget detail screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BudgetDetailScreen(budgetId: budget.id),
      ),
    );
  }

  void _navigateToBudgetCreation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BudgetCreationScreen(),
      ),
    );
  }
}

/// Bottom sheet for budget filters
class BudgetFilterBottomSheet extends StatefulWidget {
  const BudgetFilterBottomSheet({
    super.key,
    this.currentFilter,
    required this.onApplyFilter,
    required this.onClearFilter,
  });

  final BudgetFilter? currentFilter;
  final void Function(BudgetFilter) onApplyFilter;
  final VoidCallback onClearFilter;

  @override
  State<BudgetFilterBottomSheet> createState() => _BudgetFilterBottomSheetState();
}

class _BudgetFilterBottomSheetState extends State<BudgetFilterBottomSheet> {
  late BudgetType? _selectedType;
  late bool? _isActive;
  late DateTime? _startDate;
  late DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.currentFilter?.budgetType;
    _isActive = widget.currentFilter?.isActive;
    _startDate = widget.currentFilter?.startDate;
    _endDate = widget.currentFilter?.endDate;
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
            'Filter Budgets',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),

          // Budget Type
          Text(
            'Budget Type',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<BudgetType?>(
            initialValue: _selectedType,
            decoration: const InputDecoration(
              labelText: 'Select Type',
            ),
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('All Types'),
              ),
              ...BudgetType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName),
                );
              }),
            ],
            onChanged: (value) {
              setState(() {
                _selectedType = value;
              });
            },
          ),

          const SizedBox(height: 24),

          // Active Status
          Text(
            'Status',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SegmentedButton<bool?>(
            segments: const [
              ButtonSegment(
                value: null,
                label: Text('All'),
              ),
              ButtonSegment(
                value: true,
                label: Text('Active'),
              ),
              ButtonSegment(
                value: false,
                label: Text('Inactive'),
              ),
            ],
            selected: {_isActive},
            onSelectionChanged: (selected) {
              setState(() {
                _isActive = selected.first;
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
                      lastDate: DateTime.now().add(const Duration(days: 365)),
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
                        ? DateFormat('MMM dd, yyyy').format(_startDate!)
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
                      lastDate: DateTime.now().add(const Duration(days: 365)),
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
                        ? DateFormat('MMM dd, yyyy').format(_endDate!)
                        : 'End Date',
                  ),
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
                    final filter = BudgetFilter(
                      budgetType: _selectedType,
                      isActive: _isActive,
                      startDate: _startDate,
                      endDate: _endDate,
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
}