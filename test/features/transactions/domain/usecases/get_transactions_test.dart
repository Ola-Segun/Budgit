import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/core/error/failures.dart';
import '../../../../../lib/core/error/result.dart';
import '../../../../../lib/features/transactions/domain/entities/transaction.dart';
import '../../../../../lib/features/transactions/domain/repositories/transaction_repository.dart';
import '../../../../../lib/features/transactions/domain/usecases/get_transactions.dart';

// Mock classes
class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  late GetTransactions useCase;
  late MockTransactionRepository mockRepository;

  setUp(() {
    mockRepository = MockTransactionRepository();
    useCase = GetTransactions(mockRepository);
  });

  group('GetTransactions Use Case', () {
    final testTransactions = [
      Transaction(
        id: '1',
        title: 'Transaction 1',
        amount: 50.0,
        type: TransactionType.expense,
        date: DateTime(2025, 10, 1),
        categoryId: 'food',
      ),
      Transaction(
        id: '2',
        title: 'Transaction 2',
        amount: 100.0,
        type: TransactionType.income,
        date: DateTime(2025, 10, 2),
        categoryId: 'salary',
      ),
    ];

    group('call() - Get all transactions', () {
      test('should return all transactions successfully', () async {
        // Arrange
        when(mockRepository.getAll())
            .thenAnswer((_) async => Result.success(testTransactions));

        // Act
        final result = await useCase();

        // Assert
        expect(result, isA<Success<List<Transaction>>>());
        result.when(
          success: (transactions) {
            expect(transactions, testTransactions);
            expect(transactions.length, 2);
          },
          error: (_) => fail('Should not error'),
        );
        verify(mockRepository.getAll()).called(1);
      });

      test('should return empty list when no transactions', () async {
        // Arrange
        when(mockRepository.getAll())
            .thenAnswer((_) async => Result.success(<Transaction>[]));

        // Act
        final result = await useCase();

        // Assert
        expect(result, isA<Success<List<Transaction>>>());
        result.when(
          success: (transactions) {
            expect(transactions, isEmpty);
          },
          error: (_) => fail('Should not error'),
        );
      });

      test('should handle repository failure', () async {
        // Arrange
        when(mockRepository.getAll())
            .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

        // Act
        final result = await useCase();

        // Assert
        expect(result, isA<Error<List<Transaction>>>());
        result.when(
          success: (_) => fail('Should not succeed'),
          error: (failure) {
            expect(failure, isA<CacheFailure>());
          },
        );
      });

      test('should handle unknown errors', () async {
        // Arrange
        when(mockRepository.getAll()).thenThrow(Exception('Unexpected error'));

        // Act
        final result = await useCase();

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

    group('getByDateRange()', () {
      final startDate = DateTime(2025, 10, 1);
      final endDate = DateTime(2025, 10, 31);

      test('should return transactions in date range', () async {
        // Arrange
        when(mockRepository.getByDateRange(startDate, endDate))
            .thenAnswer((_) async => Result.success(testTransactions));

        // Act
        final result = await useCase.getByDateRange(startDate, endDate);

        // Assert
        expect(result, isA<Success<List<Transaction>>>());
        verify(mockRepository.getByDateRange(startDate, endDate)).called(1);
      });

      test('should handle date range errors', () async {
        // Arrange
        when(mockRepository.getByDateRange(startDate, endDate))
            .thenThrow(Exception('Date range error'));

        // Act
        final result = await useCase.getByDateRange(startDate, endDate);

        // Assert
        expect(result, isA<Error<List<Transaction>>>());
      });
    });

    group('getByCategory()', () {
      const categoryId = 'food';

      test('should return transactions by category', () async {
        // Arrange
        final foodTransactions = testTransactions.where((t) => t.categoryId == categoryId).toList();
        when(mockRepository.getByCategory(categoryId))
            .thenAnswer((_) async => Result.success(foodTransactions));

        // Act
        final result = await useCase.getByCategory(categoryId);

        // Assert
        expect(result, isA<Success<List<Transaction>>>());
        result.when(
          success: (transactions) {
            expect(transactions.every((t) => t.categoryId == categoryId), true);
          },
          error: (_) => fail('Should not error'),
        );
        verify(mockRepository.getByCategory(categoryId)).called(1);
      });
    });

    group('getByType()', () {
      test('should return expense transactions', () async {
        // Arrange
        final expenseTransactions = testTransactions.where((t) => t.type == TransactionType.expense).toList();
        when(mockRepository.getByType(TransactionType.expense))
            .thenAnswer((_) async => Result.success(expenseTransactions));

        // Act
        final result = await useCase.getByType(TransactionType.expense);

        // Assert
        expect(result, isA<Success<List<Transaction>>>());
        result.when(
          success: (transactions) {
            expect(transactions.every((t) => t.type == TransactionType.expense), true);
          },
          error: (_) => fail('Should not error'),
        );
        verify(mockRepository.getByType(TransactionType.expense)).called(1);
      });

      test('should return income transactions', () async {
        // Arrange
        final incomeTransactions = testTransactions.where((t) => t.type == TransactionType.income).toList();
        when(mockRepository.getByType(TransactionType.income))
            .thenAnswer((_) async => Result.success(incomeTransactions));

        // Act
        final result = await useCase.getByType(TransactionType.income);

        // Assert
        expect(result, isA<Success<List<Transaction>>>());
        result.when(
          success: (transactions) {
            expect(transactions.every((t) => t.type == TransactionType.income), true);
          },
          error: (_) => fail('Should not error'),
        );
      });
    });

    group('search()', () {
      test('should search transactions with valid query', () async {
        // Arrange
        const query = 'Transaction';
        when(mockRepository.search(query))
            .thenAnswer((_) async => Result.success(testTransactions));

        // Act
        final result = await useCase.search(query);

        // Assert
        expect(result, isA<Success<List<Transaction>>>());
        verify(mockRepository.search(query)).called(1);
      });

      test('should return all transactions for empty query', () async {
        // Arrange
        const query = '   ';
        when(mockRepository.getAll())
            .thenAnswer((_) async => Result.success(testTransactions));

        // Act
        final result = await useCase.search(query);

        // Assert
        expect(result, isA<Success<List<Transaction>>>());
        verify(mockRepository.getAll()).called(1);
        verifyNever(mockRepository.search(any as String));
      });
    });

    group('getCount()', () {
      test('should return transaction count', () async {
        // Arrange
        const count = 5;
        when(mockRepository.getCount())
            .thenAnswer((_) async => Result.success(count));

        // Act
        final result = await useCase.getCount();

        // Assert
        expect(result, isA<Success<int>>());
        result.when(
          success: (c) => expect(c, count),
          error: (_) => fail('Should not error'),
        );
        verify(mockRepository.getCount()).called(1);
      });
    });

    group('getTotalAmount()', () {
      final startDate = DateTime(2025, 10, 1);
      final endDate = DateTime(2025, 10, 31);
      const totalAmount = 150.0;

      test('should return total amount for date range', () async {
        // Arrange
        when(mockRepository.getTotalAmount(startDate, endDate))
            .thenAnswer((_) async => Result.success(totalAmount));

        // Act
        final result = await useCase.getTotalAmount(startDate, endDate);

        // Assert
        expect(result, isA<Success<double>>());
        result.when(
          success: (amount) => expect(amount, totalAmount),
          error: (_) => fail('Should not error'),
        );
        verify(mockRepository.getTotalAmount(startDate, endDate)).called(1);
      });

      test('should return total amount for specific type', () async {
        // Arrange
        const expenseTotal = 50.0;
        when(mockRepository.getTotalAmount(startDate, endDate, type: TransactionType.expense))
            .thenAnswer((_) async => Result.success(expenseTotal));

        // Act
        final result = await useCase.getTotalAmount(startDate, endDate, type: TransactionType.expense);

        // Assert
        expect(result, isA<Success<double>>());
        result.when(
          success: (amount) => expect(amount, expenseTotal),
          error: (_) => fail('Should not error'),
        );
        verify(mockRepository.getTotalAmount(startDate, endDate, type: TransactionType.expense)).called(1);
      });
    });
  });
}