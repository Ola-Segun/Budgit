import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/core/error/failures.dart';
import '../../../../../lib/core/error/result.dart';
import '../../../../../lib/features/transactions/domain/entities/transaction.dart';
import '../../../../../lib/features/transactions/domain/repositories/transaction_repository.dart';
import '../../../../../lib/features/transactions/domain/usecases/update_transaction.dart';

// Mock classes
class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  late UpdateTransaction useCase;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    useCase = UpdateTransaction(mockRepository);
  });

  group('UpdateTransaction Use Case', () {
    final testTransaction = Transaction(
      id: 'test-id',
      title: 'Test Transaction',
      amount: 50.0,
      type: TransactionType.expense,
      date: DateTime(2025, 10, 2),
      categoryId: 'food',
    );

    final updatedTransaction = testTransaction.copyWith(
      title: 'Updated Transaction',
      amount: 75.0,
    );

    test('should update transaction successfully', () async {
      // Arrange
      when(mockRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));
      when(mockRepository.update(updatedTransaction))
          .thenAnswer((_) async => Result.success(updatedTransaction));

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
      verify(mockRepository.getById(testTransaction.id)).called(1);
      verify(mockRepository.update(updatedTransaction)).called(1);
    });

    test('should return validation error for empty title', () async {
      // Arrange
      final invalidTransaction = updatedTransaction.copyWith(title: '');
      when(mockRepository.getById(testTransaction.id))
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
      verify(mockRepository.getById(testTransaction.id)).called(1);
      verifyNever(mockRepository.update(any as Transaction));
    });

    test('should return validation error for zero amount', () async {
      // Arrange
      final invalidTransaction = updatedTransaction.copyWith(amount: 0);
      when(mockRepository.getById(testTransaction.id))
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
      verifyNever(mockRepository.update(any as Transaction));
    });

    test('should return validation error for negative amount', () async {
      // Arrange
      final invalidTransaction = updatedTransaction.copyWith(amount: -50);
      when(mockRepository.getById(testTransaction.id))
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
      verifyNever(mockRepository.update(any as Transaction));
    });

    test('should return validation error for empty category', () async {
      // Arrange
      final invalidTransaction = updatedTransaction.copyWith(categoryId: '');
      when(mockRepository.getById(testTransaction.id))
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
      verifyNever(mockRepository.update(any as Transaction));
    });

    test('should return validation error for future date', () async {
      // Arrange
      final futureDate = DateTime.now().add(const Duration(days: 2));
      final invalidTransaction = updatedTransaction.copyWith(date: futureDate);
      when(mockRepository.getById(testTransaction.id))
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
      verifyNever(mockRepository.update(any as Transaction));
    });

    test('should return error when transaction does not exist', () async {
      // Arrange
      when(mockRepository.getById(testTransaction.id))
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
      verify(mockRepository.getById(testTransaction.id)).called(1);
      verifyNever(mockRepository.update(any as Transaction));
    });

    test('should return validation error when getById fails', () async {
      // Arrange
      when(mockRepository.getById(testTransaction.id))
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
      verifyNever(mockRepository.update(any as Transaction));
    });

    test('should handle repository update failure', () async {
      // Arrange
      when(mockRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));
      when(mockRepository.update(updatedTransaction))
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
      when(mockRepository.getById(testTransaction.id))
          .thenThrow(Exception('Unexpected error'));

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
      when(mockRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));
      when(mockRepository.update(incomeTransaction))
          .thenAnswer((_) async => Result.success(incomeTransaction));

      // Act
      final result = await useCase(incomeTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockRepository.update(incomeTransaction)).called(1);
    });

    test('should accept transaction with description and tags', () async {
      // Arrange
      final detailedTransaction = updatedTransaction.copyWith(
        description: 'Updated lunch',
        tags: ['business', 'updated'],
      );
      when(mockRepository.getById(testTransaction.id))
          .thenAnswer((_) async => Result.success(testTransaction));
      when(mockRepository.update(detailedTransaction))
          .thenAnswer((_) async => Result.success(detailedTransaction));

      // Act
      final result = await useCase(detailedTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockRepository.update(detailedTransaction)).called(1);
    });
  });
}