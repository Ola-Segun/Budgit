import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/transaction.dart';
import '../providers/transaction_providers.dart';

/// Screen for viewing and editing transaction details
class TransactionDetailScreen extends ConsumerStatefulWidget {
  const TransactionDetailScreen({
    super.key,
    required this.transactionId,
  });

  final String transactionId;

  @override
  ConsumerState<TransactionDetailScreen> createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends ConsumerState<TransactionDetailScreen> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final transactionState = ref.watch(transactionNotifierProvider);

    return transactionState.when(
      data: (state) {
        final transaction = state.transactions
            .where((t) => t.id == widget.transactionId)
            .firstOrNull;

        if (transaction == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Transaction Not Found')),
            body: const Center(
              child: Text('Transaction not found'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(_isEditing ? 'Edit Transaction' : 'Transaction Details'),
            actions: [
              if (!_isEditing) ...[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => setState(() => _isEditing = true),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _confirmDeleteTransaction(transaction),
                ),
              ] else ...[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _isEditing = false),
                ),
              ],
            ],
          ),
          body: _isEditing
              ? _buildEditView(transaction)
              : _buildDetailView(transaction),
        );
      },
      loading: () => const Scaffold(body: LoadingView()),
      error: (error, stack) => Scaffold(
        body: ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(transactionNotifierProvider),
        ),
      ),
    );
  }

  Widget _buildDetailView(Transaction transaction) {
    return SingleChildScrollView(
      padding: AppTheme.screenPaddingAll,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Amount Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    transaction.signedAmount,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: transaction.isIncome
                              ? Colors.green
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    transaction.type.displayName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Transaction Details
          Text(
            'Details',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),

          _buildDetailRow('Title', transaction.title),
          _buildDetailRow('Description', transaction.description ?? 'No description'),
          _buildDetailRow('Category', _getCategoryName(transaction.categoryId)),
          _buildDetailRow('Date', DateFormat('EEEE, MMMM dd, yyyy').format(transaction.date)),
          _buildDetailRow('Time', DateFormat('HH:mm').format(transaction.date)),

          if (transaction.receiptUrl != null) ...[
            const SizedBox(height: 16),
            _buildDetailRow('Receipt', 'Available'),
          ],

          if (transaction.tags.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildDetailRow('Tags', transaction.tags.join(', ')),
          ],
        ],
      ),
    );
  }

  Widget _buildEditView(Transaction transaction) {
    final categories = ref.read(transactionCategoriesProvider);
    final categoryIconColorService = ref.read(categoryIconColorServiceProvider);

    return EditTransactionForm(
      transaction: transaction,
      categories: categories,
      categoryIconColorService: categoryIconColorService,
      onSave: (updatedTransaction) async {
        final success = await ref
            .read(transactionNotifierProvider.notifier)
            .updateTransaction(updatedTransaction);

        if (success && mounted) {
          setState(() => _isEditing = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaction updated successfully')),
          );
        }
      },
      onCancel: () => setState(() => _isEditing = false),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryName(String categoryId) {
    final categories = ref.read(transactionCategoriesProvider);
    final category = categories.where((c) => c.id == categoryId).firstOrNull;
    return category?.name ?? 'Unknown Category';
  }

  Future<void> _confirmDeleteTransaction(Transaction transaction) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: Text(
          'Are you sure you want to delete "${transaction.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await ref
          .read(transactionNotifierProvider.notifier)
          .deleteTransaction(transaction.id);

      if (success && mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction deleted')),
        );
      }
    }
  }
}

/// Form for editing transaction details
class EditTransactionForm extends StatefulWidget {
  const EditTransactionForm({
    super.key,
    required this.transaction,
    required this.categories,
    required this.categoryIconColorService,
    required this.onSave,
    required this.onCancel,
  });

  final Transaction transaction;
  final List<TransactionCategory> categories;
  final dynamic categoryIconColorService;
  final void Function(Transaction) onSave;
  final VoidCallback onCancel;

  @override
  State<EditTransactionForm> createState() => _EditTransactionFormState();
}

class _EditTransactionFormState extends State<EditTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _amountController;

  late TransactionType _selectedType;
  late DateTime _selectedDate;
  late String _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.transaction.title);
    _descriptionController = TextEditingController(text: widget.transaction.description);
    _amountController = TextEditingController(text: widget.transaction.amount.toStringAsFixed(2));

    _selectedType = widget.transaction.type;
    _selectedDate = widget.transaction.date;
    _selectedCategoryId = widget.transaction.categoryId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppTheme.screenPaddingAll,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Transaction Type Toggle
            SegmentedButton<TransactionType>(
              segments: const [
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
            ),
            const SizedBox(height: 16),

            // Title Field
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Transaction title',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Category Selection
            DropdownButtonFormField<String>(
              initialValue: _selectedCategoryId,
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              items: widget.categories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Row(
                    children: [
                      Icon(
                        widget.categoryIconColorService.getIconForCategory(category.id),
                        size: 20,
                        color: widget.categoryIconColorService.getColorForCategory(category.id),
                      ),
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
                hintText: 'Additional details...',
              ),
              maxLength: 200,
              maxLines: 3,
            ),

            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onCancel,
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _saveTransaction,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveTransaction() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final amount = double.parse(_amountController.text);

    final updatedTransaction = widget.transaction.copyWith(
      title: _titleController.text.trim(),
      amount: amount,
      type: _selectedType,
      date: _selectedDate,
      categoryId: _selectedCategoryId,
      description: _descriptionController.text.trim().isNotEmpty
          ? _descriptionController.text.trim()
          : null,
    );

    widget.onSave(updatedTransaction);
  }

}