import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/dashboard_data.dart';
import '../repositories/dashboard_repository.dart';

/// Use case for calculating comprehensive dashboard data asynchronously
class CalculateDashboardData {
  const CalculateDashboardData(this._repository);

  final DashboardRepository _repository;

  /// Calculate dashboard data with async computation and caching
  Future<Result<DashboardData>> call() async {
    try {
      return await _repository.getDashboardData();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to calculate dashboard data: $e'));
    }
  }

  /// Refresh dashboard data, bypassing any caches
  Future<Result<void>> refresh() async {
    try {
      return await _repository.refreshDashboardData();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to refresh dashboard data: $e'));
    }
  }
}