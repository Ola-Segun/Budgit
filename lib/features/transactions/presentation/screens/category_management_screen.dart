import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/transaction.dart';
import '../providers/transaction_providers.dart';

/// Screen for managing transaction categories
class CategoryManagementScreen extends ConsumerStatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  ConsumerState<CategoryManagementScreen> createState() => _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends ConsumerState<CategoryManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(transactionCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddCategoryDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: AppTheme.screenPaddingAll,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryTile(category);
        },
      ),
    );
  }

  Widget _buildCategoryTile(TransactionCategory category) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(category.color).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getIconFromString(category.icon),
            color: Color(category.color),
          ),
        ),
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          category.type.displayName,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditCategoryDialog(context, category),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDeleteCategory(context, category),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddCategoryDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const AddCategoryDialog(),
    );
  }

  Future<void> _showEditCategoryDialog(BuildContext context, TransactionCategory category) async {
    await showDialog(
      context: context,
      builder: (context) => EditCategoryDialog(category: category),
    );
  }

  Future<void> _confirmDeleteCategory(BuildContext context, TransactionCategory category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Category'),
        content: Text(
          'Are you sure you want to delete "${category.name}"? This action cannot be undone.',
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
      // Note: In a real app, this would call a use case to delete the category
      // For now, we'll just show a message since categories are static
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category deletion not implemented yet')),
        );
      }
    }
  }

  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'restaurant':
        return Icons.restaurant;
      case 'directions_car':
        return Icons.directions_car;
      case 'shopping_bag':
        return Icons.shopping_bag;
      case 'movie':
        return Icons.movie;
      case 'bolt':
        return Icons.bolt;
      case 'local_hospital':
        return Icons.local_hospital;
      case 'work':
        return Icons.work;
      case 'computer':
        return Icons.computer;
      case 'trending_up':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
  }
}

/// Dialog for adding a new category
class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  TransactionType _selectedType = TransactionType.expense;
  String _selectedIcon = 'category';
  int _selectedColor = 0xFF64748B; // Default gray

  final List<Map<String, dynamic>> _availableIcons = [
    {'name': 'restaurant', 'icon': Icons.restaurant},
    {'name': 'directions_car', 'icon': Icons.directions_car},
    {'name': 'shopping_bag', 'icon': Icons.shopping_bag},
    {'name': 'movie', 'icon': Icons.movie},
    {'name': 'bolt', 'icon': Icons.bolt},
    {'name': 'local_hospital', 'icon': Icons.local_hospital},
    {'name': 'work', 'icon': Icons.work},
    {'name': 'computer', 'icon': Icons.computer},
    {'name': 'trending_up', 'icon': Icons.trending_up},
    {'name': 'category', 'icon': Icons.category},
  ];

  final List<Map<String, dynamic>> _availableColors = [
    {'name': 'Blue', 'color': 0xFF2563EB},
    {'name': 'Green', 'color': 0xFF10B981},
    {'name': 'Red', 'color': 0xFFEF4444},
    {'name': 'Yellow', 'color': 0xFFF59E0B},
    {'name': 'Purple', 'color': 0xFF8B5CF6},
    {'name': 'Pink', 'color': 0xFFEC4899},
    {'name': 'Orange', 'color': 0xFFF97316},
    {'name': 'Cyan', 'color': 0xFF06B6D4},
    {'name': 'Gray', 'color': 0xFF64748B},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Category'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Name field
              TextFormField(
                controller: _nameController,
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
              const SizedBox(height: 16),

              // Type selection
              DropdownButtonFormField<TransactionType>(
                initialValue: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type',
                ),
                items: TransactionType.values.map((type) {
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

              // Icon selection
              Text('Icon', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableIcons.map((iconData) {
                  final isSelected = _selectedIcon == iconData['name'];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIcon = iconData['name'] as String;
                      });
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.surface,
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        iconData['icon'] as IconData,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Color selection
              Text('Color', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableColors.map((colorData) {
                  final isSelected = _selectedColor == colorData['color'];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedColor = colorData['color'] as int;
                      });
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(colorData['color'] as int),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  );
                }).toList(),
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
        FilledButton(
          onPressed: _addCategory,
          child: const Text('Add'),
        ),
      ],
    );
  }

  void _addCategory() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Note: In a real app, this would call a use case to add the category
    // For now, we'll just show a message since categories are static
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Category addition not implemented yet')),
    );
  }
}

/// Dialog for editing an existing category
class EditCategoryDialog extends StatefulWidget {
  const EditCategoryDialog({
    super.key,
    required this.category,
  });

  final TransactionCategory category;

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  late final TextEditingController _nameController;
  late TransactionType _selectedType;
  late String _selectedIcon;
  late int _selectedColor;

  final List<Map<String, dynamic>> _availableIcons = [
    {'name': 'restaurant', 'icon': Icons.restaurant},
    {'name': 'directions_car', 'icon': Icons.directions_car},
    {'name': 'shopping_bag', 'icon': Icons.shopping_bag},
    {'name': 'movie', 'icon': Icons.movie},
    {'name': 'bolt', 'icon': Icons.bolt},
    {'name': 'local_hospital', 'icon': Icons.local_hospital},
    {'name': 'work', 'icon': Icons.work},
    {'name': 'computer', 'icon': Icons.computer},
    {'name': 'trending_up', 'icon': Icons.trending_up},
    {'name': 'category', 'icon': Icons.category},
  ];

  final List<Map<String, dynamic>> _availableColors = [
    {'name': 'Blue', 'color': 0xFF2563EB},
    {'name': 'Green', 'color': 0xFF10B981},
    {'name': 'Red', 'color': 0xFFEF4444},
    {'name': 'Yellow', 'color': 0xFFF59E0B},
    {'name': 'Purple', 'color': 0xFF8B5CF6},
    {'name': 'Pink', 'color': 0xFFEC4899},
    {'name': 'Orange', 'color': 0xFFF97316},
    {'name': 'Cyan', 'color': 0xFF06B6D4},
    {'name': 'Gray', 'color': 0xFF64748B},
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category.name);
    _selectedType = widget.category.type;
    _selectedIcon = widget.category.icon;
    _selectedColor = widget.category.color;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Category'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Name field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                hintText: 'e.g., Food & Dining',
              ),
            ),
            const SizedBox(height: 16),

            // Type selection
            DropdownButtonFormField<TransactionType>(
              initialValue: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Type',
              ),
              items: TransactionType.values.map((type) {
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

            // Icon selection
            Text('Icon', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableIcons.map((iconData) {
                final isSelected = _selectedIcon == iconData['name'];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIcon = iconData['name'] as String;
                    });
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.surface,
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      iconData['icon'] as IconData,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Color selection
            Text('Color', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableColors.map((colorData) {
                final isSelected = _selectedColor == colorData['color'];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedColor = colorData['color'] as int;
                    });
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(colorData['color'] as int),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _updateCategory,
          child: const Text('Update'),
        ),
      ],
    );
  }

  void _updateCategory() {
    // Note: In a real app, this would call a use case to update the category
    // For now, we'll just show a message since categories are static
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Category update not implemented yet')),
    );
  }
}