import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/bills/domain/entities/bill.dart';
import 'package:budget_tracker/features/bills/domain/repositories/bill_repository.dart';
import 'package:budget_tracker/features/bills/domain/usecases/mark_bill_as_paid.dart';

@GenerateMocks([BillRepository, AccountRepository])
import 'bill_payment_integration_test.mocks.dart';

void main() {
  late MarkBillAsPaid markBillAsPaid;
  late MockBillRepository mockBillRepository;
  late MockAccountRepository mockAccountRepository;

  setUpAll(() {
    provideDummy<Result<Bill>>(Result.error(Failure.unknown('dummy')));
    provideDummy<Result<Account>>(Result.error(Failure.unknown('dummy')));
    provideDummy<Result<Account?>>(Result.error(Failure.unknown('dummy')));
    provideDummy<Result<void>>(Result.error(Failure.unknown('dummy')));
  });

  setUp(() {
    mockBillRepository = MockBillRepository();
    mockAccountRepository = MockAccountRepository();
    markBillAsPaid = MarkBillAsPaid(mockBillRepository, mockAccountRepository);
  });

  group('Bill Payment Integration Tests', () {
    const accountId = 'acc_1';
    const billId = 'bill_1';

    final account = Account(
      id: accountId,
      name: 'Checking Account',
      type: AccountType.bankAccount,
      cachedBalance: 1000.0,
      isActive: true,
    );

    final bill = Bill(
      id: billId,
      name: 'Electricity Bill',
      amount: 150.0,
      dueDate: DateTime.now().add(const Duration(days: 5)),
      frequency: BillFrequency.monthly,
      categoryId: 'utilities',
      accountId: accountId,
    );

    test('should validate account before processing bill payment', () async {
      // Arrange
      final payment = BillPayment(
        id: 'payment_1',
        amount: 150.0,
        paymentDate: DateTime.now(),
        method: PaymentMethod.bankTransfer,
      );

      // Mock account with insufficient balance
      final insufficientAccount = account.copyWith(cachedBalance: 50.0); // Less than payment amount
      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(insufficientAccount));

      // Act
      final result = await markBillAsPaid(billId, payment, accountId: accountId);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Insufficient funds for payment',
      );

      // Verify bill was not marked as paid
      verifyNever(mockBillRepository.markAsPaid(any, any, accountId: anyNamed('accountId')));
    });

    test('should successfully process bill payment when validation passes', () async {
      // Arrange
      final payment = BillPayment(
        id: 'payment_1',
        amount: 150.0,
        paymentDate: DateTime.now(),
        method: PaymentMethod.bankTransfer,
      );

      final updatedBill = bill.copyWith(
        isPaid: true,
        paymentHistory: [payment],
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(account));
      when(mockBillRepository.markAsPaid(billId, payment, accountId: accountId))
          .thenAnswer((_) async => Result.success(updatedBill));

      // Act
      final result = await markBillAsPaid(billId, payment, accountId: accountId);

      // Assert
      expect(result.isSuccess, true);
      final resultBill = result.dataOrNull!;
      expect(resultBill.isPaid, true);
      expect(resultBill.paymentHistory.length, 1);
      expect(resultBill.paymentHistory.first.amount, 150.0);

      // Verify interactions
      verify(mockAccountRepository.getById(accountId)).called(1);
      verify(mockBillRepository.markAsPaid(billId, payment, accountId: accountId)).called(1);
    });

    test('should handle bill repository failure gracefully', () async {
      // Arrange
      final payment = BillPayment(
        id: 'payment_1',
        amount: 150.0,
        paymentDate: DateTime.now(),
        method: PaymentMethod.bankTransfer,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(account));
      when(mockBillRepository.markAsPaid(billId, payment, accountId: accountId))
          .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

      // Act
      final result = await markBillAsPaid(billId, payment, accountId: accountId);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<CacheFailure>());
    });

    test('should validate payment data before processing', () async {
      // Arrange - Invalid payment (zero amount)
      final invalidPayment = BillPayment(
        id: 'payment_1',
        amount: 0.0, // Invalid amount
        paymentDate: DateTime.now(),
        method: PaymentMethod.bankTransfer,
      );

      // Act
      final result = await markBillAsPaid(billId, invalidPayment, accountId: accountId);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Payment amount must be greater than zero',
      );

      // Verify no repository calls were made
      verifyZeroInteractions(mockAccountRepository);
      verifyZeroInteractions(mockBillRepository);
    });

    test('should require account ID for bill payments', () async {
      // Arrange
      final payment = BillPayment(
        id: 'payment_1',
        amount: 150.0,
        paymentDate: DateTime.now(),
        method: PaymentMethod.bankTransfer,
      );

      // Act - Call without accountId
      final result = await markBillAsPaid(billId, payment);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Account required for bill payment',
      );

      // Verify no repository calls were made
      verifyZeroInteractions(mockAccountRepository);
      verifyZeroInteractions(mockBillRepository);
    });

    test('should handle inactive account validation', () async {
      // Arrange
      final inactiveAccount = account.copyWith(isActive: false);

      final payment = BillPayment(
        id: 'payment_1',
        amount: 150.0,
        paymentDate: DateTime.now(),
        method: PaymentMethod.bankTransfer,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(inactiveAccount));

      // Act
      final result = await markBillAsPaid(billId, payment, accountId: accountId);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Inactive account',
      );

      // Verify bill was not processed
      verifyNever(mockBillRepository.markAsPaid(any, any, accountId: anyNamed('accountId')));
    });

    test('should handle credit card over-limit validation', () async {
      // Arrange - Credit card that's over limit (balance > credit limit)
      final overLimitCard = Account(
        id: accountId,
        name: 'Over Limit Card',
        type: AccountType.creditCard,
        cachedBalance: 1200.0, // Amount owed exceeds credit limit
        creditLimit: 1000.0,
        isActive: true,
      );

      final payment = BillPayment(
        id: 'payment_1',
        amount: 50.0, // Small payment that wouldn't trigger utilization warning
        paymentDate: DateTime.now(),
        method: PaymentMethod.creditCard,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(overLimitCard));

      // Act
      final result = await markBillAsPaid(billId, payment, accountId: accountId);

      // Assert - Since available balance is negative (-200), it should fail with insufficient funds
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Insufficient funds for payment',
      );

      // Verify bill was not processed
      verifyNever(mockBillRepository.markAsPaid(any, any, accountId: anyNamed('accountId')));
    });

    test('should handle high credit utilization warnings', () async {
      // Arrange - Credit card that would exceed 95% utilization after payment
      final highUtilizationCard = Account(
        id: accountId,
        name: 'High Utilization Card',
        type: AccountType.creditCard,
        cachedBalance: 900.0, // Current balance (90% utilization)
        creditLimit: 1000.0, // After payment of 60 would be 960 (96% utilization)
        isActive: true,
      );

      final payment = BillPayment(
        id: 'payment_1',
        amount: 60.0, // Would put utilization over 95%
        paymentDate: DateTime.now(),
        method: PaymentMethod.creditCard,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(highUtilizationCard));

      // Act
      final result = await markBillAsPaid(billId, payment, accountId: accountId);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'High credit utilization warning',
      );

      // Verify bill was not processed
      verifyNever(mockBillRepository.markAsPaid(any, any, accountId: anyNamed('accountId')));
    });
  });
}