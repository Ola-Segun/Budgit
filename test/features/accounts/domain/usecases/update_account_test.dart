import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/accounts/domain/usecases/update_account.dart';

import 'update_account_test.mocks.dart';

@GenerateMocks([AccountRepository])

void main() {
   late UpdateAccount useCase;
   late MockAccountRepository mockRepository;

   setUpAll(() {
     provideDummy<Result<Account>>(Result.error(Failure.unknown('Dummy error')));
   });

   setUp(() {
     mockRepository = MockAccountRepository();
     useCase = UpdateAccount(mockRepository);
   });

  group('UpdateAccount Use Case', () {
    final testAccount = Account(
      id: 'test-id',
      name: 'Test Account',
      type: AccountType.bankAccount,
      balance: 1000.0,
    );

    final updatedAccount = testAccount.copyWith(
      name: 'Updated Account',
      balance: 1500.0,
    );

    test('should update account successfully', () async {
       // Arrange
       final expectedAccount = updatedAccount.copyWith(updatedAt: DateTime.now());
       when(mockRepository.update(any))
           .thenAnswer((_) async => Result.success(expectedAccount));

       // Act
       final result = await useCase(updatedAccount);

       // Assert
       expect(result, isA<Success<Account>>());
       result.when(
         success: (account) {
           expect(account.name, 'Updated Account');
           expect(account.balance, 1500.0);
           expect(account.updatedAt, isNotNull);
         },
         error: (_) => fail('Should not error'),
       );
       verify(mockRepository.update(any)).called(1);
     });

    test('should return validation error for empty ID', () async {
      // Arrange
      final invalidAccount = updatedAccount.copyWith(id: '');

      // Act
      final result = await useCase(invalidAccount);

      // Assert
      expect(result, isA<Error<Account>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('ID'));
        },
      );
      verifyNever(mockRepository.update(any));
    });

    test('should return validation error for empty name', () async {
      // Arrange
      final invalidAccount = updatedAccount.copyWith(name: '');

      // Act
      final result = await useCase(invalidAccount);

      // Assert
      expect(result, isA<Error<Account>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('name'));
        },
      );
      verifyNever(mockRepository.update(any));
    });

    test('should return validation error for NaN balance', () async {
      // Arrange
      final invalidAccount = updatedAccount.copyWith(balance: double.nan);

      // Act
      final result = await useCase(invalidAccount);

      // Assert
      expect(result, isA<Error<Account>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('balance'));
        },
      );
      verifyNever(mockRepository.update(any));
    });

    test('should return validation error for infinite balance', () async {
      // Arrange
      final invalidAccount = updatedAccount.copyWith(balance: double.infinity);

      // Act
      final result = await useCase(invalidAccount);

      // Assert
      expect(result, isA<Error<Account>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('balance'));
        },
      );
      verifyNever(mockRepository.update(any));
    });

    test('should return validation error for credit card without credit limit', () async {
      // Arrange
      final invalidAccount = updatedAccount.copyWith(
        type: AccountType.creditCard,
        creditLimit: null,
      );

      // Act
      final result = await useCase(invalidAccount);

      // Assert
      expect(result, isA<Error<Account>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('Credit limit'));
        },
      );
      verifyNever(mockRepository.update(any));
    });

    test('should return validation error for credit card balance exceeding limit', () async {
      // Arrange
      final invalidAccount = updatedAccount.copyWith(
        type: AccountType.creditCard,
        balance: 6000.0,
        creditLimit: 5000.0,
      );

      // Act
      final result = await useCase(invalidAccount);

      // Assert
      expect(result, isA<Error<Account>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, contains('exceed'));
        },
      );
      verifyNever(mockRepository.update(any));
    });

    test('should handle repository failure', () async {
      // Arrange
      when(mockRepository.update(any))
          .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

      // Act
      final result = await useCase(updatedAccount);

      // Assert
      expect(result, isA<Error<Account>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<CacheFailure>());
        },
      );
    });

    test('should handle unknown errors', () async {
      // Arrange
      when(mockRepository.update(any))
          .thenAnswer((_) async => Result.error(Failure.unknown('Unexpected error')));

      // Act
      final result = await useCase(updatedAccount);

      // Assert
      expect(result, isA<Error<Account>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<UnknownFailure>());
        },
      );
    });

    test('should accept valid credit card account update', () async {
      // Arrange
      final creditCard = updatedAccount.copyWith(
        type: AccountType.creditCard,
        balance: 1000.0,
        creditLimit: 5000.0,
      );
      when(mockRepository.update(any))
          .thenAnswer((_) async => Result.success(creditCard));

      // Act
      final result = await useCase(creditCard);

      // Assert
      expect(result, isA<Success<Account>>());
      verify(mockRepository.update(any)).called(1);
    });

    test('should accept account with all optional fields', () async {
      // Arrange
      final detailedAccount = updatedAccount.copyWith(
        description: 'Updated account',
        institution: 'Updated Bank',
        accountNumber: '987654321',
        currency: 'EUR',
        creditLimit: 10000.0,
        availableCredit: 8500.0,
        interestRate: 4.5,
        minimumPayment: 150.0,
        dueDate: DateTime(2025, 12, 1),
        isActive: false,
      );
      when(mockRepository.update(any))
          .thenAnswer((_) async => Result.success(detailedAccount));

      // Act
      final result = await useCase(detailedAccount);

      // Assert
      expect(result, isA<Success<Account>>());
      verify(mockRepository.update(any)).called(1);
    });
  });
}