import '../../../../core/error/result.dart';
import '../entities/shared_budget.dart';

/// Repository interface for shared budget management
abstract class SharedBudgetRepository {
  /// Get shared budget by ID
  Future<Result<SharedBudget?>> getSharedBudgetById(String budgetId);

  /// Get all shared budgets for a user (as owner or member)
  Future<Result<List<SharedBudget>>> getSharedBudgetsForUser(String userId);

  /// Get shared budgets owned by user
  Future<Result<List<SharedBudget>>> getOwnedSharedBudgets(String userId);

  /// Get shared budgets where user is a member
  Future<Result<List<SharedBudget>>> getMemberSharedBudgets(String userId);

  /// Create a new shared budget
  Future<Result<SharedBudget>> createSharedBudget(SharedBudget budget);

  /// Update shared budget
  Future<Result<SharedBudget>> updateSharedBudget(SharedBudget budget);

  /// Delete shared budget
  Future<Result<void>> deleteSharedBudget(String budgetId);

  /// Add member to shared budget
  Future<Result<SharedBudget>> addMember(String budgetId, String userId, BudgetPermission permission);

  /// Remove member from shared budget
  Future<Result<SharedBudget>> removeMember(String budgetId, String userId);

  /// Update member permission
  Future<Result<SharedBudget>> updateMemberPermission(String budgetId, String userId, BudgetPermission permission);

  /// Send invitation to join budget
  Future<Result<void>> sendInvitation(String budgetId, String email);

  /// Accept invitation to join budget
  Future<Result<SharedBudget>> acceptInvitation(String budgetId, String userId);

  /// Decline invitation to join budget
  Future<Result<void>> declineInvitation(String budgetId, String userId);

  /// Get pending invitations for user
  Future<Result<List<String>>> getPendingInvitations(String userId);
}