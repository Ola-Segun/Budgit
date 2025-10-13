import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../test_setup.dart';
import '../../../../../features/budgets/domain/entities/budget.dart';
import '../../../../../features/budgets/presentation/providers/budget_providers.dart';
import '../../../../../features/budgets/presentation/screens/budget_edit_screen.dart';
import '../../../../../features/budgets/presentation/notifiers/budget_notifier.dart';
import '../../../../../features/transactions/domain/entities/transaction.dart';

class MockBudgetNotifier extends Mock implements BudgetNotifier {}

void main() {
  late MockBudgetNotifier mockBudgetNotifier;

  setUp(() {
    mockBudgetNotifier = MockBudgetNotifier();
  });

  group('BudgetEditScreen', () {
    testWidgets('renders correctly with valid budget', (tester) async {
      final budget = Budget(
        id: 'test-budget-id',
        name: 'Test Budget',
        type: BudgetType.custom,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        categories: [
          BudgetCategory(
            id: 'cat1',
            name: 'Food',
            amount: 500.0,
          ),
        ],
        isActive: true,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetNotifierProvider.overrideWith(() => mockBudgetNotifier),
          ],
          child: MaterialApp(
            home: BudgetEditScreen(budget: budget),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Edit Budget'), findsOneWidget);
      expect(find.text('Test Budget'), findsOneWidget);
    });

    testWidgets('shows error when no categories available', (tester) async {
      final budget = Budget(
        id: 'test-budget-id',
        name: 'Test Budget',
        type: BudgetType.custom,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        categories: [],
        isActive: true,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetNotifierProvider.overrideWith(() => mockBudgetNotifier),
          ],
          child: MaterialApp(
            home: BudgetEditScreen(budget: budget),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('No expense categories available'), findsOneWidget);
    });

    testWidgets('validates form fields correctly', (tester) async {
      final budget = Budget(
        id: 'test-budget-id',
        name: 'Test Budget',
        type: BudgetType.custom,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        categories: [
          BudgetCategory(
            id: 'cat1',
            name: 'Food',
            amount: 500.0,
          ),
        ],
        isActive: true,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetNotifierProvider.overrideWith(() => mockBudgetNotifier),
          ],
          child: MaterialApp(
            home: BudgetEditScreen(budget: budget),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Clear the name field and try to submit
      await tester.enterText(find.byType(TextFormField).first, '');
      await tester.tap(find.text('Update Budget'));
      await tester.pump();

      expect(find.text('Please enter a budget name'), findsOneWidget);
    });

    testWidgets('handles successful budget update', (tester) async {
      final budget = Budget(
        id: 'test-budget-id',
        name: 'Test Budget',
        type: BudgetType.custom,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        categories: [
          BudgetCategory(
            id: 'cat1',
            name: 'Food',
            amount: 500.0,
          ),
        ],
        isActive: true,
      );

      when(mockBudgetNotifier.updateBudget(any)).thenAnswer((_) async => true);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            budgetNotifierProvider.overrideWith(() => mockBudgetNotifier),
          ],
          child: MaterialApp(
            home: BudgetEditScreen(budget: budget),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Fill in required fields and submit
      await tester.enterText(find.byType(TextFormField).first, 'Updated Budget');
      await tester.tap(find.text('Update Budget'));
      await tester.pump();

      verify(mockBudgetNotifier.updateBudget(any)).called(1);
    });
  });
}