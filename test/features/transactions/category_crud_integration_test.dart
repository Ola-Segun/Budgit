import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_category_repository.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/add_category.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/delete_category.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/get_categories.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/update_category.dart';

@GenerateMocks([TransactionCategoryRepository])
import 'category_crud_integration_test.mocks.dart';

void main() {
  late AddCategory addCategory;
  late UpdateCategory updateCategory;
  late DeleteCategory deleteCategory;
  late GetCategories getCategories;
  late MockTransactionCategoryRepository mockRepository;

  setUpAll(() {
    provideDummy<Result<List<TransactionCategory>>>(
      Result.error(Failure.unknown('dummy')),
    );
    provideDummy<Result<TransactionCategory>>(
      Result.error(Failure.unknown('dummy')),
    );
    provideDummy<Result<bool>>(
      Result.error(Failure.unknown('dummy')),
    );
    provideDummy<Result<void>>(
      Result.error(Failure.unknown('dummy')),
    );
  });

  setUp(() {
    mockRepository = MockTransactionCategoryRepository();
    addCategory = AddCategory(mockRepository);
    updateCategory = UpdateCategory(mockRepository);
    deleteCategory = DeleteCategory(mockRepository);
    getCategories = GetCategories(mockRepository);
  });

  group('Category CRUD Integration Tests', () {
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

    final newCategory = const TransactionCategory(
      id: 'entertainment',
      name: 'Entertainment',
      icon: 'movie',
      color: 0xFFF97316,
      type: TransactionType.expense,
    );

    test('should successfully create a category', () async {
      // Arrange
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));
      when(mockRepository.add(newCategory)).thenAnswer((_) async => Result.success(newCategory));

      // Act
      final result = await addCategory(newCategory);

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, newCategory);
      verify(mockRepository.getAll()).called(1);
      verify(mockRepository.add(newCategory)).called(1);
    });

    test('should successfully update a category', () async {
      // Arrange
      final categoriesWithNew = [...existingCategories, newCategory];
      final updatedCategory = newCategory.copyWith(name: 'Entertainment & Leisure');

      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(categoriesWithNew));
      when(mockRepository.update(updatedCategory)).thenAnswer((_) async => Result.success(updatedCategory));

      // Act
      final result = await updateCategory(updatedCategory);

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull?.name, 'Entertainment & Leisure');
      verify(mockRepository.getAll()).called(1);
      verify(mockRepository.update(updatedCategory)).called(1);
    });

    test('should successfully delete a category', () async {
      // Arrange
      when(mockRepository.isCategoryInUse('food')).thenAnswer((_) async => Result.success(false));
      when(mockRepository.delete('food')).thenAnswer((_) async => Result.success(null));

      // Act
      final result = await deleteCategory('food');

      // Assert
      expect(result.isSuccess, true);
      verify(mockRepository.isCategoryInUse('food')).called(1);
      verify(mockRepository.delete('food')).called(1);
    });

    test('should successfully read categories', () async {
      // Arrange
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));

      // Act
      final result = await getCategories();

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, existingCategories);
      verify(mockRepository.getAll()).called(1);
    });

    test('should validate category creation with existing categories', () async {
      // Arrange
      final duplicateCategory = const TransactionCategory(
        id: 'duplicate',
        name: 'Food & Dining', // Same name as existing
        icon: 'restaurant',
        color: 0xFF000000,
        type: TransactionType.expense,
      );

      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));

      // Act
      final result = await addCategory(duplicateCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect((result.failureOrNull as ValidationFailure).message, 'Category name already exists for this type');

      // Verify repository was not called for add
      verifyNever(mockRepository.add(any));
    });

    test('should prevent deletion of category that is in use', () async {
      // Arrange
      when(mockRepository.isCategoryInUse('food')).thenAnswer((_) async => Result.success(true));

      // Act
      final result = await deleteCategory('food');

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect((result.failureOrNull as ValidationFailure).message, 'Cannot delete category that is currently in use');

      // Verify repository was not called for delete
      verifyNever(mockRepository.delete(any));
    });

    test('should handle repository failures during CRUD operations', () async {
      // Arrange - Test repository failure during add
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));
      final failure = Failure.cache('Database connection failed');
      when(mockRepository.add(newCategory)).thenAnswer((_) async => Result.error(failure));

      // Act
      final result = await addCategory(newCategory);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, failure);
    });

    test('should validate category update with existing categories', () async {
      // Arrange
      final categoriesWithExtra = [
        ...existingCategories,
        const TransactionCategory(
          id: 'shopping',
          name: 'Shopping',
          icon: 'shopping_bag',
          color: 0xFFEC4899,
          type: TransactionType.expense,
        ),
      ];

      final invalidUpdate = categoriesWithExtra[0].copyWith(name: 'Shopping'); // Conflict with another expense category

      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(categoriesWithExtra));

      // Act
      final result = await updateCategory(invalidUpdate);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect((result.failureOrNull as ValidationFailure).message, 'Category name already exists for this type');

      // Verify repository was not called for update
      verifyNever(mockRepository.update(any));
    });

    test('should allow updating category name to same name (no change)', () async {
      // Arrange
      final sameNameCategory = existingCategories[0]; // Same name as itself

      when(mockRepository.getAll()).thenAnswer((_) async => Result.success(existingCategories));
      when(mockRepository.update(sameNameCategory)).thenAnswer((_) async => Result.success(sameNameCategory));

      // Act
      final result = await updateCategory(sameNameCategory);

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, sameNameCategory);
    });

    test('should handle empty category list for new category creation', () async {
      // Arrange
      when(mockRepository.getAll()).thenAnswer((_) async => Result.success([]));
      when(mockRepository.add(newCategory)).thenAnswer((_) async => Result.success(newCategory));

      // Act
      final result = await addCategory(newCategory);

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, newCategory);
    });

    test('should validate category ID format during deletion', () async {
      // Act
      final result = await deleteCategory('');

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect((result.failureOrNull as ValidationFailure).message, 'Category ID cannot be empty');

      // Verify repository calls were not made
      verifyNever(mockRepository.isCategoryInUse(any));
      verifyNever(mockRepository.delete(any));
    });

    test('should handle repository failure during category check', () async {
      // Arrange
      final failure = Failure.network('Connection timeout');
      when(mockRepository.isCategoryInUse('food')).thenAnswer((_) async => Result.error(failure));

      // Act
      final result = await deleteCategory('food');

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, failure);

      // Verify delete was not attempted
      verifyNever(mockRepository.delete(any));
    });
  });
}