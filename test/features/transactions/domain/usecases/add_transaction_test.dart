import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/core/error/failures.dart';
import '../../../../../lib/core/error/result.dart';
import '../../../../../lib/features/transactions/domain/entities/transaction.dart';
import '../../../../../lib/features/transactions/domain/repositories/transaction_repository.dart';
import '../../../../../lib/features/transactions/domain/usecases/add_transaction.dart';

// Mock classes
class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  late AddTransaction useCase;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    useCase = AddTransaction(mockRepository);
  });

  group('AddTransaction Use Case', () {
    final testTransaction = Transaction(
      id: 'test-id',
      title: 'Test Transaction',
      amount: 50.0,
      type: TransactionType.expense,
      date: DateTime(2025, 10, 2),
      categoryId: 'food',
    );

    test('should add transaction successfully', () async {
      // Arrange
      when(mockRepository.add(any as Transaction))
          .thenAnswer((_) async => Result.success(testTransaction));

      // Act
      final result = await useCase(testTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockRepository.add(testTransaction)).called(1);
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
      verifyNever(mockRepository.add(any as Transaction));
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
      verifyNever(mockRepository.add(any as Transaction));
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
      verifyNever(mockRepository.add(any as Transaction));
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
      verifyNever(mockRepository.add(any as Transaction));
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
      verifyNever(mockRepository.add(any as Transaction));
    });

    test('should handle repository failure', () async {
      // Arrange
      when(mockRepository.add(any as Transaction))
          .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

      // Act
      final result = await useCase(testTransaction);

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
      when(mockRepository.add(any as Transaction))
          .thenThrow(Exception('Unexpected error'));

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
      when(mockRepository.add(any as Transaction))
          .thenAnswer((_) async => Result.success(incomeTransaction));

      // Act
      final result = await useCase(incomeTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockRepository.add(incomeTransaction)).called(1);
    });

    test('should accept transaction with description and tags', () async {
      // Arrange
      final detailedTransaction = testTransaction.copyWith(
        description: 'Lunch at restaurant',
        tags: ['business', 'client_meeting'],
      );
      when(mockRepository.add(any as Transaction))
          .thenAnswer((_) async => Result.success(detailedTransaction));

      // Act
      final result = await useCase(detailedTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockRepository.add(detailedTransaction)).called(1);
    });

    test('should accept transaction with receipt URL', () async {
      // Arrange
      final receiptTransaction = testTransaction.copyWith(
        receiptUrl: 'receipts/lunch_receipt.jpg',
      );
      when(mockRepository.add(any as Transaction))
          .thenAnswer((_) async => Result.success(receiptTransaction));

      // Act
      final result = await useCase(receiptTransaction);

      // Assert
      expect(result, isA<Success<Transaction>>());
      verify(mockRepository.add(receiptTransaction)).called(1);
    });
  });
}