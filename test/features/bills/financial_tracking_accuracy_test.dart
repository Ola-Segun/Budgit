import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/bills/domain/entities/bill.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';

@GenerateMocks([AccountRepository])
import 'financial_tracking_accuracy_test.mocks.dart';

void main() {
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
  });

  group('Financial Tracking Accuracy Tests', () {
    const accountId = 'acc_1';

    test('should accurately calculate account balance from transaction history', () {
      // Arrange - Following Account-Transaction-Relationship.md principles
      final account = Account(
        id: accountId,
        name: 'Checking Account',
        type: AccountType.bankAccount,
        cachedBalance: 0.0, // Start with zero, calculate from transactions
        isActive: true,
      );

      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Initial Deposit',
          amount: 1000.0,
          type: TransactionType.income,
          date: DateTime.now().subtract(const Duration(days: 10)),
          categoryId: 'deposit',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_2',
          title: 'Grocery Shopping',
          amount: 150.0,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 8)),
          categoryId: 'food',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_3',
          title: 'Salary',
          amount: 2500.0,
          type: TransactionType.income,
          date: DateTime.now().subtract(const Duration(days: 5)),
          categoryId: 'salary',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_4',
          title: 'Rent Payment',
          amount: 1200.0,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 3)),
          categoryId: 'rent',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_5',
          title: 'ATM Withdrawal',
          amount: 200.0,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 1)),
          categoryId: 'cash',
          accountId: accountId,
        ),
      ];

      // Act - Calculate balance using effectiveAmount (per Account-Transaction-Relationship.md)
      final calculatedBalance = transactions.fold<double>(
        0.0,
        (balance, transaction) => balance + transaction.effectiveAmount,
      );

      // Assert - Expected: 1000 + 2500 - 150 - 1200 - 200 = 1950
      expect(calculatedBalance, 1950.0);
      expect(calculatedBalance, greaterThan(0)); // Account should have positive balance
    });

    test('should accurately handle credit card balance calculations', () {
      // Arrange - Credit card with payments and charges
      final creditCard = Account(
        id: accountId,
        name: 'Credit Card',
        type: AccountType.creditCard,
        cachedBalance: 0.0,
        creditLimit: 5000.0,
        isActive: true,
      );

      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Restaurant Charge',
          amount: 85.50,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 10)),
          categoryId: 'dining',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_2',
          title: 'Gas Station',
          amount: 45.00,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 8)),
          categoryId: 'transport',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_3',
          title: 'Grocery Store',
          amount: 125.75,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 5)),
          categoryId: 'food',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_4',
          title: 'Credit Card Payment',
          amount: 150.00,
          type: TransactionType.expense, // Payment reduces balance
          date: DateTime.now().subtract(const Duration(days: 3)),
          categoryId: 'payment',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_5',
          title: 'Online Purchase',
          amount: 299.99,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 1)),
          categoryId: 'shopping',
          accountId: accountId,
        ),
      ];

      // Act - Calculate credit card balance (amounts owed)
      final calculatedBalance = transactions.fold<double>(
        0.0,
        (balance, transaction) => balance + transaction.effectiveAmount,
      );

      // Assert - Expected: 85.50 + 45.00 + 125.75 - 150.00 + 299.99 = 406.24
      expect(calculatedBalance, 406.24);

      // Verify available credit calculation
      final availableCredit = creditCard.creditLimit! - calculatedBalance;
      expect(availableCredit, 5000.0 - 406.24);
      expect(availableCredit, 4593.76);
    });

    test('should accurately handle transfer transactions between accounts', () {
      // Arrange - Transfer between two accounts
      const sourceAccountId = 'acc_1';
      const destinationAccountId = 'acc_2';

      final sourceAccount = Account(
        id: sourceAccountId,
        name: 'Checking',
        type: AccountType.bankAccount,
        cachedBalance: 1000.0,
        isActive: true,
      );

      final destinationAccount = Account(
        id: destinationAccountId,
        name: 'Savings',
        type: AccountType.bankAccount,
        cachedBalance: 500.0,
        isActive: true,
      );

      final transferTransaction = Transaction(
        id: 'transfer_1',
        title: 'Transfer to Savings',
        amount: 300.0,
        type: TransactionType.transfer,
        date: DateTime.now(),
        categoryId: 'transfer',
        accountId: sourceAccountId,
        toAccountId: destinationAccountId,
        transferFee: 5.0,
      );

      // Act - Calculate impact on source account
      final sourceImpact = transferTransaction.effectiveAmount; // Should be -305 (amount + fee)

      // For destination account, transfer amount is added (no fee)
      final destinationImpact = transferTransaction.amount; // Should be +300

      // Assert - Following Account-Transaction-Relationship.md transfer rules
      expect(sourceImpact, -305.0); // -300 - 5 fee
      expect(destinationImpact, 300.0);

      // Verify total system balance conservation (minus fee)
      final totalSystemChange = sourceImpact + destinationImpact;
      expect(totalSystemChange, -5.0); // Only the fee is "lost"
    });

    test('should accurately calculate bill payment impact on account balances', () {
      // Arrange - Bill payment scenario
      final account = Account(
        id: accountId,
        name: 'Checking Account',
        type: AccountType.bankAccount,
        cachedBalance: 2000.0,
        isActive: true,
      );

      final bill = Bill(
        id: 'bill_1',
        name: 'Electricity Bill',
        amount: 150.0,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        frequency: BillFrequency.monthly,
        categoryId: 'utilities',
        accountId: accountId,
      );

      final billPayment = BillPayment(
        id: 'payment_1',
        amount: 150.0,
        paymentDate: DateTime.now(),
        method: PaymentMethod.bankTransfer,
      );

      // Act - Simulate bill payment transaction
      final paymentTransaction = Transaction(
        id: 'tx_bill_payment',
        title: 'Electricity Bill Payment',
        amount: 150.0,
        type: TransactionType.expense,
        date: billPayment.paymentDate,
        categoryId: 'utilities',
        accountId: accountId,
        description: 'Payment for ${bill.name}',
      );

      final balanceImpact = paymentTransaction.effectiveAmount;

      // Assert - Payment should reduce account balance
      expect(balanceImpact, -150.0);
      expect(account.currentBalance + balanceImpact, 1850.0); // 2000 - 150
    });

    test('should accurately track partial bill payments', () {
      // Arrange - Bill with multiple partial payments
      final bill = Bill(
        id: 'bill_1',
        name: 'Internet Bill',
        amount: 200.0,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        frequency: BillFrequency.monthly,
        categoryId: 'internet',
        accountId: accountId,
      );

      final payments = [
        BillPayment(
          id: 'payment_1',
          amount: 100.0,
          paymentDate: DateTime.now().subtract(const Duration(days: 5)),
          method: PaymentMethod.bankTransfer,
        ),
        BillPayment(
          id: 'payment_2',
          amount: 75.0,
          paymentDate: DateTime.now().subtract(const Duration(days: 2)),
          method: PaymentMethod.bankTransfer,
        ),
      ];

      final billWithPayments = bill.copyWith(paymentHistory: payments);

      // Act - Calculate total paid and remaining balance
      final totalPaid = billWithPayments.totalPaid;
      final remainingBalance = bill.amount - totalPaid;

      // Assert
      expect(totalPaid, 175.0); // 100 + 75
      expect(remainingBalance, 25.0); // 200 - 175
      expect(billWithPayments.isPaid, false); // Not fully paid
    });

    test('should accurately calculate account utilization rates for credit cards', () {
      // Arrange - Credit card with various balance scenarios
      final testCases = [
        {
          'balance': 500.0,
          'limit': 2000.0,
          'expectedUtilization': 0.25, // 25%
        },
        {
          'balance': 1500.0,
          'limit': 2000.0,
          'expectedUtilization': 0.75, // 75%
        },
        {
          'balance': 1900.0,
          'limit': 2000.0,
          'expectedUtilization': 0.95, // 95%
        },
        {
          'balance': 2100.0,
          'limit': 2000.0,
          'expectedUtilization': 1.05, // Over limit (105%)
        },
      ];

      for (final testCase in testCases) {
        final creditCard = Account(
          id: 'cc_${testCase['balance']}',
          name: 'Test Credit Card',
          type: AccountType.creditCard,
          cachedBalance: testCase['balance'] as double,
          creditLimit: testCase['limit'] as double,
          isActive: true,
        );

        // Act
        final utilization = creditCard.utilizationRate;
        final isOverLimit = creditCard.isOverLimit;

        // Assert
        expect(utilization, testCase['expectedUtilization']);
        expect(isOverLimit, testCase['balance'] as double > testCase['limit'] as double);
      }
    });

    test('should accurately calculate net worth across multiple accounts', () {
      // Arrange - Multiple accounts with different types
      final accounts = [
        Account(
          id: 'checking',
          name: 'Checking',
          type: AccountType.bankAccount,
          cachedBalance: 2500.0,
          isActive: true,
        ),
        Account(
          id: 'savings',
          name: 'Savings',
          type: AccountType.bankAccount,
          cachedBalance: 10000.0,
          isActive: true,
        ),
        Account(
          id: 'credit_card',
          name: 'Credit Card',
          type: AccountType.creditCard,
          cachedBalance: 1200.0, // Amount owed
          creditLimit: 5000.0,
          isActive: true,
        ),
        Account(
          id: 'loan',
          name: 'Student Loan',
          type: AccountType.loan,
          cachedBalance: 15000.0, // Amount owed
          isActive: true,
        ),
      ];

      // Act - Calculate net worth (assets - liabilities)
      final totalAssets = accounts
          .where((acc) => acc.isAsset)
          .fold<double>(0, (sum, acc) => sum + acc.currentBalance);

      final totalLiabilities = accounts
          .where((acc) => acc.isLiability)
          .fold<double>(0, (sum, acc) => sum + acc.currentBalance);

      final netWorth = totalAssets - totalLiabilities;

      // Assert
      expect(totalAssets, 12500.0); // 2500 + 10000
      expect(totalLiabilities, 16200.0); // 1200 + 15000
      expect(netWorth, -3700.0); // 12500 - 16200
    });

    test('should accurately handle currency conversion in multi-currency scenarios', () {
      // Arrange - Transactions in different currencies (simplified)
      final usdTransactions = [
        Transaction(
          id: 'tx_usd_1',
          title: 'USD Income',
          amount: 1000.0,
          type: TransactionType.income,
          date: DateTime.now(),
          categoryId: 'salary',
          accountId: accountId,
          currencyCode: 'USD',
        ),
        Transaction(
          id: 'tx_usd_2',
          title: 'USD Expense',
          amount: 200.0,
          type: TransactionType.expense,
          date: DateTime.now(),
          categoryId: 'food',
          accountId: accountId,
          currencyCode: 'USD',
        ),
      ];

      // Simplified currency conversion (1 EUR = 1.1 USD)
      final eurToUsdRate = 1.1;
      final eurTransactions = [
        Transaction(
          id: 'tx_eur_1',
          title: 'EUR Expense',
          amount: 50.0, // 50 EUR
          type: TransactionType.expense,
          date: DateTime.now(),
          categoryId: 'shopping',
          accountId: accountId,
          currencyCode: 'EUR',
        ),
      ];

      // Act - Calculate total balance in USD
      final usdBalance = usdTransactions.fold<double>(
        0,
        (sum, tx) => sum + tx.effectiveAmount,
      );

      final eurBalanceInUsd = eurTransactions.fold<double>(
        0,
        (sum, tx) => sum + (tx.effectiveAmount * eurToUsdRate),
      );

      final totalBalanceUsd = usdBalance + eurBalanceInUsd;

      // Assert
      expect(usdBalance, 800.0); // 1000 - 200
      expect(eurBalanceInUsd, -55.0); // -50 * 1.1
      expect(totalBalanceUsd, 745.0); // 800 - 55
    });

    test('should accurately calculate financial ratios and metrics', () {
      // Arrange - Account with transaction history for ratio calculations
      final account = Account(
        id: accountId,
        name: 'Checking Account',
        type: AccountType.bankAccount,
        cachedBalance: 5000.0,
        isActive: true,
      );

      final monthlyTransactions = [
        // Income
        Transaction(id: 'inc_1', title: 'Salary', amount: 3000.0, type: TransactionType.income, date: DateTime.now(), categoryId: 'salary', accountId: accountId),
        Transaction(id: 'inc_2', title: 'Freelance', amount: 500.0, type: TransactionType.income, date: DateTime.now(), categoryId: 'freelance', accountId: accountId),

        // Expenses
        Transaction(id: 'exp_1', title: 'Rent', amount: 1200.0, type: TransactionType.expense, date: DateTime.now(), categoryId: 'rent', accountId: accountId),
        Transaction(id: 'exp_2', title: 'Food', amount: 400.0, type: TransactionType.expense, date: DateTime.now(), categoryId: 'food', accountId: accountId),
        Transaction(id: 'exp_3', title: 'Transport', amount: 200.0, type: TransactionType.expense, date: DateTime.now(), categoryId: 'transport', accountId: accountId),
        Transaction(id: 'exp_4', title: 'Entertainment', amount: 150.0, type: TransactionType.expense, date: DateTime.now(), categoryId: 'entertainment', accountId: accountId),
      ];

      // Act - Calculate financial ratios
      final totalIncome = monthlyTransactions
          .where((tx) => tx.isIncome)
          .fold<double>(0, (sum, tx) => sum + tx.amount);

      final totalExpenses = monthlyTransactions
          .where((tx) => tx.isExpense)
          .fold<double>(0, (sum, tx) => sum + tx.amount);

      final savingsRate = totalIncome > 0 ? (totalIncome - totalExpenses) / totalIncome : 0.0;
      final expenseRatio = totalIncome > 0 ? totalExpenses / totalIncome : 0.0;

      // Assert - Financial health metrics
      expect(totalIncome, 3500.0); // 3000 + 500
      expect(totalExpenses, 1950.0); // 1200 + 400 + 200 + 150
      expect(savingsRate, (3500.0 - 1950.0) / 3500.0); // 0.443 (44.3% savings rate)
      expect(expenseRatio, 1950.0 / 3500.0); // 0.557 (55.7% expense ratio)

      // Verify savings rate is positive (good financial health)
      expect(savingsRate, greaterThan(0));
      expect(savingsRate, closeTo(0.443, 0.001));
    });
  });
}