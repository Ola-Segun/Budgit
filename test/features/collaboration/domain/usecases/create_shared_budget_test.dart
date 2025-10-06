import 'package:budget_tracker/features/collaboration/domain/entities/shared_budget.dart';
import 'package:budget_tracker/features/collaboration/domain/repositories/shared_budget_repository.dart';
import 'package:budget_tracker/features/collaboration/domain/usecases/create_shared_budget.dart';
import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_shared_budget_test.mocks.dart';

@GenerateMocks([SharedBudgetRepository])

void main() {
  // Provide dummy values for Mockito
  setUpAll(() {
    provideDummy<Result<SharedBudget>>(
      Result.error(Failure.unknown('Dummy error')),
    );
  });
  late CreateSharedBudget useCase;
  late MockSharedBudgetRepository mockRepository;

  setUp(() {
    mockRepository = MockSharedBudgetRepository();
    useCase = CreateSharedBudget(mockRepository);
  });

  group('CreateSharedBudget', () {
    const userId = 'user123';
    const budgetName = 'Test Budget';
    const totalBudget = 1000.0;
    const category = 'General';

    test('should create shared budget successfully', () async {
      // Arrange
      final expectedBudget = SharedBudget(
        id: 'budget_1234567890_123',
        name: budgetName,
        ownerId: userId,
        memberIds: [],
        pendingInvites: [],
        totalBudget: totalBudget,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        category: category,
      );

      when(mockRepository.createSharedBudget(any))
          .thenAnswer((_) async => Result.success(expectedBudget));

      // Act
      final result = await useCase(
        name: budgetName,
        ownerId: userId,
        totalBudget: totalBudget,
        category: category,
      );

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, isA<SharedBudget>());
      verify(mockRepository.createSharedBudget(any)).called(1);
    });

    test('should return validation error for empty name', () async {
      // Act
      final result = await useCase(
        name: '',
        ownerId: userId,
        totalBudget: totalBudget,
      );

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      expect((result.failureOrNull as Failure).message, contains('empty'));
      verifyNever(mockRepository.createSharedBudget(any));
    });

    test('should return validation error for zero budget', () async {
      // Act
      final result = await useCase(
        name: budgetName,
        ownerId: userId,
        totalBudget: 0.0,
      );

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      expect((result.failureOrNull as Failure).message, contains('greater than zero'));
      verifyNever(mockRepository.createSharedBudget(any));
    });

    test('should return validation error for empty owner ID', () async {
      // Act
      final result = await useCase(
        name: budgetName,
        ownerId: '',
        totalBudget: totalBudget,
      );

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      expect((result.failureOrNull as Failure).message, contains('Owner ID is required'));
      verifyNever(mockRepository.createSharedBudget(any));
    });

    test('should handle repository errors', () async {
      // Arrange
      when(mockRepository.createSharedBudget(any))
          .thenAnswer((_) async => Result.error(Failure.unknown('Database error')));

      // Act
      final result = await useCase(
        name: budgetName,
        ownerId: userId,
        totalBudget: totalBudget,
      );

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      verify(mockRepository.createSharedBudget(any)).called(1);
    });
  });
}