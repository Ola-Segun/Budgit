import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/bills/domain/entities/bill.dart';
import 'package:budget_tracker/features/bills/domain/repositories/bill_repository.dart';
import 'package:budget_tracker/features/bills/domain/usecases/update_bill.dart';

@GenerateMocks([BillRepository, AccountRepository])
import 'update_bill_test.mocks.dart';

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

  late UpdateBill updateBillUseCase;
  late MockBillRepository mockBillRepository;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockBillRepository = MockBillRepository();
    mockAccountRepository = MockAccountRepository();
    updateBillUseCase = UpdateBill(mockBillRepository, mockAccountRepository);
  });

  tearDown(() {
    reset(mockBillRepository);
    reset(mockAccountRepository);
  });

  group('UpdateBill - Duplicate Name Validation', () {
    final testBill = Bill(
      id: 'test-bill-id',
      name: 'Test Bill',
      amount: 100.0,
      dueDate: DateTime.now().add(const Duration(days: 7)),
      frequency: BillFrequency.monthly,
      categoryId: 'test-category',
    );

    test('should succeed when renaming to same name', () async {
      // Arrange
      when(mockBillRepository.nameExists('Test Bill', excludeId: 'test-bill-id')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.update(testBill)).thenAnswer((_) async => Result.success(testBill));

      // Act
      final result = await updateBillUseCase(testBill);

      // Assert
      expect(result.isSuccess, true);
      verify(mockBillRepository.nameExists('Test Bill', excludeId: 'test-bill-id')).called(1);
      verify(mockBillRepository.update(testBill)).called(1);
    });

    test('should succeed when renaming to unique name', () async {
      // Arrange
      final updatedBill = testBill.copyWith(name: 'Updated Bill');
      when(mockBillRepository.nameExists('Updated Bill', excludeId: 'test-bill-id')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.update(updatedBill)).thenAnswer((_) async => Result.success(updatedBill));

      // Act
      final result = await updateBillUseCase(updatedBill);

      // Assert
      expect(result.isSuccess, true);
      verify(mockBillRepository.nameExists('Updated Bill', excludeId: 'test-bill-id')).called(1);
      verify(mockBillRepository.update(updatedBill)).called(1);
    });

    test('should fail when renaming to existing name', () async {
      // Arrange
      final updatedBill = testBill.copyWith(name: 'Existing Bill');
      when(mockBillRepository.nameExists('Existing Bill', excludeId: 'test-bill-id')).thenAnswer((_) async => Result.success(true));

      // Act
      final result = await updateBillUseCase(updatedBill);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      expect((result.failureOrNull as Failure).message, contains('Bill names must be unique'));
      verify(mockBillRepository.nameExists('Existing Bill', excludeId: 'test-bill-id')).called(1);
      verifyNever(mockBillRepository.update(updatedBill));
    });

    test('should handle repository error during name validation', () async {
      // Arrange
      final updatedBill = testBill.copyWith(name: 'New Name');
      when(mockBillRepository.nameExists('New Name', excludeId: 'test-bill-id')).thenAnswer((_) async => Result.error(Failure.unknown('Repository error')));

      // Act
      final result = await updateBillUseCase(updatedBill);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      expect((result.failureOrNull as Failure).message, 'Repository error');
      verify(mockBillRepository.nameExists('New Name', excludeId: 'test-bill-id')).called(1);
      verifyNever(mockBillRepository.update(any));
    });

    test('should handle bill validation failure', () async {
      // Arrange
      final invalidBill = testBill.copyWith(amount: -50.0); // Invalid amount

      // Act
      final result = await updateBillUseCase(invalidBill);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      expect((result.failureOrNull as Failure).message, contains('Bill amount must be greater than zero'));
      verifyZeroInteractions(mockBillRepository);
      verifyZeroInteractions(mockAccountRepository);
    });

    test('should handle account validation failure when account is specified', () async {
      // Arrange
      final billWithAccount = testBill.copyWith(accountId: 'test-account');
      when(mockBillRepository.nameExists('Test Bill', excludeId: 'test-bill-id')).thenAnswer((_) async => Result.success(false));
      when(mockAccountRepository.getById('test-account')).thenAnswer((_) async => Result.error(Failure.notFound('Account not found')));

      // Act
      final result = await updateBillUseCase(billWithAccount);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      expect((result.failureOrNull as Failure).message, 'Account not found');
      verify(mockBillRepository.nameExists('Test Bill', excludeId: 'test-bill-id')).called(1);
      verify(mockAccountRepository.getById('test-account')).called(1);
      verifyNever(mockBillRepository.update(any));
    });

    test('should succeed when account validation passes', () async {
      // Arrange
      final billWithAccount = testBill.copyWith(accountId: 'test-account');
      when(mockBillRepository.nameExists('Test Bill', excludeId: 'test-bill-id')).thenAnswer((_) async => Result.success(false));
      when(mockAccountRepository.getById('test-account')).thenAnswer((_) async => Result.success(null)); // Account exists but not needed for this test
      when(mockBillRepository.update(billWithAccount)).thenAnswer((_) async => Result.success(billWithAccount));

      // Act
      final result = await updateBillUseCase(billWithAccount);

      // Assert
      expect(result.isSuccess, true);
      verify(mockBillRepository.nameExists('Test Bill', excludeId: 'test-bill-id')).called(1);
      verify(mockAccountRepository.getById('test-account')).called(1);
      verify(mockBillRepository.update(billWithAccount)).called(1);
    });

    test('should skip account validation when accountId is null', () async {
      // Arrange
      final billWithoutAccount = testBill.copyWith(accountId: null);
      when(mockBillRepository.nameExists('Test Bill', excludeId: 'test-bill-id')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.update(billWithoutAccount)).thenAnswer((_) async => Result.success(billWithoutAccount));

      // Act
      final result = await updateBillUseCase(billWithoutAccount);

      // Assert
      expect(result.isSuccess, true);
      verify(mockBillRepository.nameExists('Test Bill', excludeId: 'test-bill-id')).called(1);
      verifyZeroInteractions(mockAccountRepository);
      verify(mockBillRepository.update(billWithoutAccount)).called(1);
    });

    test('should handle repository error during bill update', () async {
      // Arrange
      when(mockBillRepository.nameExists('Test Bill', excludeId: 'test-bill-id')).thenAnswer((_) async => Result.success(false));
      when(mockBillRepository.update(testBill)).thenAnswer((_) async => Result.error(Failure.unknown('Update failed')));

      // Act
      final result = await updateBillUseCase(testBill);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<Failure>());
      expect((result.failureOrNull as Failure).message, 'Update failed');
      verify(mockBillRepository.nameExists('Test Bill', excludeId: 'test-bill-id')).called(1);
      verify(mockBillRepository.update(testBill)).called(1);
    });
  });
}