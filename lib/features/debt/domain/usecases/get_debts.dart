import '../../../../core/error/result.dart';
import '../entities/debt.dart';
import '../repositories/debt_repository.dart';

/// Use case for getting all debts
class GetDebts {
  const GetDebts(this._repository);

  final DebtRepository _repository;

  Future<Result<List<Debt>>> call() => _repository.getAll();
}

/// Use case for getting active debts
class GetActiveDebts {
  const GetActiveDebts(this._repository);

  final DebtRepository _repository;

  Future<Result<List<Debt>>> call() => _repository.getActive();
}

/// Use case for getting debt by ID
class GetDebtById {
  const GetDebtById(this._repository);

  final DebtRepository _repository;

  Future<Result<Debt?>> call(String id) => _repository.getById(id);
}

/// Use case for getting overdue debts
class GetOverdueDebts {
  const GetOverdueDebts(this._repository);

  final DebtRepository _repository;

  Future<Result<List<Debt>>> call() => _repository.getOverdue();
}