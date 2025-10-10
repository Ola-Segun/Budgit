import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';

@GenerateMocks([AccountRepository, TransactionRepository])
import 'balance_reconciliation_test.mocks.dart';

void main() {
  late MockAccountRepository mockAccountRepository;
  late MockTransactionRepository mockTransactionRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    mockTransactionRepository = MockTransactionRepository();
  });

  group('Balance Reconciliation Tests - Account-Transaction Relationship Integrity', () {
    const accountId = 'acc_1';

    test('should detect when cached balance matches calculated balance', () async {
      // Arrange - Account with consistent balances
      final account = Account(
        id: accountId,
        name: 'Consistent Account',
        type: AccountType.bankAccount,
        cachedBalance: 950.0,
        reconciledBalance: 950.0,
        lastReconciliation: DateTime.now(),
        isActive: true,
      );

      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Initial Deposit',
          amount: 1000.0,
          type: TransactionType.income,
          date: DateTime.now().subtract(const Duration(days: 5)),
          categoryId: 'deposit',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_2',
          title: 'Grocery Shopping',
          amount: 50.0,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 3)),
          categoryId: 'food',
          accountId: accountId,
        ),
      ];

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(account));
      when(mockTransactionRepository.getByAccountId(accountId))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final accountResult = await mockAccountRepository.getById(accountId);
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId);

      // Assert
      expect(accountResult.isSuccess, true);
      expect(transactionsResult.isSuccess, true);

      final actualAccount = accountResult.dataOrNull!;
      final actualTransactions = transactionsResult.dataOrNull!;

      // Calculate balance from transactions
      final calculatedBalance = actualTransactions.fold<double>(
        0.0,
        (sum, tx) => sum + tx.effectiveAmount,
      );

      // Verify reconciliation
      expect(actualAccount.cachedBalance, calculatedBalance);
      expect(actualAccount.reconciledBalance, calculatedBalance);
      expect(actualAccount.needsReconciliation, false);
      expect(actualAccount.balanceDiscrepancy, null);
    });

    test('should detect balance discrepancies requiring reconciliation', () async {
      // Arrange - Account with balance discrepancy
      final accountWithDiscrepancy = Account(
        id: accountId,
        name: 'Discrepant Account',
        type: AccountType.bankAccount,
        cachedBalance: 1000.0, // Cached balance
        reconciledBalance: 950.0, // Calculated balance (50 less)
        lastReconciliation: DateTime.now().subtract(const Duration(days: 1)),
        isActive: true,
      );

      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Salary',
          amount: 2000.0,
          type: TransactionType.income,
          date: DateTime.now().subtract(const Duration(days: 10)),
          categoryId: 'salary',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_2',
          title: 'Rent',
          amount: 1000.0,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 8)),
          categoryId: 'rent',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_3',
          title: 'Groceries',
          amount: 50.0,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 5)),
          categoryId: 'food',
          accountId: accountId,
        ),
      ];

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(accountWithDiscrepancy));
      when(mockTransactionRepository.getByAccountId(accountId))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final accountResult = await mockAccountRepository.getById(accountId);
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId);

      // Assert
      expect(accountResult.isSuccess, true);
      expect(transactionsResult.isSuccess, true);

      final account = accountResult.dataOrNull!;
      final actualTransactions = transactionsResult.dataOrNull!;

      // Calculate actual balance from transactions
      final calculatedBalance = actualTransactions.fold<double>(
        0.0,
        (sum, tx) => sum + tx.effectiveAmount,
      );

      // Verify discrepancy detection
      expect(account.needsReconciliation, true);
      expect(account.balanceDiscrepancy, 50.0); // 1000 - 950
      expect(calculatedBalance, 950.0); // 2000 - 1000 - 50
    });

    test('should handle reconciliation for credit card accounts', () async {
      // Arrange - Credit card with potential discrepancy
      final creditCard = Account(
        id: accountId,
        name: 'Credit Card',
        type: AccountType.creditCard,
        cachedBalance: 1200.0, // Amount owed (cached)
        reconciledBalance: 1150.0, // Slightly different
        creditLimit: 5000.0,
        lastReconciliation: DateTime.now().subtract(const Duration(hours: 12)),
        isActive: true,
      );

      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Restaurant',
          amount: 85.50,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 5)),
          categoryId: 'dining',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_2',
          title: 'Gas Station',
          amount: 45.00,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(days: 3)),
          categoryId: 'transport',
          accountId: accountId,
        ),
        Transaction(
          id: 'tx_3',
          title: 'Payment',
          amount: 150.00,
          type: TransactionType.expense, // Payment reduces balance
          date: DateTime.now().subtract(const Duration(days: 1)),
          categoryId: 'payment',
          accountId: accountId,
        ),
      ];

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(creditCard));
      when(mockTransactionRepository.getByAccountId(accountId))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final accountResult = await mockAccountRepository.getById(accountId);
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId);

      // Assert
      expect(accountResult.isSuccess, true);
      expect(transactionsResult.isSuccess, true);

      final account = accountResult.dataOrNull!;
      final actualTransactions = transactionsResult.dataOrNull!;

      // Calculate balance from transactions
      final calculatedBalance = actualTransactions.fold<double>(
        0.0,
        (sum, tx) => sum + tx.effectiveAmount,
      );

      // Verify credit card reconciliation
      expect(account.needsReconciliation, true);
      expect(account.balanceDiscrepancy, 50.0); // 1200 - 1150
      expect(calculatedBalance, -19.50); // 85.50 + 45.00 - 150.00
    });

    test('should handle reconciliation for transfer transactions', () async {
      // Arrange - Account involved in transfers
      const sourceAccountId = 'acc_1';
      const destinationAccountId = 'acc_2';

      final sourceAccount = Account(
        id: sourceAccountId,
        name: 'Checking',
        type: AccountType.bankAccount,
        cachedBalance: 700.0,
        reconciledBalance: 695.0, // Slight discrepancy
        isActive: true,
      );

      final destinationAccount = Account(
        id: destinationAccountId,
        name: 'Savings',
        type: AccountType.bankAccount,
        cachedBalance: 1305.0,
        reconciledBalance: 1310.0, // Slight discrepancy
        isActive: true,
      );

      final transferTransactions = [
        Transaction(
          id: 'transfer_1',
          title: 'Transfer to Savings',
          amount: 300.0,
          type: TransactionType.transfer,
          date: DateTime.now().subtract(const Duration(days: 2)),
          categoryId: 'transfer',
          accountId: sourceAccountId,
          toAccountId: destinationAccountId,
          transferFee: 5.0,
        ),
      ];

      when(mockAccountRepository.getById(sourceAccountId))
          .thenAnswer((_) async => Result.success(sourceAccount));
      when(mockAccountRepository.getById(destinationAccountId))
          .thenAnswer((_) async => Result.success(destinationAccount));
      when(mockTransactionRepository.getByAccountId(sourceAccountId))
          .thenAnswer((_) async => Result.success(transferTransactions));
      when(mockTransactionRepository.getByAccountId(destinationAccountId))
          .thenAnswer((_) async => Result.success(transferTransactions));

      // Act
      final sourceResult = await mockAccountRepository.getById(sourceAccountId);
      final destResult = await mockAccountRepository.getById(destinationAccountId);
      final sourceTxResult = await mockTransactionRepository.getByAccountId(sourceAccountId);
      final destTxResult = await mockTransactionRepository.getByAccountId(destinationAccountId);

      // Assert
      expect(sourceResult.isSuccess, true);
      expect(destResult.isSuccess, true);
      expect(sourceTxResult.isSuccess, true);
      expect(destTxResult.isSuccess, true);

      final sourceAccountActual = sourceResult.dataOrNull!;
      final destAccountActual = destResult.dataOrNull!;

      // Verify transfer reconciliation
      expect(sourceAccountActual.needsReconciliation, true);
      expect(sourceAccountActual.balanceDiscrepancy, 5.0); // 700 - 695

      expect(destAccountActual.needsReconciliation, true);
      expect(destAccountActual.balanceDiscrepancy, -5.0); // 1305 - 1310

      // Total system should be balanced (discrepancies should offset)
      final totalDiscrepancy = (sourceAccountActual.balanceDiscrepancy ?? 0) +
                              (destAccountActual.balanceDiscrepancy ?? 0);
      expect(totalDiscrepancy, 0.0); // Transfer should maintain system balance
    });

    test('should handle reconciliation with missing reconciled balance', () async {
      // Arrange - Account without reconciled balance (first time reconciliation)
      final account = Account(
        id: accountId,
        name: 'New Account',
        type: AccountType.bankAccount,
        cachedBalance: 500.0,
        isActive: true,
        // No reconciledBalance set
      );

      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Deposit',
          amount: 500.0,
          type: TransactionType.income,
          date: DateTime.now(),
          categoryId: 'deposit',
          accountId: accountId,
        ),
      ];

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(account));
      when(mockTransactionRepository.getByAccountId(accountId))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final accountResult = await mockAccountRepository.getById(accountId);
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId);

      // Assert
      expect(accountResult.isSuccess, true);
      expect(transactionsResult.isSuccess, true);

      final actualAccount = accountResult.dataOrNull!;
      final actualTransactions = transactionsResult.dataOrNull!;

      // Calculate balance from transactions
      final calculatedBalance = actualTransactions.fold<double>(
        0.0,
        (sum, tx) => sum + tx.effectiveAmount,
      );

      // Account without reconciled balance should not need reconciliation
      expect(actualAccount.needsReconciliation, false);
      expect(actualAccount.balanceDiscrepancy, null);
      expect(calculatedBalance, 500.0);
    });

    test('should handle reconciliation with zero balance account', () async {
      // Arrange - Zero balance account
      final zeroBalanceAccount = Account(
        id: accountId,
        name: 'Zero Balance Account',
        type: AccountType.bankAccount,
        cachedBalance: 0.0,
        reconciledBalance: 0.0,
        isActive: true,
      );

      final transactions = <Transaction>[]; // No transactions

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(zeroBalanceAccount));
      when(mockTransactionRepository.getByAccountId(accountId))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final accountResult = await mockAccountRepository.getById(accountId);
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId);

      // Assert
      expect(accountResult.isSuccess, true);
      expect(transactionsResult.isSuccess, true);

      final account = accountResult.dataOrNull!;
      final actualTransactions = transactionsResult.dataOrNull!;

      // Calculate balance from transactions
      final calculatedBalance = actualTransactions.fold<double>(
        0.0,
        (sum, tx) => sum + tx.effectiveAmount,
      );

      // Zero balance account should be reconciled
      expect(account.needsReconciliation, false);
      expect(account.balanceDiscrepancy, null);
      expect(calculatedBalance, 0.0);
      expect(account.cachedBalance, 0.0);
    });

    test('should handle reconciliation with negative balance', () async {
      // Arrange - Account with negative balance
      final negativeBalanceAccount = Account(
        id: accountId,
        name: 'Negative Balance Account',
        type: AccountType.bankAccount,
        cachedBalance: -200.0,
        reconciledBalance: -200.0,
        isActive: true,
      );

      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Overdraft Fee',
          amount: 200.0,
          type: TransactionType.expense,
          date: DateTime.now(),
          categoryId: 'fee',
          accountId: accountId,
        ),
      ];

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(negativeBalanceAccount));
      when(mockTransactionRepository.getByAccountId(accountId))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final accountResult = await mockAccountRepository.getById(accountId);
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId);

      // Assert
      expect(accountResult.isSuccess, true);
      expect(transactionsResult.isSuccess, true);

      final account = accountResult.dataOrNull!;
      final actualTransactions = transactionsResult.dataOrNull!;

      // Calculate balance from transactions
      final calculatedBalance = actualTransactions.fold<double>(
        0.0,
        (sum, tx) => sum + tx.effectiveAmount,
      );

      // Negative balance account should be reconciled
      expect(account.needsReconciliation, false);
      expect(account.balanceDiscrepancy, null);
      expect(calculatedBalance, -200.0);
      expect(account.cachedBalance, -200.0);
    });

    test('should detect reconciliation needed for stale data', () async {
      // Arrange - Account with old reconciliation date
      final staleAccount = Account(
        id: accountId,
        name: 'Stale Account',
        type: AccountType.bankAccount,
        cachedBalance: 1000.0,
        reconciledBalance: 950.0,
        lastReconciliation: DateTime.now().subtract(const Duration(days: 30)), // Very old
        isActive: true,
      );

      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Recent Transaction',
          amount: 100.0,
          type: TransactionType.expense,
          date: DateTime.now().subtract(const Duration(hours: 1)), // Very recent
          categoryId: 'shopping',
          accountId: accountId,
        ),
      ];

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(staleAccount));
      when(mockTransactionRepository.getByAccountId(accountId))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final accountResult = await mockAccountRepository.getById(accountId);
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId);

      // Assert
      expect(accountResult.isSuccess, true);
      expect(transactionsResult.isSuccess, true);

      final account = accountResult.dataOrNull!;

      // Account with stale reconciliation should need reconciliation
      expect(account.needsReconciliation, true);
      expect(account.balanceDiscrepancy, 50.0); // 1000 - 950
    });

    test('should handle reconciliation with large transaction volumes', () async {
      // Arrange - Account with many transactions
      final account = Account(
        id: accountId,
        name: 'High Volume Account',
        type: AccountType.bankAccount,
        cachedBalance: 5000.0,
        reconciledBalance: 4950.0, // 50 less
        isActive: true,
      );

      // Generate 100 transactions
      final transactions = List.generate(100, (index) {
        final isIncome = index % 3 == 0; // Every 3rd transaction is income
        final amount = isIncome ? 100.0 : 50.0;

        return Transaction(
          id: 'tx_$index',
          title: isIncome ? 'Income $index' : 'Expense $index',
          amount: amount,
          type: isIncome ? TransactionType.income : TransactionType.expense,
          date: DateTime.now().subtract(Duration(days: index)),
          categoryId: isIncome ? 'salary' : 'misc',
          accountId: accountId,
        );
      });

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(account));
      when(mockTransactionRepository.getByAccountId(accountId))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final accountResult = await mockAccountRepository.getById(accountId);
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId);

      // Assert
      expect(accountResult.isSuccess, true);
      expect(transactionsResult.isSuccess, true);

      final actualAccount = accountResult.dataOrNull!;
      final actualTransactions = transactionsResult.dataOrNull!;

      // Calculate balance from all transactions
      final calculatedBalance = actualTransactions.fold<double>(
        0.0,
        (sum, tx) => sum + tx.effectiveAmount,
      );

      // Verify reconciliation with large volume
      expect(actualAccount.needsReconciliation, true);
      expect(actualAccount.balanceDiscrepancy, 50.0); // 5000 - 4950

      // Verify calculation accuracy with large volume
      final incomeCount = actualTransactions.where((tx) => tx.isIncome).length;
      final expenseCount = actualTransactions.where((tx) => tx.isExpense).length;
      final expectedCalculatedBalance = (incomeCount * 100.0) - (expenseCount * 50.0);

      expect(calculatedBalance, expectedCalculatedBalance);
      expect(incomeCount + expenseCount, 100); // All transactions accounted for
    });

    test('should handle reconciliation edge case with floating point precision', () async {
      // Arrange - Account with tiny balance differences due to floating point
      final account = Account(
        id: accountId,
        name: 'Precision Account',
        type: AccountType.bankAccount,
        cachedBalance: 100.0,
        reconciledBalance: 100.0000001, // Tiny difference due to floating point
        isActive: true,
      );

      final transactions = [
        Transaction(
          id: 'tx_1',
          title: 'Precise Amount',
          amount: 100.0,
          type: TransactionType.income,
          date: DateTime.now(),
          categoryId: 'deposit',
          accountId: accountId,
        ),
      ];

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(account));
      when(mockTransactionRepository.getByAccountId(accountId))
          .thenAnswer((_) async => Result.success(transactions));

      // Act
      final accountResult = await mockAccountRepository.getById(accountId);
      final transactionsResult = await mockTransactionRepository.getByAccountId(accountId);

      // Assert
      expect(accountResult.isSuccess, true);
      expect(transactionsResult.isSuccess, true);

      final actualAccount = accountResult.dataOrNull!;

      // Tiny floating point differences should not trigger reconciliation
      expect(actualAccount.needsReconciliation, false);
      expect(actualAccount.balanceDiscrepancy?.abs(), lessThan(0.01)); // Less than 1 cent
    });
  });
}