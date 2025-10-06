import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

/// Transaction entity - represents a financial transaction
/// Pure domain entity with no dependencies
@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String title,
    required double amount,
    required TransactionType type,
    required DateTime date,
    required String categoryId,
    required String accountId,
    String? description,
    String? receiptUrl,
    @Default([]) List<String> tags,
    @Default('USD') String currencyCode, // Currency code (USD, EUR, etc.)
  }) = _Transaction;

  const Transaction._();

  /// Check if transaction is income
  bool get isIncome => type == TransactionType.income;

  /// Check if transaction is expense
  bool get isExpense => type == TransactionType.expense;

  /// Get formatted amount with sign
  String get signedAmount => isIncome ? '+\$${amount.toStringAsFixed(2)}' : '-\$${amount.toStringAsFixed(2)}';

  /// Get absolute amount
  double get absoluteAmount => amount.abs();
}

/// Transaction type enum
enum TransactionType {
  income,
  expense;

  String get displayName {
    switch (this) {
      case TransactionType.income:
        return 'Income';
      case TransactionType.expense:
        return 'Expense';
    }
  }

  bool get isIncome => this == TransactionType.income;
  bool get isExpense => this == TransactionType.expense;
}

/// Transaction category entity
@freezed
class TransactionCategory with _$TransactionCategory {
  const factory TransactionCategory({
    required String id,
    required String name,
    required String icon,
    required int color,
    required TransactionType type,
  }) = _TransactionCategory;

  const TransactionCategory._();

  /// Create default categories
  static List<TransactionCategory> get defaultCategories => [
    // Income categories
    const TransactionCategory(
      id: 'salary',
      name: 'Salary',
      icon: 'work',
      color: 0xFF10B981, // Green
      type: TransactionType.income,
    ),
    const TransactionCategory(
      id: 'freelance',
      name: 'Freelance',
      icon: 'computer',
      color: 0xFF3B82F6, // Blue
      type: TransactionType.income,
    ),
    const TransactionCategory(
      id: 'investment',
      name: 'Investment',
      icon: 'trending_up',
      color: 0xFF8B5CF6, // Purple
      type: TransactionType.income,
    ),

    // Expense categories
    const TransactionCategory(
      id: 'food',
      name: 'Food & Dining',
      icon: 'restaurant',
      color: 0xFFF59E0B, // Yellow
      type: TransactionType.expense,
    ),
    const TransactionCategory(
      id: 'transport',
      name: 'Transportation',
      icon: 'directions_car',
      color: 0xFFEF4444, // Red
      type: TransactionType.expense,
    ),
    const TransactionCategory(
      id: 'shopping',
      name: 'Shopping',
      icon: 'shopping_bag',
      color: 0xFFEC4899, // Pink
      type: TransactionType.expense,
    ),
    const TransactionCategory(
      id: 'entertainment',
      name: 'Entertainment',
      icon: 'movie',
      color: 0xFFF97316, // Orange
      type: TransactionType.expense,
    ),
    const TransactionCategory(
      id: 'utilities',
      name: 'Utilities',
      icon: 'bolt',
      color: 0xFF06B6D4, // Cyan
      type: TransactionType.expense,
    ),
    const TransactionCategory(
      id: 'healthcare',
      name: 'Healthcare',
      icon: 'local_hospital',
      color: 0xFFDC2626, // Dark red
      type: TransactionType.expense,
    ),
    const TransactionCategory(
      id: 'other',
      name: 'Other',
      icon: 'category',
      color: 0xFF64748B, // Gray
      type: TransactionType.expense,
    ),
  ];
}