import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_category_repository.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/get_categories.dart';

@GenerateMocks([TransactionCategoryRepository])
import 'get_categories_test.mocks.dart';

void main() {
  late GetCategories useCase;
  late MockTransactionCategoryRepository mockRepository;

  setUpAll(() {
    provideDummy<Result<List<TransactionCategory>>>(
      Result.error(Failure.unknown('dummy')),
    );
  });

  setUp(() {
    mockRepository = MockTransactionCategoryRepository();
    useCase = GetCategories(mockRepository);
  });

  group('GetCategories Use Case', () {
    final testCategories = [
      const TransactionCategory(
        id: 'food',
        name: 'Food & Dining',
        icon: 'restaurant',
        color: 0xFFF59E0B,
        type: TransactionType.expense,
      ),
      const TransactionCategory(
        id: 'salary',
        name: 'Salary',
        icon: 'work',
        color: 0xFF10B981,
        type: TransactionType.income,
      ),
    ];

    test('should return categories successfully', () async {
      // Arrange
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(testCategories));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, testCategories);
      verify(mockRepository.getAll()).called(1);
    });

    test('should return error when repository fails', () async {
      // Arrange
      final failure = Failure.cache('Database error');
      when(mockRepository.getAll()).thenAnswer((_) async => Result.error(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, failure);
      verify(mockRepository.getAll()).called(1);
    });

    test('should return unknown error on exception', () async {
      // Arrange
      when(mockRepository.getAll()).thenThrow(Exception('Unexpected error'));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<UnknownFailure>());
      expect((result.failureOrNull as UnknownFailure).message, contains('Failed to get categories'));
      verify(mockRepository.getAll()).called(1);
    });

    test('should return empty list when no categories exist', () async {
      // Arrange
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success([]));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, isEmpty);
      verify(mockRepository.getAll()).called(1);
    });

    test('should return categories with different types', () async {
      // Arrange
      final mixedCategories = [
        ...testCategories,
        const TransactionCategory(
          id: 'transfer',
          name: 'Transfer',
          icon: 'swap_horiz',
          color: 0xFF6B7280,
          type: TransactionType.transfer,
        ),
      ];
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(mixedCategories));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull?.length, 3);
      expect(result.dataOrNull, mixedCategories);
      verify(mockRepository.getAll()).called(1);
    });
  });
}