import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../dashboard/domain/entities/dashboard_data.dart';
import '../../../transactions/domain/repositories/transaction_category_repository.dart';
import '../../domain/entities/budget.dart';
import '../../domain/repositories/budget_repository.dart';
import '../../domain/usecases/calculate_budget_status.dart';
import '../datasources/budget_hive_datasource.dart';

/// Implementation of BudgetRepository using Hive data source
class BudgetRepositoryImpl implements BudgetRepository {
  const BudgetRepositoryImpl(
    this._dataSource,
    this._calculateBudgetStatus,
    this._transactionCategoryRepository,
  );

  final BudgetHiveDataSource _dataSource;
  final CalculateBudgetStatus _calculateBudgetStatus;
  final TransactionCategoryRepository _transactionCategoryRepository;

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
    // Get budget first, then calculate status
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

    // Use the CalculateBudgetStatus use case for proper spending calculation
    return _calculateBudgetStatus(budget);
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

  @override
  Future<Result<List<BudgetCategoryOverview>>> getBudgetCategoryOverviews(String budgetId, {int limit = 5}) async {
    try {
      // Get budget first
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

      // Calculate budget status
      final statusResult = await _calculateBudgetStatus(budget);
      if (statusResult.isError) {
        return Result.error(statusResult.failureOrNull!);
      }

      final budgetStatus = statusResult.dataOrNull!;

      // Get category names asynchronously
      final categoryOverviews = <BudgetCategoryOverview>[];
      for (final status in budgetStatus.categoryStatuses) {
        final categoryName = await _getCategoryName(status.categoryId);
        categoryOverviews.add(BudgetCategoryOverview(
          categoryId: status.categoryId,
          categoryName: categoryName,
          spent: status.spent,
          budget: status.budget,
          percentage: status.percentage,
          status: _mapBudgetHealthToStatus(status.status),
        ));
      }

      categoryOverviews
          .sort((a, b) => b.spent.compareTo(a.spent)); // Sort by spending amount
      final limitedOverviews = categoryOverviews.take(limit).toList();

      return Result.success(limitedOverviews);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get budget category overviews: $e'));
    }
  }

  /// Get category name by ID using repository lookup
  Future<String> _getCategoryName(String categoryId) async {
    final result = await _transactionCategoryRepository.getById(categoryId);

    return result.when(
      success: (category) => category?.name ?? categoryId,
      error: (failure) {
        // Log error and return category ID as fallback
        debugPrint('Failed to get category name for $categoryId: $failure');
        return categoryId;
      },
    );
  }

  /// Map BudgetHealth to BudgetHealthStatus
  BudgetHealthStatus _mapBudgetHealthToStatus(BudgetHealth health) {
    switch (health) {
      case BudgetHealth.healthy:
        return BudgetHealthStatus.healthy;
      case BudgetHealth.warning:
        return BudgetHealthStatus.warning;
      case BudgetHealth.critical:
        return BudgetHealthStatus.critical;
      case BudgetHealth.overBudget:
        return BudgetHealthStatus.overBudget;
    }
  }
}