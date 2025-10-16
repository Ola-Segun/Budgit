import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';

import '../lib/core/di/providers.dart' as di;
import '../lib/core/navigation/main_navigation_scaffold.dart';
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
    mockBillNotifier = MockBillNotifier();
    mockRecurringIncomeNotifier = MockRecurringIncomeNotifier();
    mockTransactionNotifier = MockTransactionNotifier();
  });

  group('Navigation Flows Integration Tests', () {
    testWidgets('Complete navigation flow through all main screens', (tester) async {
      // Setup mock data
      final bills = [
        Bill(
          id: 'bill1',
          name: 'Electricity',
          amount: 150.0,
          dueDate: DateTime.now().add(const Duration(days: 5)),
          frequency: BillFrequency.monthly,
          categoryId: 'utilities',
          defaultAccountId: 'account1',
        ),
      ];

      final incomes = [
        RecurringIncome(
          id: 'income1',
          name: 'Salary',
          amount: 3000.0,
          startDate: DateTime.now().subtract(const Duration(days: 30)),
          frequency: RecurringIncomeFrequency.monthly,
          categoryId: 'salary',
          defaultAccountId: 'account1',
        ),
      ];

      final transactions = [
        Transaction(
          id: 'tx1',
          title: 'Grocery Shopping',
          amount: 85.50,
          type: TransactionType.expense,
          categoryId: 'food',
          accountId: 'account1',
          date: DateTime.now(),
        ),
      ];

      // Setup mock states
      when(mockBillNotifier.state).thenReturn(
        BillState.loaded(
          bills: bills,
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
          incomes: incomes,
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
        AsyncData(TransactionState(transactions: transactions, hasMoreData: false)),
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

      // Verify we're on the home dashboard
      expect(find.text('Dashboard'), findsOneWidget);

      // Navigate to Transactions
      await tester.tap(find.byIcon(Icons.receipt_long));
      await tester.pumpAndSettle();

      expect(find.text('Transactions'), findsOneWidget);

      // Navigate back to Dashboard
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      expect(find.text('Dashboard'), findsOneWidget);

      // Navigate to More menu
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();

      expect(find.text('More'), findsOneWidget);

      // Navigate to Bills
      await tester.tap(find.text('Bills'));
      await tester.pumpAndSettle();

      expect(find.text('Bills'), findsOneWidget);

      // Navigate to Incomes
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Incomes'));
      await tester.pumpAndSettle();

      expect(find.text('Recurring Incomes'), findsOneWidget);
    });

    testWidgets('Bill payment flow with plus button navigation', (tester) async {
      // Setup mock data
      final bills = [
        Bill(
          id: 'bill1',
          name: 'Electricity',
          amount: 150.0,
          dueDate: DateTime.now().add(const Duration(days: 5)),
          frequency: BillFrequency.monthly,
          categoryId: 'utilities',
          defaultAccountId: 'account1',
        ),
      ];

      when(mockBillNotifier.state).thenReturn(
        BillState.loaded(
          bills: bills,
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

      // Navigate to Bills
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Bills'));
      await tester.pumpAndSettle();

      // Find and tap the plus button on a bill item
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pumpAndSettle();

      // Verify we're in payment recording flow
      expect(find.text('Record Payment'), findsOneWidget);
    });

    testWidgets('Income receipt recording flow with plus button navigation', (tester) async {
      // Setup mock data
      final incomes = [
        RecurringIncome(
          id: 'income1',
          name: 'Salary',
          amount: 3000.0,
          startDate: DateTime.now().subtract(const Duration(days: 30)),
          frequency: RecurringIncomeFrequency.monthly,
          categoryId: 'salary',
          defaultAccountId: 'account1',
        ),
      ];

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
        RecurringIncomeState.loaded(
          incomes: incomes,
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

      // Navigate to Incomes
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Incomes'));
      await tester.pumpAndSettle();

      // Find and tap the plus button on an income item
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pumpAndSettle();

      // Verify we're in receipt recording flow
      expect(find.text('Record Income Receipt'), findsOneWidget);
    });
  });
}