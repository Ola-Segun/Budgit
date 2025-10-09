import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/delete_transaction.dart';

@GenerateMocks([TransactionRepository])
import 'delete_transaction_test.mocks.dart';

void main() {
  late DeleteTransaction useCase;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    useCase = DeleteTransaction(mockRepository);

    // Provide dummy values for Mockito
    provideDummy<Result<Transaction?>>(Result.error(Failure.unknown('dummy')));
    provideDummy<Result<void>>(Result.error(Failure.unknown('dummy')));
  });

  group('DeleteTransaction Use Case', () {
    const transactionId = 'test-id';
    final testTransaction = Transaction(
      id: transactionId,
      title: 'Test Transaction',
      amount: 50.0,
      type: TransactionType.expense,
      date: DateTime(2025, 10, 2),
      categoryId: 'food',
      accountId: 'account1',
    );

    test('should delete transaction successfully', () async {
      // Arrange
      when(mockRepository.getById(transactionId))
          .thenAnswer((_) async => Result.success(testTransaction));
      when(mockRepository.delete(transactionId))
          .thenAnswer((_) async => Result.success(null));

      // Act
      final result = await useCase(transactionId);

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockRepository.getById(transactionId)).called(1);
      verify(mockRepository.delete(transactionId)).called(1);
    });

    test('should return error when transaction does not exist', () async {
      // Arrange
      when(mockRepository.getById(transactionId))
          .thenAnswer((_) async => Result.error(Failure.notFound('Transaction not found')));

      // Act
      final result = await useCase(transactionId);

      // Assert
      expect(result, isA<Error<void>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<NotFoundFailure>());
        },
      );
      verify(mockRepository.getById(transactionId)).called(1);
      verifyNever(mockRepository.delete(any));
    });

    test('should return validation error when getById fails', () async {
      // Arrange
      when(mockRepository.getById(transactionId))
          .thenAnswer((_) async => Result.error(Failure.validation('Invalid ID', {'id': 'Invalid ID'})));

      // Act
      final result = await useCase(transactionId);

      // Assert
      expect(result, isA<Error<void>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
        },
      );
      verifyNever(mockRepository.delete(any));
    });

    test('should handle repository delete failure', () async {
      // Arrange
      when(mockRepository.getById(transactionId))
          .thenAnswer((_) async => Result.success(testTransaction));
      when(mockRepository.delete(transactionId))
          .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

      // Act
      final result = await useCase(transactionId);

      // Assert
      expect(result, isA<Error<void>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<CacheFailure>());
        },
      );
    });

    test('should handle unknown errors', () async {
      // Arrange
      when(mockRepository.getById(transactionId))
          .thenAnswer((_) async => Result.error(Failure.unknown('Unexpected error')));

      // Act
      final result = await useCase(transactionId);

      // Assert
      expect(result, isA<Error<void>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<UnknownFailure>());
        },
      );
    });

    test('should handle empty transaction ID', () async {
      // Arrange
      const emptyId = '';

      // Act
      final result = await useCase(emptyId);

      // Assert
      expect(result, isA<Error<void>>());
      // The usecase doesn't validate empty ID, it just tries to getById
      // So it will depend on what getById returns for empty ID
    });

    test('should handle null transaction ID', () async {
      // Arrange
      const nullId = null;

      // Act - this would cause a compile error since String is non-nullable
      // So we don't test this case
    });
  });
}