import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/shared_budget.dart';
import '../repositories/shared_budget_repository.dart';

/// Use case for creating a new shared budget
class CreateSharedBudget {
  const CreateSharedBudget(this._repository);

  final SharedBudgetRepository _repository;

  /// Execute the use case
  Future<Result<SharedBudget>> call({
    required String name,
    required String ownerId,
    String? description,
    required double totalBudget,
    String? category,
  }) async {
    try {
      // Validate input
      final validationResult = _validateInput(name, ownerId, totalBudget);
      if (validationResult.isError) {
        return validationResult;
      }

      // Create shared budget entity
      final budget = SharedBudget(
        id: _generateBudgetId(ownerId),
        name: name,
        description: description,
        ownerId: ownerId,
        memberIds: [],
        pendingInvites: [],
        totalBudget: totalBudget,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        category: category,
      );

      // Save to repository
      return await _repository.createSharedBudget(budget);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to create shared budget: $e'));
    }
  }

  /// Validate input parameters
  Result<SharedBudget> _validateInput(String name, String ownerId, double totalBudget) {
    if (name.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Budget name cannot be empty',
        {'name': 'Name is required'},
      ));
    }

    if (ownerId.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Owner ID is required',
        {'ownerId': 'Owner ID is required'},
      ));
    }

    if (totalBudget <= 0) {
      return Result.error(Failure.validation(
        'Budget amount must be greater than zero',
        {'totalBudget': 'Amount must be positive'},
      ));
    }

    return Result.success(SharedBudget(
      id: '',
      name: '',
      ownerId: '',
      memberIds: [],
      pendingInvites: [],
      totalBudget: 0.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    )); // Dummy success for validation
  }

  /// Generate a unique budget ID
  String _generateBudgetId(String ownerId) {
    // In a real app, this would use UUID or similar
    return 'budget_${DateTime.now().millisecondsSinceEpoch}_${ownerId.hashCode}';
  }
}