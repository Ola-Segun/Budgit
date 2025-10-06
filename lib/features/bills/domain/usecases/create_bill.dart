import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

/// Use case for creating a new bill
class CreateBill {
  const CreateBill(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<Bill>> call(Bill bill) async {
    try {
      // Validate bill
      final validationResult = _validateBill(bill);
      if (validationResult.isError) {
        return validationResult;
      }

      // Create bill
      return await _repository.add(bill);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to create bill: $e'));
    }
  }

  /// Validate bill data
  Result<Bill> _validateBill(Bill bill) {
    // Use the bill's built-in validation
    return bill.validate();
  }
}

/// Use case for marking a bill as paid
class MarkBillAsPaid {
  const MarkBillAsPaid(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<Bill>> call(String billId, BillPayment payment) async {
    try {
      // Validate payment
      final validationResult = _validatePayment(payment);
      if (validationResult.isError) {
        return Result.error(validationResult.failureOrNull!);
      }

      // Mark bill as paid
      return await _repository.markAsPaid(billId, payment);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to mark bill as paid: $e'));
    }
  }

  /// Validate payment data
  Result<BillPayment> _validatePayment(BillPayment payment) {
    // Use the payment's built-in validation
    return payment.validate();
  }
}

/// Use case for updating bill next due date
class UpdateBillNextDueDate {
  const UpdateBillNextDueDate(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<Bill>> call(String billId) async {
    try {
      if (billId.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Bill ID cannot be empty',
          {'billId': 'ID is required'},
        ));
      }

      return await _repository.updateNextDueDate(billId);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to update bill due date: $e'));
    }
  }
}