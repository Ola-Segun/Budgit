import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/accounts/domain/usecases/delete_account.dart';

import 'delete_account_test.mocks.dart';

@GenerateMocks([AccountRepository])

void main() {
   late DeleteAccount useCase;
   late MockAccountRepository mockRepository;

   setUpAll(() {
     provideDummy<Result<void>>(Result.error(Failure.unknown('Dummy error')));
   });

   setUp(() {
     mockRepository = MockAccountRepository();
     useCase = DeleteAccount(mockRepository);
     // Stub delete for any string to return success by default
     when(mockRepository.delete(any))
         .thenAnswer((_) async => Result.success(null));
   });

  group('DeleteAccount Use Case', () {
    const accountId = 'test-account-id';

    test('should delete account successfully', () async {
      // Arrange
      when(mockRepository.delete(accountId))
          .thenAnswer((_) async => Result.success(null));

      // Act
      final result = await useCase(accountId);

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockRepository.delete(accountId)).called(1);
    });

    test('should handle repository failure', () async {
      // Arrange
      when(mockRepository.delete(accountId))
          .thenAnswer((_) async => Result.error(Failure.cache('Database error')));

      // Act
      final result = await useCase(accountId);

      // Assert
      expect(result, isA<Error<void>>());
      result.when(
        success: (_) => fail('Should not succeed'),
        error: (failure) {
          expect(failure, isA<CacheFailure>());
        },
      );
    });

    test('should handle unknown errors', () async {
       // Arrange
       when(mockRepository.delete(accountId))
           .thenAnswer((_) async => Result.error(Failure.unknown('Unexpected error')));

       // Act
       final result = await useCase(accountId);

       // Assert
       expect(result, isA<Error<void>>());
       result.when(
         success: (_) => fail('Should not succeed'),
         error: (failure) {
           expect(failure, isA<UnknownFailure>());
         },
       );
     });

    test('should handle empty account ID', () async {
      // Arrange
      const emptyId = '';

      // Act
      final result = await useCase(emptyId);

      // Assert
      // The usecase doesn't validate empty ID, it just passes it to repository
      // So it will depend on what the repository returns
      verify(mockRepository.delete(emptyId)).called(1);
    });
  });
}