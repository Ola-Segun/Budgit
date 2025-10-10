import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/accounts/domain/usecases/reconcile_account_balance.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';

import 'reconcile_account_balance_test.mocks.dart';

@GenerateMocks([AccountRepository, TransactionRepository])

void main() {
  late ReconcileAccountBalance useCase;
  late MockAccountRepository mockAccountRepository;
  late MockTransactionRepository mockTransactionRepository;

  setUpAll(() {
    provideDummy<Result<Account?>>(Result.error(Failure.unknown('Dummy error')));
    provideDummy<Result<Account>>(Result.error(Failure.unknown('Dummy error')));
    provideDummy<Result<double>>(Result.error(Failure.unknown('Dummy error')));
  });

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    mockTransactionRepository = MockTransactionRepository();
    useCase = ReconcileAccountBalance(mockAccountRepository, mockTransactionRepository);
  });

  group('ReconcileAccountBalance Use Case', () {
    const accountId = 'account1';

    final testAccount = Account(
      id: accountId,
      name: 'Test Account',
      type: AccountType.bankAccount,
      cachedBalance: 1000.0,
      reconciledBalance: 950.0,
    );

    test('should successfully reconcile when discrepancy exists', () async {
      // Arrange
      final calculatedBalance = 1050.0; // Discrepancy of 50.0
      final now = DateTime.now();

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(testAccount));
      when(mockTransactionRepository.getCalculatedBalance(accountId))
          .thenAnswer((_) async => Result.success(calculatedBalance));
      when(mockAccountRepository.update(any))
          .thenAnswer((_) async => Result.success(testAccount));

      // Act
      final result = await useCase(accountId);

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockAccountRepository.getById(accountId)).called(1);
      verify(mockTransactionRepository.getCalculatedBalance(accountId)).called(1);
      verify(mockAccountRepository.update(any)).called(2); // Update reconciliation + correct balance
    });

    test('should do nothing when balances match', () async {
      // Arrange
      final matchingBalance = 1000.0; // No discrepancy
      final accountWithMatchingBalance = testAccount.copyWith(
        cachedBalance: matchingBalance,
        reconciledBalance: matchingBalance,
      );

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(accountWithMatchingBalance));
      when(mockTransactionRepository.getCalculatedBalance(accountId))
          .thenAnswer((_) async => Result.success(matchingBalance));
      when(mockAccountRepository.update(any))
          .thenAnswer((_) async => Result.success(accountWithMatchingBalance));

      // Act
      final result = await useCase(accountId);

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockAccountRepository.getById(accountId)).called(1);
      verify(mockTransactionRepository.getCalculatedBalance(accountId)).called(1);
      verify(mockAccountRepository.update(any)).called(1); // Only update reconciliation fields
    });

    test('should handle account not found error', () async {
      // Arrange
      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.error(Failure.notFound('Account not found')));

      // Act
      final result = await useCase(accountId);

      // Assert
      expect(result, isA<Error<void>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) => expect(failure, isA<NotFoundFailure>()),
      );
      verify(mockAccountRepository.getById(accountId)).called(1);
      verifyNever(mockTransactionRepository.getCalculatedBalance(any));
    });

    test('should handle null account gracefully', () async {
      // Arrange
      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(null));

      // Act
      final result = await useCase(accountId);

      // Assert
      expect(result, isA<Error<void>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) => expect(failure, isA<NotFoundFailure>()),
      );
      verify(mockAccountRepository.getById(accountId)).called(1);
      verifyNever(mockTransactionRepository.getCalculatedBalance(any));
    });

    test('should handle balance calculation failure gracefully', () async {
      // Arrange
      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(testAccount));
      when(mockTransactionRepository.getCalculatedBalance(accountId))
          .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

      // Act
      final result = await useCase(accountId);

      // Assert
      expect(result, isA<Success<void>>()); // Should succeed despite calculation failure
      verify(mockAccountRepository.getById(accountId)).called(1);
      verify(mockTransactionRepository.getCalculatedBalance(accountId)).called(1);
      verifyNever(mockAccountRepository.update(any)); // No updates due to calculation failure
    });

    test('should handle account update failure', () async {
      // Arrange
      final calculatedBalance = 1050.0;
      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(testAccount));
      when(mockTransactionRepository.getCalculatedBalance(accountId))
          .thenAnswer((_) async => Result.success(calculatedBalance));
      when(mockAccountRepository.update(any))
          .thenAnswer((_) async => Result.error(Failure.cache('Update failed')));

      // Act
      final result = await useCase(accountId);

      // Assert
      expect(result, isA<Error<void>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) => expect(failure, isA<CacheFailure>()),
      );
    });

    test('should handle edge case with zero balances', () async {
      // Arrange
      final zeroAccount = testAccount.copyWith(
        cachedBalance: 0.0,
        reconciledBalance: null,
        balance: null,
      );
      final calculatedBalance = 0.0;

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(zeroAccount));
      when(mockTransactionRepository.getCalculatedBalance(accountId))
          .thenAnswer((_) async => Result.success(calculatedBalance));
      when(mockAccountRepository.update(any))
          .thenAnswer((_) async => Result.success(zeroAccount));

      // Act
      final result = await useCase(accountId);

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockAccountRepository.update(any)).called(1); // Only reconciliation update
    });

    test('should handle negative balances correctly', () async {
      // Arrange
      final negativeAccount = testAccount.copyWith(
        cachedBalance: -100.0,
        reconciledBalance: -50.0,
      );
      final calculatedBalance = -150.0; // Larger discrepancy

      when(mockAccountRepository.getById(accountId))
          .thenAnswer((_) async => Result.success(negativeAccount));
      when(mockTransactionRepository.getCalculatedBalance(accountId))
          .thenAnswer((_) async => Result.success(calculatedBalance));
      when(mockAccountRepository.update(any))
          .thenAnswer((_) async => Result.success(negativeAccount));

      // Act
      final result = await useCase(accountId);

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockAccountRepository.update(any)).called(2); // Reconciliation + correction
    });

    test('should handle unexpected errors gracefully', () async {
      // Arrange
      when(mockAccountRepository.getById(accountId))
          .thenThrow(Exception('Unexpected error'));

      // Act
      final result = await useCase(accountId);

      // Assert
      expect(result, isA<Success<void>>()); // Should succeed despite unexpected error
      verify(mockAccountRepository.getById(accountId)).called(1);
    });
  });
}