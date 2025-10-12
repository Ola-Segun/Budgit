import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_category_repository.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/add_category.dart';

@GenerateMocks([TransactionCategoryRepository])
import 'add_category_test.mocks.dart';

void main() {
  late AddCategory useCase;
  late MockTransactionCategoryRepository mockRepository;

  setUpAll(() {
    provideDummy<Result<List<TransactionCategory>>>(
      Result.error(Failure.unknown('dummy')),
    );
    provideDummy<Result<TransactionCategory>>(
      Result.error(Failure.unknown('dummy')),
    );
  });

  setUp(() {
    mockRepository = MockTransactionCategoryRepository();
    useCase = AddCategory(mockRepository);
  });

  group('AddCategory Use Case', () {
    final existingCategories = [
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

    final validCategory = const TransactionCategory(
      id: 'shopping',
      name: 'Shopping',
      icon: 'shopping_bag',
      color: 0xFFEC4899,
      type: TransactionType.expense,
    );

    final invalidCategory = const TransactionCategory(
      id: 'test',
      name: '', // Invalid: empty name
      icon: 'test',
      color: 0xFF000000,
      type: TransactionType.expense,
    );

    test('should add category successfully when validation passes', () async {
      // Arrange
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));
      when(mockRepository.add(validCategory)).thenAnswer((_) async => Result.success(validCategory));

      // Act
      final result = await useCase(validCategory);

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, validCategory);
      verify(mockRepository.getAll()).called(1);
      verify(mockRepository.add(validCategory)).called(1);
    });

    test('should return validation error for invalid category', () async {
      // Arrange
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));

      // Act
      final result = await useCase(invalidCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect((result.failureOrNull as ValidationFailure).message, 'Category name cannot be empty');
      verify(mockRepository.getAll()).called(1);
      verifyNever(mockRepository.add(any));
    });

    test('should return error when getting existing categories fails', () async {
      // Arrange
      final failure = Failure.cache('Database error');
      when(mockRepository.getAll()).thenAnswer((_) async => Result.error(failure));

      // Act
      final result = await useCase(validCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, failure);
      verify(mockRepository.getAll()).called(1);
      verifyNever(mockRepository.add(any));
    });

    test('should return error when repository add fails', () async {
      // Arrange
      final failure = Failure.cache('Failed to save category');
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));
      when(mockRepository.add(validCategory)).thenAnswer((_) async => Result.error(failure));

      // Act
      final result = await useCase(validCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, failure);
      verify(mockRepository.getAll()).called(1);
      verify(mockRepository.add(validCategory)).called(1);
    });

    test('should return unknown error on exception', () async {
      // Arrange
      when(mockRepository.getAll()).thenThrow(Exception('Unexpected error'));

      // Act
      final result = await useCase(validCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<UnknownFailure>());
      expect((result.failureOrNull as UnknownFailure).message, contains('Failed to add category'));
      verify(mockRepository.getAll()).called(1);
      verifyNever(mockRepository.add(any));
    });

    test('should handle empty existing categories list', () async {
      // Arrange
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success([]));
      when(mockRepository.add(validCategory)).thenAnswer((_) async => Result.success(validCategory));

      // Act
      final result = await useCase(validCategory);

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, validCategory);
      verify(mockRepository.getAll()).called(1);
      verify(mockRepository.add(validCategory)).called(1);
    });

    test('should validate duplicate names within same type', () async {
      // Arrange
      final duplicateCategory = const TransactionCategory(
        id: 'test',
        name: 'Food & Dining', // Same as existing expense category
        icon: 'test',
        color: 0xFF000000,
        type: TransactionType.expense,
      );
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));

      // Act
      final result = await useCase(duplicateCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect((result.failureOrNull as ValidationFailure).message, 'Category name already exists for this type');
      verify(mockRepository.getAll()).called(1);
      verifyNever(mockRepository.add(any));
    });

    test('should allow duplicate names in different types', () async {
      // Arrange
      final categoryWithExistingName = const TransactionCategory(
        id: 'test',
        name: 'Food & Dining', // Same name as expense category but for income
        icon: 'test',
        color: 0xFF000000,
        type: TransactionType.income,
      );
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));
      when(mockRepository.add(categoryWithExistingName)).thenAnswer((_) async => Result.success(categoryWithExistingName));

      // Act
      final result = await useCase(categoryWithExistingName);

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, categoryWithExistingName);
      verify(mockRepository.getAll()).called(1);
      verify(mockRepository.add(categoryWithExistingName)).called(1);
    });
  });
}