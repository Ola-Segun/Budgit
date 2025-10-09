import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/bill.dart';

/// Bottom sheet for editing an existing bill
class EditBillBottomSheet extends ConsumerStatefulWidget {
  const EditBillBottomSheet({
    super.key,
    required this.bill,
    required this.onSubmit,
  });

  final Bill bill;
  final Future<void> Function(Bill updatedBill) onSubmit;

  @override
  ConsumerState<EditBillBottomSheet> createState() => _EditBillBottomSheetState();
}

class _EditBillBottomSheetState extends ConsumerState<EditBillBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _payeeController;
  late final TextEditingController _websiteController;
  late final TextEditingController _notesController;

  late BillFrequency _selectedFrequency;
  late DateTime _selectedDueDate;
  late String _selectedCategoryId;
  late bool _isAutoPay;

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
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.bill.name);
    _amountController = TextEditingController(text: widget.bill.amount.toString());
    _descriptionController = TextEditingController(text: widget.bill.description ?? '');
    _payeeController = TextEditingController(text: widget.bill.payee ?? '');
    _websiteController = TextEditingController(text: widget.bill.website ?? '');
    _notesController = TextEditingController(text: widget.bill.notes ?? '');

    _selectedFrequency = widget.bill.frequency;
    _selectedDueDate = widget.bill.dueDate;
    _selectedCategoryId = widget.bill.categoryId;
    _isAutoPay = widget.bill.isAutoPay;
  }

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
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Text(
                  'Edit Bill',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Form
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      value: _selectedCategoryId,
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
                      value: _selectedFrequency,
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
                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
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
                            onPressed: _isSubmitting ? null : _submitBill,
                            child: _isSubmitting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Text('Update Bill'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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

      final updatedBill = widget.bill.copyWith(
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

      await widget.onSubmit(updatedBill);
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