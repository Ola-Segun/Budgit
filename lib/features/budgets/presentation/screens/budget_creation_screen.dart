import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../transactions/domain/entities/transaction.dart';
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

  // Available transaction categories for selection (matching transaction creation)
  final List<Map<String, dynamic>> _availableCategories = [
    {'id': 'food', 'name': 'Food & Dining', 'icon': Icons.restaurant, 'color': 0xFFF59E0B},
    {'id': 'transportation', 'name': 'Transportation', 'icon': Icons.directions_car, 'color': 0xFFEF4444},
    {'id': 'shopping', 'name': 'Shopping', 'icon': Icons.shopping_bag, 'color': 0xFFEC4899},
    {'id': 'entertainment', 'name': 'Entertainment', 'icon': Icons.movie, 'color': 0xFFF97316},
    {'id': 'utilities', 'name': 'Utilities', 'icon': Icons.electrical_services, 'color': 0xFF06B6D4},
    {'id': 'healthcare', 'name': 'Healthcare', 'icon': Icons.local_hospital, 'color': 0xFFDC2626},
    {'id': 'other', 'name': 'Other', 'icon': Icons.category, 'color': 0xFF64748B},
  ];

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Add a default category
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Budget'),
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
              autofocus: true,
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
                        firstDate: DateTime.now(),
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
                        : const Text('Create Budget'),
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
                  child: DropdownButtonFormField<String>(
                    value: category.selectedCategoryId,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    items: _availableCategories.map((availableCategory) {
                      return DropdownMenuItem(
                        value: availableCategory['id'] as String,
                        child: Row(
                          children: [
                            Icon(
                              availableCategory['icon'] as IconData,
                              size: 20,
                              color: Color(availableCategory['color'] as int),
                            ),
                            const SizedBox(width: 8),
                            Text(availableCategory['name'] as String),
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
        final selectedCategory = _availableCategories.firstWhere(
          (cat) => cat['id'] == categoryData.selectedCategoryId,
        );
        return BudgetCategory(
          id: selectedCategory['id'] as String,
          name: selectedCategory['name'] as String,
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
  String selectedCategoryId = 'food'; // Default to food category
  final TextEditingController amountController = TextEditingController();

  void dispose() {
    amountController.dispose();
  }
}
