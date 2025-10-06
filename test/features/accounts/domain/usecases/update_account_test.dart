import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/core/error/failures.dart';
import '../../../../../lib/core/error/result.dart';
import '../../../../../lib/features/accounts/domain/entities/account.dart';
import '../../../../../lib/features/accounts/domain/repositories/account_repository.dart';
import '../../../../../lib/features/accounts/domain/usecases/update_account.dart';

// Mock classes
class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  late UpdateAccount useCase;
  late MockAccountRepository mockRepository;

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
      when(mockRepository.update(any as Account))
          .thenAnswer((_) async => Result.success(updatedAccount));

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
      verify(mockRepository.update(any as Account)).called(1);
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
      verifyNever(mockRepository.update(any as Account));
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
      verifyNever(mockRepository.update(any as Account));
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
      verifyNever(mockRepository.update(any as Account));
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
      verifyNever(mockRepository.update(any as Account));
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
          expect(failure.message, contains('credit limit'));
        },
      );
      verifyNever(mockRepository.update(any as Account));
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
      verifyNever(mockRepository.update(any as Account));
    });

    test('should handle repository failure', () async {
      // Arrange
      when(mockRepository.update(any as Account))
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
      when(mockRepository.update(any as Account))
          .thenThrow(Exception('Unexpected error'));

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
      when(mockRepository.update(any as Account))
          .thenAnswer((_) async => Result.success(creditCard));

      // Act
      final result = await useCase(creditCard);

      // Assert
      expect(result, isA<Success<Account>>());
      verify(mockRepository.update(any as Account)).called(1);
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
      when(mockRepository.update(any as Account))
          .thenAnswer((_) async => Result.success(detailedAccount));

      // Act
      final result = await useCase(detailedAccount);

      // Assert
      expect(result, isA<Success<Account>>());
      verify(mockRepository.update(any as Account)).called(1);
    });
  });
}