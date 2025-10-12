import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/account.dart';

/// Bottom sheet for adding or editing accounts
class AddEditAccountBottomSheet extends StatefulWidget {
  const AddEditAccountBottomSheet({
    super.key,
    this.account, // null for creation, provided for editing
    required this.onSubmit,
  });

  final Account? account;
  final void Function(Account) onSubmit;

  @override
  State<AddEditAccountBottomSheet> createState() => _AddEditAccountBottomSheetState();
}

class _AddEditAccountBottomSheetState extends State<AddEditAccountBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _institutionController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _creditLimitController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _minimumPaymentController = TextEditingController();
  final _scrollController = ScrollController();

  AccountType _selectedType = AccountType.bankAccount;
  String _selectedCurrency = 'USD';
  bool _isActive = true;
  bool _isSubmitting = false;

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'CAD', 'AUD', 'JPY'];

  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      // Editing mode - populate fields
      final account = widget.account!;
      _nameController.text = account.name;
      _balanceController.text = account.currentBalance.toStringAsFixed(2);
      _descriptionController.text = account.description ?? '';
      _institutionController.text = account.institution ?? '';
      _accountNumberController.text = account.accountNumber ?? '';
      _selectedType = account.type;
      _selectedCurrency = account.currency;
      _isActive = account.isActive;

      // Type-specific fields
      if (account.creditLimit != null) {
        _creditLimitController.text = account.creditLimit!.toStringAsFixed(2);
      }
      if (account.interestRate != null) {
        _interestRateController.text = account.interestRate!.toStringAsFixed(2);
      }
      if (account.minimumPayment != null) {
        _minimumPaymentController.text = account.minimumPayment!.toStringAsFixed(2);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _descriptionController.dispose();
    _institutionController.dispose();
    _accountNumberController.dispose();
    _creditLimitController.dispose();
    _interestRateController.dispose();
    _minimumPaymentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.account != null;
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final availableHeight = screenHeight - keyboardHeight - 100; // 100 for safe area

    return Container(
      constraints: BoxConstraints(
        maxHeight: availableHeight,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Fixed Header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  isEditing ? 'Edit Account' : 'Add Account',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  tooltip: 'Close',
                ),
              ],
            ),
          ),

          // Scrollable Content
          Flexible(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Account Type Selection
                    Text(
                      'Account Type',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildAccountTypeGrid(),
                    const SizedBox(height: 24),

                    // Basic Information
                    Text(
                      'Basic Information',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 16),

                    // Account Name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Account Name',
                        hintText: 'e.g., Main Checking',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Account name is required';
                        }
                        return null;
                      },
                      autofocus: !isEditing,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    // Balance
                    TextFormField(
                      controller: _balanceController,
                      decoration: InputDecoration(
                        labelText: 'Current Balance',
                        prefixText: _getCurrencySymbol(_selectedCurrency),
                        hintText: '0.00',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^-?\d+\.?\d{0,2}')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Balance is required';
                        }
                        final balance = double.tryParse(value);
                        if (balance == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    // Currency
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCurrency,
                      decoration: const InputDecoration(
                        labelText: 'Currency',
                      ),
                      items: _currencies.map((currency) {
                        return DropdownMenuItem(
                          value: currency,
                          child: Text(currency),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCurrency = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Institution (optional)
                    TextFormField(
                      controller: _institutionController,
                      decoration: const InputDecoration(
                        labelText: 'Institution (optional)',
                        hintText: 'e.g., Bank of America',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    // Account Number (optional)
                    TextFormField(
                      controller: _accountNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Account Number (optional)',
                        hintText: 'e.g., ****1234',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    // Description (optional)
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description (optional)',
                        hintText: 'Additional notes about this account',
                      ),
                      maxLines: 2,
                      textInputAction: TextInputAction.done,
                    ),

                    // Type-specific fields
                    ..._buildTypeSpecificFields(),

                    const SizedBox(height: 16),

                    // Active Status
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SwitchListTile(
                        title: const Text('Account is Active'),
                        subtitle: const Text('Inactive accounts are hidden from calculations'),
                        value: _isActive,
                        onChanged: (value) {
                          setState(() {
                            _isActive = value;
                          });
                        },
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _isSubmitting ? null : () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 48),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FilledButton(
                            onPressed: _isSubmitting ? null : _submitAccount,
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(0, 48),
                            ),
                            child: _isSubmitting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : Text(isEditing ? 'Update Account' : 'Add Account'),
                          ),
                        ),
                      ],
                    ),
                    
                    // Extra padding for keyboard
                    SizedBox(height: keyboardHeight > 0 ? 16 : 0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountTypeGrid() {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 360 ? 2 : 3;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: screenWidth < 360 ? 1.2 : 1.0,
          children: AccountType.values.map((type) {
            final isSelected = _selectedType == type;
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedType = type;
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Color(type.color).withValues(alpha: 0.1)
                      : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  border: Border.all(
                    color: isSelected
                        ? Color(type.color)
                        : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getIconData(type.icon),
                      color: isSelected
                          ? Color(type.color)
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      size: screenWidth < 360 ? 20 : 24,
                    ),
                    const SizedBox(height: 4),
                    Flexible(
                      child: Text(
                        type.displayName,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isSelected
                                  ? Color(type.color)
                                  : Theme.of(context).colorScheme.onSurfaceVariant,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              fontSize: screenWidth < 360 ? 10 : 12,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  List<Widget> _buildTypeSpecificFields() {
    switch (_selectedType) {
      case AccountType.creditCard:
        return [
          const SizedBox(height: 24),
          Text(
            'Credit Card Details',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _creditLimitController,
            decoration: InputDecoration(
              labelText: 'Credit Limit',
              prefixText: _getCurrencySymbol(_selectedCurrency),
              hintText: '5000.00',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final limit = double.tryParse(value);
                if (limit == null || limit <= 0) {
                  return 'Please enter a valid credit limit';
                }
                final balance = double.tryParse(_balanceController.text) ?? 0;
                if (balance > limit) {
                  return 'Balance cannot exceed credit limit';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _minimumPaymentController,
            decoration: InputDecoration(
              labelText: 'Minimum Payment (optional)',
              prefixText: _getCurrencySymbol(_selectedCurrency),
              hintText: '25.00',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            textInputAction: TextInputAction.done,
          ),
        ];

      case AccountType.loan:
        return [
          const SizedBox(height: 24),
          Text(
            'Loan Details',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _interestRateController,
            decoration: const InputDecoration(
              labelText: 'Interest Rate (%)',
              hintText: '5.5',
              suffixText: '%',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final rate = double.tryParse(value);
                if (rate == null || rate < 0 || rate > 100) {
                  return 'Please enter a valid interest rate (0-100%)';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _minimumPaymentController,
            decoration: InputDecoration(
              labelText: 'Monthly Payment (optional)',
              prefixText: _getCurrencySymbol(_selectedCurrency),
              hintText: '150.00',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            textInputAction: TextInputAction.done,
          ),
        ];

      default:
        return [];
    }
  }

  String _getCurrencySymbol(String currency) {
    switch (currency) {
      case 'USD':
      case 'CAD':
      case 'AUD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      default:
        return '\$';
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'account_balance':
        return Icons.account_balance;
      case 'credit_card':
        return Icons.credit_card;
      case 'account_balance_wallet':
        return Icons.account_balance_wallet;
      case 'trending_up':
        return Icons.trending_up;
      case 'edit':
        return Icons.edit;
      default:
        return Icons.account_balance_wallet;
    }
  }

  Future<void> _submitAccount() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    debugPrint('AddEditAccountBottomSheet: _submitAccount called, _isSubmitting: $_isSubmitting');
    if (_isSubmitting) {
      debugPrint('AddEditAccountBottomSheet: Already submitting, ignoring duplicate call');
      return;
    }

    setState(() => _isSubmitting = true);
    debugPrint('AddEditAccountBottomSheet: Set _isSubmitting to true');

    try {
      final balance = double.parse(_balanceController.text);
      debugPrint('AddEditAccountBottomSheet: Parsed balance: $balance');
      final creditLimit = _creditLimitController.text.isNotEmpty
          ? double.tryParse(_creditLimitController.text)
          : null;
      final interestRate = _interestRateController.text.isNotEmpty
          ? double.tryParse(_interestRateController.text)
          : null;
      final minimumPayment = _minimumPaymentController.text.isNotEmpty
          ? double.tryParse(_minimumPaymentController.text)
          : null;

      final account = Account(
        id: widget.account?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        type: _selectedType,
        balance: balance,
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        institution: _institutionController.text.isNotEmpty
            ? _institutionController.text.trim()
            : null,
        accountNumber: _accountNumberController.text.isNotEmpty
            ? _accountNumberController.text.trim()
            : null,
        currency: _selectedCurrency,
        createdAt: widget.account?.createdAt,
        updatedAt: DateTime.now(),
        creditLimit: creditLimit,
        interestRate: interestRate,
        minimumPayment: minimumPayment,
        isActive: _isActive,
      );

      debugPrint('AddEditAccountBottomSheet: Created account with balance: ${account.balance}, currentBalance: ${account.currentBalance}, formattedBalance: ${account.formattedBalance}');
      widget.onSubmit(account);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to ${widget.account != null ? 'update' : 'create'} account: ${e.toString()}'),
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