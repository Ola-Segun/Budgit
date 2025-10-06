import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/transactions/data/datasources/transaction_hive_datasource.dart';
import 'package:budget_tracker/features/transactions/data/models/transaction_dto.dart';
import 'package:budget_tracker/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';

@GenerateMocks([TransactionHiveDataSource])
import 'transaction_repository_impl_test.mocks.dart';

void main() {
  late TransactionRepositoryImpl repository;
  late MockTransactionHiveDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockTransactionHiveDataSource();
    repository = TransactionRepositoryImpl(mockDataSource);
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
        when(mockDataSource.getAll()).thenThrow(Exception('Unexpected error'));

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
  });
}