import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/presentation/providers/account_providers.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
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
  late String? _selectedAccountId;
  late bool _isAutoPay;

  bool _isSubmitting = false;

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
    _selectedAccountId = widget.bill.accountId;
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
    return ConstrainedBox(
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
                    Consumer(
                      builder: (context, ref, child) {
                        final categories = ref.watch(transactionCategoriesProvider);
                        final categoryIconColorService = ref.watch(categoryIconColorServiceProvider);

                        if (categories.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'No categories available. You can still create the bill and assign a category later.',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return DropdownButtonFormField<String>(
                          initialValue: _selectedCategoryId,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                          ),
                          items: categories.map((category) {
                            return DropdownMenuItem(
                              value: category.id,
                              child: Row(
                                children: [
                                  Icon(categoryIconColorService.getIconForCategory(category.id), size: 20, color: categoryIconColorService.getColorForCategory(category.id)),
                                  const SizedBox(width: 8),
                                  Text(category.name),
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
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Account Selection
// Replace the entire Account Selection Consumer widget in BOTH files with this:

// Account Selection
Consumer(
  builder: (context, ref, child) {
    final accountsAsync = ref.watch(filteredAccountsProvider);

    return accountsAsync.when(
      data: (accounts) {
        if (accounts.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'No accounts available. You can still create the bill and assign an account later.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // For BillCreationScreen only: Smart default selection
        // (Skip this block in EditBillBottomSheet)
        if (_selectedAccountId == null) {
          final defaultAccount = accounts.firstWhere(
            (account) => account.type == AccountType.bankAccount && account.isActive,
            orElse: () => accounts.firstWhere(
              (account) => account.isActive,
              orElse: () => accounts.first,
            ),
          );
          _selectedAccountId = defaultAccount.id;
        }

        // Validate selected account ID exists
        if (_selectedAccountId != null && 
            !accounts.any((account) => account.id == _selectedAccountId)) {
          _selectedAccountId = null;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _selectedAccountId,
              isExpanded: true, // CRITICAL: This fixes the overflow
              decoration: const InputDecoration(
                labelText: 'Default Account (Optional)',
                border: OutlineInputBorder(),
                helperText: 'Account to use for automatic payments',
              ),
              selectedItemBuilder: (BuildContext context) {
                // Custom builder for the selected value display
                return [
                  const Text('No account selected'),
                  ...accounts.map((account) {
                    return Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: Color(account.type.color),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            account.displayName,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  }),
                ];
              },
              items: [
                // Add "No account" option
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('No account selected'),
                ),
                // Add all accounts
                ...accounts.map((account) {
                  return DropdownMenuItem<String>(
                    value: account.id,
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: Color(account.type.color),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                account.displayName,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                account.formattedAvailableBalance,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
              onChanged: (value) {
                setState(() => _selectedAccountId = value);
              },
            ),
            // Only show info message if an account is actually selected
            if (_selectedAccountId != null) ...[
              const SizedBox(height: 8),
              Builder(
                builder: (context) {
                  // Find the selected account safely
                  final selectedAccount = accounts.firstWhere(
                    (account) => account.id == _selectedAccountId,
                  );
                  
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Payments will be deducted from ${selectedAccount.displayName}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],
        );
      },
      loading: () => const SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Error loading accounts: $error',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
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
      // Validate selected account if one is chosen
      if (_selectedAccountId != null) {
        final accountsAsync = ref.read(filteredAccountsProvider);
        final accounts = accountsAsync.maybeWhen(
          data: (data) => data,
          orElse: () => <Account>[],
        );

        final selectedAccount = accounts.firstWhere(
          (account) => account.id == _selectedAccountId,
        );

        if (!selectedAccount.isActive) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Selected account is inactive. Please select a different account.'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }
      }

      final amount = double.parse(_amountController.text);

      final updatedBill = widget.bill.copyWith(
        name: _nameController.text.trim(),
        amount: amount,
        dueDate: _selectedDueDate,
        frequency: _selectedFrequency,
        categoryId: _selectedCategoryId,
        accountId: _selectedAccountId,
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