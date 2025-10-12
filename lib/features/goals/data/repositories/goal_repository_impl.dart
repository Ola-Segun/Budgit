import 'package:flutter/foundation.dart';

import '../../../../core/error/result.dart';
import '../../../transactions/domain/repositories/transaction_category_repository.dart';
import '../../domain/entities/goal.dart';
import '../../domain/entities/goal_contribution.dart';
import '../../domain/entities/goal_progress.dart';
import '../../domain/repositories/goal_repository.dart';
import '../datasources/goal_hive_datasource.dart';

/// Implementation of GoalRepository using Hive data source
class GoalRepositoryImpl implements GoalRepository {
  const GoalRepositoryImpl(this._dataSource, this._transactionCategoryRepository);

  final GoalHiveDataSource _dataSource;
  final TransactionCategoryRepository _transactionCategoryRepository;

  @override
  Future<Result<List<Goal>>> getAll() => _dataSource.getAll();

  @override
  Future<Result<Goal?>> getById(String id) => _dataSource.getById(id);

  @override
  Future<Result<List<Goal>>> getActive() => _dataSource.getActive();

  @override
  Future<Result<List<Goal>>> getByPriority(GoalPriority priority) =>
      _dataSource.getByPriority(priority);

  @override
  Future<Result<List<Goal>>> getByCategoryId(String categoryId) =>
      _dataSource.getByCategoryId(categoryId);

  @override
  Future<Result<Goal>> add(Goal goal) => _dataSource.add(goal);

  @override
  Future<Result<Goal>> update(Goal goal) => _dataSource.update(goal);

  @override
  Future<Result<void>> delete(String id) => _dataSource.delete(id);

  @override
  Future<Result<List<GoalContribution>>> getContributions(String goalId) =>
      _dataSource.getContributions(goalId);

  @override
  Future<Result<Goal>> addContribution(String goalId, GoalContribution contribution) =>
      _dataSource.addContribution(goalId, contribution);

  @override
  Future<Result<void>> deleteContribution(String contributionId) =>
      _dataSource.deleteContribution(contributionId);

  @override
  Future<Result<GoalProgress>> getGoalProgress(String goalId) =>
      _dataSource.getGoalProgress(goalId);

  @override
  Future<Result<List<GoalProgress>>> getAllGoalProgress() =>
      _dataSource.getAllGoalProgress();

  @override
  Future<Result<List<Goal>>> search(String query) => _dataSource.search(query);

  @override
  Future<Result<int>> getCount() => _dataSource.getCount();

  @override
  Future<Result<List<Goal>>> getAllWithCategories() async {
    final goalsResult = await getAll();
    if (goalsResult.isError) {
      return goalsResult;
    }

    final goals = goalsResult.dataOrNull ?? [];
    final goalsWithCategories = <Goal>[];

    for (final goal in goals) {
      final categoryName = await _getCategoryName(goal.categoryId);
      // For now, we can't modify the Goal entity to include categoryName
      // So we return the goals as-is. Category name resolution should be done in presentation layer
      // using the _getCategoryName method or similar approach
      goalsWithCategories.add(goal);
    }

    return Result.success(goalsWithCategories);
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
}