import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

/// Use case for updating an existing bill
class UpdateBill {
  const UpdateBill(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<Bill>> call(Bill bill) async {
    try {
      // Validate bill
      final validationResult = _validateBill(bill);
      if (validationResult.isError) {
        return validationResult;
      }

      // Update bill
      return await _repository.update(bill);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to update bill: $e'));
    }
  }

  /// Validate bill data
  Result<Bill> _validateBill(Bill bill) {
    // Use the bill's built-in validation
    return bill.validate();
  }
}