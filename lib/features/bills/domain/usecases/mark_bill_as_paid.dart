import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../accounts/domain/repositories/account_repository.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';
import 'validate_bill_account.dart';

/// Use case for marking a bill as paid
class MarkBillAsPaid {
  const MarkBillAsPaid(
    this._repository,
    this._accountRepository,
  );

  final BillRepository _repository;
  final AccountRepository _accountRepository;

  /// Execute the use case
  Future<Result<Bill>> call(String billId, BillPayment payment, {String? accountId}) async {
    try {
      // Validate payment
      final validationResult = await _validatePayment(payment, accountId);
      if (validationResult.isError) {
        return Result.error(validationResult.failureOrNull!);
      }

      // Mark bill as paid
      return await _repository.markAsPaid(billId, payment, accountId: accountId);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to mark bill as paid: $e'));
    }
  }

  /// Validate payment data and account
  Future<Result<BillPayment>> _validatePayment(BillPayment payment, String? accountId) async {
    // First, use the payment's built-in validation
    final paymentValidation = payment.validate();
    if (paymentValidation.isError) {
      return paymentValidation;
    }

    // Then validate account for payment (account is required for payments)
    if (accountId != null) {
      final accountValidator = ValidateBillAccount(_accountRepository);
      final accountValidation = await accountValidator.callForPayment(accountId, payment.amount);
      if (accountValidation.isError) {
        return Result.error(accountValidation.failureOrNull!);
      }
    } else {
      return Result.error(Failure.validation(
        'Account required for bill payment',
        {'accountId': 'Account selection is required for bill payments'},
      ));
    }

    return Result.success(payment);
  }
}