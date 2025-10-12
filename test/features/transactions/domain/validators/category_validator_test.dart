import 'package:flutter_test/flutter_test.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/validators/category_validator.dart';

void main() {
  group('CategoryValidator', () {
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
      const TransactionCategory(
        id: 'transport',
        name: 'Transportation',
        icon: 'directions_car',
        color: 0xFFEF4444,
        type: TransactionType.expense,
      ),
    ];

    group('validateForCreation', () {
      test('should validate successfully for valid category', () {
        // Arrange
        final validCategory = const TransactionCategory(
          id: 'shopping',
          name: 'Shopping',
          icon: 'shopping_bag',
          color: 0xFFEC4899,
          type: TransactionType.expense,
        );

        // Act
        final result = CategoryValidator.validateForCreation(validCategory, testCategories);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, validCategory);
      });

      test('should fail validation for empty name', () {
        // Arrange
        final invalidCategory = const TransactionCategory(
          id: 'test',
          name: '',
          icon: 'test',
          color: 0xFF000000,
          type: TransactionType.expense,
        );

        // Act
        final result = CategoryValidator.validateForCreation(invalidCategory, testCategories);

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect((result.failureOrNull as ValidationFailure).message, 'Category name cannot be empty');
        expect((result.failureOrNull as ValidationFailure).errors['name'], 'Name is required');
      });


      test('should fail validation for name too long', () {
        // Arrange
        final longName = 'A' * 51; // 51 characters
        final invalidCategory = TransactionCategory(
          id: 'test',
          name: longName,
          icon: 'test',
          color: 0xFF000000,
          type: TransactionType.expense,
        );

        // Act
        final result = CategoryValidator.validateForCreation(invalidCategory, testCategories);

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect((result.failureOrNull as ValidationFailure).message, 'Category name is too long');
      });

      test('should fail validation for empty icon', () {
        // Arrange
        final invalidCategory = const TransactionCategory(
          id: 'test',
          name: 'Test Category',
          icon: '',
          color: 0xFF000000,
          type: TransactionType.expense,
        );

        // Act
        final result = CategoryValidator.validateForCreation(invalidCategory, testCategories);

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect((result.failureOrNull as ValidationFailure).message, 'Category icon cannot be empty');
      });

      test('should fail validation for invalid color', () {
        // Arrange
        final invalidCategory = const TransactionCategory(
          id: 'test',
          name: 'Test Category',
          icon: 'test',
          color: -1, // Invalid color
          type: TransactionType.expense,
        );

        // Act
        final result = CategoryValidator.validateForCreation(invalidCategory, testCategories);

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect((result.failureOrNull as ValidationFailure).message, 'Invalid category color');
      });

      test('should fail validation for duplicate name in same type', () {
        // Arrange
        final duplicateCategory = const TransactionCategory(
          id: 'test',
          name: 'Food & Dining', // Same as existing expense category
          icon: 'test',
          color: 0xFF000000,
          type: TransactionType.expense,
        );

        // Act
        final result = CategoryValidator.validateForCreation(duplicateCategory, testCategories);

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect((result.failureOrNull as ValidationFailure).message, 'Category name already exists for this type');
      });

      test('should allow duplicate name in different types', () {
        // Arrange
        final categoryWithExistingName = const TransactionCategory(
          id: 'test',
          name: 'Food & Dining', // Same name as expense category but for income
          icon: 'test',
          color: 0xFF000000,
          type: TransactionType.income,
        );

        // Act
        final result = CategoryValidator.validateForCreation(categoryWithExistingName, testCategories);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, categoryWithExistingName);
      });

      test('should handle case insensitive duplicate names', () {
        // Arrange
        final duplicateCategory = const TransactionCategory(
          id: 'test',
          name: 'food & dining', // Same as existing but different case
          icon: 'test',
          color: 0xFF000000,
          type: TransactionType.expense,
        );

        // Act
        final result = CategoryValidator.validateForCreation(duplicateCategory, testCategories);

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect((result.failureOrNull as ValidationFailure).message, 'Category name already exists for this type');
      });
    });

    group('validateForUpdate', () {
      test('should validate successfully for valid category update', () {
        // Arrange
        final updatedCategory = testCategories[0].copyWith(name: 'Updated Food');

        // Act
        final result = CategoryValidator.validateForUpdate(updatedCategory, testCategories);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, updatedCategory);
      });

      test('should allow updating category with same name (no change)', () {
        // Arrange
        final sameNameCategory = testCategories[0]; // Same name as itself

        // Act
        final result = CategoryValidator.validateForUpdate(sameNameCategory, testCategories);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, sameNameCategory);
      });

      test('should fail validation for duplicate name in same type during update', () {
        // Arrange
        final updatedCategory = testCategories[0].copyWith(name: 'Transportation'); // Same as another expense category

        // Act
        final result = CategoryValidator.validateForUpdate(updatedCategory, testCategories);

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect((result.failureOrNull as ValidationFailure).message, 'Category name already exists for this type');
      });

      test('should allow duplicate name in different types during update', () {
        // Arrange
        final updatedCategory = testCategories[0].copyWith(
          name: 'Salary', // Same as income category but updating expense category
          type: TransactionType.expense,
        );

        // Act
        final result = CategoryValidator.validateForUpdate(updatedCategory, testCategories);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, updatedCategory);
      });
    });

    group('validateForDeletion', () {
      test('should validate successfully for category not in use', () {
        // Arrange
        const categoryId = 'food';
        const isInUse = false;

        // Act
        final result = CategoryValidator.validateForDeletion(categoryId, isInUse);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, categoryId);
      });

      test('should fail validation for empty category ID', () {
        // Arrange
        const categoryId = '';
        const isInUse = false;

        // Act
        final result = CategoryValidator.validateForDeletion(categoryId, isInUse);

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect((result.failureOrNull as ValidationFailure).message, 'Category ID cannot be empty');
      });

      test('should fail validation for category in use', () {
        // Arrange
        const categoryId = 'food';
        const isInUse = true;

        // Act
        final result = CategoryValidator.validateForDeletion(categoryId, isInUse);

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect((result.failureOrNull as ValidationFailure).message, 'Cannot delete category that is currently in use');
      });
    });

    group('validateCategoryId', () {
      test('should validate successfully for valid category ID', () {
        // Arrange
        const categoryId = 'valid_id_123';

        // Act
        final result = CategoryValidator.validateCategoryId(categoryId);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, categoryId);
      });

      test('should fail validation for empty category ID', () {
        // Arrange
        const categoryId = '';

        // Act
        final result = CategoryValidator.validateCategoryId(categoryId);

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect((result.failureOrNull as ValidationFailure).message, 'Category ID cannot be empty');
      });

      test('should trim whitespace from category ID', () {
        // Arrange
        const categoryId = '  test_id  ';

        // Act
        final result = CategoryValidator.validateCategoryId(categoryId);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, 'test_id');
      });
    });

    group('Edge cases', () {
      test('should handle empty existing categories list', () {
        // Arrange
        final validCategory = const TransactionCategory(
          id: 'test',
          name: 'Test Category',
          icon: 'test',
          color: 0xFF000000,
          type: TransactionType.expense,
        );
        final emptyCategories = <TransactionCategory>[];

        // Act
        final result = CategoryValidator.validateForCreation(validCategory, emptyCategories);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, validCategory);
      });

      test('should handle empty existing categories list', () {
        // Arrange
        final validCategory = const TransactionCategory(
          id: 'test',
          name: 'Test Category',
          icon: 'test',
          color: 0xFF000000,
          type: TransactionType.expense,
        );
        final emptyCategories = <TransactionCategory>[];

        // Act
        final result = CategoryValidator.validateForCreation(validCategory, emptyCategories);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, validCategory);
      });

      test('should validate maximum valid color value', () {
        // Arrange
        final validCategory = const TransactionCategory(
          id: 'test',
          name: 'Test Category',
          icon: 'test',
          color: 0xFFFFFFFF, // Maximum valid color
          type: TransactionType.expense,
        );

        // Act
        final result = CategoryValidator.validateForCreation(validCategory, testCategories);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, validCategory);
      });

      test('should validate minimum valid color value', () {
        // Arrange
        final validCategory = const TransactionCategory(
          id: 'test',
          name: 'Test Category',
          icon: 'test',
          color: 0x00000000, // Minimum valid color
          type: TransactionType.expense,
        );

        // Act
        final result = CategoryValidator.validateForCreation(validCategory, testCategories);

        // Assert
        expect(result.isSuccess, true);
        expect(result.dataOrNull, validCategory);
      });
    });
  });
}