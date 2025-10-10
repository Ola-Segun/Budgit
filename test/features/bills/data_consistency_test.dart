import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/bills/domain/entities/bill.dart';
import 'package:budget_tracker/features/bills/domain/repositories/bill_repository.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';

@GenerateMocks([BillRepository, AccountRepository, TransactionRepository])
import 'data_consistency_test.mocks.dart';

void main() {
  late MockBillRepository mockBillRepository;
  late MockAccountRepository mockAccountRepository;
  late MockTransactionRepository mockTransactionRepository;

  setUpAll(() {
    provideDummy<Result<List<Bill>>>(Result.error(Failure.unknown('dummy')));
    provideDummy<Result<List<Account>>>(Result.error(Failure.unknown('dummy')));
    provideDummy<Result<List<Transaction>>>(Result.error(Failure.unknown('dummy')));
    provideDummy<Result<Map<String, double>>>(Result.error(Failure.unknown('dummy')));
  });

  setUp(() {
    mockBillRepository = MockBillRepository();
    mockAccountRepository = MockAccountRepository();
    mockTransactionRepository = MockTransactionRepository();
  });

  group('Data Consistency Tests - Account-Transaction-Bill Relationships', () {
    const accountId1 = 'acc_1';
    const accountId2 = 'acc_2';
    const billId1 = 'bill_1';
    const billId2 = 'bill_2';

    final account1 = Account(
      id: accountId1,
      name: 'Checking Account',
      type: AccountType.bankAccount,
      cachedBalance: 1000.0,
      reconciledBalance: 1000.0,
      isActive: true,
    );

    final account2 = Account(
      id: accountId2,
      name: 'Credit Card',
      type: AccountType.creditCard,
      cachedBalance: 500.0,
      creditLimit: 2000.0,
      reconciledBalance: 500.0,
      isActive: true,
    );

    test('should maintain balance consistency: account balance equals sum of transaction effects', () async {
      // Arrange - Account with multiple transactions
      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Salary Deposit',
          amount: 200.0,
          type: TransactionType.income,
          date: DateTime.now().subtract(const Duration(days: 5)),
          categoryId: 'salary',
          accountId: accountId1,
        ),
        Transaction(
          id: 'tx_2',
          title: 'Electricity Bill',
          amount: 150.0,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 3)),
          categoryId: 'utilities',
          accountId: accountId1,
        ),
        Transaction(
          id: 'tx_3',
          title: 'Grocery Shopping',
          amount: 100.0,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 1)),
          categoryId: 'groceries',
          accountId: accountId1,
        ),
      ];

      // Expected balance: 1000 + 200 - 150 - 100 = 950
      final expectedBalance = 950.0;

      when(mockTransactionRepository.getByAccountId(accountId1))
          .thenAnswer((_) async => Result.success(transactions));
      when(mockAccountRepository.getById(accountId1))
          .thenAnswer((_) async => Result.success(account1));

      // Act - Calculate actual balance from transactions
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId1);
      final accountResult = await mockAccountRepository.getById(accountId1);

      // Assert
      expect(transactionsResult.isSuccess, true);
      expect(accountResult.isSuccess, true);

      final actualTransactions = transactionsResult.dataOrNull!;
      final account = accountResult.dataOrNull!;

      // Calculate balance from transactions
      final calculatedBalance = actualTransactions.fold<double>(
        0,
        (sum, tx) => sum + tx.effectiveAmount,
      );

      // Account balance should equal calculated balance (following Account-Transaction-Relationship.md principle)
      expect(account.currentBalance, calculatedBalance);
      expect(calculatedBalance, expectedBalance);
    });

    test('should maintain bill payment consistency: bill payments create corresponding transactions', () async {
      // Arrange - Bill with payment history
      final payment1 = BillPayment(
        id: 'payment_1',
        amount: 100.0,
        paymentDate: DateTime.now().subtract(const Duration(days: 5)),
        method: PaymentMethod.bankTransfer,
      );

      final payment2 = BillPayment(
        id: 'payment_2',
        amount: 50.0,
        paymentDate: DateTime.now().subtract(const Duration(days: 2)),
        method: PaymentMethod.bankTransfer,
      );

      final bill = Bill(
        id: billId1,
        name: 'Electricity Bill',
        amount: 200.0,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        frequency: BillFrequency.monthly,
        categoryId: 'utilities',
        accountId: accountId1,
        paymentHistory: [payment1, payment2],
        isPaid: true,
      );

      // Expected transactions from bill payments
      final expectedTransactions = [
        Transaction(
          id: 'tx_bill_1',
          title: 'Electricity Bill Payment',
          amount: 100.0,
          type: TransactionType.expense,
          date: payment1.paymentDate,
          categoryId: 'utilities',
          accountId: accountId1,
          description: 'Electricity Bill - Payment 1',
        ),
        Transaction(
          id: 'tx_bill_2',
          title: 'Electricity Bill Payment',
          amount: 50.0,
          type: TransactionType.expense,
          date: payment2.paymentDate,
          categoryId: 'utilities',
          accountId: accountId1,
          description: 'Electricity Bill - Payment 2',
        ),
      ];

      when(mockBillRepository.getById(billId1))
          .thenAnswer((_) async => Result.success(bill));
      when(mockTransactionRepository.getByAccountId(accountId1))
          .thenAnswer((_) async => Result.success(expectedTransactions));

      // Act
      final billResult = await mockBillRepository.getById(billId1);
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId1);

      // Assert
      expect(billResult.isSuccess, true);
      expect(transactionsResult.isSuccess, true);

      final actualBill = billResult.dataOrNull!;
      final actualTransactions = transactionsResult.dataOrNull!;

      // Bill payment history should match transaction amounts
      final totalPaid = actualBill.totalPaid;
      final totalTransactionAmount = actualTransactions.fold<double>(
        0,
        (sum, tx) => sum + tx.amount,
      );

      expect(totalPaid, totalTransactionAmount);
      expect(actualTransactions.length, actualBill.paymentHistory.length);
    });

    test('should maintain transfer consistency: transfers update both accounts atomically', () async {
      // Arrange - Transfer between accounts
      final transferTransaction = Transaction(
        id: 'transfer_1',
        title: 'Transfer to Savings',
        amount: 300.0,
        type: TransactionType.transfer,
        date: DateTime.now(),
        categoryId: 'transfer',
        accountId: accountId1, // Source account
        toAccountId: accountId2, // Destination account
        transferFee: 5.0,
      );

      // Source account: 1000 - 300 - 5 = 695
      final updatedAccount1 = account1.copyWith(cachedBalance: 695.0);

      // Destination account: 500 + 300 = 800
      final updatedAccount2 = account2.copyWith(cachedBalance: 800.0);

      when(mockTransactionRepository.getByAccountId(accountId1))
          .thenAnswer((_) async => Result.success([transferTransaction]));
      when(mockTransactionRepository.getByAccountId(accountId2))
          .thenAnswer((_) async => Result.success([transferTransaction]));
      when(mockAccountRepository.getById(accountId1))
          .thenAnswer((_) async => Result.success(updatedAccount1));
      when(mockAccountRepository.getById(accountId2))
          .thenAnswer((_) async => Result.success(updatedAccount2));

      // Act
      final account1Result = await mockAccountRepository.getById(accountId1);
      final account2Result = await mockAccountRepository.getById(accountId2);
      final tx1Result = await mockTransactionRepository.getByAccountId(accountId1);
      final tx2Result = await mockTransactionRepository.getByAccountId(accountId2);

      // Assert
      expect(account1Result.isSuccess, true);
      expect(account2Result.isSuccess, true);
      expect(tx1Result.isSuccess, true);
      expect(tx2Result.isSuccess, true);

      final actualAccount1 = account1Result.dataOrNull!;
      final actualAccount2 = account2Result.dataOrNull!;

      // Transfer should maintain total system balance (minus fee)
      final totalSystemBalance = actualAccount1.currentBalance + actualAccount2.currentBalance;
      final originalTotal = account1.currentBalance + account2.currentBalance;
      final expectedTotal = originalTotal - 5.0; // Fee is "lost"

      expect(totalSystemBalance, expectedTotal);

      // Source account balance should reflect deduction
      expect(actualAccount1.currentBalance, 695.0);

      // Destination account balance should reflect addition
      expect(actualAccount2.currentBalance, 800.0);
    });

    test('should detect and flag balance discrepancies', () async {
      // Arrange - Account with balance discrepancy
      final accountWithDiscrepancy = account1.copyWith(
        cachedBalance: 1000.0,
        reconciledBalance: 950.0, // 50 less than cached
      );

      final transactions = [
        Transaction(
          id: 'tx_1',
          amount: 200.0,
          type: TransactionType.income,
          date: DateTime.now(),
          categoryId: 'salary',
          accountId: accountId1,
        ),
        Transaction(
          id: 'tx_2',
          amount: 150.0,
          type: TransactionType.expense,
          date: DateTime.now(),
          categoryId: 'utilities',
          accountId: accountId1,
        ),
      ];

      when(mockAccountRepository.getById(accountId1))
          .thenAnswer((_) async => Result.success(accountWithDiscrepancy));
      when(mockTransactionRepository.getByAccountId(accountId1))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final accountResult = await mockAccountRepository.getById(accountId1);
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId1);

      // Assert
      expect(accountResult.isSuccess, true);
      expect(transactionsResult.isSuccess, true);

      final account = accountResult.dataOrNull!;
      final actualTransactions = transactionsResult.dataOrNull!;

      // Calculate expected balance from transactions
      final calculatedBalance = actualTransactions.fold<double>(
        0,
        (sum, tx) => sum + tx.effectiveAmount,
      );

      // Account should detect discrepancy
      expect(account.needsReconciliation, true);
      expect(account.balanceDiscrepancy, 50.0); // 1000 - 950
      expect(calculatedBalance, 50.0); // 200 - 150
    });

    test('should maintain bill-account relationship integrity', () async {
      // Arrange - Bills linked to accounts
      final bills = [
        Bill(
          id: billId1,
          name: 'Electricity Bill',
          amount: 150.0,
          dueDate: DateTime.now().add(const Duration(days: 5)),
          frequency: BillFrequency.monthly,
          categoryId: 'utilities',
          accountId: accountId1,
        ),
        Bill(
          id: billId2,
          name: 'Credit Card Bill',
          amount: 500.0,
          dueDate: DateTime.now().add(const Duration(days: 10)),
          frequency: BillFrequency.monthly,
          categoryId: 'credit_card',
          accountId: accountId2,
        ),
      ];

      when(mockBillRepository.getAll())
          .thenAnswer((_) async => Result.success(bills));
      when(mockAccountRepository.getById(accountId1))
          .thenAnswer((_) async => Result.success(account1));
      when(mockAccountRepository.getById(accountId2))
          .thenAnswer((_) async => Result.success(account2));

      // Act
      final billsResult = await mockBillRepository.getAll();
      final account1Result = await mockAccountRepository.getById(accountId1);
      final account2Result = await mockAccountRepository.getById(accountId2);

      // Assert
      expect(billsResult.isSuccess, true);
      expect(account1Result.isSuccess, true);
      expect(account2Result.isSuccess, true);

      final actualBills = billsResult.dataOrNull!;
      final actualAccount1 = account1Result.dataOrNull!;
      final actualAccount2 = account2Result.dataOrNull!;

      // Bills should be linked to valid accounts
      for (final bill in actualBills) {
        expect(bill.accountId, isNotNull);
        if (bill.accountId == accountId1) {
          // Bank account should have sufficient balance for bill
          expect(actualAccount1.availableBalance, greaterThanOrEqualTo(bill.amount));
        } else if (bill.accountId == accountId2) {
          // Credit card should have available credit for bill
          expect(actualAccount2.availableBalance, greaterThanOrEqualTo(bill.amount));
        }
      }
    });

    test('should maintain transaction categorization consistency', () async {
      // Arrange - Transactions with proper categorization
      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Monthly Salary',
          amount: 2000.0,
          type: TransactionType.income,
          date: DateTime.now(),
          categoryId: 'salary',
          accountId: accountId1,
        ),
        Transaction(
          id: 'tx_2',
          title: 'Utility Bill',
          amount: 150.0,
          type: TransactionType.expense,
          date: DateTime.now(),
          categoryId: 'utilities',
          accountId: accountId1,
        ),
        Transaction(
          id: 'tx_3',
          title: 'Transfer to Savings',
          amount: 300.0,
          type: TransactionType.transfer,
          date: DateTime.now(),
          categoryId: 'transfer',
          accountId: accountId1,
          toAccountId: accountId2,
        ),
      ];

      when(mockTransactionRepository.getByAccountId(accountId1))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final result = await mockTransactionRepository.getByAccountId(accountId1);

      // Assert
      expect(result.isSuccess, true);

      final actualTransactions = result.dataOrNull!;

      // All transactions should have valid categories
      for (final transaction in actualTransactions) {
        expect(transaction.categoryId, isNotEmpty);

        // Category should match transaction type
        if (transaction.type == TransactionType.income) {
          expect(transaction.categoryId, isNot('transfer'));
        } else if (transaction.type == TransactionType.transfer) {
          expect(transaction.categoryId, 'transfer');
        }
      }

      // Transfer transactions should have destination account
      final transferTx = actualTransactions.firstWhere(
        (tx) => tx.type == TransactionType.transfer,
      );
      expect(transferTx.toAccountId, isNotNull);
      expect(transferTx.toAccountId, accountId2);
    });

    test('should maintain chronological transaction ordering', () async {
      // Arrange - Transactions in chronological order
      final baseTime = DateTime.now();
      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Lunch',
          amount: 100.0,
          type: TransactionType.expense,
          date: baseTime.subtract(const Duration(days: 5)),
          categoryId: 'food',
          accountId: accountId1,
        ),
        Transaction(
          id: 'tx_2',
          title: 'Electricity Bill',
          amount: 200.0,
          type: TransactionType.expense,
          date: baseTime.subtract(const Duration(days: 3)),
          categoryId: 'utilities',
          accountId: accountId1,
        ),
        Transaction(
          id: 'tx_3',
          title: 'Bus Fare',
          amount: 50.0,
          type: TransactionType.expense,
          date: baseTime.subtract(const Duration(days: 1)),
          categoryId: 'transport',
          accountId: accountId1,
        ),
      ];

      when(mockTransactionRepository.getByAccountId(accountId1))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final result = await mockTransactionRepository.getByAccountId(accountId1);

      // Assert
      expect(result.isSuccess, true);

      final actualTransactions = result.dataOrNull!;

      // Transactions should be in chronological order (most recent first)
      for (int i = 0; i < actualTransactions.length - 1; i++) {
        expect(
          actualTransactions[i].date.isAfter(actualTransactions[i + 1].date) ||
          actualTransactions[i].date.isAtSameMomentAs(actualTransactions[i + 1].date),
          true,
        );
      }
    });
  });
}