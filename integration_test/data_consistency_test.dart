import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';

import '../lib/core/di/providers.dart' as di;
import '../lib/features/bills/domain/entities/bill.dart';
import '../lib/features/bills/presentation/notifiers/bill_notifier.dart';
import '../lib/features/bills/presentation/providers/bill_providers.dart';
import '../lib/features/bills/presentation/states/bill_state.dart';
import '../lib/features/recurring_incomes/domain/entities/recurring_income.dart';
import '../lib/features/recurring_incomes/presentation/notifiers/recurring_income_notifier.dart';
import '../lib/features/recurring_incomes/presentation/providers/recurring_income_providers.dart' as income_providers;
import '../lib/features/recurring_incomes/presentation/states/recurring_income_state.dart';
import '../lib/features/transactions/domain/entities/transaction.dart';
import '../lib/features/transactions/presentation/notifiers/transaction_notifier.dart';
import '../lib/features/transactions/presentation/providers/transaction_providers.dart';
import '../lib/features/transactions/presentation/states/transaction_state.dart';
import '../lib/main.dart';

class MockBillNotifier extends Mock implements BillNotifier {}

class MockRecurringIncomeNotifier extends Mock implements RecurringIncomeNotifier {}

class MockTransactionNotifier extends Mock implements TransactionNotifier {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockBillNotifier mockBillNotifier;
  late MockRecurringIncomeNotifier mockRecurringIncomeNotifier;
  late MockTransactionNotifier mockTransactionNotifier;

  setUp(() {
    mockBillNotifier = MockBillNotifier();i
    mockRecurringIncomeNotifier = MockRecurringIncomeNotifier();
    mockTransactionNotifier = MockTransactionNotifier();
  });

