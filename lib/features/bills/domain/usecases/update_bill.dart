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

/// Use case for deleting a bill
class DeleteBill {
  const DeleteBill(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<void>> call(String billId) async {
    try {
      if (billId.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Bill ID cannot be empty',
          {'billId': 'ID is required'},
        ));
      }

      return await _repository.delete(billId);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to delete bill: $e'));
    }
  }
}

/// Use case for getting upcoming bills
class GetUpcomingBills {
  const GetUpcomingBills(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<List<Bill>>> call({int days = 30}) async {
    try {
      if (days < 0) {
        return Result.error(Failure.validation(
          'Days cannot be negative',
          {'days': 'Must be non-negative'},
        ));
      }

      return await _repository.getDueWithin(days);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get upcoming bills: $e'));
    }
  }
}