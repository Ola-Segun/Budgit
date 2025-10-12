import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/error/failures.dart';
import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/presentation/providers/account_providers.dart';
import '../../../dashboard/presentation/providers/dashboard_providers.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import '../../../../core/di/providers.dart' as core_providers;
import '../../domain/entities/bill.dart';
import '../../domain/usecases/validate_bill_account.dart';
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
  String _selectedCategoryId = ''; // Will be set dynamically
  String? _selectedAccountId;
  bool _isAutoPay = false;

  bool _isSubmitting = false;

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
            Consumer(
              builder: (context, ref, child) {
                final categoryState = ref.watch(categoryNotifierProvider);
                final categoryIconColorService = ref.watch(categoryIconColorServiceProvider);

                return categoryState.when(
                  data: (state) {
                    final expenseCategories = state.getCategoriesByType(TransactionType.expense);

                    // Update default category if not set or invalid
                    if (_selectedCategoryId.isEmpty ||
                        !expenseCategories.any((cat) => cat.id == _selectedCategoryId)) {
                      _selectedCategoryId = _getSmartDefaultCategoryId(expenseCategories);
                    }

                    if (expenseCategories.isEmpty) {
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
                                'No expense categories available. Please add categories first.',
                                style: TextStyle(fontSize: 14),
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
                      items: expenseCategories.map((category) {
                        final iconAndColor = categoryIconColorService.getIconAndColorForCategory(category.id);
                        return DropdownMenuItem(
                          value: category.id,
                          child: Row(
                            children: [
                              Icon(iconAndColor.icon, size: 20, color: iconAndColor.color),
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
                  loading: () => const SizedBox(
                    height: 60,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, stack) => Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Error loading categories: $error',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                        : const Text('Add Bill'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Get smart default category ID for expense categories (bills)
  String _getSmartDefaultCategoryId(List<TransactionCategory> expenseCategories) {
    if (expenseCategories.isEmpty) {
      // Fallback to default categories if no user categories exist
      final defaultCategories = TransactionCategory.defaultCategories.where((cat) => cat.type == TransactionType.expense).toList();
      return defaultCategories.isNotEmpty ? defaultCategories.first.id : 'other';
    }

    // Prefer commonly used bill categories
    final preferredIds = ['utilities', 'other'];
    for (final preferredId in preferredIds) {
      final preferredCategory = expenseCategories.firstWhere(
        (cat) => cat.id == preferredId,
        orElse: () => expenseCategories.first,
      );
      if (preferredCategory.id == preferredId) {
        return preferredId;
      }
    }

    // Return first expense category
    return expenseCategories.first.id;
  }

  Future<void> _submitBill() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final billAmount = double.parse(_amountController.text);

      // Validate selected account if one is chosen
      if (_selectedAccountId != null) {
        final accountRepository = ref.read(core_providers.accountRepositoryProvider);
        final validateAccount = ValidateBillAccount(accountRepository);
        final accountValidation = await validateAccount(_selectedAccountId, billAmount);

        if (accountValidation.isError) {
          final failure = accountValidation.failureOrNull!;

          String errorMessage = failure.message;
          if (failure is ValidationFailure) {
            final errors = failure.errors;
            if (errors.containsKey('accountId')) {
              errorMessage = errors['accountId']!;
            }
          }

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          }
          return;
        }
      }

      final amount = double.parse(_amountController.text);

      final bill = Bill(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
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

      final success = await ref
          .read(billNotifierProvider.notifier)
          .createBill(bill);

      if (success && mounted) {
        // Invalidate dashboard to refresh data
        ref.invalidate(dashboardDataProvider);
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