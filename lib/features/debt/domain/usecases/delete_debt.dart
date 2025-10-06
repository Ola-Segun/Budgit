import '../../../../core/error/result.dart';
import '../repositories/debt_repository.dart';

/// Use case for deleting a debt
class DeleteDebt {
  const DeleteDebt(this._repository);

  final DebtRepository _repository;

  Future<Result<void>> call(String id) => _repository.delete(id);
}