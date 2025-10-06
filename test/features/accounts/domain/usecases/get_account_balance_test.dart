import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/accounts/domain/usecases/get_account_balance.dart';

import 'get_account_balance_test.mocks.dart';

@GenerateMocks([AccountRepository])

void main() {
   late GetAccountBalance useCase;
   late MockAccountRepository mockRepository;

   setUpAll(() {
     provideDummy<Result<double>>(Result.error(Failure.unknown('Dummy error')));
     provideDummy<Result<Account?>>(Result.error(Failure.unknown('Dummy error')));
   });

   setUp(() {
     mockRepository = MockAccountRepository();
     useCase = GetAccountBalance(mockRepository);
   });

  group('GetAccountBalance Use Case', () {
    const accountId = 'test-account-id';
    final testAccount = Account(
      id: accountId,
      name: 'Test Account',
      type: AccountType.bankAccount,
      balance: 1000.0,
    );

    group('getTotalBalance()', () {
      test('should return total balance successfully', () async {
        // Arrange
        const totalBalance = 5000.0;
        when(mockRepository.getTotalBalance())
            .thenAnswer((_) async => Result.success(totalBalance));

        // Act
        final result = await useCase.getTotalBalance();

        // Assert
        expect(result, isA<Success<double>>());
        result.when(
          success: (balance) => expect(balance, totalBalance),
          error: (_) => fail('Should not error'),
        );
        verify(mockRepository.getTotalBalance()).called(1);
      });

      test('should handle repository failure', () async {
        // Arrange
        when(mockRepository.getTotalBalance())
            .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

        // Act
        final result = await useCase.getTotalBalance();

        // Assert
        expect(result, isA<Error<double>>());
        result.when(
          success: (_) => fail('Should not succeed'),
          error: (failure) => expect(failure, isA<CacheFailure>()),
        );
      });
    });

    group('getNetWorth()', () {
      test('should return net worth successfully', () async {
        // Arrange
        const netWorth = 2500.0;
        when(mockRepository.getNetWorth())
            .thenAnswer((_) async => Result.success(netWorth));

        // Act
        final result = await useCase.getNetWorth();

        // Assert
        expect(result, isA<Success<double>>());
        result.when(
          success: (worth) => expect(worth, netWorth),
          error: (_) => fail('Should not error'),
        );
        verify(mockRepository.getNetWorth()).called(1);
      });

      test('should handle negative net worth', () async {
        // Arrange
        const negativeNetWorth = -1500.0;
        when(mockRepository.getNetWorth())
            .thenAnswer((_) async => Result.success(negativeNetWorth));

        // Act
        final result = await useCase.getNetWorth();

        // Assert
        expect(result, isA<Success<double>>());
        result.when(
          success: (worth) => expect(worth, negativeNetWorth),
          error: (_) => fail('Should not error'),
        );
      });
    });

    group('getAccountBalance()', () {
      test('should return account balance successfully', () async {
        // Arrange
        when(mockRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(testAccount));

        // Act
        final result = await useCase.getAccountBalance(accountId);

        // Assert
        expect(result, isA<Success<Account?>>());
        result.when(
          success: (account) {
            expect(account, isNotNull);
            expect(account!.id, accountId);
            expect(account.balance, 1000.0);
          },
          error: (_) => fail('Should not error'),
        );
        verify(mockRepository.getById(accountId)).called(1);
      });

      test('should return null for non-existent account', () async {
        // Arrange
        when(mockRepository.getById(accountId))
            .thenAnswer((_) async => Result.success(null));

        // Act
        final result = await useCase.getAccountBalance(accountId);

        // Assert
        expect(result, isA<Success<Account?>>());
        result.when(
          success: (account) => expect(account, isNull),
          error: (_) => fail('Should not error'),
        );
      });

      test('should handle repository failure', () async {
        // Arrange
        when(mockRepository.getById(accountId))
            .thenAnswer((_) async => Result.error(Failure.notFound('Account not found')));

        // Act
        final result = await useCase.getAccountBalance(accountId);

        // Assert
        expect(result, isA<Error<Account?>>());
        result.when(
          success: (_) => fail('Should not succeed'),
          error: (failure) => expect(failure, isA<NotFoundFailure>()),
        );
      });
    });
  });
}