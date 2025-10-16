import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_setup.dart';
import '../../../../../lib/features/budgets/domain/entities/budget.dart';
import '../../../../../lib/features/budgets/domain/entities/budget_template.dart';
import '../../../../../lib/features/budgets/presentation/providers/budget_providers.dart';
import '../../../../../lib/features/budgets/presentation/screens/budget_creation_screen.dart';
import '../../../../../lib/features/budgets/presentation/notifiers/budget_notifier.dart';
import '../../../../../lib/features/transactions/domain/entities/transaction.dart';
import '../../../../../lib/features/transactions/presentation/notifiers/category_notifier.dart';
import '../../../../../lib/features/transactions/presentation/providers/transaction_providers.dart';
import '../../../../../lib/features/transactions/presentation/states/category_state.dart';

class MockBudgetNotifier extends Mock implements BudgetNotifier {}

class MockCategoryNotifier extends Mock implements CategoryNotifier {}

void main() {
  late MockBudgetNotifier mockBudgetNotifier;
  late MockCategoryNotifier mockCategoryNotifier;

  setUp(() {
    mockBudgetNotifier = MockBudgetNotifier();
    mockCategoryNotifier = MockCategoryNotifier();
    setupMockitoDummies();
  });

  group('Budget Creation Workflow Integration Tests', () {
    testWidgets('Complete budget creation workflow with template selection',
        (tester) async {
      // Setup mock data
      final expenseCategories = [
        TransactionCategory(id: 'food', name: 'Food', color: 0xFF10B981, icon: 'restaurant', type: TransactionType.expense),
        TransactionCategory(id: 'transport', name: 'Transport', color: 0xFF3B82F6, icon: 'car', type: TransactionType.expense),
        TransactionCategory(id: 'entertainment', name: 'Entertainment', color: 0xFFF59E0B, icon: 'movie', type: TransactionType.expense),
      ];

      when(mockCategoryNotifier.state).thenReturn(
        AsyncData(CategoryState(expenseCategories: expenseCategories)),
      );

      // Mock successful budget creation
      when(mockBudgetNotifier.createBudget(any)).thenAnswer((_) async => true);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetNotifierProvider.overrideWith(() => mockBudgetNotifier),
            categoryNotifierProvider.overrideWith(() => mockCategoryNotifier),
          ],
          child: const MaterialApp(
            home: BudgetCreationScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Step 1: Select 50/30/20 template
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('50/30/20 Rule').last);
      await tester.pumpAndSettle();

      // Verify template loaded with correct name
      expect(find.text('50/30/20 Rule Budget'), findsOneWidget);

      // Step 2: Verify categories are mapped correctly
      expect(find.text('Food'), findsWidgets); // Should find in dropdowns

      // Step 3: Modify amounts
      final amountFields = find.byType(TextFormField).where((widget) {
        final textField = widget as TextFormField;
        return textField.decoration?.prefixText == '\$';
      });

      // Update first category amount
      await tester.enterText(amountFields.first, '600.00');
      await tester.pump(const Duration(milliseconds: 150));

      // Verify total updates
      expect(find.text('Total Budget: \$600.00'), findsOneWidget);

      // Step 4: Submit budget
      await tester.tap(find.text('Create Budget'));
      await tester.pump();

      // Verify budget creation was called
      verify(mockBudgetNotifier.createBudget(any)).called(1);
    });

    testWidgets('Template loading with unmapped categories shows warning',
        (tester) async {
      // Setup with limited categories
      final expenseCategories = [
        TransactionCategory(id: 'food', name: 'Food', color: 0xFF10B981),
      ];

      when(mockCategoryNotifier.state).thenReturn(
        AsyncData(CategoryState(expenseCategories: expenseCategories)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetNotifierProvider.overrideWith(() => mockBudgetNotifier),
            categoryNotifierProvider.overrideWith(() => mockCategoryNotifier),
          ],
          child: const MaterialApp(
            home: BudgetCreationScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Select template with unmapped categories
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('50/30/20 Rule').last);
      await tester.pumpAndSettle();

      // Verify warning snackbar appears
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.textContaining('could not be mapped'), findsOneWidget);
    });

    testWidgets('Dynamic category management workflow', (tester) async {
      final expenseCategories = [
        TransactionCategory(id: 'food', name: 'Food', color: 0xFF10B981, icon: 'restaurant', type: TransactionType.expense),
        TransactionCategory(id: 'transport', name: 'Transport', color: 0xFF3B82F6, icon: 'car', type: TransactionType.expense),
        TransactionCategory(id: 'utilities', name: 'Utilities', color: 0xFF6B7280, icon: 'bolt', type: TransactionType.expense),
      ];

      when(mockCategoryNotifier.state).thenReturn(
        AsyncData(CategoryState(expenseCategories: expenseCategories)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetNotifierProvider.overrideWith(() => mockBudgetNotifier),
            categoryNotifierProvider.overrideWith(() => mockCategoryNotifier),
          ],
          child: const MaterialApp(
            home: BudgetCreationScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Initially should have 1 category
      expect(find.text('Category'), findsOneWidget);

      // Add multiple categories
      await tester.tap(find.text('Add Category'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add Category'));
      await tester.pumpAndSettle();

      expect(find.text('Category'), findsNWidgets(3));

      // Select different categories for each
      final categoryDropdowns = find.byType(DropdownButtonFormField<String>).where((widget) {
        // Find dropdowns that are for category selection (not template)
        return true; // Simplified for test
      });

      // Remove middle category
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle();

      expect(find.text('Category'), findsNWidgets(2));

      // Enter amounts and verify total calculation
      final amountFields = find.byType(TextFormField).where((widget) {
        final textField = widget as TextFormField;
        return textField.decoration?.prefixText == '\$';
      });

      await tester.enterText(amountFields.first, '200.00');
      await tester.enterText(amountFields.last, '300.00');
      await tester.pump(const Duration(milliseconds: 150));

      expect(find.text('Total Budget: \$500.00'), findsOneWidget);
    });

    testWidgets('Form validation workflow with error recovery', (tester) async {
      final expenseCategories = [
        TransactionCategory(id: 'food', name: 'Food', color: 0xFF10B981),
      ];

      when(mockCategoryNotifier.state).thenReturn(
        AsyncData(CategoryState(expenseCategories: expenseCategories)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetNotifierProvider.overrideWith(() => mockBudgetNotifier),
            categoryNotifierProvider.overrideWith(() => mockCategoryNotifier),
          ],
          child: const MaterialApp(
            home: BudgetCreationScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Try to submit without name
      await tester.tap(find.text('Create Budget'));
      await tester.pump();

      expect(find.text('Please enter a budget name'), findsOneWidget);

      // Enter name but no amount
      await tester.enterText(find.byType(TextFormField).first, 'Test Budget');
      await tester.tap(find.text('Create Budget'));
      await tester.pump();

      expect(find.text('Total budget must be greater than zero'), findsOneWidget);

      // Enter valid amount
      await tester.enterText(find.byType(TextFormField).last, '100.00');
      await tester.pump(const Duration(milliseconds: 150));

      // Submit successfully
      when(mockBudgetNotifier.createBudget(any)).thenAnswer((_) async => true);
      await tester.tap(find.text('Create Budget'));
      await tester.pump();

      verify(mockBudgetNotifier.createBudget(any)).called(1);
    });

    testWidgets('Performance test with large number of categories', (tester) async {
      // Create many categories
      final expenseCategories = List.generate(50, (index) =>
        TransactionCategory(
          id: 'category_$index',
          name: 'Category $index',
          color: 0xFF10B981 + index,
          icon: 'category',
          type: TransactionType.expense,
        ),
      );

      when(mockCategoryNotifier.state).thenReturn(
        AsyncData(CategoryState(expenseCategories: expenseCategories)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetNotifierProvider.overrideWith(() => mockBudgetNotifier),
            categoryNotifierProvider.overrideWith(() => mockCategoryNotifier),
          ],
          child: const MaterialApp(
            home: BudgetCreationScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Add multiple categories
      for (int i = 0; i < 10; i++) {
        await tester.tap(find.text('Add Category'));
        await tester.pumpAndSettle();
      }

      // Enter amounts for all categories
      final amountFields = find.byType(TextFormField).where((widget) {
        final textField = widget as TextFormField;
        return textField.decoration?.prefixText == '\$';
      });

      int fieldIndex = 0;
      await for (final field in Stream.fromIterable(amountFields.take(10))) {
        await tester.enterText(field, '${(fieldIndex + 1) * 10}.00');
        fieldIndex++;
        await tester.pump(const Duration(milliseconds: 50)); // Reduced debounce for performance
      }

      await tester.pump(const Duration(milliseconds: 200));

      // Verify total calculation with many categories
      expect(find.text('Total Budget: \$550.00'), findsOneWidget); // 10 + 20 + ... + 100 = 550
    });

    testWidgets('Template switching workflow', (tester) async {
      final expenseCategories = [
        TransactionCategory(id: 'needs', name: 'Needs (50%)', color: 0xFF10B981, icon: 'home', type: TransactionType.expense),
        TransactionCategory(id: 'wants', name: 'Wants (30%)', color: 0xFFF59E0B, icon: 'shopping', type: TransactionType.expense),
        TransactionCategory(id: 'savings', name: 'Savings & Debt (20%)', color: 0xFF3B82F6, icon: 'savings', type: TransactionType.expense),
        TransactionCategory(id: 'housing', name: 'Housing', color: 0xFF10B981, icon: 'home', type: TransactionType.expense),
        TransactionCategory(id: 'groceries', name: 'Groceries', color: 0xFF10B981, icon: 'shopping_cart', type: TransactionType.expense),
      ];

      when(mockCategoryNotifier.state).thenReturn(
        AsyncData(CategoryState(expenseCategories: expenseCategories)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetNotifierProvider.overrideWith(() => mockBudgetNotifier),
            categoryNotifierProvider.overrideWith(() => mockCategoryNotifier),
          ],
          child: const MaterialApp(
            home: BudgetCreationScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Start with 50/30/20 template
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('50/30/20 Rule').last);
      await tester.pumpAndSettle();

      expect(find.text('50/30/20 Rule Budget'), findsOneWidget);
      expect(find.text('Total Budget: \$1,000.00'), findsOneWidget);

      // Switch to Zero-Based template
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Zero-Based Budget').last);
      await tester.pumpAndSettle();

      expect(find.text('Zero-Based Budget Budget'), findsOneWidget);
      expect(find.text('Total Budget: \$3,000.00'), findsOneWidget);

      // Switch back to custom
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('None (Custom)').last);
      await tester.pumpAndSettle();

      expect(find.text('Total Budget: \$0.00'), findsOneWidget);
    });

    testWidgets('Error handling workflow during budget creation', (tester) async {
      final expenseCategories = [
        TransactionCategory(id: 'food', name: 'Food', color: 0xFF10B981),
      ];

      when(mockCategoryNotifier.state).thenReturn(
        AsyncData(CategoryState(expenseCategories: expenseCategories)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetNotifierProvider.overrideWith(() => mockBudgetNotifier),
            categoryNotifierProvider.overrideWith(() => mockCategoryNotifier),
          ],
          child: const MaterialApp(
            home: BudgetCreationScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Setup for failure
      when(mockBudgetNotifier.createBudget(any)).thenAnswer((_) async => false);

      // Fill form
      await tester.enterText(find.byType(TextFormField).first, 'Test Budget');
      await tester.enterText(find.byType(TextFormField).last, '500.00');
      await tester.tap(find.text('Create Budget'));
      await tester.pump();

      // Verify error message
      expect(find.text('Failed to create budget'), findsOneWidget);

      // Try again with success
      when(mockBudgetNotifier.createBudget(any)).thenAnswer((_) async => true);
      await tester.tap(find.text('Create Budget'));
      await tester.pump();

      verify(mockBudgetNotifier.createBudget(any)).called(2);
    });
  });
}