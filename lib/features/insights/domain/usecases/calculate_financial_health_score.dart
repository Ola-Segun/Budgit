import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/insight.dart';
import '../repositories/insight_repository.dart';

/// Use case for calculating financial health score
class CalculateFinancialHealthScore {
  const CalculateFinancialHealthScore(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<FinancialHealthScore>> call() async {
    try {
      return await _repository.calculateFinancialHealthScore();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to calculate financial health score: $e'));
    }
  }
}

/// Use case for generating monthly summary
class GenerateMonthlySummary {
  const GenerateMonthlySummary(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<MonthlySummary>> call(DateTime month) async {
    try {
      // Validate month (should be a valid date)
      if (month.year < 2000 || month.year > 2100) {
        return Result.error(Failure.validation(
          'Invalid month year',
          {'month': 'Year must be between 2000 and 2100'},
        ));
      }

      return await _repository.generateMonthlySummary(month);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to generate monthly summary: $e'));
    }
  }
}

/// Use case for generating spending trends
class GenerateSpendingTrends {
  const GenerateSpendingTrends(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<List<SpendingTrend>>> call(DateTime startDate, DateTime endDate) async {
    try {
      // Validate date range
      if (startDate.isAfter(endDate)) {
        return Result.error(Failure.validation(
          'Start date cannot be after end date',
          {'startDate': 'Must be before end date'},
        ));
      }

      if (endDate.difference(startDate).inDays > 365) {
        return Result.error(Failure.validation(
          'Date range cannot exceed 365 days',
          {'dateRange': 'Maximum 365 days allowed'},
        ));
      }

      return await _repository.generateSpendingTrends(startDate, endDate);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to generate spending trends: $e'));
    }
  }
}

/// Use case for generating category analysis
class GenerateCategoryAnalysis {
  const GenerateCategoryAnalysis(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<List<CategoryAnalysis>>> call(DateTime period) async {
    try {
      return await _repository.generateCategoryAnalysis(period);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to generate category analysis: $e'));
    }
  }
}

/// Use case for clearing old insights
class ClearOldInsights {
  const ClearOldInsights(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<int>> call(int daysOld) async {
    try {
      if (daysOld <= 0) {
        return Result.error(Failure.validation(
          'Days old must be greater than zero',
          {'daysOld': 'Must be positive'},
        ));
      }

      if (daysOld < 30) {
        return Result.error(Failure.validation(
          'Cannot clear insights less than 30 days old',
          {'daysOld': 'Minimum 30 days required'},
        ));
      }

      return await _repository.clearOldInsights(daysOld);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to clear old insights: $e'));
    }
  }
}

/// Use case for creating financial reports
class CreateFinancialReport {
  const CreateFinancialReport(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<FinancialReport>> call(
    String title,
    String description,
    FinancialReportType type,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      // Validate inputs
      if (title.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Report title cannot be empty',
          {'title': 'Title is required'},
        ));
      }

      if (description.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Report description cannot be empty',
          {'description': 'Description is required'},
        ));
      }

      if (startDate.isAfter(endDate)) {
        return Result.error(Failure.validation(
          'Start date cannot be after end date',
          {'startDate': 'Must be before end date'},
        ));
      }

      if (endDate.difference(startDate).inDays > 365) {
        return Result.error(Failure.validation(
          'Report period cannot exceed 365 days',
          {'dateRange': 'Maximum 365 days allowed'},
        ));
      }

      return await _repository.createFinancialReport(
        title,
        description,
        type,
        startDate,
        endDate,
      );
    } catch (e) {
      return Result.error(Failure.unknown('Failed to create financial report: $e'));
    }
  }
}

/// Use case for getting all financial reports
class GetFinancialReports {
  const GetFinancialReports(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<List<FinancialReport>>> call() async {
    try {
      return await _repository.getAllFinancialReports();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get financial reports: $e'));
    }
  }
}

/// Use case for exporting financial reports
class ExportFinancialReport {
  const ExportFinancialReport(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<String>> call(String reportId, String format) async {
    try {
      if (reportId.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Report ID cannot be empty',
          {'reportId': 'ID is required'},
        ));
      }

      if (!['pdf', 'csv', 'json'].contains(format.toLowerCase())) {
        return Result.error(Failure.validation(
          'Invalid export format. Supported formats: PDF, CSV, JSON',
          {'format': 'Must be PDF, CSV, or JSON'},
        ));
      }

      return await _repository.exportFinancialReport(reportId, format.toLowerCase());
    } catch (e) {
      return Result.error(Failure.unknown('Failed to export financial report: $e'));
    }
  }
}