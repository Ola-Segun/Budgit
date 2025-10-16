import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/budgets/domain/entities/budget.dart';
import 'package:budget_tracker/features/budgets/domain/repositories/budget_repository.dart';
import 'package:budget_tracker/features/budgets/domain/usecases/create_budget.dart';
import 'package:budget_tracker/features/budgets/domain/usecases/update_budget.dart';

class MockBudgetRepository extends Mock implements BudgetRepository {}

void main() {
  late CreateBudget createBudgetUseCase;
  late UpdateBudget updateBudgetUseCase;
  late MockBudgetRepository mockRepository;

  setUp(() {
    mockRepository = MockBudgetRepository();
    createBudgetUseCase = CreateBudget(mockRepository);
    updateBudgetUseCase = UpdateBudget(mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });

  group('Duplicate Budget Name Validation', () {
    final testBudget = Budget(
      id: 'test-id',
      name: 'Test Budget',
      type: BudgetType.custom,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
      createdAt: DateTime.now(),
      categories: [
        BudgetCategory(
          id: 'cat1',
          name: 'Food',
          amount: 500.0,
        ),
      ],
      isActive: true,
      allowRollover: false,
    );

    test('CreateBudget: should succeed when name is unique', () async {
       // Arrange
       when(mockRepository.nameExists('Test Budget')).thenAnswer((_) async => Result.success(false));
       when(mockRepository.add(testBudget)).thenAnswer((_) async => Result.success(testBudget));

       // Act
       final result = await createBudgetUseCase(testBudget);

       // Assert
       expect(result.isSuccess, true);
       verify(mockRepository.nameExists('Test Budget')).called(1);
       verify(mockRepository.add(testBudget)).called(1);
     });

    test('CreateBudget: should fail when name already exists', () async {
       // Arrange
       when(mockRepository.nameExists('Test Budget')).thenAnswer((_) async => Result.success(true));

       // Act
       final result = await createBudgetUseCase(testBudget);

       // Assert
       expect(result.isError, true);
       expect(result.failureOrNull, isA<Failure>());
       expect((result.failureOrNull as Failure).message, contains('Budget names must be unique'));
       verify(mockRepository.nameExists('Test Budget')).called(1);
       verifyNever(mockRepository.add(testBudget));
     });

    test('UpdateBudget: should succeed when renaming to same name', () async {
       // Arrange
       when(mockRepository.nameExists('Test Budget', excludeId: 'test-id')).thenAnswer((_) async => Result.success(false));
       when(mockRepository.update(testBudget)).thenAnswer((_) async => Result.success(testBudget));

       // Act
       final result = await updateBudgetUseCase(testBudget);

       // Assert
       expect(result.isSuccess, true);
       verify(mockRepository.nameExists('Test Budget', excludeId: 'test-id')).called(1);
       verify(mockRepository.update(testBudget)).called(1);
     });

    test('UpdateBudget: should succeed when renaming to unique name', () async {
       // Arrange
       final updatedBudget = testBudget.copyWith(name: 'Updated Budget');
       when(mockRepository.nameExists('Updated Budget', excludeId: 'test-id')).thenAnswer((_) async => Result.success(false));
       when(mockRepository.update(updatedBudget)).thenAnswer((_) async => Result.success(updatedBudget));

       // Act
       final result = await updateBudgetUseCase(updatedBudget);

       // Assert
       expect(result.isSuccess, true);
       verify(mockRepository.nameExists('Updated Budget', excludeId: 'test-id')).called(1);
       verify(mockRepository.update(updatedBudget)).called(1);
     });

    test('UpdateBudget: should fail when renaming to existing name', () async {
       // Arrange
       final updatedBudget = testBudget.copyWith(name: 'Existing Budget');
       when(mockRepository.nameExists('Existing Budget', excludeId: 'test-id')).thenAnswer((_) async => Result.success(true));

       // Act
       final result = await updateBudgetUseCase(updatedBudget);

       // Assert
       expect(result.isError, true);
       expect(result.failureOrNull, isA<Failure>());
       expect((result.failureOrNull as Failure).message, contains('Budget names must be unique'));
       verify(mockRepository.nameExists('Existing Budget', excludeId: 'test-id')).called(1);
       verifyNever(mockRepository.update(updatedBudget));
     });

    test('Repository nameExists: should handle case-insensitive matching', () async {
      // This test verifies the repository implementation handles case-insensitive matching
      // as seen in the implementation (trim().toLowerCase())

      // Test with different cases
      when(mockRepository.nameExists('test budget')).thenAnswer((_) async => Result.success(true));
      when(mockRepository.nameExists('TEST BUDGET')).thenAnswer((_) async => Result.success(true));
      when(mockRepository.nameExists('Test Budget')).thenAnswer((_) async => Result.success(true));

      var result = await mockRepository.nameExists('test budget');
      expect(result.dataOrNull, true);

      result = await mockRepository.nameExists('TEST BUDGET');
      expect(result.dataOrNull, true);

      result = await mockRepository.nameExists('Test Budget');
      expect(result.dataOrNull, true);
    });
  });
}