import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/dashboard_data.dart';
import '../repositories/dashboard_repository.dart';

/// Use case for getting comprehensive dashboard data
class GetDashboardData {
  const GetDashboardData(this._repository);

  final DashboardRepository _repository;

  /// Execute the use case
  Future<Result<DashboardData>> call() async {
    try {
      return await _repository.getDashboardData();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get dashboard data: $e'));
    }
  }
}