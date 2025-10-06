import '../../../../core/error/result.dart';
import '../entities/debt.dart';
import '../repositories/debt_repository.dart';

/// Use case for creating a new debt
class CreateDebt {
  const CreateDebt(this._repository);

  final DebtRepository _repository;

  Future<Result<Debt>> call(Debt debt) => _repository.add(debt);
}