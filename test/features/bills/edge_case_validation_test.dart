import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/bills/domain/usecases/validate_bill_account.dart';

@GenerateMocks([AccountRepository])
import 'edge_case_validation_test.mocks.dart';

void main() {
  late ValidateBillAccount useCase;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    useCase = ValidateBillAccount(mockAccountRepository);
  });

  group('Edge Case Validation Tests - Bill Account Selection', () {
    group('Boundary Value Testing', () {
      test('should handle zero balance account for bill creation', () async {
        // Arrange
        const accountId = 'zero_balance';
        final zeroBalanceAccount = Account(
          id: accountId,
          name: 'Zero Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: 0.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(zeroBalanceAccount));

        // Act - Try to create bill for any amount
        final result = await useCase(accountId, 100.0);

        // Assert - Should fail due to insufficient balance
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Insufficient balance',
        );
      });

      test('should handle exact balance match for bill creation', () async {
        // Arrange
        const accountId = 'exact_balance';
        final exactBalanceAccount = Account(
          id: accountId,
          name: 'Exact Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: 100.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(exactBalanceAccount));

        // Act - Create bill for exact balance amount
        final result = await useCase(accountId, 100.0);

        // Assert - Should succeed with exact match
        expect(result.isSuccess, true);
      });

      test('should handle negative balance account', () async {
        // Arrange
        const accountId = 'negative_balance';
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
        final result = await useCase(accountId, 100.0);

        // Assert - Should fail due to negative balance
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Insufficient balance',
        );
      });

      test('should handle very large bill amounts', () async {
        // Arrange
        const accountId = 'large_balance';
        final largeBalanceAccount = Account(
          id: accountId,
          name: 'Large Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: 1000000.0, // 1 million
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(largeBalanceAccount));

        // Act - Create bill for very large amount
        final result = await useCase(accountId, 999999.0);

        // Assert - Should succeed
        expect(result.isSuccess, true);
      });

      test('should handle very small bill amounts', () async {
        // Arrange
        const accountId = 'small_balance';
        final smallBalanceAccount = Account(
          id: accountId,
          name: 'Small Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: 1.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(smallBalanceAccount));

        // Act - Create bill for very small amount
        final result = await useCase(accountId, 0.01);

        // Assert - Should succeed
        expect(result.isSuccess, true);
      });
    });

    group('Credit Card Edge Cases', () {
      test('should handle credit card at exactly credit limit', () async {
        // Arrange
        const accountId = 'at_limit_card';
        final atLimitCard = Account(
          id: accountId,
          name: 'At Limit Card',
          type: AccountType.creditCard,
          cachedBalance: 1000.0, // At credit limit
          creditLimit: 1000.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(atLimitCard));

        // Act - Try to create bill
        final result = await useCase(accountId, 100.0);

        // Assert - Should fail (no available credit)
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Insufficient balance',
        );
      });

      test('should handle credit card over limit', () async {
        // Arrange
        const accountId = 'over_limit_card';
        final overLimitCard = Account(
          id: accountId,
          name: 'Over Limit Card',
          type: AccountType.creditCard,
          cachedBalance: 1200.0, // Over credit limit
          creditLimit: 1000.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(overLimitCard));

        // Act
        final result = await useCase(accountId, 100.0);

        // Assert - Should fail
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Insufficient balance',
        );
      });

      test('should handle credit card with null credit limit', () async {
        // Arrange
        const accountId = 'no_limit_card';
        final noLimitCard = Account(
          id: accountId,
          name: 'No Limit Card',
          type: AccountType.creditCard,
          cachedBalance: 500.0,
          isActive: true,
          // No creditLimit set
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(noLimitCard));

        // Act
        final result = await useCase(accountId, 100.0);

        // Assert - Should fail due to calculation error
        expect(result.isError, true);
      });

      test('should handle credit card with zero credit limit', () async {
        // Arrange
        const accountId = 'zero_limit_card';
        final zeroLimitCard = Account(
          id: accountId,
          name: 'Zero Limit Card',
          type: AccountType.creditCard,
          cachedBalance: 0.0,
          creditLimit: 0.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(zeroLimitCard));

        // Act
        final result = await useCase(accountId, 100.0);

        // Assert - Should fail
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Insufficient balance',
        );
      });
    });

    group('Payment Validation Edge Cases', () {
      test('should handle zero payment amount', () async {
        // Arrange
        const accountId = 'test_account';
        final account = Account(
          id: accountId,
          name: 'Test Account',
          type: AccountType.bankAccount,
          cachedBalance: 1000.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(account));

        // Act - Try zero payment
        final result = await useCase.callForPayment(accountId, 0.0);

        // Assert - Should fail
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Insufficient funds for payment',
        );
      });

      test('should handle negative payment amount', () async {
        // Arrange
        const accountId = 'test_account';
        final account = Account(
          id: accountId,
          name: 'Test Account',
          type: AccountType.bankAccount,
          cachedBalance: 1000.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(account));

        // Act - Try negative payment
        final result = await useCase.callForPayment(accountId, -50.0);

        // Assert - Should fail
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Insufficient funds for payment',
        );
      });

      test('should handle payment exactly matching available balance', () async {
        // Arrange
        const accountId = 'exact_match';
        final exactMatchAccount = Account(
          id: accountId,
          name: 'Exact Match Account',
          type: AccountType.bankAccount,
          cachedBalance: 500.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(exactMatchAccount));

        // Act - Payment exactly matching balance
        final result = await useCase.callForPayment(accountId, 500.0);

        // Assert - Should succeed
        expect(result.isSuccess, true);
      });

      test('should handle very large payment amounts', () async {
        // Arrange
        const accountId = 'large_balance';
        final largeBalanceAccount = Account(
          id: accountId,
          name: 'Large Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: 1000000.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(largeBalanceAccount));

        // Act - Very large payment
        final result = await useCase.callForPayment(accountId, 999999.99);

        // Assert - Should succeed
        expect(result.isSuccess, true);
      });
    });

    group('Account State Edge Cases', () {
      test('should handle account with NaN balance', () async {
        // Arrange
        const accountId = 'nan_balance';
        final nanBalanceAccount = Account(
          id: accountId,
          name: 'NaN Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: double.nan,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(nanBalanceAccount));

        // Act
        final result = await useCase(accountId, 100.0);

        // Assert - Should handle gracefully (may succeed or fail depending on implementation)
        // The important thing is it doesn't crash
        expect(result.isSuccess || result.isError, true);
      });

      test('should handle account with infinite balance', () async {
        // Arrange
        const accountId = 'infinite_balance';
        final infiniteBalanceAccount = Account(
          id: accountId,
          name: 'Infinite Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: double.infinity,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(infiniteBalanceAccount));

        // Act
        final result = await useCase(accountId, 100.0);

        // Assert - Should succeed (infinite balance means unlimited funds)
        expect(result.isSuccess, true);
      });

      test('should handle account with negative infinite balance', () async {
        // Arrange
        const accountId = 'negative_infinite_balance';
        final negativeInfiniteBalanceAccount = Account(
          id: accountId,
          name: 'Negative Infinite Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: double.negativeInfinity,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(negativeInfiniteBalanceAccount));

        // Act
        final result = await useCase(accountId, 100.0);

        // Assert - Should fail
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Insufficient balance',
        );
      });

      test('should handle account with very large balance', () async {
        // Arrange
        const accountId = 'very_large_balance';
        final veryLargeBalanceAccount = Account(
          id: accountId,
          name: 'Very Large Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: 1e15, // 1 quadrillion
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(veryLargeBalanceAccount));

        // Act
        final result = await useCase(accountId, 100.0);

        // Assert - Should succeed
        expect(result.isSuccess, true);
      });

      test('should handle account with very small positive balance', () async {
        // Arrange
        const accountId = 'tiny_balance';
        final tinyBalanceAccount = Account(
          id: accountId,
          name: 'Tiny Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: 0.000001, // Very small amount
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(tinyBalanceAccount));

        // Act - Try to create bill larger than balance
        final result = await useCase(accountId, 1.0);

        // Assert - Should fail
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Insufficient balance',
        );
      });
    });

    group('Repository Failure Edge Cases', () {
      test('should handle repository timeout', () async {
        // Arrange
        const accountId = 'timeout_account';
        when(mockAccountRepository.getById(accountId))
            .thenThrow(Exception('Timeout'));

        // Act
        final result = await useCase(accountId, 100.0);

        // Assert - Should fail gracefully
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Account not found',
        );
      });

      test('should handle repository returning null account', () async {
        // Arrange
        const accountId = 'null_account';
        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(null));

        // Act
        final result = await useCase(accountId, 100.0);

        // Assert - Should fail
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Account not found',
        );
      });

      test('should handle malformed account data', () async {
        // Arrange
        const accountId = 'malformed_account';
        final malformedAccount = Account(
          id: accountId,
          name: '', // Empty name
          type: AccountType.bankAccount,
          cachedBalance: double.nan, // Invalid balance
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(malformedAccount));

        // Act
        final result = await useCase(accountId, 100.0);

        // Assert - Should handle gracefully
        expect(result.isSuccess || result.isError, true);
      });
    });

    group('Concurrent Access Edge Cases', () {
      test('should handle rapid successive validations', () async {
        // Arrange
        const accountId = 'concurrent_account';
        final account = Account(
          id: accountId,
          name: 'Concurrent Account',
          type: AccountType.bankAccount,
          cachedBalance: 1000.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(account));

        // Act - Perform multiple validations rapidly
        final results = await Future.wait([
          useCase(accountId, 100.0),
          useCase(accountId, 200.0),
          useCase(accountId, 50.0),
        ]);

        // Assert - All should succeed (assuming no balance changes between calls)
        for (final result in results) {
          expect(result.isSuccess, true);
        }
      });

      test('should handle account balance changing between validation calls', () async {
        // Arrange
        const accountId = 'changing_balance';
        final initialAccount = Account(
          id: accountId,
          name: 'Changing Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: 1000.0,
          isActive: true,
        );

        final updatedAccount = Account(
          id: accountId,
          name: 'Changing Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: 100.0, // Balance reduced
          isActive: true,
        );

        // First call returns high balance
        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(initialAccount))
            .thenAnswer((_) async => Result.success(updatedAccount));

        // Act - Two successive validations
        final result1 = await useCase(accountId, 500.0); // Should succeed
        final result2 = await useCase(accountId, 500.0); // Should fail

        // Assert
        expect(result1.isSuccess, true);
        expect(result2.isError, true);
        expect(result2.failureOrNull, isA<ValidationFailure>());
        expect(
          (result2.failureOrNull as ValidationFailure).message,
          'Insufficient balance',
        );
      });
    });

    group('Input Validation Edge Cases', () {
      test('should handle empty account ID', () async {
        // Act
        final result = await useCase('', 100.0);

        // Assert - Should fail
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          'Account not found',
        );
      });

      test('should handle null account ID', () async {
        // Act
        final result = await useCase(null, 100.0);

        // Assert - Should succeed (optional for bill creation)
        expect(result.isSuccess, true);
      });

      test('should handle zero bill amount', () async {
        // Arrange
        const accountId = 'test_account';
        final account = Account(
          id: accountId,
          name: 'Test Account',
          type: AccountType.bankAccount,
          cachedBalance: 1000.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(account));

        // Act
        final result = await useCase(accountId, 0.0);

        // Assert - Should succeed (zero amount is valid for bill creation)
        expect(result.isSuccess, true);
      });

      test('should handle negative bill amount', () async {
        // Arrange
        const accountId = 'test_account';
        final account = Account(
          id: accountId,
          name: 'Test Account',
          type: AccountType.bankAccount,
          cachedBalance: 1000.0,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(account));

        // Act
        final result = await useCase(accountId, -100.0);

        // Assert - Should succeed (negative amounts might be valid for some bill types)
        expect(result.isSuccess, true);
      });

      test('should handle very large bill amounts', () async {
        // Arrange
        const accountId = 'large_balance';
        final largeBalanceAccount = Account(
          id: accountId,
          name: 'Large Balance Account',
          type: AccountType.bankAccount,
          cachedBalance: double.maxFinite,
          isActive: true,
        );

        when(mockAccountRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(largeBalanceAccount));

        // Act
        final result = await useCase(accountId, double.maxFinite);

        // Assert - Should succeed
        expect(result.isSuccess, true);
      });
    });
  });
}