  group('Data Consistency Integration Tests', () {
    testWidgets('Bills appear immediately on dashboard without refresh', (tester) async {
      // Start with empty bills
      when(mockBillNotifier.state).thenReturn(
        const BillState.loaded(
          bills: [],
          summary: BillsSummary(
            totalBills: 0,
            paidThisMonth: 0,
            dueThisMonth: 0,
            overdue: 0,
            totalMonthlyAmount: 0.0,
            paidAmount: 0.0,
            remainingAmount: 0.0,
            upcomingBills: [],
          ),
        ),
      );

      when(mockRecurringIncomeNotifier.state).thenReturn(
        const RecurringIncomeState.loaded(
          incomes: [],
          summary: RecurringIncomesSummary(
            totalIncomes: 0,
            activeIncomes: 0,
            expectedThisMonth: 0,
            totalMonthlyAmount: 0.0,
            receivedThisMonth: 0.0,
            expectedAmount: 0.0,
            upcomingIncomes: [],
          ),
        ),
      );

      when(mockTransactionNotifier.state).thenReturn(
        const AsyncData(TransactionState(transactions: [], hasMoreData: false)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            billNotifierProvider.overrideWith((ref) => mockBillNotifier),
            income_providers.recurringIncomeNotifierProvider.overrideWith((ref) => mockRecurringIncomeNotifier),
            transactionNotifierProvider.overrideWith((ref) => mockTransactionNotifier),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify dashboard shows no bills initially
      expect(find.text('Bills'), findsWidgets); // Should find the navigation tab
      expect(find.text('\$0.00'), findsWidgets); // Should show zero amounts

      // Simulate adding a bill by updating the mock state
      final newBill = Bill(
        id: 'new-bill',
        name: 'New Electricity Bill',
        amount: 200.0,
        dueDate: DateTime.now().add(const Duration(days: 7)),
        frequency: BillFrequency.monthly,
        categoryId: 'utilities',
        defaultAccountId: 'account1',
      );

      when(mockBillNotifier.state).thenReturn(
        BillState.loaded(
          bills: [newBill],
          summary: BillsSummary(
            totalBills: 1,
            paidThisMonth: 0,
            dueThisMonth: 1,
            overdue: 0,
            totalMonthlyAmount: 200.0,
            paidAmount: 0.0,
            remainingAmount: 200.0,
            upcomingBills: [],
          ),
        ),
      );

      // Trigger a rebuild by updating the state
      await tester.pump();

      // Verify the bill appears immediately without manual refresh
      expect(find.text('New Electricity Bill'), findsOneWidget);
      expect(find.text('\$200.00'), findsOneWidget);
    });

    testWidgets('Incomes appear immediately on dashboard without refresh', (tester) async {
      // Start with empty incomes
      when(mockBillNotifier.state).thenReturn(
        const BillState.loaded(
          bills: [],
          summary: BillsSummary(
            totalBills: 0,
            paidThisMonth: 0,
            dueThisMonth: 0,
            overdue: 0,
            totalMonthlyAmount: 0.0,
            paidAmount: 0.0,
            remainingAmount: 0.0,
            upcomingBills: [],
          ),
        ),
      );

      when(mockRecurringIncomeNotifier.state).thenReturn(
        const RecurringIncomeState.loaded(
          incomes: [],
          summary: RecurringIncomesSummary(
            totalIncomes: 0,
            activeIncomes: 0,
            expectedThisMonth: 0,
            totalMonthlyAmount: 0.0,
            receivedThisMonth: 0.0,
            expectedAmount: 0.0,
            upcomingIncomes: [],
          ),
        ),
      );

      when(mockTransactionNotifier.state).thenReturn(
        const AsyncData(TransactionState(transactions: [], hasMoreData: false)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            billNotifierProvider.overrideWith((ref) => mockBillNotifier),
            income_providers.recurringIncomeNotifierProvider.overrideWith((ref) => mockRecurringIncomeNotifier),
            transactionNotifierProvider.overrideWith((ref) => mockTransactionNotifier),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify dashboard shows no incomes initially
      expect(find.text('Income'), findsWidgets);
      expect(find.text('\$0.00'), findsWidgets);

      // Simulate adding an income by updating the mock state
      final newIncome = RecurringIncome(
        id: 'new-income',
        name: 'New Salary',
        amount: 5000.0,
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        frequency: RecurringIncomeFrequency.monthly,
        categoryId: 'salary',
        defaultAccountId: 'account1',
      );

      when(mockRecurringIncomeNotifier.state).thenReturn(
        RecurringIncomeState.loaded(
          incomes: [newIncome],
          summary: RecurringIncomesSummary(
            totalIncomes: 1,
            activeIncomes: 1,
            expectedThisMonth: 1,
            totalMonthlyAmount: 5000.0,
            receivedThisMonth: 0.0,
            expectedAmount: 5000.0,
            upcomingIncomes: [],
          ),
        ),
      );

      // Trigger a rebuild by updating the state
      await tester.pump();

      // Verify the income appears immediately without manual refresh
      expect(find.text('New Salary'), findsOneWidget);
      expect(find.text('\$5,000.00'), findsOneWidget);
    });

    testWidgets('Data consistency across all screens', (tester) async {
      // Setup consistent test data
      final testBill = Bill(
        id: 'test-bill',
        name: 'Test Bill',
        amount: 150.0,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        frequency: BillFrequency.monthly,
        categoryId: 'utilities',
        defaultAccountId: 'account1',
      );

      final testIncome = RecurringIncome(
        id: 'test-income',
        name: 'Test Income',
        amount: 3000.0,
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        frequency: RecurringIncomeFrequency.monthly,
        categoryId: 'salary',
        defaultAccountId: 'account1',
      );

      final testTransaction = Transaction(
        id: 'test-tx',
        title: 'Test Transaction',
        amount: 100.0,
        type: TransactionType.expense,
        categoryId: 'food',
        accountId: 'account1',
        date: DateTime.now(),
      );

      // Setup mock states with consistent data
      when(mockBillNotifier.state).thenReturn(
        BillState.loaded(
          bills: [testBill],
          summary: BillsSummary(
            totalBills: 1,
            paidThisMonth: 0,
            dueThisMonth: 1,
            overdue: 0,
            totalMonthlyAmount: 150.0,
            paidAmount: 0.0,
            remainingAmount: 150.0,
            upcomingBills: [],
          ),
        ),
      );

      when(mockRecurringIncomeNotifier.state).thenReturn(
        RecurringIncomeState.loaded(
          incomes: [testIncome],
          summary: RecurringIncomesSummary(
            totalIncomes: 1,
            activeIncomes: 1,
            expectedThisMonth: 1,
            totalMonthlyAmount: 3000.0,
            receivedThisMonth: 0.0,
            expectedAmount: 3000.0,
            upcomingIncomes: [],
          ),
        ),
      );

      when(mockTransactionNotifier.state).thenReturn(
        AsyncData(TransactionState(transactions: [testTransaction], hasMoreData: false)),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            billNotifierProvider.overrideWith((ref) => mockBillNotifier),
            income_providers.recurringIncomeNotifierProvider.overrideWith((ref) => mockRecurringIncomeNotifier),
            transactionNotifierProvider.overrideWith((ref) => mockTransactionNotifier),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify data consistency on dashboard
      expect(find.text('Test Bill'), findsOneWidget);
      expect(find.text('Test Income'), findsOneWidget);
      expect(find.text('Test Transaction'), findsOneWidget);

      // Navigate to Bills screen
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Bills'));
      await tester.pumpAndSettle();

      // Verify same bill data on Bills screen
      expect(find.text('Test Bill'), findsOneWidget);
      expect(find.text('\$150.00'), findsOneWidget);

      // Navigate to Incomes screen
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Incomes'));
      await tester.pumpAndSettle();

      // Verify same income data on Incomes screen
      expect(find.text('Test Income'), findsOneWidget);
      expect(find.text('\$3,000.00'), findsOneWidget);

      // Navigate to Transactions screen
      await tester.tap(find.byIcon(Icons.receipt_long));
      await tester.pumpAndSettle();

      // Verify same transaction data on Transactions screen
      expect(find.text('Test Transaction'), findsOneWidget);
      expect(find.text('\$100.00'), findsOneWidget);
    });
  });
}