import '../../../../core/error/result.dart';
import '../../domain/entities/goal.dart';
import '../../domain/entities/goal_contribution.dart';
import '../../domain/entities/goal_progress.dart';
import '../../domain/repositories/goal_repository.dart';
import '../datasources/goal_hive_datasource.dart';

/// Implementation of GoalRepository using Hive data source
class GoalRepositoryImpl implements GoalRepository {
  const GoalRepositoryImpl(this._dataSource);

  final GoalHiveDataSource _dataSource;

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
  Future<Result<List<Goal>>> getByCategory(GoalCategory category) =>
      _dataSource.getByCategory(category);

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
}