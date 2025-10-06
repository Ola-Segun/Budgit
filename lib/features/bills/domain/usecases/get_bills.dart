import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

/// Use case for getting all bills
class GetBills {
  const GetBills(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<List<Bill>>> call() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get bills: $e'));
    }
  }
}

/// Use case for getting bill by ID
class GetBillById {
  const GetBillById(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<Bill?>> call(String id) async {
    try {
      if (id.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Bill ID cannot be empty',
          {'id': 'ID is required'},
        ));
      }

      return await _repository.getById(id);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get bill: $e'));
    }
  }
}

/// Use case for getting bills due within specified days
class GetBillsDueWithin {
  const GetBillsDueWithin(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<List<Bill>>> call(int days) async {
    try {
      if (days < 0) {
        return Result.error(Failure.validation(
          'Days cannot be negative',
          {'days': 'Must be non-negative'},
        ));
      }

      return await _repository.getDueWithin(days);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get bills due within $days days: $e'));
    }
  }
}

/// Use case for getting overdue bills
class GetOverdueBills {
  const GetOverdueBills(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<List<Bill>>> call() async {
    try {
      return await _repository.getOverdue();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get overdue bills: $e'));
    }
  }
}