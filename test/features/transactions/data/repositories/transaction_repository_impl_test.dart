import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/transactions/data/datasources/transaction_hive_datasource.dart';
import 'package:budget_tracker/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';

import '../../../../test_setup.dart';

@GenerateMocks([TransactionHiveDataSource, AccountRepository])
import 'transaction_repository_impl_test.mocks.dart';

void main() {
   late TransactionRepositoryImpl repository;
   late MockTransactionHiveDataSource mockDataSource;
   late MockAccountRepository mockAccountRepository;

   setUpAll(() {
     setupMockitoDummies();
   });

   setUp(() {
     mockDataSource = MockTransactionHiveDataSource();
     mockAccountRepository = MockAccountRepository();
     repository = TransactionRepositoryImpl(mockDataSource, mockAccountRepository);
   });

  group('TransactionRepositoryImpl', () {
    final testTransaction = Transaction(
      id: 'test-id',
      title: 'Test Transaction',
      amount: 50.0,
      type: TransactionType.expense,
      date: DateTime(2025, 10, 2),
      categoryId: 'food',
      accountId: 'account1',
    );

    group('getAll', () {
      test('should return transactions when data source succeeds', () async {
        // Arrange
        final transactions = [testTransaction];
        when(mockDataSource.getAll())
            .thenAnswer((_) async => Result.success(transactions));

        // Act
        final result = await repository.getAll();

        // Assert
        expect(result, isA<Success<List<Transaction>>>());
        result.when(
          success: (data) {
            expect(data.length, 1);
            expect(data.first.id, testTransaction.id);
          },
          error: (_) => fail('Should not fail'),
        );
        verify(mockDataSource.getAll()).called(1);
      });

      test('should return cache failure when data source fails', () async {
         // Arrange
         when(mockDataSource.getAll())
             .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

         // Act
         final result = await repository.getAll();

         // Assert
         expect(result, isA<Error<List<Transaction>>>());
         result.when(
           success: (_) => fail('Should not succeed'),
           error: (failure) {
             expect(failure, isA<CacheFailure>());
           },
         );
       });

      test('should return unknown failure for unexpected errors', () async {
        // Arrange
        when(mockDataSource.getAll()).thenAnswer((_) async => Result.error(Failure.unknown('Unexpected error')));

        // Act
        final result = await repository.getAll();

        // Assert
        expect(result, isA<Error<List<Transaction>>>());
        result.when(
          success: (_) => fail('Should not succeed'),
          error: (failure) {
            expect(failure, isA<UnknownFailure>());
          },
        );
      });
    });

    group('add', () {
      test('should return transaction when data source succeeds', () async {
         // Arrange
         when(mockDataSource.add(testTransaction))
             .thenAnswer((_) async => Result.success(testTransaction));

         // Act
         final result = await repository.add(testTransaction);

         // Assert
         expect(result, isA<Success<Transaction>>());
         result.when(
           success: (transaction) {
             expect(transaction.id, testTransaction.id);
           },
           error: (_) => fail('Should not fail'),
         );
         verify(mockDataSource.add(testTransaction)).called(1);
       });

       test('should return cache failure when data source throws CacheException', () async {
         // Arrange
         when(mockDataSource.add(testTransaction))
             .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

         // Act
         final result = await repository.add(testTransaction);

         // Assert
         expect(result, isA<Error<Transaction>>());
         result.when(
           success: (_) => fail('Should not succeed'),
           error: (failure) {
             expect(failure, isA<CacheFailure>());
           },
         );
       });
     });

    group('getById', () {
      test('should return transaction when found', () async {
         // Arrange
         when(mockDataSource.getById('test-id'))
             .thenAnswer((_) async => Result.success(testTransaction));

         // Act
         final result = await repository.getById('test-id');

         // Assert
         expect(result, isA<Success<Transaction?>>());
         result.when(
           success: (transaction) {
             expect(transaction!.id, testTransaction.id);
           },
           error: (_) => fail('Should not fail'),
         );
       });

      test('should return cache failure when data source fails', () async {
         // Arrange
         when(mockDataSource.getById('test-id'))
             .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

         // Act
         final result = await repository.getById('test-id');

         // Assert
         expect(result, isA<Error<Transaction?>>());
         result.when(
           success: (_) => fail('Should not succeed'),
           error: (failure) {
             expect(failure, isA<CacheFailure>());
           },
         );
       });
    });

    group('Balance Methods', () {
      const accountId1 = 'account1';
      const accountId2 = 'account2';

      final testAccount1 = Account(
        id: accountId1,
        name: 'Test Account 1',
        type: AccountType.bankAccount,
        cachedBalance: 1000.0,
      );

      final testAccount2 = Account(
        id: accountId2,
        name: 'Test Account 2',
        type: AccountType.bankAccount,
        cachedBalance: 500.0,
      );

      final incomeTransaction = Transaction(
        id: 'income1',
        title: 'Salary',
        amount: 2000.0,
        type: TransactionType.income,
        date: DateTime(2025, 10, 1),
        categoryId: 'salary',
        accountId: accountId1,
      );

      final expenseTransaction = Transaction(
        id: 'expense1',
        title: 'Groceries',
        amount: 100.0,
        type: TransactionType.expense,
        date: DateTime(2025, 10, 2),
        categoryId: 'food',
        accountId: accountId1,
      );

      final transferTransaction = Transaction(
        id: 'transfer1',
        title: 'Transfer to savings',
        amount: 500.0,
        type: TransactionType.transfer,
        date: DateTime(2025, 10, 3),
        categoryId: 'transfer',
        accountId: accountId1,
        toAccountId: accountId2,
        transferFee: 5.0,
      );

      group('getByAccountId', () {
        test('should return transactions for specific account including transfers', () async {
          // Arrange
          final allTransactions = [incomeTransaction, expenseTransaction, transferTransaction];
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.success(allTransactions));

          // Act
          final result = await repository.getByAccountId(accountId1);

          // Assert
          expect(result, isA<Success<List<Transaction>>>());
          result.when(
            success: (transactions) {
              expect(transactions.length, 3);
              expect(transactions.map((t) => t.id), containsAll(['income1', 'expense1', 'transfer1']));
              // Should be sorted by date (newest first)
              expect(transactions.first.date.isAfter(transactions.last.date), true);
            },
            error: (_) => fail('Should not fail'),
          );
          verify(mockDataSource.getAll()).called(1);
        });

        test('should return transactions for destination account in transfers', () async {
          // Arrange
          final allTransactions = [transferTransaction];
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.success(allTransactions));

          // Act
          final result = await repository.getByAccountId(accountId2);

          // Assert
          expect(result, isA<Success<List<Transaction>>>());
          result.when(
            success: (transactions) {
              expect(transactions.length, 1);
              expect(transactions.first.id, 'transfer1');
            },
            error: (_) => fail('Should not fail'),
          );
        });

        test('should return empty list for account with no transactions', () async {
          // Arrange
          final allTransactions = [incomeTransaction];
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.success(allTransactions));

          // Act
          final result = await repository.getByAccountId('nonexistent');

          // Assert
          expect(result, isA<Success<List<Transaction>>>());
          result.when(
            success: (transactions) {
              expect(transactions, isEmpty);
            },
            error: (_) => fail('Should not fail'),
          );
        });

        test('should return failure when data source fails', () async {
          // Arrange
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

          // Act
          final result = await repository.getByAccountId(accountId1);

          // Assert
          expect(result, isA<Error<List<Transaction>>>());
          result.when(
            success: (_) => fail('Should not succeed'),
            error: (failure) => expect(failure, isA<CacheFailure>()),
          );
        });
      });

      group('getCalculatedBalance', () {
        test('should calculate correct balance from transactions', () async {
          // Arrange
          final transactions = [incomeTransaction, expenseTransaction]; // 2000 - 100 = 1900
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.success([incomeTransaction, expenseTransaction]));

          // Act
          final result = await repository.getCalculatedBalance(accountId1);

          // Assert
          expect(result, isA<Success<double>>());
          result.when(
            success: (balance) => expect(balance, 1900.0),
            error: (_) => fail('Should not fail'),
          );
        });

        test('should handle transfer transactions correctly', () async {
          // Arrange - transfer from account1 to account2: account1 should be -505 (amount + fee)
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.success([transferTransaction]));

          // Act
          final result = await repository.getCalculatedBalance(accountId1);

          // Assert
          expect(result, isA<Success<double>>());
          result.when(
            success: (balance) => expect(balance, -505.0), // -500 - 5 fee
            error: (_) => fail('Should not fail'),
          );
        });

        test('should handle destination account in transfers', () async {
          // Arrange - transfer to account2: account2 should receive +500
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.success([transferTransaction]));

          // Act
          final result = await repository.getCalculatedBalance(accountId2);

          // Assert
          expect(result, isA<Success<double>>());
          result.when(
            success: (balance) => expect(balance, 500.0),
            error: (_) => fail('Should not fail'),
          );
        });

        test('should return zero for account with no transactions', () async {
          // Arrange
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.success([]));

          // Act
          final result = await repository.getCalculatedBalance(accountId1);

          // Assert
          expect(result, isA<Success<double>>());
          result.when(
            success: (balance) => expect(balance, 0.0),
            error: (_) => fail('Should not fail'),
          );
        });

        test('should return failure when data source fails', () async {
          // Arrange
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

          // Act
          final result = await repository.getCalculatedBalance(accountId1);

          // Assert
          expect(result, isA<Error<double>>());
          result.when(
            success: (_) => fail('Should not succeed'),
            error: (failure) => expect(failure, isA<CacheFailure>()),
          );
        });
      });

      group('getBalancesByAccount', () {
        test('should calculate balances for all accounts', () async {
          // Arrange
          final accounts = [testAccount1, testAccount2];
          final transactions = [incomeTransaction, expenseTransaction, transferTransaction];
          // account1: +2000 -100 -505 = 1395
          // account2: +500 = 500

          when(mockAccountRepository.getAll())
              .thenAnswer((_) async => Result.success(accounts));
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.success(transactions));

          // Act
          final result = await repository.getBalancesByAccount();

          // Assert
          expect(result, isA<Success<Map<String, double>>>());
          result.when(
            success: (balances) {
              expect(balances.length, 2);
              expect(balances[accountId1], 1395.0); // 2000 - 100 - 505
              expect(balances[accountId2], 500.0);  // +500 from transfer
            },
            error: (_) => fail('Should not fail'),
          );
        });

        test('should initialize all accounts with zero balance', () async {
          // Arrange
          final accounts = [testAccount1];
          when(mockAccountRepository.getAll())
              .thenAnswer((_) async => Result.success(accounts));
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.success([]));

          // Act
          final result = await repository.getBalancesByAccount();

          // Assert
          expect(result, isA<Success<Map<String, double>>>());
          result.when(
            success: (balances) {
              expect(balances[accountId1], 0.0);
            },
            error: (_) => fail('Should not fail'),
          );
        });

        test('should return failure when account repository fails', () async {
          // Arrange
          when(mockAccountRepository.getAll())
              .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

          // Act
          final result = await repository.getBalancesByAccount();

          // Assert
          expect(result, isA<Error<Map<String, double>>>());
          result.when(
            success: (_) => fail('Should not succeed'),
            error: (failure) => expect(failure, isA<CacheFailure>()),
          );
        });

        test('should return failure when transaction data source fails', () async {
          // Arrange
          final accounts = [testAccount1];
          when(mockAccountRepository.getAll())
              .thenAnswer((_) async => Result.success(accounts));
          when(mockDataSource.getAll())
              .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

          // Act
          final result = await repository.getBalancesByAccount();

          // Assert
          expect(result, isA<Error<Map<String, double>>>());
          result.when(
            success: (_) => fail('Should not succeed'),
            error: (failure) => expect(failure, isA<CacheFailure>()),
          );
        });
      });
    });
  });
}