import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/services/category_icon_color_service.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import '../../domain/entities/budget.dart';
import '../providers/budget_providers.dart';

/// Screen for creating a new budget
class BudgetCreationScreen extends ConsumerStatefulWidget {
  const BudgetCreationScreen({super.key});

  @override
  ConsumerState<BudgetCreationScreen> createState() => _BudgetCreationScreenState();
}

class _BudgetCreationScreenState extends ConsumerState<BudgetCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  BudgetType _selectedType = BudgetType.custom;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 30));
  final List<BudgetCategoryFormData> _categories = [];

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _addCategory();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    for (final category in _categories) {
      category.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryNotifierProvider);
    final categoryIconColorService = ref.watch(categoryIconColorServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Budget'),
      ),
      body: categoryState.when(
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.read(categoryNotifierProvider.notifier).loadCategories(),
        ),
        data: (state) => _buildForm(context, state.expenseCategories, categoryIconColorService),
      ),
    );
  }

  Widget _buildForm(BuildContext context, List<TransactionCategory> expenseCategories, CategoryIconColorService categoryIconColorService) {
    for (final category in _categories) {
      if (category.selectedCategoryId == null && expenseCategories.isNotEmpty) {
        category.selectedCategoryId = expenseCategories.first.id;
      }
    }

    return Form(
      key: _formKey,
      child: ListView(
        padding: AppTheme.screenPaddingAll,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Budget Name',
              hintText: 'e.g., Monthly Expenses',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a budget name';
              }
              return null;
            },
            autofocus: true,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description (optional)',
              hintText: 'Describe your budget...',
            ),
            maxLength: 200,
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<BudgetType>(
            initialValue: _selectedType,
            decoration: const InputDecoration(
              labelText: 'Budget Type',
            ),
            items: BudgetType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type.displayName),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedType = value;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _startDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        _startDate = date;
                        if (_endDate.isBefore(_startDate)) {
                          _endDate = _startDate.add(const Duration(days: 30));
                        }
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('MMM dd, yyyy').format(_startDate)),
                        const Icon(Icons.calendar_today, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _endDate,
                      firstDate: _startDate,
                      lastDate: _startDate.add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        _endDate = date;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('MMM dd, yyyy').format(_endDate)),
                        const Icon(Icons.calendar_today, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Budget Categories',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              TextButton.icon(
                onPressed: _addCategory,
                icon: const Icon(Icons.add),
                label: const Text('Add Category'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._categories.map((category) => _buildCategoryItem(category, expenseCategories, categoryIconColorService)),
          const SizedBox(height: 16),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Total Budget:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${NumberFormat('#,##0.00').format(_calculateTotalBudget())}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSubmitting ? null : () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : () => _submitBudget(expenseCategories),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Create Budget'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BudgetCategoryFormData category, List<TransactionCategory> expenseCategories, CategoryIconColorService categoryIconColorService) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Dropdown
            DropdownButtonFormField<String>(
              initialValue: category.selectedCategoryId,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Category',
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              ),
              items: expenseCategories.map((cat) {
                return DropdownMenuItem(
                  value: cat.id,
                  child: Row(
                    children: [
                      Icon(
                        categoryIconColorService.getIconForCategory(cat.id),
                        size: 20,
                        color: categoryIconColorService.getColorForCategory(cat.id),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          cat.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    category.selectedCategoryId = value;
                  });
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a category';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            // Amount Field and Delete Button Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: category.amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      prefixText: '\$',
                      hintText: '0.00',
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount < 0) {
                        return 'Invalid';
                      }
                      return null;
                    },
                  ),
                ),
                if (_categories.length > 1) ...[
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: IconButton(
                      onPressed: () => _removeCategory(category),
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Remove Category',
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addCategory() {
    setState(() {
      _categories.add(BudgetCategoryFormData());
    });
  }

  void _removeCategory(BudgetCategoryFormData category) {
    setState(() {
      category.dispose();
      _categories.remove(category);
    });
  }

  double _calculateTotalBudget() {
    return _categories.fold(0.0, (total, category) {
      final amount = double.tryParse(category.amountController.text) ?? 0.0;
      return total + amount;
    });
  }

  Future<void> _submitBudget(List<TransactionCategory> expenseCategories) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final totalBudget = _calculateTotalBudget();
    if (totalBudget <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Total budget must be greater than zero'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final categories = _categories.map((categoryData) {
        final selectedCategory = expenseCategories.firstWhere(
          (cat) => cat.id == categoryData.selectedCategoryId,
        );
        return BudgetCategory(
          id: selectedCategory.id,
          name: selectedCategory.name,
          amount: double.parse(categoryData.amountController.text),
        );
      }).toList();

      final budget = Budget(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        type: _selectedType,
        startDate: _startDate,
        endDate: _endDate,
        categories: categories,
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        isActive: true,
      );

      final success = await ref
          .read(budgetNotifierProvider.notifier)
          .createBudget(budget);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Budget created successfully')),
        );
        Navigator.pop(context);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create budget'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}

/// Helper class for category form data
class BudgetCategoryFormData {
  String? selectedCategoryId;
  final TextEditingController amountController = TextEditingController();

  void dispose() {
    amountController.dispose();
  }
}