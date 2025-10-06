import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/bill.dart';
import '../providers/bill_providers.dart';

/// Screen for creating a new bill
class BillCreationScreen extends ConsumerStatefulWidget {
  const BillCreationScreen({super.key});

  @override
  ConsumerState<BillCreationScreen> createState() => _BillCreationScreenState();
}

class _BillCreationScreenState extends ConsumerState<BillCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _payeeController = TextEditingController();
  final _websiteController = TextEditingController();
  final _notesController = TextEditingController();

  BillFrequency _selectedFrequency = BillFrequency.monthly;
  DateTime _selectedDueDate = DateTime.now().add(const Duration(days: 30));
  String _selectedCategoryId = 'utilities'; // Default category
  bool _isAutoPay = false;

  bool _isSubmitting = false;

  // Mock categories - in real app, this would come from a provider
  final List<Map<String, dynamic>> _categories = [
    {'id': 'utilities', 'name': 'Utilities', 'icon': Icons.electrical_services},
    {'id': 'rent', 'name': 'Rent/Mortgage', 'icon': Icons.home},
    {'id': 'insurance', 'name': 'Insurance', 'icon': Icons.security},
    {'id': 'subscription', 'name': 'Subscriptions', 'icon': Icons.subscriptions},
    {'id': 'credit_card', 'name': 'Credit Card', 'icon': Icons.credit_card},
    {'id': 'loan', 'name': 'Loan Payment', 'icon': Icons.account_balance},
    {'id': 'other', 'name': 'Other', 'icon': Icons.category},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _payeeController.dispose();
    _websiteController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bill'),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _submitBill,
            child: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: AppTheme.screenPaddingAll,
          children: [
            // Bill Name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Bill Name',
                hintText: 'e.g., Electricity Bill',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a bill name';
                }
                return null;
              },
              autofocus: true,
            ),
            const SizedBox(height: 16),

            // Amount
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
            ),
            const SizedBox(height: 16),

            // Category
            DropdownButtonFormField<String>(
              initialValue: _selectedCategoryId,
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category['id'] as String,
                  child: Row(
                    children: [
                      Icon(category['icon'] as IconData, size: 20),
                      const SizedBox(width: 8),
                      Text(category['name'] as String),
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
            const SizedBox(height: 16),

            // Frequency
            DropdownButtonFormField<BillFrequency>(
              initialValue: _selectedFrequency,
              decoration: const InputDecoration(
                labelText: 'Frequency',
              ),
              items: BillFrequency.values.map((frequency) {
                return DropdownMenuItem(
                  value: frequency,
                  child: Text(frequency.displayName),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedFrequency = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            // Due Date
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDueDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                );
                if (date != null) {
                  setState(() {
                    _selectedDueDate = date;
                  });
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Due Date',
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat('MMM dd, yyyy').format(_selectedDueDate)),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Payee
            TextFormField(
              controller: _payeeController,
              decoration: const InputDecoration(
                labelText: 'Payee (optional)',
                hintText: 'e.g., Electric Company',
              ),
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Additional details about this bill',
              ),
              maxLength: 200,
              maxLines: 2,
            ),
            const SizedBox(height: 16),

            // Website
            TextFormField(
              controller: _websiteController,
              decoration: const InputDecoration(
                labelText: 'Website (optional)',
                hintText: 'https://example.com',
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),

            // Auto Pay
            SwitchListTile(
              title: const Text('Auto Pay'),
              subtitle: const Text('Automatically pay this bill when due'),
              value: _isAutoPay,
              onChanged: (value) {
                setState(() {
                  _isAutoPay = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Notes
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                hintText: 'Any additional notes',
              ),
              maxLength: 500,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitBill() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final amount = double.parse(_amountController.text);

      final bill = Bill(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        amount: amount,
        dueDate: _selectedDueDate,
        frequency: _selectedFrequency,
        categoryId: _selectedCategoryId,
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        payee: _payeeController.text.trim().isNotEmpty
            ? _payeeController.text.trim()
            : null,
        isAutoPay: _isAutoPay,
        website: _websiteController.text.trim().isNotEmpty
            ? _websiteController.text.trim()
            : null,
        notes: _notesController.text.trim().isNotEmpty
            ? _notesController.text.trim()
            : null,
      );

      final success = await ref
          .read(billNotifierProvider.notifier)
          .createBill(bill);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bill added successfully')),
        );
        Navigator.pop(context);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add bill'),
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