import '../../../../core/error/result.dart';
import '../entities/debt.dart';
import '../repositories/debt_repository.dart';

/// Use case for updating an existing debt
class UpdateDebt {
  const UpdateDebt(this._repository);

  final DebtRepository _repository;

  Future<Result<Debt>> call(Debt debt) => _repository.update(debt);
}

/// Use case for making a payment towards a debt
class MakeDebtPayment {
  const MakeDebtPayment(this._repository);

  final DebtRepository _repository;

  Future<Result<Debt>> call(String debtId, double amount, DateTime date) =>
      _repository.makePayment(debtId, amount, date);
}