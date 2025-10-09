import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../repositories/bill_repository.dart';

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