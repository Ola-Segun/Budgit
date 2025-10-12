import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_category_repository.dart';
import 'package:budget_tracker/features/transactions/domain/usecases/delete_category.dart';

@GenerateMocks([TransactionCategoryRepository])
import 'delete_category_test.mocks.dart';

void main() {
  late DeleteCategory useCase;
  late MockTransactionCategoryRepository mockRepository;

  setUpAll(() {
    provideDummy<Result<bool>>(
      Result.error(Failure.unknown('dummy')),
    );
    provideDummy<Result<void>>(
      Result.error(Failure.unknown('dummy')),
    );
  });

  setUp(() {
    mockRepository = MockTransactionCategoryRepository();
    useCase = DeleteCategory(mockRepository);
  });

  group('DeleteCategory Use Case', () {
    const validCategoryId = 'food';
    const invalidCategoryId = '';

    test('should delete category successfully when validation passes', () async {
      // Arrange
      when(mockRepository.isCategoryInUse(validCategoryId)).thenAnswer((_) async => Result.success(false));
      when(mockRepository.delete(validCategoryId)).thenAnswer((_) async => Result.success(null));

      // Act
      final result = await useCase(validCategoryId);

      // Assert
      expect(result.isSuccess, true);
      verify(mockRepository.isCategoryInUse(validCategoryId)).called(1);
      verify(mockRepository.delete(validCategoryId)).called(1);
    });

    test('should return validation error for empty category ID', () async {
      // Act
      final result = await useCase(invalidCategoryId);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect((result.failureOrNull as ValidationFailure).message, 'Category ID cannot be empty');
      verifyNever(mockRepository.isCategoryInUse(any));
      verifyNever(mockRepository.delete(any));
    });

    test('should return error when checking if category is in use fails', () async {
      // Arrange
      final failure = Failure.cache('Database error');
      when(mockRepository.isCategoryInUse(validCategoryId)).thenAnswer((_) async => Result.error(failure));

      // Act
      final result = await useCase(validCategoryId);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, failure);
      verify(mockRepository.isCategoryInUse(validCategoryId)).called(1);
      verifyNever(mockRepository.delete(any));
    });

    test('should return validation error when category is in use', () async {
      // Arrange
      when(mockRepository.isCategoryInUse(validCategoryId)).thenAnswer((_) async => Result.success(true));

      // Act
      final result = await useCase(validCategoryId);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect((result.failureOrNull as ValidationFailure).message, 'Cannot delete category that is currently in use');
      verify(mockRepository.isCategoryInUse(validCategoryId)).called(1);
      verifyNever(mockRepository.delete(any));
    });

    test('should return error when repository delete fails', () async {
      // Arrange
      final failure = Failure.cache('Failed to delete category');
      when(mockRepository.isCategoryInUse(validCategoryId)).thenAnswer((_) async => Result.success(false));
      when(mockRepository.delete(validCategoryId)).thenAnswer((_) async => Result.error(failure));

      // Act
      final result = await useCase(validCategoryId);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, failure);
      verify(mockRepository.isCategoryInUse(validCategoryId)).called(1);
      verify(mockRepository.delete(validCategoryId)).called(1);
    });

    test('should return unknown error on exception', () async {
      // Arrange
      when(mockRepository.isCategoryInUse(validCategoryId)).thenThrow(Exception('Unexpected error'));

      // Act
      final result = await useCase(validCategoryId);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<UnknownFailure>());
      expect((result.failureOrNull as UnknownFailure).message, contains('Failed to delete category'));
      verify(mockRepository.isCategoryInUse(validCategoryId)).called(1);
      verifyNever(mockRepository.delete(any));
    });

    test('should handle category ID with whitespace', () async {
      // Arrange
      const categoryIdWithWhitespace = '  food  ';
      when(mockRepository.isCategoryInUse(categoryIdWithWhitespace)).thenAnswer((_) async => Result.success(false));
      when(mockRepository.delete(categoryIdWithWhitespace)).thenAnswer((_) async => Result.success(null));

      // Act
      final result = await useCase(categoryIdWithWhitespace);

      // Assert
      expect(result.isSuccess, true);
      verify(mockRepository.isCategoryInUse(categoryIdWithWhitespace)).called(1);
      verify(mockRepository.delete(categoryIdWithWhitespace)).called(1);
    });

  });
}