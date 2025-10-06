import 'package:flutter_test/flutter_test.dart';

import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';

void main() {
  group('Transaction Entity', () {
    final testDate = DateTime(2025, 10, 2, 14, 30);
    final testTransaction = Transaction(
      id: 'test-id',
      title: 'Test Transaction',
      amount: 50.0,
      type: TransactionType.expense,
      date: testDate,
      categoryId: 'food',
      accountId: 'account1',
      description: 'Test description',
      receiptUrl: 'receipt.jpg',
      tags: ['tag1', 'tag2'],
    );

    test('should create transaction with all fields', () {
      expect(testTransaction.id, 'test-id');
      expect(testTransaction.title, 'Test Transaction');
      expect(testTransaction.amount, 50.0);
      expect(testTransaction.type, TransactionType.expense);
      expect(testTransaction.date, testDate);
      expect(testTransaction.categoryId, 'food');
      expect(testTransaction.description, 'Test description');
      expect(testTransaction.receiptUrl, 'receipt.jpg');
      expect(testTransaction.tags, ['tag1', 'tag2']);
    });

    test('should create transaction with minimal fields', () {
      final minimalTransaction = Transaction(
        id: 'minimal-id',
        title: 'Minimal Transaction',
        amount: 25.0,
        type: TransactionType.income,
        date: testDate,
        categoryId: 'salary',
        accountId: 'account2',
      );

      expect(minimalTransaction.id, 'minimal-id');
      expect(minimalTransaction.title, 'Minimal Transaction');
      expect(minimalTransaction.amount, 25.0);
      expect(minimalTransaction.type, TransactionType.income);
      expect(minimalTransaction.date, testDate);
      expect(minimalTransaction.categoryId, 'salary');
      expect(minimalTransaction.description, null);
      expect(minimalTransaction.receiptUrl, null);
      expect(minimalTransaction.tags, []);
    });

    test('isIncome should return true for income transactions', () {
      final incomeTransaction = testTransaction.copyWith(type: TransactionType.income);
      expect(incomeTransaction.isIncome, true);
      expect(incomeTransaction.isExpense, false);
    });

    test('isExpense should return true for expense transactions', () {
      expect(testTransaction.isIncome, false);
      expect(testTransaction.isExpense, true);
    });

    test('signedAmount should return positive for income', () {
      final incomeTransaction = testTransaction.copyWith(
        type: TransactionType.income,
        amount: 100.0,
      );
      expect(incomeTransaction.signedAmount, '+\$100.00');
    });

    test('signedAmount should return negative for expense', () {
      expect(testTransaction.signedAmount, '-\$50.00');
    });

    test('absoluteAmount should return positive amount', () {
      expect(testTransaction.absoluteAmount, 50.0);
      final negativeAmount = testTransaction.copyWith(amount: -25.0);
      expect(negativeAmount.absoluteAmount, 25.0);
    });

    test('copyWith should create new instance with updated fields', () {
      final updated = testTransaction.copyWith(
        title: 'Updated Title',
        amount: 75.0,
      );

      expect(updated.title, 'Updated Title');
      expect(updated.amount, 75.0);
      expect(updated.id, testTransaction.id); // unchanged
      expect(updated.type, testTransaction.type); // unchanged
    });

    test('should handle zero amount', () {
      final zeroTransaction = testTransaction.copyWith(amount: 0.0);
      expect(zeroTransaction.amount, 0.0);
      expect(zeroTransaction.signedAmount, '-\$0.00');
      expect(zeroTransaction.absoluteAmount, 0.0);
    });

    test('should handle large amounts', () {
      final largeTransaction = testTransaction.copyWith(amount: 999999.99);
      expect(largeTransaction.amount, 999999.99);
      expect(largeTransaction.signedAmount, '-\$999999.99');
    });

    test('should handle decimal amounts', () {
      final decimalTransaction = testTransaction.copyWith(amount: 12.345);
      expect(decimalTransaction.amount, 12.345);
      expect(decimalTransaction.signedAmount, '-\$12.35'); // rounded to 2 decimals
    });
  });

  group('TransactionType Enum', () {
    test('income should have correct display name', () {
      expect(TransactionType.income.displayName, 'Income');
      expect(TransactionType.income.isIncome, true);
      expect(TransactionType.income.isExpense, false);
    });

    test('expense should have correct display name', () {
      expect(TransactionType.expense.displayName, 'Expense');
      expect(TransactionType.expense.isIncome, false);
      expect(TransactionType.expense.isExpense, true);
    });
  });

  group('TransactionCategory Entity', () {
    final testCategory = TransactionCategory(
      id: 'food',
      name: 'Food & Dining',
      icon: 'restaurant',
      color: 0xFFF59E0B,
      type: TransactionType.expense,
    );

    test('should create category with all fields', () {
      expect(testCategory.id, 'food');
      expect(testCategory.name, 'Food & Dining');
      expect(testCategory.icon, 'restaurant');
      expect(testCategory.color, 0xFFF59E0B);
      expect(testCategory.type, TransactionType.expense);
    });

    test('copyWith should create new instance with updated fields', () {
      final updated = testCategory.copyWith(name: 'Updated Name');
      expect(updated.name, 'Updated Name');
      expect(updated.id, testCategory.id); // unchanged
    });

    test('defaultCategories should contain expected categories', () {
      final categories = TransactionCategory.defaultCategories;

      expect(categories.length, greaterThan(5));

      // Check for essential categories
      final foodCategory = categories.firstWhere((c) => c.id == 'food');
      expect(foodCategory.name, 'Food & Dining');
      expect(foodCategory.type, TransactionType.expense);

      final salaryCategory = categories.firstWhere((c) => c.id == 'salary');
      expect(salaryCategory.name, 'Salary');
      expect(salaryCategory.type, TransactionType.income);
    });
  });
}