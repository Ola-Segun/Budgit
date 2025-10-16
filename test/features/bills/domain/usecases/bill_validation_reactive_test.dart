import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/bills/domain/entities/bill.dart';
import 'package:budget_tracker/features/bills/domain/repositories/bill_repository.dart';
import 'package:budget_tracker/features/bills/domain/usecases/create_bill.dart';
import 'package:budget_tracker/features/bills/domain/usecases/update_bill.dart';
import 'package:budget_tracker/features/bills/domain/usecases/validate_bill_name.dart';

@GenerateMocks([BillRepository, AccountRepository])
import 'bill_validation_reactive_test.mocks.dart';

// Provide dummy values for Mockito
void main() {
  provideDummy<Result<bool>>(Result.success(false));
  provideDummy<Result<Bill>>(Result.success(Bill(
    id: 'dummy',
    name: 'Dummy',
    amount: 0.0,
    dueDate: DateTime.now(),
    frequency: BillFrequency.monthly,
    categoryId: 'dummy',
  )));
  provideDummy<Result<Account?>>(Result.success(null));

  late CreateBill createBillUseCase;
  late UpdateBill updateBillUseCase;
  late ValidateBillName validateBillNameUseCase;
  late MockBillRepository mockBillRepository;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockBillRepository = MockBillRepository();
    mockAccountRepository = MockAccountRepository();
    createBillUseCase = CreateBill(mockBillRepository, mockAccountRepository);
    updateBillUseCase = UpdateBill(mockBillRepository, mockAccountRepository);
    validateBillNameUseCase = ValidateBillName(mockBillRepository);
  });

  tearDown(() {
    reset(mockBillRepository);
    reset(mockAccountRepository);
  });

  group('Bill Validation - Reactive Behavior', () {
    final testBill = Bill(
      id: 'test-bill-id',
      name: 'Test Bill',
      amount: 100.0,
      dueDate: DateTime.now().add(const Duration(days: 7)),
      frequency: BillFrequency.monthly,
      categoryId: 'test-category',
    );

    test('should validate name uniqueness reactively during creation', () async {
      // Arrange - Simulate real-time validation calls
      when(mockBillRepository.nameExists('Test Bill')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.add(testBill)).thenAnswer((_) async => Result.success(testBill));

      // Act - First validate name (reactive validation)
      final nameValidation = await validateBillNameUseCase('Test Bill');
      // Then create bill
      final result = await createBillUseCase(testBill);

      // Assert
      expect(nameValidation.isSuccess, true);
      expect(result.isSuccess, true);
      verify(mockBillRepository.nameExists('Test Bill')).called(2); // Called once for validation, once for creation
    });

    test('should prevent creation when reactive validation detects duplicate', () async {
      // Arrange - Simulate reactive validation detecting duplicate
      when(mockBillRepository.nameExists('Test Bill')).thenAnswer((_) async => Result.success(true));

      // Act - Reactive validation detects duplicate
      final nameValidation = await validateBillNameUseCase('Test Bill');
      // Attempt creation anyway
      final result = await createBillUseCase(testBill);

      // Assert
      expect(nameValidation.isError, true);
      expect(result.isError, true);
      expect((result.failureOrNull as Failure).message, contains('Bill names must be unique'));
      verify(mockBillRepository.nameExists('Test Bill')).called(2); // Called once for validation, once for creation
      verifyNever(mockBillRepository.add(testBill));
    });

    test('should validate name uniqueness reactively during update', () async {
      // Arrange - Simulate real-time validation during update
      final updatedBill = testBill.copyWith(name: 'Updated Bill');
      when(mockBillRepository.nameExists('Updated Bill', excludeId: 'test-bill-id')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.update(updatedBill)).thenAnswer((_) async => Result.success(updatedBill));

      // Act - First validate name (reactive validation)
      final nameValidation = await validateBillNameUseCase('Updated Bill', excludeId: 'test-bill-id');
      // Then update bill
      final result = await updateBillUseCase(updatedBill);

      // Assert
      expect(nameValidation.isSuccess, true);
      expect(result.isSuccess, true);
      verify(mockBillRepository.nameExists('Updated Bill', excludeId: 'test-bill-id')).called(2); // Called once for validation, once for update
    });

    test('should prevent update when reactive validation detects duplicate', () async {
      // Arrange - Simulate reactive validation detecting duplicate during update
      final updatedBill = testBill.copyWith(name: 'Existing Bill');
      when(mockBillRepository.nameExists('Existing Bill', excludeId: 'test-bill-id')).thenAnswer((_) async => Result.success(true));

      // Act - Reactive validation detects duplicate
      final nameValidation = await validateBillNameUseCase('Existing Bill', excludeId: 'test-bill-id');
      // Attempt update anyway
      final result = await updateBillUseCase(updatedBill);

      // Assert
      expect(nameValidation.isError, true);
      expect(result.isError, true);
      expect((result.failureOrNull as Failure).message, contains('Bill names must be unique'));
      verify(mockBillRepository.nameExists('Existing Bill', excludeId: 'test-bill-id')).called(2); // Called once for validation, once for update
      verifyNever(mockBillRepository.update(updatedBill));
    });

    test('should handle rapid successive validation calls', () async {
      // Arrange - Simulate rapid validation calls (user typing quickly)
      when(mockBillRepository.nameExists('Test')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.nameExists('Test B')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.nameExists('Test Bi')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.nameExists('Test Bil')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.nameExists('Test Bill')).thenAnswer((_) async => Result.success(false));

      // Act - Simulate user typing "Test Bill" character by character
      final validations = await Future.wait([
        validateBillNameUseCase('Test'),
        validateBillNameUseCase('Test B'),
        validateBillNameUseCase('Test Bi'),
        validateBillNameUseCase('Test Bil'),
        validateBillNameUseCase('Test Bill'),
      ]);

      // Assert - All validations should succeed
      for (final validation in validations) {
        expect(validation.isSuccess, true);
      }
      verify(mockBillRepository.nameExists('Test')).called(1);
      verify(mockBillRepository.nameExists('Test B')).called(1);
      verify(mockBillRepository.nameExists('Test Bi')).called(1);
      verify(mockBillRepository.nameExists('Test Bil')).called(1);
      verify(mockBillRepository.nameExists('Test Bill')).called(1);
    });

    test('should handle validation state changes during editing', () async {
      // Arrange - Simulate validation state changing during editing
      // Start with unique name
      when(mockBillRepository.nameExists('New Bill')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.nameExists('Existing Bill')).thenAnswer((_) async => Result.success(true));

      // Act - User starts typing a new name
      var validation = await validateBillNameUseCase('New Bill');
      expect(validation.isSuccess, true);

      // User changes to an existing name
      validation = await validateBillNameUseCase('Existing Bill');
      expect(validation.isError, true);

      // User goes back to unique name
      validation = await validateBillNameUseCase('New Bill');
      expect(validation.isSuccess, true);
    });

    test('should validate case-insensitive duplicates reactively', () async {
      // Arrange - Repository handles case-insensitive matching
      when(mockBillRepository.nameExists('test bill')).thenAnswer((_) async => Result.success(true));
      when(mockBillRepository.nameExists('TEST BILL')).thenAnswer((_) async => Result.success(true));
      when(mockBillRepository.nameExists('Test Bill')).thenAnswer((_) async => Result.success(true));

      // Act - Test different cases
      final validation1 = await validateBillNameUseCase('test bill');
      final validation2 = await validateBillNameUseCase('TEST BILL');
      final validation3 = await validateBillNameUseCase('Test Bill');

      // Assert - All should fail due to case-insensitive duplicate detection
      expect(validation1.isError, true);
      expect(validation2.isError, true);
      expect(validation3.isError, true);
    });

    test('should handle validation timeout scenarios', () async {
      // Arrange - Simulate slow repository response
      when(mockBillRepository.nameExists('Test Bill')).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1)); // Simulate delay
        return Result.success(false);
      });

      // Act - Start validation
      final validationFuture = validateBillNameUseCase('Test Bill');

      // Assert - Should eventually succeed (in real app, might have timeout handling)
      final validation = await validationFuture;
      expect(validation.isSuccess, true);
    });

    test('should maintain validation state consistency across operations', () async {
      // Arrange - Ensure validation state is consistent
      when(mockBillRepository.nameExists('Unique Bill')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.nameExists('Duplicate Bill')).thenAnswer((_) async => Result.success(true));

      // Act - Validate name first
      final nameValidation = await validateBillNameUseCase('Unique Bill');
      expect(nameValidation.isSuccess, true);

      // Create bill with validated name
      final bill = testBill.copyWith(name: 'Unique Bill');
      when(mockBillRepository.add(bill)).thenAnswer((_) async => Result.success(bill));
      final createResult = await createBillUseCase(bill);
      expect(createResult.isSuccess, true);

      // Now try to create another bill with same name - should fail
      final duplicateValidation = await validateBillNameUseCase('Duplicate Bill');
      expect(duplicateValidation.isError, true);
    });
  });
}