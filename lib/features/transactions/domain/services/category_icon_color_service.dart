import 'package:flutter/material.dart';

import '../../presentation/notifiers/category_notifier.dart';

/// Service for providing centralized access to category icons and colors
/// Uses CategoryNotifier to access dynamic category data instead of hardcoded mappings
class CategoryIconColorService {
  final CategoryNotifier _categoryNotifier;

  CategoryIconColorService(this._categoryNotifier);

  /// Get the icon for a given category ID
  IconData getIconForCategory(String categoryId) {
    final category = _categoryNotifier.getCategoryById(categoryId);
    if (category != null) {
      return _getIconFromString(category.icon);
    }
    return _getFallbackIcon();
  }

  /// Get the color for a given category ID
  Color getColorForCategory(String categoryId) {
    final category = _categoryNotifier.getCategoryById(categoryId);
    if (category != null) {
      return Color(category.color);
    }
    return _getFallbackColor();
  }

  /// Get both icon and color for a given category ID
  ({IconData icon, Color color}) getIconAndColorForCategory(String categoryId) {
    final category = _categoryNotifier.getCategoryById(categoryId);
    if (category != null) {
      return (
        icon: _getIconFromString(category.icon),
        color: Color(category.color)
      );
    }
    return (
      icon: _getFallbackIcon(),
      color: _getFallbackColor()
    );
  }

  /// Convert icon string to IconData
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
      case 'category':
        return Icons.category;
      default:
        return _getFallbackIcon();
    }
  }

  /// Get fallback icon for unknown categories
  IconData _getFallbackIcon() => Icons.category;

  /// Get fallback color for unknown categories
  Color _getFallbackColor() => const Color(0xFF64748B);
}