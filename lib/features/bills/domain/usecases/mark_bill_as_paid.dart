import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

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