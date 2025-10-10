import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/add_transaction.dart';

import 'add_transaction_test.mocks.dart';

@GenerateMocks([TransactionRepository, AccountRepository])

void main() {
   late AddTransaction useCase;
   late MockTransactionRepository mockTransactionRepository;
   late MockAccountRepository mockAccountRepository;

   setUpAll(() {
     provideDummy<Result<Transaction>>(Result.error(Failure.unknown('Dummy error')));
     provideDummy<Result<Account?>>(Result.error(Failure.unknown('Dummy error')));
     provideDummy<Result<Account>>(Result.error(Failure.unknown('Dummy error')));
   });

   setUp(() {
     mockTransactionRepository = MockTransactionRepository();
     mockAccountRepository = MockAccountRepository();
     useCase = AddTransaction(mockTransactionRepository, mockAccountRepository);
   });

  group('AddTransaction Use Case', () {
    const accountId = 'account1';
    final testTransaction = Transaction(
      id: 'test-id',
      title: 'Test Transaction',
      amount: 50.0,
      type: TransactionType.expense,
      date: DateTime(2025, 10, 2),
      categoryId: 'food',
      accountId: accountId,
    );
    final testAccount = Account(
      id: accountId,
      name: 'Test Account',
      type: AccountType.bankAccount,
      cachedBalance: 1000.0,
    );

    test('should add transaction successfully with balance update', () async {
      // Arrange
      when(mockTransactionRepository.add(any))
          .thenAnswer((_) async => Result.success(testTransaction));
      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(testAccount));
      when(mockAccountRepository.update(any))
          .thenAnswer((_) async => Result.success(testAccount));

      // Act
      final result = await useCase(testTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockTransactionRepository.add(testTransaction)).called(1);
      verify(mockAccountRepository.getById(accountId)).called(2); // Once for validation, once for update
      verify(mockAccountRepository.update(any)).called(1);
    });

    test('should return validation error for empty title', () async {
      // Arrange
      final invalidTransaction = testTransaction.copyWith(title: '');

      // Act
      final result = await useCase(invalidTransaction);

      // Assert
      expect(result, isA<Error<Transaction>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('title'));
        },
      );
      verifyNever(mockTransactionRepository.add(any));
    });

    test('should return validation error for zero amount', () async {
      // Arrange
      final invalidTransaction = testTransaction.copyWith(amount: 0);

      // Act
      final result = await useCase(invalidTransaction);

      // Assert
      expect(result, isA<Error<Transaction>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('amount'));
        },
      );
      verifyNever(mockTransactionRepository.add(any));
    });

    test('should return validation error for negative amount', () async {
      // Arrange
      final invalidTransaction = testTransaction.copyWith(amount: -50);

      // Act
      final result = await useCase(invalidTransaction);

      // Assert
      expect(result, isA<Error<Transaction>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('amount'));
        },
      );
      verifyNever(mockTransactionRepository.add(any));
      verifyZeroInteractions(mockAccountRepository);
    });

    test('should return validation error for empty category', () async {
      // Arrange
      final invalidTransaction = testTransaction.copyWith(categoryId: '');

      // Act
      final result = await useCase(invalidTransaction);

      // Assert
      expect(result, isA<Error<Transaction>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('category'));
        },
      );
      verifyNever(mockTransactionRepository.add(any));
    });

    test('should return validation error for future date', () async {
      // Arrange
      final futureDate = DateTime.now().add(const Duration(days: 2));
      final invalidTransaction = testTransaction.copyWith(date: futureDate);

      // Act
      final result = await useCase(invalidTransaction);

      // Assert
      expect(result, isA<Error<Transaction>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('future'));
        },
      );
      verifyNever(mockTransactionRepository.add(any));
    });

    test('should handle repository failure', () async {
      // Arrange - Use income transaction to avoid insufficient funds check
      final incomeTransaction = testTransaction.copyWith(type: TransactionType.income);
      when(mockTransactionRepository.add(any))
          .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

      // Act
      final result = await useCase(incomeTransaction);

      // Assert
      expect(result, isA<Error<Transaction>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<CacheFailure>());
        },
      );
    });

    test('should handle unknown errors', () async {
      // Arrange
      when(mockTransactionRepository.add(any))
          .thenAnswer((_) async => Result.error(Failure.unknown('Unexpected error')));

      // Act
      final result = await useCase(testTransaction);

      // Assert
      expect(result, isA<Error<Transaction>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<UnknownFailure>());
        },
      );
    });

    test('should accept valid income transaction', () async {
      // Arrange
      final incomeTransaction = testTransaction.copyWith(
        type: TransactionType.income,
        amount: 1000.0,
        categoryId: 'salary',
      );
      when(mockTransactionRepository.add(any))
          .thenAnswer((_) async => Result.success(incomeTransaction));
      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(testAccount));
      when(mockAccountRepository.update(any))
          .thenAnswer((_) async => Result.success(testAccount));

      // Act
      final result = await useCase(incomeTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockTransactionRepository.add(incomeTransaction)).called(1);
      verify(mockAccountRepository.getById(accountId)).called(1); // Only once for income (no insufficient funds check)
    });

    test('should accept transaction with description and tags', () async {
      // Arrange
      final detailedTransaction = testTransaction.copyWith(
        description: 'Lunch at restaurant',
        tags: ['business', 'client_meeting'],
      );
      when(mockTransactionRepository.add(any))
          .thenAnswer((_) async => Result.success(detailedTransaction));
      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(testAccount));
      when(mockAccountRepository.update(any))
          .thenAnswer((_) async => Result.success(testAccount));

      // Act
      final result = await useCase(detailedTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockTransactionRepository.add(detailedTransaction)).called(1);
    });

    test('should accept transaction with receipt URL', () async {
      // Arrange
      final receiptTransaction = testTransaction.copyWith(
        receiptUrl: 'receipts/lunch_receipt.jpg',
      );
      when(mockTransactionRepository.add(any))
          .thenAnswer((_) async => Result.success(receiptTransaction));
      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(testAccount));
      when(mockAccountRepository.update(any))
          .thenAnswer((_) async => Result.success(testAccount));

      // Act
      final result = await useCase(receiptTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockTransactionRepository.add(receiptTransaction)).called(1);
    });

    group('Balance Updates', () {
      test('should increase account balance for income transactions', () async {
        // Arrange
        final incomeTransaction = testTransaction.copyWith(
          type: TransactionType.income,
          amount: 500.0,
          categoryId: 'salary',
        );
        final expectedBalance = testAccount.currentBalance + 500.0;

        when(mockTransactionRepository.add(any))
            .thenAnswer((_) async => Result.success(incomeTransaction));
        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(testAccount));
        when(mockAccountRepository.update(any))
            .thenAnswer((_) async => Result.success(testAccount));

        // Act
        final result = await useCase(incomeTransaction);

        // Assert
        expect(result, isA<Success<Transaction>>());
        verify(mockAccountRepository.update(argThat(
          predicate<Account>((account) => account.cachedBalance == expectedBalance)
        ))).called(1);
      });

      test('should decrease account balance for expense transactions', () async {
        // Arrange
        final expenseTransaction = testTransaction.copyWith(
          type: TransactionType.expense,
          amount: 100.0,
        );
        final expectedBalance = testAccount.currentBalance - 100.0;

        when(mockTransactionRepository.add(any))
            .thenAnswer((_) async => Result.success(expenseTransaction));
        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(testAccount));
        when(mockAccountRepository.update(any))
            .thenAnswer((_) async => Result.success(testAccount));

        // Act
        final result = await useCase(expenseTransaction);

        // Assert
        expect(result, isA<Success<Transaction>>());
        verify(mockAccountRepository.update(argThat(
          predicate<Account>((account) => account.cachedBalance == expectedBalance)
        ))).called(1);
      });

      test('should reject expense transactions with insufficient funds', () async {
        // Arrange
        final lowBalanceAccount = testAccount.copyWith(cachedBalance: 25.0);
        final expenseTransaction = testTransaction.copyWith(amount: 50.0);

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(lowBalanceAccount));

        // Act
        final result = await useCase(expenseTransaction);

        // Assert
        expect(result, isA<Error<Transaction>>());
        result.when(
          success: (_) => fail('Should not succeed'),
          error: (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, contains('Insufficient balance'));
          },
        );
        verifyNever(mockTransactionRepository.add(any));
      });

      test('should update both accounts atomically for transfer transactions', () async {
        // Arrange
        const destAccountId = 'account2';
        final destAccount = Account(
          id: destAccountId,
          name: 'Destination Account',
          type: AccountType.bankAccount,
          cachedBalance: 200.0,
        );

        final transferTransaction = testTransaction.copyWith(
          type: TransactionType.transfer,
          amount: 300.0,
          toAccountId: destAccountId,
          transferFee: 5.0,
        );

        final expectedSourceBalance = testAccount.currentBalance - 305.0; // amount + fee
        final expectedDestBalance = destAccount.currentBalance + 300.0; // amount only

        when(mockTransactionRepository.add(any))
            .thenAnswer((_) async => Result.success(transferTransaction));
        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(testAccount));
        when(mockAccountRepository.getById(destAccountId))
            .thenAnswer((_) async => Result.success(destAccount));
        when(mockAccountRepository.update(any))
            .thenAnswer((_) async => Result.success(testAccount));

        // Act
        final result = await useCase(transferTransaction);

        // Assert
        expect(result, isA<Success<Transaction>>());
        verify(mockAccountRepository.update(argThat(
          predicate<Account>((account) =>
            account.id == accountId && account.cachedBalance == expectedSourceBalance)
        ))).called(1);
        verify(mockAccountRepository.update(argThat(
          predicate<Account>((account) =>
            account.id == destAccountId && account.cachedBalance == expectedDestBalance)
        ))).called(1);
      });

      test('should reject transfer transactions with insufficient funds including fee', () async {
        // Arrange
        const destAccountId = 'account2';
        final lowBalanceAccount = testAccount.copyWith(cachedBalance: 100.0);
        final transferTransaction = testTransaction.copyWith(
          type: TransactionType.transfer,
          amount: 100.0,
          toAccountId: destAccountId,
          transferFee: 10.0, // Total required: 110.0
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(lowBalanceAccount));

        // Act
        final result = await useCase(transferTransaction);

        // Assert
        expect(result, isA<Error<Transaction>>());
        result.when(
          success: (_) => fail('Should not succeed'),
          error: (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, contains('Insufficient balance'));
          },
        );
        verifyNever(mockTransactionRepository.add(any));
      });

      test('should handle transfer to same account validation', () async {
        // Arrange
        final invalidTransfer = testTransaction.copyWith(
          type: TransactionType.transfer,
          toAccountId: accountId, // Same account
        );

        // Act
        final result = await useCase(invalidTransfer);

        // Assert
        expect(result, isA<Error<Transaction>>());
        result.when(
          success: (_) => fail('Should not succeed'),
          error: (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, contains('same account'));
          },
        );
        verifyNever(mockTransactionRepository.add(any));
      });

      test('should handle account not found during balance update', () async {
        // Arrange
        when(mockTransactionRepository.add(any))
            .thenAnswer((_) async => Result.success(testTransaction));
        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.error(Failure.notFound('Account not found')));

        // Act
        final result = await useCase(testTransaction);

        // Assert
        expect(result, isA<Error<Transaction>>());
        result.when(
          success: (_) => fail('Should not succeed'),
          error: (failure) => expect(failure, isA<NotFoundFailure>()),
        );
      });

      test('should handle balance update failure', () async {
        // Arrange
        when(mockTransactionRepository.add(any))
            .thenAnswer((_) async => Result.success(testTransaction));
        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(testAccount));
        when(mockAccountRepository.update(any))
            .thenAnswer((_) async => Result.error(Failure.cache('Update failed')));

        // Act
        final result = await useCase(testTransaction);

        // Assert
        expect(result, isA<Error<Transaction>>());
        result.when(
          success: (_) => fail('Should not succeed'),
          error: (failure) => expect(failure, isA<CacheFailure>()),
        );
      });

      test('should handle fallback to balance field for backward compatibility', () async {
        // Arrange
        final legacyAccount = Account(
          id: accountId,
          name: 'Legacy Account',
          type: AccountType.bankAccount,
          balance: 500.0, // Using legacy balance field
          cachedBalance: null,
        );
        final expectedBalance = 450.0; // 500 - 50

        when(mockTransactionRepository.add(any))
            .thenAnswer((_) async => Result.success(testTransaction));
        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(legacyAccount));
        when(mockAccountRepository.update(any))
            .thenAnswer((_) async => Result.success(legacyAccount));

        // Act
        final result = await useCase(testTransaction);

        // Assert
        expect(result, isA<Success<Transaction>>());
        verify(mockAccountRepository.update(argThat(
          predicate<Account>((account) => account.cachedBalance == expectedBalance)
        ))).called(1);
      });
    });
  });
}