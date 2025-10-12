import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/add_category.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/delete_category.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/get_categories.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/update_category.dart';
import 'package:budget_tracker/features/transactions/presentation/notifiers/category_notifier.dart';

@GenerateMocks([
  GetCategories,
  AddCategory,
  UpdateCategory,
  DeleteCategory,
])
import 'category_notifier_test.mocks.dart';

void main() {
  late CategoryNotifier categoryNotifier;
  late MockGetCategories mockGetCategories;
  late MockAddCategory mockAddCategory;
  late MockUpdateCategory mockUpdateCategory;
  late MockDeleteCategory mockDeleteCategory;

  setUpAll(() {
    provideDummy<Result<List<TransactionCategory>>>(
      Result.error(Failure.unknown('dummy')),
    );
    provideDummy<Result<TransactionCategory>>(
      Result.error(Failure.unknown('dummy')),
    );
    provideDummy<Result<void>>(
      Result.error(Failure.unknown('dummy')),
    );
  });

  setUp(() async {
    mockGetCategories = MockGetCategories();
    mockAddCategory = MockAddCategory();
    mockUpdateCategory = MockUpdateCategory();
    mockDeleteCategory = MockDeleteCategory();

    // Stub the initial loadCategories call
    when(mockGetCategories()).thenAnswer((_) async => Result.success([]));
    when(mockAddCategory(any)).thenAnswer((_) async => Result.success(TransactionCategory(
      id: 'test',
      name: 'Test',
      icon: 'test',
      color: 0xFF000000,
      type: TransactionType.expense,
    )));
    when(mockUpdateCategory(any)).thenAnswer((_) async => Result.success(TransactionCategory(
      id: 'test',
      name: 'Test',
      icon: 'test',
      color: 0xFF000000,
      type: TransactionType.expense,
    )));
    when(mockDeleteCategory(any)).thenAnswer((_) async => Result.success(null));

    categoryNotifier = CategoryNotifier(
      getCategories: mockGetCategories,
      addCategory: mockAddCategory,
      updateCategory: mockUpdateCategory,
      deleteCategory: mockDeleteCategory,
    );

    // Wait for initial load to complete
    await Future.delayed(Duration.zero);
  });

  group('CategoryNotifier', () {
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

    final newCategory = const TransactionCategory(
      id: 'entertainment',
      name: 'Entertainment',
      icon: 'movie',
      color: 0xFFF97316,
      type: TransactionType.expense,
    );

    test('initial state should be data after loading', () {
      expect(categoryNotifier.state.value?.categories, isEmpty);
      expect(categoryNotifier.state.value?.isOperationInProgress, false);
      expect(categoryNotifier.state.value?.operationError, null);
    });

    test('should load categories successfully', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));

      // Act
      await categoryNotifier.loadCategories();

      // Assert
      expect(categoryNotifier.state.value?.categories, testCategories);
      expect(categoryNotifier.state.value?.isOperationInProgress, false);
      expect(categoryNotifier.state.value?.operationError, null);
      verify(mockGetCategories()).called(1);
    });

    test('should handle load categories failure', () async {
      // Arrange
      final failure = Failure.cache('Database error');
      when(mockGetCategories()).thenAnswer((_) async => Result.error(failure));

      // Act
      await categoryNotifier.loadCategories();

      // Assert
      expect(categoryNotifier.state.hasError, true);
      expect(categoryNotifier.state.error, failure.message);
    });

    test('should add category successfully', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));
      when(mockAddCategory(newCategory)).thenAnswer((_) async => Result.success(newCategory));

      // Set up state with categories
      await categoryNotifier.loadCategories();

      // Act
      final result = await categoryNotifier.addCategory(newCategory);

      // Assert
      expect(result, true);
      expect(categoryNotifier.state.value?.isOperationInProgress, false);
      expect(categoryNotifier.state.value?.operationError, null);
      verify(mockAddCategory(newCategory)).called(1);
      verify(mockGetCategories()).called(2); // Initial load + reload after add
    });

    test('should handle add category failure', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));
      final failure = Failure.validation('Category name already exists', {'name': 'Name already exists'});
      when(mockAddCategory(newCategory)).thenAnswer((_) async => Result.error(failure));

      // Set up state with categories
      await categoryNotifier.loadCategories();

      // Act
      final result = await categoryNotifier.addCategory(newCategory);

      // Assert
      expect(result, false);
      expect(categoryNotifier.state.value?.isOperationInProgress, false);
      expect(categoryNotifier.state.value?.operationError, failure.message);
      verify(mockAddCategory(newCategory)).called(1);
      verify(mockGetCategories()).called(1); // Only initial load
    });

    test('should update category successfully', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));
      final updatedCategory = testCategories[0].copyWith(name: 'Updated Food');
      when(mockUpdateCategory(updatedCategory)).thenAnswer((_) async => Result.success(updatedCategory));

      // Set up state with categories
      await categoryNotifier.loadCategories();

      // Act
      final result = await categoryNotifier.updateCategory(updatedCategory);

      // Assert
      expect(result, true);
      expect(categoryNotifier.state.value?.isOperationInProgress, false);
      expect(categoryNotifier.state.value?.operationError, null);
      verify(mockUpdateCategory(updatedCategory)).called(1);
      verify(mockGetCategories()).called(2); // Initial load + reload after update
    });

    test('should handle update category failure', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));
      final updatedCategory = testCategories[0].copyWith(name: 'Updated Food');
      final failure = Failure.validation('Category name already exists', {'name': 'Name already exists'});
      when(mockUpdateCategory(updatedCategory)).thenAnswer((_) async => Result.error(failure));

      // Wait for initial load
      await Future.delayed(Duration.zero);

      // Act
      final result = await categoryNotifier.updateCategory(updatedCategory);

      // Assert
      expect(result, false);
      expect(categoryNotifier.state.value?.isOperationInProgress, false);
      expect(categoryNotifier.state.value?.operationError, failure.message);
      verify(mockUpdateCategory(updatedCategory)).called(1);
      verify(mockGetCategories()).called(1); // Only initial load
    });

    test('should delete category successfully', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));
      when(mockDeleteCategory('food')).thenAnswer((_) async => Result.success(null));

      // Wait for initial load
      await Future.delayed(Duration.zero);

      // Act
      final result = await categoryNotifier.deleteCategory('food');

      // Assert
      expect(result, true);
      expect(categoryNotifier.state.value?.isOperationInProgress, false);
      expect(categoryNotifier.state.value?.operationError, null);
      verify(mockDeleteCategory('food')).called(1);
      verify(mockGetCategories()).called(2); // Initial load + reload after delete
    });

    test('should handle delete category failure', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));
      final failure = Failure.validation('Cannot delete category that is in use', {'categoryId': 'Category is assigned to transactions or bills'});
      when(mockDeleteCategory('food')).thenAnswer((_) async => Result.error(failure));

      // Wait for initial load
      await Future.delayed(Duration.zero);

      // Act
      final result = await categoryNotifier.deleteCategory('food');

      // Assert
      expect(result, false);
      expect(categoryNotifier.state.value?.isOperationInProgress, false);
      expect(categoryNotifier.state.value?.operationError, failure.message);
      verify(mockDeleteCategory('food')).called(1);
      verify(mockGetCategories()).called(1); // Only initial load
    });

    test('should get categories by type', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));

      // Wait for initial load
      await Future.delayed(Duration.zero);

      // Act & Assert
      final expenseCategories = categoryNotifier.getCategoriesByType(TransactionType.expense);
      final incomeCategories = categoryNotifier.getCategoriesByType(TransactionType.income);

      expect(expenseCategories.length, 1);
      expect(expenseCategories[0].id, 'food');
      expect(incomeCategories.length, 1);
      expect(incomeCategories[0].id, 'salary');
    });

    test('should get income and expense categories', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));

      // Wait for initial load
      await Future.delayed(Duration.zero);

      // Act & Assert
      expect(categoryNotifier.incomeCategories.length, 1);
      expect(categoryNotifier.incomeCategories[0].id, 'salary');
      expect(categoryNotifier.expenseCategories.length, 1);
      expect(categoryNotifier.expenseCategories[0].id, 'food');
    });

    test('should find category by ID', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));

      // Wait for initial load
      await Future.delayed(Duration.zero);

      // Act & Assert
      final foundCategory = categoryNotifier.getCategoryById('food');
      expect(foundCategory?.id, 'food');
      expect(foundCategory?.name, 'Food & Dining');

      final notFoundCategory = categoryNotifier.getCategoryById('nonexistent');
      expect(notFoundCategory, null);
    });

    test('should check if category exists', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));

      // Wait for initial load
      await Future.delayed(Duration.zero);

      // Act & Assert
      expect(categoryNotifier.hasCategory('food'), true);
      expect(categoryNotifier.hasCategory('nonexistent'), false);
    });

    test('should clear operation error', () async {
      // Arrange
      when(mockGetCategories()).thenAnswer((_) async => Result.success(testCategories));
      final failure = Failure.validation('Some error', {'error': 'Some validation error'});
      when(mockAddCategory(newCategory)).thenAnswer((_) async => Result.error(failure));

      // Wait for initial load
      await Future.delayed(Duration.zero);

      // Trigger an error
      await categoryNotifier.addCategory(newCategory);
      expect(categoryNotifier.state.value?.operationError, failure.message);

      // Act
      categoryNotifier.clearOperationError();

      // Assert
      expect(categoryNotifier.state.value?.operationError, null);
    });

    test('should not perform operations when state is null', () async {
      // Create notifier without initial load
      final freshNotifier = CategoryNotifier(
        getCategories: mockGetCategories,
        addCategory: mockAddCategory,
        updateCategory: mockUpdateCategory,
        deleteCategory: mockDeleteCategory,
      );

      // Act
      final addResult = await freshNotifier.addCategory(newCategory);
      final updateResult = await freshNotifier.updateCategory(newCategory);
      final deleteResult = await freshNotifier.deleteCategory('food');

      // Assert
      expect(addResult, false);
      expect(updateResult, false);
      expect(deleteResult, false);
      verifyZeroInteractions(mockAddCategory);
      verifyZeroInteractions(mockUpdateCategory);
      verifyZeroInteractions(mockDeleteCategory);
    });
  });
}