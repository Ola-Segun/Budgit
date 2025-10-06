import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/expense_split.dart';
import '../entities/shared_budget.dart';
import '../repositories/expense_split_repository.dart';
import '../repositories/shared_budget_repository.dart';

/// Use case for creating a new expense split
class CreateExpenseSplit {
  const CreateExpenseSplit(this._splitRepository, this._budgetRepository);

  final ExpenseSplitRepository _splitRepository;
  final SharedBudgetRepository _budgetRepository;

  /// Execute the use case
  Future<Result<ExpenseSplit>> call({
    required String sharedBudgetId,
    required String title,
    required double totalAmount,
    required String paidByUserId,
    required List<String> participantUserIds,
    String? description,
    String? category,
  }) async {
    try {
      // Validate input
      final validationResult = await _validateInput(
        sharedBudgetId,
        title,
        totalAmount,
        paidByUserId,
        participantUserIds,
      );
      if (validationResult.isError) {
        return validationResult;
      }

      // Create participants list
      final participants = participantUserIds.map((userId) {
        final amount = totalAmount / participantUserIds.length;
        return SplitParticipant(
          userId: userId,
          amount: amount,
        );
      }).toList();

      // Create expense split entity
      final split = ExpenseSplit(
        id: _generateSplitId(),
        sharedBudgetId: sharedBudgetId,
        title: title,
        description: description,
        totalAmount: totalAmount,
        paidByUserId: paidByUserId,
        participants: participants,
        createdAt: DateTime.now(),
        category: category,
      );

      // Save to repository
      return await _splitRepository.createExpenseSplit(split);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to create expense split: $e'));
    }
  }

  /// Validate input parameters
  Future<Result<ExpenseSplit>> _validateInput(
    String sharedBudgetId,
    String title,
    double totalAmount,
    String paidByUserId,
    List<String> participantUserIds,
  ) async {
    if (title.trim().isEmpty) {
      return Result.error(Failure.validation(
        'Expense title cannot be empty',
        {'title': 'Title is required'},
      ));
    }

    if (totalAmount <= 0) {
      return Result.error(Failure.validation(
        'Expense amount must be greater than zero',
        {'totalAmount': 'Amount must be positive'},
      ));
    }

    if (participantUserIds.isEmpty) {
      return Result.error(Failure.validation(
        'At least one participant is required',
        {'participants': 'At least one participant required'},
      ));
    }

    // Check if shared budget exists and user has access
    final budgetResult = await _budgetRepository.getSharedBudgetById(sharedBudgetId);
    if (budgetResult.isError) {
      return Result.error(budgetResult.failureOrNull!);
    }

    final budget = budgetResult.dataOrNull;
    if (budget == null) {
      return Result.error(Failure.notFound('Shared budget not found'));
    }

    if (!budget.hasAccess(paidByUserId)) {
      return Result.error(Failure.validation(
        'User does not have access to this budget',
        {'paidByUserId': 'No access to budget'},
      ));
    }

    // Check all participants have access to the budget
    for (final userId in participantUserIds) {
      if (!budget.hasAccess(userId)) {
        return Result.error(Failure.validation(
          'All participants must have access to the budget',
          {'participants': 'Participant $userId has no access to budget'},
        ));
      }
    }

    return Result.success(ExpenseSplit(
      id: '',
      sharedBudgetId: '',
      title: '',
      totalAmount: 0.0,
      paidByUserId: '',
      participants: [],
      createdAt: DateTime.now(),
    )); // Dummy success for validation
  }

  /// Generate a unique split ID
  String _generateSplitId() {
    return 'split_${DateTime.now().millisecondsSinceEpoch}';
  }
}