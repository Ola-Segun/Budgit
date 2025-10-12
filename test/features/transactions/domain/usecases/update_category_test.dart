import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_category_repository.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/update_category.dart';

@GenerateMocks([TransactionCategoryRepository])
import 'update_category_test.mocks.dart';

void main() {
  late UpdateCategory useCase;
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
    useCase = UpdateCategory(mockRepository);
  });

  group('UpdateCategory Use Case', () {
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

    final validUpdatedCategory = const TransactionCategory(
      id: 'food',
      name: 'Food & Dining Updated',
      icon: 'restaurant',
      color: 0xFFF59E0B,
      type: TransactionType.expense,
    );

    final invalidUpdatedCategory = const TransactionCategory(
      id: 'food',
      name: '', // Invalid: empty name
      icon: 'restaurant',
      color: 0xFFF59E0B,
      type: TransactionType.expense,
    );

    test('should update category successfully when validation passes', () async {
      // Arrange
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));
      when(mockRepository.update(validUpdatedCategory)).thenAnswer((_) async => Result.success(validUpdatedCategory));

      // Act
      final result = await useCase(validUpdatedCategory);

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, validUpdatedCategory);
      verify(mockRepository.getAll()).called(1);
      verify(mockRepository.update(validUpdatedCategory)).called(1);
    });

    test('should return validation error for invalid category', () async {
      // Arrange
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));

      // Act
      final result = await useCase(invalidUpdatedCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect((result.failureOrNull as ValidationFailure).message, 'Category name cannot be empty');
      verify(mockRepository.getAll()).called(1);
      verifyNever(mockRepository.update(any));
    });

    test('should return error when getting existing categories fails', () async {
      // Arrange
      final failure = Failure.cache('Database error');
      when(mockRepository.getAll()).thenAnswer((_) async => Result.error(failure));

      // Act
      final result = await useCase(validUpdatedCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, failure);
      verify(mockRepository.getAll()).called(1);
      verifyNever(mockRepository.update(any));
    });

    test('should return error when repository update fails', () async {
      // Arrange
      final failure = Failure.cache('Failed to update category');
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));
      when(mockRepository.update(validUpdatedCategory)).thenAnswer((_) async => Result.error(failure));

      // Act
      final result = await useCase(validUpdatedCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, failure);
      verify(mockRepository.getAll()).called(1);
      verify(mockRepository.update(validUpdatedCategory)).called(1);
    });

    test('should return unknown error on exception', () async {
      // Arrange
      when(mockRepository.getAll()).thenThrow(Exception('Unexpected error'));

      // Act
      final result = await useCase(validUpdatedCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<UnknownFailure>());
      expect((result.failureOrNull as UnknownFailure).message, contains('Failed to update category'));
      verify(mockRepository.getAll()).called(1);
      verifyNever(mockRepository.update(any));
    });

    test('should allow updating category with same name (no change)', () async {
      // Arrange
      final sameNameCategory = existingCategories[0]; // Same name as itself
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));
      when(mockRepository.update(sameNameCategory)).thenAnswer((_) async => Result.success(sameNameCategory));

      // Act
      final result = await useCase(sameNameCategory);

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, sameNameCategory);
      verify(mockRepository.getAll()).called(1);
      verify(mockRepository.update(sameNameCategory)).called(1);
    });

    test('should validate duplicate names within same type during update', () async {
      // Arrange - Try to update food category to have same name as another expense category (but there isn't one)
      // Actually, let's create a scenario where there are two expense categories
      final categoriesWithTwoExpenses = [
        ...existingCategories,
        const TransactionCategory(
          id: 'transport',
          name: 'Transportation',
          icon: 'directions_car',
          color: 0xFFEF4444,
          type: TransactionType.expense,
        ),
      ];
      final duplicateCategory = categoriesWithTwoExpenses[0].copyWith(name: 'Transportation'); // Same as another expense category
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(categoriesWithTwoExpenses));

      // Act
      final result = await useCase(duplicateCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect((result.failureOrNull as ValidationFailure).message, 'Category name already exists for this type');
      verify(mockRepository.getAll()).called(1);
      verifyNever(mockRepository.update(any));
    });

    test('should allow duplicate names in different types during update', () async {
      // Arrange
      final categoryWithExistingName = existingCategories[0].copyWith(
        name: 'Salary', // Same as income category but updating expense category
        type: TransactionType.expense,
      );
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));
      when(mockRepository.update(categoryWithExistingName)).thenAnswer((_) async => Result.success(categoryWithExistingName));

      // Act
      final result = await useCase(categoryWithExistingName);

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, categoryWithExistingName);
      verify(mockRepository.getAll()).called(1);
      verify(mockRepository.update(categoryWithExistingName)).called(1);
    });
  });
}