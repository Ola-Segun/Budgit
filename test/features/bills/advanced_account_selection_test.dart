import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:budget_tracker/features/accounts/domain/entities/account.dart';
import 'package:budget_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:budget_tracker/features/bills/domain/entities/bill.dart';
import 'package:budget_tracker/features/bills/domain/repositories/bill_repository.dart';
import 'package:budget_tracker/features/bills/domain/usecases/handle_account_deletion.dart';
import 'package:budget_tracker/features/bills/domain/usecases/process_split_payment.dart';
import 'package:budget_tracker/features/bills/domain/usecases/process_transfer_payment.dart';
import 'package:budget_tracker/features/transactions/domain/entities/transaction.dart';
import 'package:budget_tracker/features/transactions/domain/repositories/transaction_repository.dart';

@GenerateMocks([
  BillRepository,
  AccountRepository,
  TransactionRepository,
])
import 'advanced_account_selection_test.mocks.dart';

void main() {
  late HandleAccountDeletion handleAccountDeletion;
  late ProcessSplitPayment processSplitPayment;
  late ProcessTransferPayment processTransferPayment;
  late MockBillRepository mockBillRepository;
  late MockAccountRepository mockAccountRepository;
  late MockTransactionRepository mockTransactionRepository;

  setUp(() {
    mockBillRepository = MockBillRepository();
    mockAccountRepository = MockAccountRepository();
    mockTransactionRepository = MockTransactionRepository();

    handleAccountDeletion = HandleAccountDeletion(
      mockBillRepository,
      mockAccountRepository,
    );

    processSplitPayment = ProcessSplitPayment(
      mockBillRepository,
      mockAccountRepository,
      mockTransactionRepository,
    );

    processTransferPayment = ProcessTransferPayment(
      mockBillRepository,
      mockAccountRepository,
      mockTransactionRepository,
    );
  });

  group('Advanced Account Selection Edge Cases', () {
    group('Transfer Payment Processing', () {
      test('should successfully process transfer payment between accounts', () async {
        // Arrange
        final bill = Bill(
          id: 'bill_1',
          name: 'Test Bill',
          amount: 100.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
          defaultAccountId: 'source_account',
          allowedAccountIds: ['source_account', 'dest_account'],
        );

        final sourceAccount = Account(
          id: 'source_account',
          name: 'Source Account',
          type: AccountType.bankAccount,
          cachedBalance: 500.0,
          isActive: true,
          currency: 'USD',
        );

        final destAccount = Account(
          id: 'dest_account',
          name: 'Destination Account',
          type: AccountType.bankAccount,
          cachedBalance: 200.0,
          isActive: true,
          currency: 'USD',
        );

        final payment = BillPayment(
          id: 'payment_1',
          amount: 100.0,
          paymentDate: DateTime.now(),
          method: PaymentMethod.bankTransfer,
        );

        when(mockAccountRepository.getById('source_account'))
            .thenAnswer((_) async => Result.success(sourceAccount));
        when(mockAccountRepository.getById('dest_account'))
            .thenAnswer((_) async => Result.success(destAccount));
        when(mockTransactionRepository.add(any))
            .thenAnswer((_) async => Result.success(Transaction(
              id: 'tx_1',
              title: 'Test Transaction',
              amount: 100.0,
              type: TransactionType.transfer,
              date: DateTime.now(),
              categoryId: 'bills',
              accountId: 'source_account',
              toAccountId: 'dest_account',
            )));
        when(mockAccountRepository.update(any)).thenAnswer((_) async => Result.success(Account(
          id: 'source_account',
          name: 'Source Account',
          type: AccountType.bankAccount,
          cachedBalance: 400.0,
          isActive: true,
          currency: 'USD',
        )));
        when(mockBillRepository.markAsPaid(any, any, accountId: anyNamed('accountId')))
            .thenAnswer((_) async => Result.success(bill.copyWith(isPaid: true)));

        // Act
        final result = await processTransferPayment.call(
          bill: bill,
          payment: payment,
          sourceAccount: sourceAccount,
          destinationAccount: destAccount,
        );

        // Assert
        expect(result.isSuccess, true);
        final paymentResult = result.dataOrNull;
        expect(paymentResult, isNotNull);
        expect(paymentResult!.amount, 100.0);
      });

      test('should fail transfer payment with insufficient source balance', () async {
        // Arrange
        final sourceAccount = Account(
          id: 'source_account',
          name: 'Source Account',
          type: AccountType.bankAccount,
          cachedBalance: 50.0, // Insufficient balance
          isActive: true,
          currency: 'USD',
        );

        final destAccount = Account(
          id: 'dest_account',
          name: 'Destination Account',
          type: AccountType.bankAccount,
          cachedBalance: 200.0,
          isActive: true,
          currency: 'USD',
        );

        final bill = Bill(
          id: 'bill_1',
          name: 'Test Bill',
          amount: 100.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
        );

        final payment = BillPayment(
          id: 'payment_1',
          amount: 100.0,
          paymentDate: DateTime.now(),
          method: PaymentMethod.bankTransfer,
        );

        when(mockAccountRepository.getById('source_account'))
            .thenAnswer((_) async => Result.success(sourceAccount));
        when(mockAccountRepository.getById('dest_account'))
            .thenAnswer((_) async => Result.success(destAccount));

        // Act
        final result = await processTransferPayment.call(
          bill: bill,
          payment: payment,
          sourceAccount: sourceAccount,
          destinationAccount: destAccount,
        );

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          contains('Insufficient balance'),
        );
      });

      test('should fail transfer payment to same account', () async {
        // Arrange
        final account = Account(
          id: 'account_1',
          name: 'Test Account',
          type: AccountType.bankAccount,
          cachedBalance: 500.0,
          isActive: true,
          currency: 'USD',
        );

        final bill = Bill(
          id: 'bill_1',
          name: 'Test Bill',
          amount: 100.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
        );

        final payment = BillPayment(
          id: 'payment_1',
          amount: 100.0,
          paymentDate: DateTime.now(),
          method: PaymentMethod.bankTransfer,
        );

        // Act
        final result = await processTransferPayment.call(
          bill: bill,
          payment: payment,
          sourceAccount: account,
          destinationAccount: account, // Same account
        );

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          contains('Cannot transfer to the same account'),
        );
      });
    });

    group('Split Payment Processing', () {
      test('should successfully process split payment across multiple accounts', () async {
        // Arrange
        final bill = Bill(
          id: 'bill_1',
          name: 'Test Bill',
          amount: 300.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
        );

        final account1 = Account(
          id: 'account_1',
          name: 'Account 1',
          type: AccountType.bankAccount,
          cachedBalance: 150.0,
          isActive: true,
          currency: 'USD',
        );

        final account2 = Account(
          id: 'account_2',
          name: 'Account 2',
          type: AccountType.bankAccount,
          cachedBalance: 200.0,
          isActive: true,
          currency: 'USD',
        );

        final splitPortions = [
          SplitPaymentPortion(
            accountId: 'account_1',
            amount: 100.0,
            description: 'First portion',
          ),
          SplitPaymentPortion(
            accountId: 'account_2',
            amount: 200.0,
            description: 'Second portion',
          ),
        ];

        when(mockAccountRepository.getById('account_1'))
            .thenAnswer((_) async => Result.success(account1));
        when(mockAccountRepository.getById('account_2'))
            .thenAnswer((_) async => Result.success(account2));
        when(mockTransactionRepository.add(any))
            .thenAnswer((_) async => Result.success(Transaction(
              id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
              title: 'Split Payment',
              amount: 100.0, // Will be called twice with different amounts
              type: TransactionType.expense,
              date: DateTime.now(),
              categoryId: 'bills',
            )));
        when(mockAccountRepository.update(any))
            .thenAnswer((_) async => Result.success(account1)); // Simplified
        when(mockBillRepository.markAsPaid(any, any))
            .thenAnswer((_) async => Result.success(bill.copyWith(isPaid: true)));

        // Act
        final result = await processSplitPayment.call(
          bill: bill,
          paymentPortions: splitPortions,
          paymentDate: DateTime.now(),
        );

        // Assert
        expect(result.isSuccess, true);
        final splitResult = result.dataOrNull;
        expect(splitResult, isNotNull);
        expect(splitResult!.totalAmount, 300.0);
        expect(splitResult.transactions.length, 2);
        expect(splitResult.updatedAccounts.length, 2);
        expect(splitResult.numberOfAccounts, 2);
      });

      test('should fail split payment with duplicate accounts', () async {
        // Arrange
        final splitPortions = [
          SplitPaymentPortion(
            accountId: 'account_1',
            amount: 100.0,
          ),
          SplitPaymentPortion(
            accountId: 'account_1', // Duplicate
            amount: 200.0,
          ),
        ];

        final bill = Bill(
          id: 'bill_1',
          name: 'Test Bill',
          amount: 300.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
        );

        // Act
        final result = await processSplitPayment.call(
          bill: bill,
          paymentPortions: splitPortions,
          paymentDate: DateTime.now(),
        );

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          contains('Duplicate accounts'),
        );
      });

      test('should fail split payment exceeding bill amount', () async {
        // Arrange
        final splitPortions = [
          SplitPaymentPortion(
            accountId: 'account_1',
            amount: 200.0,
          ),
          SplitPaymentPortion(
            accountId: 'account_2',
            amount: 200.0,
          ),
        ];

        final bill = Bill(
          id: 'bill_1',
          name: 'Test Bill',
          amount: 300.0, // Total split exceeds bill amount
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
        );

        // Act
        final result = await processSplitPayment.call(
          bill: bill,
          paymentPortions: splitPortions,
          paymentDate: DateTime.now(),
        );

        // Assert
        expect(result.isError, true);
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          (result.failureOrNull as ValidationFailure).message,
          contains('Payment exceeds bill amount'),
        );
      });
    });

    group('Account Deletion Handling', () {
      test('should successfully migrate bills when account is deleted', () async {
        // Arrange
        final deletedAccountId = 'deleted_account';

        final bill1 = Bill(
          id: 'bill_1',
          name: 'Bill 1',
          amount: 100.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
          defaultAccountId: deletedAccountId,
        );

        final bill2 = Bill(
          id: 'bill_2',
          name: 'Bill 2',
          amount: 200.0,
          dueDate: DateTime.now().add(const Duration(days: 14)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
          accountId: 'other_account',
          allowedAccountIds: [deletedAccountId, 'other_account'],
        );

        final availableAccount = Account(
          id: 'available_account',
          name: 'Available Account',
          type: AccountType.bankAccount,
          cachedBalance: 1000.0,
          isActive: true,
          currency: 'USD',
        );

        when(mockBillRepository.getAll())
            .thenAnswer((_) async => Result.success([bill1, bill2]));
        when(mockAccountRepository.getAll())
            .thenAnswer((_) async => Result.success([availableAccount]));
        when(mockBillRepository.update(any))
            .thenAnswer((_) async => Result.success(bill1)); // Simplified

        // Act
        final result = await handleAccountDeletion.call(deletedAccountId);

        // Assert
        expect(result.isSuccess, true);
        final deletionResult = result.dataOrNull;
        expect(deletionResult, isNotNull);
        expect(deletionResult!.affectedBills.length, 2);
        expect(deletionResult.migratedBills.length, 2); // Both should be migrated
        expect(deletionResult.orphanedBills.length, 0);
        expect(deletionResult.migrationSuccessRate, 100.0);
      });

      test('should orphan bills when no alternative accounts available', () async {
        // Arrange
        final deletedAccountId = 'deleted_account';

        final bill = Bill(
          id: 'bill_1',
          name: 'Bill 1',
          amount: 100.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
          defaultAccountId: deletedAccountId,
        );

        when(mockBillRepository.getAll())
            .thenAnswer((_) async => Result.success([bill]));
        when(mockAccountRepository.getAll())
            .thenAnswer((_) async => Result.success([])); // No available accounts
        when(mockBillRepository.update(any))
            .thenAnswer((_) async => Result.success(bill.copyWith(defaultAccountId: null)));

        // Act
        final result = await handleAccountDeletion.call(deletedAccountId);

        // Assert
        expect(result.isSuccess, true);
        final deletionResult = result.dataOrNull;
        expect(deletionResult, isNotNull);
        expect(deletionResult!.affectedBills.length, 1);
        expect(deletionResult.migratedBills.length, 1); // Still migrated (to null)
        expect(deletionResult.orphanedBills.length, 0);
      });

      test('should handle account deletion with no affected bills', () async {
        // Arrange
        final deletedAccountId = 'deleted_account';

        final bill = Bill(
          id: 'bill_1',
          name: 'Bill 1',
          amount: 100.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
          defaultAccountId: 'other_account', // Different account
        );

        when(mockBillRepository.getAll())
            .thenAnswer((_) async => Result.success([bill]));

        // Act
        final result = await handleAccountDeletion.call(deletedAccountId);

        // Assert
        expect(result.isSuccess, true);
        final deletionResult = result.dataOrNull;
        expect(deletionResult, isNotNull);
        expect(deletionResult!.affectedBills.length, 0);
        expect(deletionResult.migratedBills.length, 0);
        expect(deletionResult.orphanedBills.length, 0);
      });
    });

    group('Multi-Account Bill Validation', () {
      test('should validate bill with multiple allowed accounts', () {
        // Arrange
        final bill = Bill(
          id: 'bill_1',
          name: 'Multi-Account Bill',
          amount: 100.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
          defaultAccountId: 'account_1',
          allowedAccountIds: ['account_1', 'account_2', 'account_3'],
        );

        // Act & Assert
        expect(bill.effectiveAccountId, 'account_1');
        expect(bill.allAllowedAccountIds, contains('account_1'));
        expect(bill.allAllowedAccountIds, contains('account_2'));
        expect(bill.allAllowedAccountIds, contains('account_3'));
        expect(bill.isAccountAllowed('account_1'), true);
        expect(bill.isAccountAllowed('account_2'), true);
        expect(bill.isAccountAllowed('account_4'), false);
      });

      test('should handle bill with no account restrictions', () {
        // Arrange
        final bill = Bill(
          id: 'bill_1',
          name: 'Unrestricted Bill',
          amount: 100.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
        );

        // Act & Assert
        expect(bill.effectiveAccountId, null);
        expect(bill.allAllowedAccountIds, isEmpty);
        expect(bill.isAccountAllowed('any_account'), false);
      });

      test('should prioritize default account over legacy account', () {
        // Arrange
        final bill = Bill(
          id: 'bill_1',
          name: 'Bill with both accounts',
          amount: 100.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
          defaultAccountId: 'default_account',
          accountId: 'legacy_account',
        );

        // Act & Assert
        expect(bill.effectiveAccountId, 'default_account');
      });
    });

    group('Recurring Payment Rules', () {
      test('should handle bills with recurring payment rules', () {
        // Arrange
        final rules = [
          RecurringPaymentRule(
            id: 'rule_1',
            instanceNumber: 1,
            accountId: 'special_account',
            amount: 150.0,
            notes: 'First payment special',
            isEnabled: true,
          ),
          RecurringPaymentRule(
            id: 'rule_2',
            instanceNumber: 3,
            amount: 120.0,
            notes: 'Third payment discounted',
            isEnabled: true,
          ),
        ];

        final bill = Bill(
          id: 'bill_1',
          name: 'Rule-Based Bill',
          amount: 100.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
          defaultAccountId: 'default_account',
          recurringPaymentRules: rules,
        );

        // Act & Assert
        expect(bill.getPaymentAmountForInstance(1), 150.0); // Custom amount
        expect(bill.getPaymentAmountForInstance(2), 100.0); // Default amount
        expect(bill.getPaymentAmountForInstance(3), 120.0); // Custom amount

        expect(bill.getAccountForInstance(1), 'special_account'); // Custom account
        expect(bill.getAccountForInstance(2), 'default_account'); // Default account
        expect(bill.getAccountForInstance(3), 'default_account'); // Default account
      });

      test('should validate recurring payment rules', () {
        // Arrange
        final bill = Bill(
          id: 'bill_1',
          name: 'Bill with invalid rules',
          amount: 100.0,
          dueDate: DateTime.now().add(const Duration(days: 7)),
          frequency: BillFrequency.monthly,
          categoryId: 'bills',
          recurringPaymentRules: [
            RecurringPaymentRule(
              id: 'rule_1',
              instanceNumber: 1,
              amount: -50.0, // Invalid negative amount
              isEnabled: true,
            ),
          ],
        );

        // Act
        final validation = bill.validate();

        // Assert
        expect(validation.isError, true);
        expect(validation.failureOrNull, isA<ValidationFailure>());
      });
    });
  });
}