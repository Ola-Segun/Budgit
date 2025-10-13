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
import '../../domain/entities/budget_template.dart';
import '../providers/budget_providers.dart';
import 'budget_template_selection_screen.dart';

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
  DateTime _endDate = DateTime.now().add(const Duration(days: 30));
  DateTime _createdAt = DateTime.now();
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
        actions: [
          TextButton.icon(
            onPressed: () => _showTemplateSelection(context),
            icon: const Icon(Icons.description, color: Colors.white),
            label: const Text(
              'Type',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
        ],
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
          
          // Budget Period (Creation Date to End Date)
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: DateFormat('MMM dd, yyyy hh:mm a').format(_createdAt),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Budget Creation Date & Time',
                    suffixIcon: Icon(Icons.calendar_today, size: 18),
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _createdAt,
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_createdAt),
                      );
                      setState(() {
                        _createdAt = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time?.hour ?? _createdAt.hour,
                          time?.minute ?? _createdAt.minute,
                        );
                        // Auto-adjust end date if it's before creation date
                        if (_endDate.isBefore(_createdAt)) {
                          _endDate = _createdAt.add(const Duration(days: 30));
                        }
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: DateFormat('MMM dd, yyyy hh:mm a').format(_endDate),
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Budget End Date & Time',
                    suffixIcon: Icon(Icons.calendar_today, size: 18),
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _endDate,
                      firstDate: _createdAt,
                      lastDate: _createdAt.add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_endDate),
                      );
                      setState(() {
                        _endDate = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time?.hour ?? _endDate.hour,
                          time?.minute ?? _endDate.minute,
                        );
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Fixed Creation Date/Time Picker
          TextFormField(
            readOnly: true,
            controller: TextEditingController(
              text: DateFormat('MMM dd, yyyy hh:mm a').format(_createdAt),
            ),
            decoration: const InputDecoration(
              labelText: 'Budget Creation Date & Time',
              hintText: 'When should transaction tracking start?',
              suffixIcon: Icon(Icons.calendar_today, size: 20),
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _createdAt,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 1)),
              );
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(_createdAt),
                );
                setState(() {
                  _createdAt = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time?.hour ?? _createdAt.hour,
                    time?.minute ?? _createdAt.minute,
                  );
                });
              }
            },
          ),
          const SizedBox(height: 8),
          Text(
            'Transactions made after this date/time will be tracked against this budget.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
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
        startDate: _createdAt,
        endDate: _endDate,
        createdAt: _createdAt,
        categories: categories,
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        isActive: true,
        allowRollover: false,
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

  Future<void> _showTemplateSelection(BuildContext context) async {
    final selectedTemplate = await Navigator.push<BudgetTemplate?>(
      context,
      MaterialPageRoute(
        builder: (context) => const BudgetTemplateSelectionScreen(),
      ),
    );

    if (selectedTemplate != null && mounted) {
      await _createBudgetFromTemplate(context, selectedTemplate);
    }
  }

  Future<void> _createBudgetFromTemplate(BuildContext context, BudgetTemplate template) async {
    final budgetDetails = await showDialog<BudgetFromTemplateData>(
      context: context,
      builder: (context) => BudgetFromTemplateDialog(template: template, initialCreatedAt: _createdAt),
    );

    if (budgetDetails != null && mounted) {
      final budget = template.createBudget(
        budgetName: budgetDetails.name,
        startDate: budgetDetails.startDate,
        endDate: budgetDetails.endDate,
        totalAmount: budgetDetails.totalAmount,
        description: budgetDetails.description,
      ).copyWith(createdAt: budgetDetails.createdAt ?? _createdAt);

      final success = await ref
          .read(budgetNotifierProvider.notifier)
          .createBudget(budget);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${template.name} budget created successfully')),
        );
        Navigator.pop(context);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create budget from template'),
            backgroundColor: Colors.red,
          ),
        );
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

/// Data class for budget creation from template
class BudgetFromTemplateData {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? createdAt;
  final double totalAmount;
  final String? description;

  const BudgetFromTemplateData({
    required this.name,
    required this.startDate,
    required this.endDate,
    this.createdAt,
    required this.totalAmount,
    this.description,
  });
}

/// Dialog for creating budget from template
class BudgetFromTemplateDialog extends StatefulWidget {
  const BudgetFromTemplateDialog({
    super.key,
    required this.template,
    this.initialCreatedAt,
  });

  final BudgetTemplate template;
  final DateTime? initialCreatedAt;

  @override
  State<BudgetFromTemplateDialog> createState() => _BudgetFromTemplateDialogState();
}

class _BudgetFromTemplateDialogState extends State<BudgetFromTemplateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _totalAmountController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime _endDate = DateTime.now().add(const Duration(days: 30));
  DateTime _createdAt = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nameController.text = '${widget.template.name} Budget';
    _totalAmountController.text = widget.template.totalBudget.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _totalAmountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create ${widget.template.name} Budget'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Budget Name',
                  hintText: 'e.g., Monthly Budget',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a budget name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _totalAmountController,
                decoration: const InputDecoration(
                  labelText: 'Total Budget Amount',
                  prefixText: '\$',
                  hintText: '0.00',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total budget amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Budget Period (Creation Date to End Date)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: DateFormat('MMM dd, yyyy hh:mm a').format(_createdAt),
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Budget Creation Date & Time',
                        suffixIcon: Icon(Icons.calendar_today, size: 16),
                      ),
                      style: const TextStyle(fontSize: 13),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _createdAt,
                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(_createdAt),
                          );
                          setState(() {
                            _createdAt = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time?.hour ?? _createdAt.hour,
                              time?.minute ?? _createdAt.minute,
                            );
                            if (_endDate.isBefore(_createdAt)) {
                              _endDate = _createdAt.add(const Duration(days: 30));
                            }
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: TextEditingController(
                        text: DateFormat('MMM dd, yyyy hh:mm a').format(_endDate),
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Budget End Date & Time',
                        suffixIcon: Icon(Icons.calendar_today, size: 16),
                      ),
                      style: const TextStyle(fontSize: 13),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _endDate,
                          firstDate: _createdAt,
                          lastDate: _createdAt.add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(_endDate),
                          );
                          setState(() {
                            _endDate = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time?.hour ?? _endDate.hour,
                              time?.minute ?? _endDate.minute,
                            );
                          });
                        }
                      },
                    ),
                  ),
                ],
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
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final data = BudgetFromTemplateData(
                name: _nameController.text.trim(),
                startDate: _createdAt,
                endDate: _endDate,
                createdAt: _createdAt,
                totalAmount: double.parse(_totalAmountController.text),
                description: _descriptionController.text.trim().isNotEmpty
                    ? _descriptionController.text.trim()
                    : null,
              );
              Navigator.pop(context, data);
            }
          },
          child: const Text('Create Budget'),
        ),
      ],
    );
  }
}