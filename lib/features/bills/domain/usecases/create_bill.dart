import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../accounts/domain/repositories/account_repository.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';
import 'validate_bill_account.dart';

/// Use case for creating a new bill
class CreateBill {
  const CreateBill(
    this._repository,
    this._accountRepository,
  );

  final BillRepository _repository;
  final AccountRepository _accountRepository;

  /// Execute the use case
  Future<Result<Bill>> call(Bill bill) async {
    try {
      // Validate bill
      final validationResult = await _validateBill(bill);
      if (validationResult.isError) {
        return Result.error(validationResult.failureOrNull!);
      }

      // Create bill
      return await _repository.add(bill);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to create bill: $e'));
    }
  }

  /// Validate bill data including account validation
  Future<Result<Bill>> _validateBill(Bill bill) async {
    // First, use the bill's built-in validation
    final billValidation = bill.validate();
    if (billValidation.isError) {
      return billValidation;
    }

    // Then validate account if specified
    if (bill.accountId != null) {
      final accountValidator = ValidateBillAccount(_accountRepository);
      final accountValidation = await accountValidator(bill.accountId, bill.amount);
      if (accountValidation.isError) {
        return Result.error(accountValidation.failureOrNull!);
      }
    }

    return Result.success(bill);
  }
}