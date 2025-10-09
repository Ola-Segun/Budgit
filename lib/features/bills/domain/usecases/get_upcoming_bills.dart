import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

/// Use case for getting upcoming bills
class GetUpcomingBills {
  const GetUpcomingBills(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<List<Bill>>> call({int daysAhead = 30}) async {
    try {
      if (daysAhead <= 0) {
        return Result.error(Failure.validation(
          'Days ahead must be positive',
          {'daysAhead': 'Must be greater than 0'},
        ));
      }

      return await _repository.getDueWithin(daysAhead);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get upcoming bills: $e'));
    }
  }
}