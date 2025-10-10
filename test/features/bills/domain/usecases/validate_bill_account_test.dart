import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/core/error/failures.dart';
import '../../../../../lib/core/error/result.dart';
import '../../../../../lib/features/accounts/domain/entities/account.dart';
import '../../../../../lib/features/accounts/domain/repositories/account_repository.dart';
import '../../../../../lib/features/bills/domain/usecases/validate_bill_account.dart';

@GenerateMocks([AccountRepository])
import 'validate_bill_account_test.mocks.dart';

void main() {
  late ValidateBillAccount useCase;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    useCase = ValidateBillAccount(mockAccountRepository);
  });

  group('ValidateBillAccount - Bill Creation Validation', () {
    const billAmount = 100.0;

    test('should succeed when accountId is null (optional for bill creation)', () async {
      // Act
      final result = await useCase(null, billAmount);

      // Assert
      expect(result.isSuccess, true);
      verifyZeroInteractions(mockAccountRepository);
    });

    test('should fail when account does not exist', () async {
      // Arrange
      const accountId = 'nonexistent';
      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.error(Failure.notFound('Account not found')));

      // Act
      final result = await useCase(accountId, billAmount);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Account not found',
      );
    });

    test('should fail when account is inactive', () async {
      // Arrange
      const accountId = 'inactive_account';
      final inactiveAccount = Account(
        id: accountId,
        name: 'Inactive Account',
        type: AccountType.bankAccount,
        cachedBalance: 500.0,
        isActive: false,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(inactiveAccount));

      // Act
      final result = await useCase(accountId, billAmount);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Inactive account',
      );
    });

    test('should fail when account has insufficient balance', () async {
      // Arrange
      const accountId = 'low_balance_account';
      final lowBalanceAccount = Account(
        id: accountId,
        name: 'Low Balance Account',
        type: AccountType.bankAccount,
        cachedBalance: 50.0, // Less than bill amount of 100.0
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(lowBalanceAccount));

      // Act
      final result = await useCase(accountId, billAmount);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Insufficient balance',
      );

      final failure = result.failureOrNull as ValidationFailure;
      expect(failure.errors?['availableBalance'], '50.0');
      expect(failure.errors?['requiredAmount'], '100.0');
      expect(failure.errors?['shortfall'], '50.0');
    });

    test('should succeed when account has sufficient balance', () async {
      // Arrange
      const accountId = 'sufficient_balance_account';
      final sufficientBalanceAccount = Account(
        id: accountId,
        name: 'Sufficient Balance Account',
        type: AccountType.bankAccount,
        cachedBalance: 200.0, // More than bill amount of 100.0
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(sufficientBalanceAccount));

      // Act
      final result = await useCase(accountId, billAmount);

      // Assert
      expect(result.isSuccess, true);
    });

    test('should handle credit card available balance correctly', () async {
      // Arrange
      const accountId = 'credit_card_account';
      final creditCardAccount = Account(
        id: accountId,
        name: 'Credit Card',
        type: AccountType.creditCard,
        cachedBalance: 500.0, // Current balance (amount owed)
        creditLimit: 1000.0, // Credit limit
        isActive: true,
        // availableBalance should be 500.0 (1000 - 500)
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(creditCardAccount));

      // Act
      final result = await useCase(accountId, billAmount);

      // Assert
      expect(result.isSuccess, true); // 500 available >= 100 required
    });

    test('should fail when credit card has insufficient available credit', () async {
      // Arrange
      const accountId = 'maxed_credit_card';
      final maxedCreditCard = Account(
        id: accountId,
        name: 'Maxed Credit Card',
        type: AccountType.creditCard,
        cachedBalance: 950.0, // Current balance (amount owed)
        creditLimit: 1000.0, // Credit limit
        isActive: true,
        // availableBalance should be 50.0 (1000 - 950)
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(maxedCreditCard));

      // Act - Try to create bill for 100, but only 50 available
      final result = await useCase(accountId, billAmount);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Insufficient balance',
      );
    });
  });

  group('ValidateBillAccount - Payment Validation', () {
    const paymentAmount = 75.0;

    test('should fail when accountId is empty for payment', () async {
      // Act
      final result = await useCase.callForPayment('', paymentAmount);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Account required',
      );
    });

    test('should fail when account does not exist for payment', () async {
      // Arrange
      const accountId = 'nonexistent';
      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.error(Failure.notFound('Account not found')));

      // Act
      final result = await useCase.callForPayment(accountId, paymentAmount);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Account not found',
      );
    });

    test('should fail when account is inactive for payment', () async {
      // Arrange
      const accountId = 'inactive_account';
      final inactiveAccount = Account(
        id: accountId,
        name: 'Inactive Account',
        type: AccountType.bankAccount,
        cachedBalance: 500.0,
        isActive: false,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(inactiveAccount));

      // Act
      final result = await useCase.callForPayment(accountId, paymentAmount);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Inactive account',
      );
    });

    test('should fail when account has insufficient funds for payment', () async {
      // Arrange
      const accountId = 'insufficient_funds';
      final lowBalanceAccount = Account(
        id: accountId,
        name: 'Low Balance Account',
        type: AccountType.bankAccount,
        cachedBalance: 50.0, // Less than payment amount of 75.0
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(lowBalanceAccount));

      // Act
      final result = await useCase.callForPayment(accountId, paymentAmount);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Insufficient funds for payment',
      );

      final failure = result.failureOrNull as ValidationFailure;
      expect(failure.errors?['availableBalance'], '50.00');
      expect(failure.errors?['paymentAmount'], '75.00');
      expect(failure.errors?['shortfall'], '25.00');
    });

    test('should succeed when account has sufficient funds for payment', () async {
      // Arrange
      const accountId = 'sufficient_funds';
      final sufficientBalanceAccount = Account(
        id: accountId,
        name: 'Sufficient Balance Account',
        type: AccountType.bankAccount,
        cachedBalance: 200.0, // More than payment amount of 75.0
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(sufficientBalanceAccount));

      // Act
      final result = await useCase.callForPayment(accountId, paymentAmount);

      // Assert
      expect(result.isSuccess, true);
    });

    test('should handle credit card over-limit validation', () async {
      // Arrange
      const accountId = 'over_limit_card';
      final overLimitCard = Account(
        id: accountId,
        name: 'Over Limit Card',
        type: AccountType.creditCard,
        cachedBalance: 1100.0, // Current balance exceeds credit limit
        creditLimit: 1000.0,
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(overLimitCard));

      // Act
      final result = await useCase.callForPayment(accountId, paymentAmount);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Credit card over limit',
      );
    });

    test('should warn about high credit utilization for payments', () async {
      // Arrange
      const accountId = 'high_utilization_card';
      final highUtilizationCard = Account(
        id: accountId,
        name: 'High Utilization Card',
        type: AccountType.creditCard,
        cachedBalance: 850.0, // Current balance
        creditLimit: 1000.0, // After payment would be 850+75=925 (92.5% utilization)
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(highUtilizationCard));

      // Act
      final result = await useCase.callForPayment(accountId, paymentAmount);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'High credit utilization warning',
      );

      final failure = result.failureOrNull as ValidationFailure;
      expect(failure.errors?['projectedUtilization'], '92.5%');
    });

    test('should succeed with credit card that has available credit', () async {
      // Arrange
      const accountId = 'healthy_credit_card';
      final healthyCreditCard = Account(
        id: accountId,
        name: 'Healthy Credit Card',
        type: AccountType.creditCard,
        cachedBalance: 300.0, // Current balance
        creditLimit: 1000.0, // Available credit: 700
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(healthyCreditCard));

      // Act
      final result = await useCase.callForPayment(accountId, paymentAmount);

      // Assert
      expect(result.isSuccess, true);
    });
  });

  group('ValidateBillAccount - Account Details Retrieval', () {
    test('should return account validation details successfully', () async {
      // Arrange
      const accountId = 'test_account';
      final account = Account(
        id: accountId,
        name: 'Test Account',
        type: AccountType.bankAccount,
        cachedBalance: 500.0,
        isActive: true,
        reconciledBalance: 495.0, // Slight discrepancy
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(account));

      // Act
      final result = await useCase.getAccountDetails(accountId);

      // Assert
      expect(result.isSuccess, true);
      final details = result.dataOrNull!;
      expect(details.account.id, accountId);
      expect(details.availableBalance, 500.0);
      expect(details.isActive, true);
      expect(details.canMakePayment, true);
      expect(details.warnings, contains('Account balance may need reconciliation'));
    });

    test('should return warnings for inactive account', () async {
      // Arrange
      const accountId = 'inactive_account';
      final inactiveAccount = Account(
        id: accountId,
        name: 'Inactive Account',
        type: AccountType.bankAccount,
        cachedBalance: 100.0,
        isActive: false,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(inactiveAccount));

      // Act
      final result = await useCase.getAccountDetails(accountId);

      // Assert
      expect(result.isSuccess, true);
      final details = result.dataOrNull!;
      expect(details.canMakePayment, false);
      expect(details.warnings, contains('Account is inactive'));
    });

    test('should return warnings for negative balance', () async {
      // Arrange
      const accountId = 'negative_balance_account';
      final negativeBalanceAccount = Account(
        id: accountId,
        name: 'Negative Balance Account',
        type: AccountType.bankAccount,
        cachedBalance: -50.0,
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(negativeBalanceAccount));

      // Act
      final result = await useCase.getAccountDetails(accountId);

      // Assert
      expect(result.isSuccess, true);
      final details = result.dataOrNull!;
      expect(details.availableBalance, -50.0);
      expect(details.warnings, contains('Account has negative balance'));
    });

    test('should return warnings for high credit utilization', () async {
      // Arrange
      const accountId = 'high_utilization_card';
      final highUtilizationCard = Account(
        id: accountId,
        name: 'High Utilization Card',
        type: AccountType.creditCard,
        cachedBalance: 800.0,
        creditLimit: 1000.0, // 80% utilization
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(highUtilizationCard));

      // Act
      final result = await useCase.getAccountDetails(accountId);

      // Assert
      expect(result.isSuccess, true);
      final details = result.dataOrNull!;
      expect(details.warnings, contains('Credit utilization over 70%'));
    });

    test('should return critical warnings for over-limit credit card', () async {
      // Arrange
      const accountId = 'over_limit_card';
      final overLimitCard = Account(
        id: accountId,
        name: 'Over Limit Card',
        type: AccountType.creditCard,
        cachedBalance: 1100.0,
        creditLimit: 1000.0,
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(overLimitCard));

      // Act
      final result = await useCase.getAccountDetails(accountId);

      // Assert
      expect(result.isSuccess, true);
      final details = result.dataOrNull!;
      expect(details.hasCriticalWarnings, true);
      expect(details.warnings, contains('Credit card is over limit'));
    });
  });

  group('ValidateBillAccount - Edge Cases', () {
    test('should handle account with null cachedBalance (backward compatibility)', () async {
      // Arrange
      const accountId = 'legacy_account';
      final legacyAccount = Account(
        id: accountId,
        name: 'Legacy Account',
        type: AccountType.bankAccount,
        balance: 200.0, // Using old balance field
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(legacyAccount));

      // Act
      final result = await useCase(accountId, 100.0);

      // Assert
      expect(result.isSuccess, true);
    });

    test('should handle credit card with null credit limit', () async {
      // Arrange
      const accountId = 'card_without_limit';
      final cardWithoutLimit = Account(
        id: accountId,
        name: 'Card Without Limit',
        type: AccountType.creditCard,
        cachedBalance: 500.0,
        isActive: true,
        // No creditLimit set
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(cardWithoutLimit));

      // Act
      final result = await useCase(accountId, 100.0);

      // Assert - Should fail because availableBalance calculation fails
      expect(result.isError, true);
    });

    test('should handle zero balance account', () async {
      // Arrange
      const accountId = 'zero_balance_account';
      final zeroBalanceAccount = Account(
        id: accountId,
        name: 'Zero Balance Account',
        type: AccountType.bankAccount,
        cachedBalance: 0.0,
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(zeroBalanceAccount));

      // Act
      final result = await useCase(accountId, 100.0);

      // Assert
      expect(result.isError, true);
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(
        (result.failureOrNull as ValidationFailure).message,
        'Insufficient balance',
      );
    });

    test('should handle exact balance match for bill creation', () async {
      // Arrange
      const accountId = 'exact_balance_account';
      final exactBalanceAccount = Account(
        id: accountId,
        name: 'Exact Balance Account',
        type: AccountType.bankAccount,
        cachedBalance: 100.0,
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(exactBalanceAccount));

      // Act
      final result = await useCase(accountId, 100.0);

      // Assert - Should succeed with exact balance match
      expect(result.isSuccess, true);
    });

    test('should handle exact available credit match for credit card', () async {
      // Arrange
      const accountId = 'exact_credit_card';
      final exactCreditCard = Account(
        id: accountId,
        name: 'Exact Credit Card',
        type: AccountType.creditCard,
        cachedBalance: 900.0, // Used 900
        creditLimit: 1000.0, // Available 100
        isActive: true,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(exactCreditCard));

      // Act
      final result = await useCase(accountId, 100.0);

      // Assert - Should succeed with exact available credit match
      expect(result.isSuccess, true);
    });
  });
}