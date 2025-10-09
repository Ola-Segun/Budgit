import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/transaction.dart';

/// Bottom sheet for adding new transactions
class AddTransactionBottomSheet extends StatefulWidget {
  const AddTransactionBottomSheet({
    super.key,
    required this.onSubmit,
  });

  final void Function(Transaction) onSubmit;

  @override
  State<AddTransactionBottomSheet> createState() => _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState extends State<AddTransactionBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _noteController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;
  DateTime _selectedDate = DateTime.now();
  String _selectedCategoryId = 'food'; // Default category
  String _selectedAccountId = 'checking'; // Default account

  bool _isSubmitting = false;

  // Mock categories - in real app, this would come from a provider
  final List<Map<String, dynamic>> _categories = [
    {'id': 'food', 'name': 'Food & Dining', 'icon': Icons.restaurant},
    {'id': 'transportation', 'name': 'Transportation', 'icon': Icons.directions_car},
    {'id': 'shopping', 'name': 'Shopping', 'icon': Icons.shopping_bag},
    {'id': 'entertainment', 'name': 'Entertainment', 'icon': Icons.movie},
    {'id': 'utilities', 'name': 'Utilities', 'icon': Icons.electrical_services},
    {'id': 'healthcare', 'name': 'Healthcare', 'icon': Icons.local_hospital},
    {'id': 'other', 'name': 'Other', 'icon': Icons.category},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Debug logging for responsiveness investigation
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    debugPrint('AddTransactionBottomSheet: Screen size: ${screenWidth}x${screenHeight}');

    final buttonChild = _isSubmitting
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(),
          )
        : const Text('Add Transaction');

    return LayoutBuilder(
      builder: (context, constraints) {
        debugPrint('AddTransactionBottomSheet: Available width: ${constraints.maxWidth}, height: ${constraints.maxHeight}');
        return Container(
            padding: AppTheme.screenPaddingAll,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
              maxWidth: MediaQuery.of(context).size.width, // Ensure it doesn't exceed screen width
            ),
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            // Header
            Row(
              children: [
                Text(
                  'Add Transaction',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Transaction Type Toggle
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SegmentedButton<TransactionType>(
                segments: [
                  ButtonSegment(
                    value: TransactionType.expense,
                    label: Text('Expense'),
                    icon: Icon(Icons.remove_circle_outline),
                  ),
                  ButtonSegment(
                    value: TransactionType.income,
                    label: Text('Income'),
                    icon: Icon(Icons.add_circle_outline),
                  ),
                ],
                selected: {_selectedType},
                onSelectionChanged: (selected) {
                  setState(() {
                    _selectedType = selected.first;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),

            // Amount Field
            TextFormField(
              controller: _amountController,
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
                  return 'Please enter an amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
              autofocus: true,
            ),
            const SizedBox(height: 16),

            // Category Selection
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth - (AppTheme.screenPaddingAll.horizontal * 2),
              ),
              child: DropdownButtonFormField<String>(
                initialValue: _selectedCategoryId,
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category['id'] as String,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(category['icon'] as IconData, size: 20),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            category['name'] as String,
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
                      _selectedCategoryId = value;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),

            // Account Selection
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth - (AppTheme.screenPaddingAll.horizontal * 2),
              ),
              child: DropdownButtonFormField<String>(
                initialValue: _selectedAccountId,
                decoration: const InputDecoration(
                  labelText: 'Account',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'checking',
                    child: Text('Checking Account'),
                  ),
                  DropdownMenuItem(
                    value: 'savings',
                    child: Text('Savings Account'),
                  ),
                  DropdownMenuItem(
                    value: 'credit',
                    child: Text('Credit Card'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedAccountId = value;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),

            // Date Picker
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                  });
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date',
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat('MMM dd, yyyy').format(_selectedDate)),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Description Field
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'e.g., Grocery shopping at Walmart',
              ),
              maxLength: 100,
            ),
            const SizedBox(height: 16),

            // Receipt Scanning
            OutlinedButton.icon(
              onPressed: _scanReceipt,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Scan Receipt'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: 16),

            // Note Field
            TextFormField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Note (optional)',
                hintText: 'Additional details...',
              ),
              maxLength: 200,
              maxLines: 2,
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
                  child: TextButton(
                    onPressed: _isSubmitting ? null : () {
                      _submitTransaction();
                    },
                    child: buttonChild,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
        ),
      );
      },
    );
  }

  Future<void> _scanReceipt() async {
    // Show receipt scanning dialog
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Receipt Scanner'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.camera_alt,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Receipt scanning feature is coming soon!\n\nFor now, you can manually enter transaction details.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitTransaction() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final amount = double.parse(_amountController.text);

      final transaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : 'Transaction',
        amount: amount,
        type: _selectedType,
        date: _selectedDate,
        categoryId: _selectedCategoryId,
        accountId: _selectedAccountId,
        description: _noteController.text.isNotEmpty
            ? _noteController.text
            : null,
      );

      widget.onSubmit(transaction);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add transaction: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
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