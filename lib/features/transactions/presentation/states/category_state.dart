import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/transaction.dart';

part 'category_state.freezed.dart';

/// State for category management
@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default([]) List<TransactionCategory> categories,
    @Default(false) bool isOperationInProgress,
    String? operationError,
  }) = _CategoryState;

  const CategoryState._();

  /// Get categories by type
  List<TransactionCategory> getCategoriesByType(TransactionType type) {
    return categories.where((category) => category.type == type).toList();
  }

  /// Get income categories
  List<TransactionCategory> get incomeCategories => getCategoriesByType(TransactionType.income);

  /// Get expense categories
  List<TransactionCategory> get expenseCategories => getCategoriesByType(TransactionType.expense);

  /// Get transfer categories (if any)
  List<TransactionCategory> get transferCategories => getCategoriesByType(TransactionType.transfer);

  /// Find category by ID
  TransactionCategory? getCategoryById(String id) {
    return categories.where((category) => category.id == id).firstOrNull;
  }

  /// Check if category exists
  bool hasCategory(String id) {
    return categories.any((category) => category.id == id);
  }
}