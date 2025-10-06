import '../../../../core/error/result.dart';
import '../entities/expense_split.dart';

/// Repository interface for expense split management
abstract class ExpenseSplitRepository {
  /// Get expense split by ID
  Future<Result<ExpenseSplit?>> getExpenseSplitById(String splitId);

  /// Get all expense splits for a shared budget
  Future<Result<List<ExpenseSplit>>> getExpenseSplitsForBudget(String budgetId);

  /// Get expense splits where user is involved (payer or participant)
  Future<Result<List<ExpenseSplit>>> getExpenseSplitsForUser(String userId);

  /// Get expense splits where user is the payer
  Future<Result<List<ExpenseSplit>>> getExpenseSplitsPaidByUser(String userId);

  /// Get expense splits where user is a participant
  Future<Result<List<ExpenseSplit>>> getExpenseSplitsForParticipant(String userId);

  /// Create a new expense split
  Future<Result<ExpenseSplit>> createExpenseSplit(ExpenseSplit split);

  /// Update expense split
  Future<Result<ExpenseSplit>> updateExpenseSplit(ExpenseSplit split);

  /// Delete expense split
  Future<Result<void>> deleteExpenseSplit(String splitId);

  /// Mark participant as settled
  Future<Result<ExpenseSplit>> settleParticipant(String splitId, String userId, {
    String? paymentMethod,
    String? notes,
  });

  /// Mark participant as unsettled (reverse settlement)
  Future<Result<ExpenseSplit>> unsettleParticipant(String splitId, String userId);

  /// Get settlements for a user
  Future<Result<List<Settlement>>> getSettlementsForUser(String userId);

  /// Get settlements between two users
  Future<Result<List<Settlement>>> getSettlementsBetweenUsers(String userId1, String userId2);

  /// Create a settlement record
  Future<Result<Settlement>> createSettlement(Settlement settlement);

  /// Get balance summary for user (amount owed to/from others)
  Future<Result<Map<String, double>>> getBalanceSummary(String userId);
}