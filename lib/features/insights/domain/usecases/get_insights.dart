import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/insight.dart';
import '../repositories/insight_repository.dart';

/// Use case for getting all insights
class GetInsights {
  const GetInsights(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<List<Insight>>> call() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get insights: $e'));
    }
  }
}

/// Use case for getting recent insights
class GetRecentInsights {
  const GetRecentInsights(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<List<Insight>>> call({int limit = 20}) async {
    try {
      if (limit <= 0) {
        return Result.error(Failure.validation(
          'Limit must be greater than zero',
          {'limit': 'Must be positive'},
        ));
      }

      return await _repository.getRecent(limit: limit);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get recent insights: $e'));
    }
  }
}

/// Use case for getting unread insights
class GetUnreadInsights {
  const GetUnreadInsights(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<List<Insight>>> call() async {
    try {
      return await _repository.getUnread();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to get unread insights: $e'));
    }
  }
}

/// Use case for marking insight as read
class MarkInsightAsRead {
  const MarkInsightAsRead(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<Insight>> call(String insightId) async {
    try {
      if (insightId.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Insight ID cannot be empty',
          {'insightId': 'ID is required'},
        ));
      }

      return await _repository.markAsRead(insightId);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to mark insight as read: $e'));
    }
  }
}

/// Use case for generating insights summary
class GenerateInsightsSummary {
  const GenerateInsightsSummary(this._repository);

  final InsightRepository _repository;

  /// Execute the use case
  Future<Result<InsightsSummary>> call() async {
    try {
      return await _repository.generateInsightsSummary();
    } catch (e) {
      return Result.error(Failure.unknown('Failed to generate insights summary: $e'));
    }
  }
}