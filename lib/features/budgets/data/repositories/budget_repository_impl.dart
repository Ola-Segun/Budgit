import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/budget.dart';
import '../../domain/repositories/budget_repository.dart';
import '../datasources/budget_hive_datasource.dart';

/// Implementation of BudgetRepository using Hive data source
class BudgetRepositoryImpl implements BudgetRepository {
  const BudgetRepositoryImpl(this._dataSource);

  final BudgetHiveDataSource _dataSource;

  @override
  Future<Result<List<Budget>>> getAll() => _dataSource.getAll();

  @override
  Future<Result<Budget?>> getById(String id) => _dataSource.getById(id);

  @override
  Future<Result<List<Budget>>> getActive() => _dataSource.getActive();

  @override
  Future<Result<List<Budget>>> getByDateRange(DateTime start, DateTime end) =>
      _dataSource.getByDateRange(start, end);

  @override
  Future<Result<Budget>> add(Budget budget) => _dataSource.add(budget);

  @override
  Future<Result<Budget>> update(Budget budget) => _dataSource.update(budget);

  @override
  Future<Result<void>> delete(String id) => _dataSource.delete(id);

  @override
  Future<Result<BudgetStatus>> getBudgetStatus(String budgetId) async {
    // This is a complex operation that requires transaction data
    // For now, return a basic implementation
    // In a full implementation, this would calculate spending vs budget
    final budgetResult = await _dataSource.getById(budgetId);

    if (budgetResult.isError) {
      return Result.error(budgetResult.failureOrNull!);
    }

    final budget = budgetResult.dataOrNull;
    if (budget == null) {
      return Result.error(Failure.validation(
        'Budget not found',
        {'budgetId': 'Budget does not exist'},
      ));
    }

    // TODO: Calculate actual spending from transactions
    // For now, return a placeholder status
    final status = BudgetStatus(
      budget: budget,
      totalSpent: 0.0, // Would be calculated from transactions
      totalBudget: budget.totalBudget,
      categoryStatuses: budget.categories.map((category) {
        return CategoryStatus(
          categoryId: category.id,
          spent: 0.0, // Would be calculated from transactions
          budget: category.amount,
          percentage: 0.0,
          status: BudgetHealth.healthy,
        );
      }).toList(),
      daysRemaining: budget.remainingDays,
    );

    return Result.success(status);
  }

  @override
  Future<Result<List<BudgetStatus>>> getAllBudgetStatuses() async {
    final budgetsResult = await _dataSource.getActive();

    if (budgetsResult.isError) {
      return Result.error(budgetsResult.failureOrNull!);
    }

    final budgets = budgetsResult.dataOrNull ?? [];
    final statuses = <BudgetStatus>[];

    for (final budget in budgets) {
      final statusResult = await getBudgetStatus(budget.id);
      if (statusResult.isSuccess) {
        statuses.add(statusResult.dataOrNull!);
      }
    }

    return Result.success(statuses);
  }

  @override
  Future<Result<Budget>> duplicate(String budgetId, DateTime newStartDate, DateTime newEndDate) =>
      _dataSource.duplicate(budgetId, newStartDate, newEndDate);
}