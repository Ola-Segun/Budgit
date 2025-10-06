import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/budget.dart';
import '../repositories/budget_repository.dart';

/// Use case for getting all budgets
class GetBudgets {
  const GetBudgets(this._repository);

  final BudgetRepository _repository;

  /// Execute the use case
  Future<Result<List<Budget>>> call() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get budgets: $e'));
    }
  }
}

/// Use case for getting active budgets
class GetActiveBudgets {
  const GetActiveBudgets(this._repository);

  final BudgetRepository _repository;

  /// Execute the use case
  Future<Result<List<Budget>>> call() async {
    try {
      return await _repository.getActive();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get active budgets: $e'));
    }
  }
}

/// Use case for getting budget by ID
class GetBudgetById {
  const GetBudgetById(this._repository);

  final BudgetRepository _repository;

  /// Execute the use case
  Future<Result<Budget?>> call(String id) async {
    try {
      if (id.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Budget ID cannot be empty',
          {'id': 'ID is required'},
        ));
      }

      return await _repository.getById(id);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get budget: $e'));
    }
  }
}