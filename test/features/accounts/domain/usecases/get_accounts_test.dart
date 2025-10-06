import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/accounts/domain/usecases/get_accounts.dart';

import 'get_accounts_test.mocks.dart';

@GenerateMocks([AccountRepository])
void main() {
   late GetAccounts useCase;
   late MockAccountRepository mockRepository;

   setUpAll(() {
     provideDummy<Result<List<Account>>>(Result.error(Failure.unknown('Dummy error')));
   });

   setUp(() {
     mockRepository = MockAccountRepository();
     useCase = GetAccounts(mockRepository);
   });

  group('GetAccounts Use Case', () {
    final testAccounts = [
      Account(
        id: '1',
        name: 'Checking Account',
        type: AccountType.bankAccount,
        balance: 1000.0,
        institution: 'Test Bank',
      ),
      Account(
        id: '2',
        name: 'Credit Card',
        type: AccountType.creditCard,
        balance: 500.0,
        creditLimit: 5000.0,
        institution: 'Test Card',
      ),
    ];

    test('should return all accounts successfully', () async {
      // Arrange
      when(mockRepository.getAll())
          .thenAnswer((_) async => Result.success(testAccounts));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Success<List<Account>>>());
      result.when(
        success: (accounts) {
          expect(accounts, testAccounts);
          expect(accounts.length, 2);
        },
        error: (_) => fail('Should not error'),
      );
      verify(mockRepository.getAll()).called(1);
    });

    test('should return empty list when no accounts', () async {
      // Arrange
      when(mockRepository.getAll())
          .thenAnswer((_) async => Result.success(<Account>[]));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Success<List<Account>>>());
      result.when(
        success: (accounts) {
          expect(accounts, isEmpty);
        },
        error: (_) => fail('Should not error'),
      );
    });

    test('should handle repository failure', () async {
      // Arrange
      when(mockRepository.getAll())
          .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<Error<List<Account>>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<CacheFailure>());
        },
      );
    });

    test('should handle unknown errors', () async {
       // Arrange
       when(mockRepository.getAll())
           .thenAnswer((_) async => Result.error(Failure.unknown('Unexpected error')));

       // Act
       final result = await useCase();

       // Assert
       expect(result, isA<Error<List<Account>>>());
       result.when(
         success: (_) => fail('Should not succeed'),
         error: (failure) {
           expect(failure, isA<UnknownFailure>());
         },
       );
     });
  });
}