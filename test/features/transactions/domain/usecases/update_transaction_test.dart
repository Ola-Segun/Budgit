import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/update_transaction.dart';

import '../../../../test_setup.dart';

@GenerateMocks([TransactionRepository, AccountRepository])
import 'update_transaction_test.mocks.dart';

void main() {
   late UpdateTransaction useCase;
   late MockTransactionRepository mockTransactionRepository;
   late MockAccountRepository mockAccountRepository;

   setUpAll(() {
     setupMockitoDummies();
   });

   setUp(() {
     mockTransactionRepository = MockTransactionRepository();
     mockAccountRepository = MockAccountRepository();
     useCase = UpdateTransaction(mockTransactionRepository, mockAccountRepository);
   });

   final testAccount = Account(
     id: 'account1',
     name: 'Test Account',
     type: AccountType.bankAccount,
     cachedBalance: 1000.0,
   );

  group('UpdateTransaction Use Case', () {
    final testTransaction = Transaction(
      id: 'test-id',
      title: 'Test Transaction',
      amount: 50.0,
      type: TransactionType.expense,
      date: DateTime(2025, 10, 2),
      categoryId: 'food',
      accountId: 'account1',
    );

    final updatedTransaction = testTransaction.copyWith(
      title: 'Updated Transaction',
      amount: 75.0,
    );

    test('should update transaction successfully', () async {
      // Arrange
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));
      when(mockTransactionRepository.update(updatedTransaction))
          .thenAnswer((_) async => Result.success(updatedTransaction));
      when(mockAccountRepository.getById(testAccount.id))
          .thenAnswer((_) async => Result.success(testAccount));
      when(mockAccountRepository.update(any))
          .thenAnswer((_) async => Result.success(testAccount));

      // Act
      final result = await useCase(updatedTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      result.when(
        success: (transaction) {
          expect(transaction.title, 'Updated Transaction');
          expect(transaction.amount, 75.0);
        },
        error: (_) => fail('Should not error'),
      );
      verify(mockTransactionRepository.getById(testTransaction.id)).called(1);
      verify(mockTransactionRepository.update(updatedTransaction)).called(1);
      verify(mockAccountRepository.getById(testAccount.id)).called(1);
      verify(mockAccountRepository.update(any)).called(1);
    });

    test('should return validation error for empty title', () async {
      // Arrange
      final invalidTransaction = updatedTransaction.copyWith(title: '');
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));

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
      verify(mockTransactionRepository.getById(testTransaction.id)).called(1);
      verifyNever(mockTransactionRepository.update(any as Transaction));
    });

    test('should return validation error for zero amount', () async {
      // Arrange
      final invalidTransaction = updatedTransaction.copyWith(amount: 0);
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));

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
      verifyNever(mockTransactionRepository.update(any as Transaction));
    });

    test('should return validation error for negative amount', () async {
      // Arrange
      final invalidTransaction = updatedTransaction.copyWith(amount: -50);
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));

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
      verifyNever(mockTransactionRepository.update(any));
    });

    test('should return validation error for empty category', () async {
      // Arrange
      final invalidTransaction = updatedTransaction.copyWith(categoryId: '');
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));

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
      verifyNever(mockTransactionRepository.update(any));
    });

    test('should return validation error for future date', () async {
      // Arrange
      final futureDate = DateTime.now().add(const Duration(days: 2));
      final invalidTransaction = updatedTransaction.copyWith(date: futureDate);
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));

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
      verifyNever(mockTransactionRepository.update(any));
    });

    test('should return error when transaction does not exist', () async {
      // Arrange
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.error(Failure.notFound('Transaction not found')));

      // Act
      final result = await useCase(updatedTransaction);

      // Assert
      expect(result, isA<Error<Transaction>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<NotFoundFailure>());
        },
      );
      verify(mockTransactionRepository.getById(testTransaction.id)).called(1);
      verifyNever(mockTransactionRepository.update(any as Transaction));
    });

    test('should return validation error when getById fails', () async {
      // Arrange
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.error(Failure.validation('Invalid ID', {'id': 'Invalid ID'})));

      // Act
      final result = await useCase(updatedTransaction);

      // Assert
      expect(result, isA<Error<Transaction>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
        },
      );
      verifyNever(mockTransactionRepository.update(any as Transaction));
    });

    test('should handle repository update failure', () async {
      // Arrange
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));
      when(mockTransactionRepository.update(updatedTransaction))
          .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

      // Act
      final result = await useCase(updatedTransaction);

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
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.error(Failure.unknown('Unexpected error')));

      // Act
      final result = await useCase(updatedTransaction);

      // Assert
      expect(result, isA<Error<Transaction>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<UnknownFailure>());
        },
      );
    });

    test('should accept valid income transaction update', () async {
      // Arrange
      final incomeTransaction = testTransaction.copyWith(
        type: TransactionType.income,
        amount: 1000.0,
        categoryId: 'salary',
      );
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));
      when(mockTransactionRepository.update(incomeTransaction))
          .thenAnswer((_) async => Result.success(incomeTransaction));

      // Act
      final result = await useCase(incomeTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockTransactionRepository.update(incomeTransaction)).called(1);
    });

    test('should accept transaction with description and tags', () async {
      // Arrange
      final detailedTransaction = updatedTransaction.copyWith(
        description: 'Updated lunch',
        tags: ['business', 'updated'],
      );
      when(mockTransactionRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));
      when(mockTransactionRepository.update(detailedTransaction))
          .thenAnswer((_) async => Result.success(detailedTransaction));

      // Act
      final result = await useCase(detailedTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockTransactionRepository.update(detailedTransaction)).called(1);
    });
  });
}