import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/budget.dart';
import '../providers/budget_providers.dart';

/// Screen for editing an existing budget
class BudgetEditScreen extends ConsumerStatefulWidget {
  const BudgetEditScreen({
    super.key,
    required this.budget,
  });

  final Budget budget;

  @override
  ConsumerState<BudgetEditScreen> createState() => _BudgetEditScreenState();
}

class _BudgetEditScreenState extends ConsumerState<BudgetEditScreen> {
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
    // Initialize form with existing budget data
    _nameController.text = widget.budget.name;
    _descriptionController.text = widget.budget.description ?? '';
    _selectedType = widget.budget.type;
    _startDate = widget.budget.startDate;
    _endDate = widget.budget.endDate;

    // Initialize categories
    for (final category in widget.budget.categories) {
      _categories.add(BudgetCategoryFormData.fromDomain(category));
    }

    if (_categories.isEmpty) {
      _addCategory();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    for (final category in _categories) {
      category.nameController.dispose();
      category.amountController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Budget'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: AppTheme.screenPaddingAll,
          children: [
            // Budget Name
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
              autofocus: false,
            ),
            const SizedBox(height: 16),

            // Description
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

            // Budget Type
            DropdownButtonFormField<BudgetType>(
              value: _selectedType,
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

            // Date Range
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        setState(() {
                          _startDate = date;
                          // Auto-adjust end date if it's before start date
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

            // Categories Section
            Row(
              children: [
                Text(
                  'Budget Categories',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: _addCategory,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Category'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Category List
            ..._categories.map((category) => _buildCategoryItem(category)),
            const SizedBox(height: 16),

            // Total Budget Display
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

            // Action Buttons
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
                    onPressed: _isSubmitting ? null : _submitBudget,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Update Budget'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BudgetCategoryFormData category) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: category.nameController,
                    decoration: const InputDecoration(
                      labelText: 'Category Name',
                      hintText: 'e.g., Food & Dining',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a category name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    controller: category.amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      prefixText: '\$',
                      hintText: '0.00',
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
                  IconButton(
                    onPressed: () => _removeCategory(category),
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Remove Category',
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
      category.nameController.dispose();
      category.amountController.dispose();
      _categories.remove(category);
    });
  }

  double _calculateTotalBudget() {
    return _categories.fold(0.0, (total, category) {
      final amount = double.tryParse(category.amountController.text) ?? 0.0;
      return total + amount;
    });
  }

  Future<void> _submitBudget() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate that total budget is greater than 0
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
        return BudgetCategory(
          id: categoryData.id ?? DateTime.now().millisecondsSinceEpoch.toString() + categoryData.nameController.text,
          name: categoryData.nameController.text.trim(),
          amount: double.parse(categoryData.amountController.text),
        );
      }).toList();

      final updatedBudget = widget.budget.copyWith(
        name: _nameController.text.trim(),
        type: _selectedType,
        startDate: _startDate,
        endDate: _endDate,
        categories: categories,
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
      );

      final success = await ref
          .read(budgetNotifierProvider.notifier)
          .updateBudget(updatedBudget);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Budget updated successfully')),
        );
        Navigator.pop(context);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update budget'),
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final String? id;

  BudgetCategoryFormData({this.id});

  factory BudgetCategoryFormData.fromDomain(BudgetCategory category) {
    final data = BudgetCategoryFormData(id: category.id);
    data.nameController.text = category.name;
    data.amountController.text = category.amount.toString();
    return data;
  }
}