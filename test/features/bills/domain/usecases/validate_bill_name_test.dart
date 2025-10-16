import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/bills/domain/repositories/bill_repository.dart';
import 'package:budget_tracker/features/bills/domain/usecases/validate_bill_name.dart';

@GenerateMocks([BillRepository])
import 'validate_bill_name_test.mocks.dart';

// Provide dummy values for Mockito
void main() {
  provideDummy<Result<bool>>(Result.success(false));

  late ValidateBillName useCase;
  late MockBillRepository mockRepository;

  setUp(() {
    mockRepository = MockBillRepository();
    useCase = ValidateBillName(mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });

  group('ValidateBillName', () {
    test('should succeed when name is unique', () async {
      // Arrange
      when(mockRepository.nameExists('Test Bill')).thenAnswer((_) async => Result.success(false));

      // Act
      final result = await useCase('Test Bill');

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, 'Test Bill');
      verify(mockRepository.nameExists('Test Bill')).called(1);
    });

    test('should fail when name already exists', () async {
      // Arrange
      when(mockRepository.nameExists('Test Bill')).thenAnswer((_) async => Result.success(true));

      // Act
      final result = await useCase('Test Bill');

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      expect((result.failureOrNull as Failure).message, contains('Bill names must be unique'));
      verify(mockRepository.nameExists('Test Bill')).called(1);
    });

    test('should succeed when name is unique with excludeId', () async {
      // Arrange
      when(mockRepository.nameExists('Test Bill', excludeId: 'bill-id')).thenAnswer((_) async => Result.success(false));

      // Act
      final result = await useCase('Test Bill', excludeId: 'bill-id');

      // Assert
      expect(result.isSuccess, true);
      expect(result.dataOrNull, 'Test Bill');
      verify(mockRepository.nameExists('Test Bill', excludeId: 'bill-id')).called(1);
    });

    test('should fail when name exists with excludeId', () async {
      // Arrange
      when(mockRepository.nameExists('Test Bill', excludeId: 'bill-id')).thenAnswer((_) async => Result.success(true));

      // Act
      final result = await useCase('Test Bill', excludeId: 'bill-id');

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      expect((result.failureOrNull as Failure).message, contains('Bill names must be unique'));
      verify(mockRepository.nameExists('Test Bill', excludeId: 'bill-id')).called(1);
    });

    test('should handle repository error', () async {
      // Arrange
      when(mockRepository.nameExists('Test Bill')).thenAnswer((_) async => Result.error(Failure.unknown('Repository error')));

      // Act
      final result = await useCase('Test Bill');

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      expect((result.failureOrNull as Failure).message, 'Repository error');
      verify(mockRepository.nameExists('Test Bill')).called(1);
    });

    test('should handle case-insensitive matching', () async {
      // Test with different cases
      when(mockRepository.nameExists('test bill')).thenAnswer((_) async => Result.success(true));
      when(mockRepository.nameExists('TEST BILL')).thenAnswer((_) async => Result.success(true));
      when(mockRepository.nameExists('Test Bill')).thenAnswer((_) async => Result.success(true));

      var result = await useCase('test bill');
      expect(result.isError, true);

      result = await useCase('TEST BILL');
      expect(result.isError, true);

      result = await useCase('Test Bill');
      expect(result.isError, true);
    });

    test('should handle empty name', () async {
      // Act
      final result = await useCase('');

      // Assert
      expect(result.isSuccess, false);
      expect(result.failureOrNull, isA<Failure>());
      verify(mockRepository.nameExists('', excludeId: null)).called(1);
    });

    test('should handle whitespace-only name', () async {
      // Act
      final result = await useCase('   ');

      // Assert
      expect(result.isSuccess, false);
      expect(result.failureOrNull, isA<Failure>());
      verify(mockRepository.nameExists('   ', excludeId: null)).called(1);
    });
  });
}