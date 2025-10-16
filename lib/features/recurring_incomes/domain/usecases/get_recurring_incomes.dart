import '../../../../core/error/result.dart';
import '../entities/recurring_income.dart';
import '../repositories/recurring_income_repository.dart';

/// Use case for getting all recurring incomes
class GetRecurringIncomes {
  const GetRecurringIncomes(this._repository);

  final RecurringIncomeRepository _repository;

  /// Execute the use case
  Future<Result<List<RecurringIncome>>> call() => _repository.getAll();
}