import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../repositories/goal_repository.dart';

/// Use case for deleting a goal
class DeleteGoal {
  const DeleteGoal(this._repository);

  final GoalRepository _repository;

  /// Execute the use case
  Future<Result<void>> call(String id) async {
    try {
      // Validate ID
      if (id.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Goal ID cannot be empty',
          {'id': 'ID is required'},
        ));
      }

      // Delete goal
      return await _repository.delete(id);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to delete goal: $e'));
    }
  }
}