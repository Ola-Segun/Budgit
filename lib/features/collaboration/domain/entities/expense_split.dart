import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'expense_split.freezed.dart';

/// Expense split entity for splitting costs among users
@freezed
class ExpenseSplit with _$ExpenseSplit {
  const factory ExpenseSplit({
    required String id,
    required String sharedBudgetId,
    required String title,
    String? description,
    required double totalAmount,
    required String paidByUserId,
    required List<SplitParticipant> participants,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(SplitStatus.pending) SplitStatus status,
    String? category,
    String? receiptUrl,
  }) = _ExpenseSplit;

  const ExpenseSplit._();

  /// Get the payer user (would need to be resolved from repository)
  User? get payer => null; // TODO: Implement with user repository

  /// Get all participant users
  List<User> get participantUsers => []; // TODO: Implement with user repository

  /// Calculate amount each participant owes
  double get amountPerParticipant {
    final participantCount = participants.length;
    return participantCount > 0 ? totalAmount / participantCount : 0.0;
  }

  /// Get amount a specific user owes
  double amountOwedBy(String userId) {
    final participant = participants.firstWhere(
      (p) => p.userId == userId,
      orElse: () => SplitParticipant(
        userId: userId,
        amount: 0.0,
        status: SplitStatus.pending,
      ),
    );
    return participant.amount;
  }

  /// Check if user is the payer
  bool isPayer(String userId) => paidByUserId == userId;

  /// Check if user is a participant
  bool isParticipant(String userId) => participants.any((p) => p.userId == userId);

  /// Get total amount settled
  double get settledAmount => participants
      .where((p) => p.status == SplitStatus.settled)
      .fold(0.0, (sum, p) => sum + p.amount);

  /// Get remaining amount to be settled
  double get remainingAmount => totalAmount - settledAmount;

  /// Check if split is fully settled
  bool get isFullySettled => remainingAmount <= 0.01; // Allow for floating point precision

  /// Get settlement progress (0.0 to 1.0)
  double get settlementProgress => totalAmount > 0 ? settledAmount / totalAmount : 1.0;
}

/// Participant in an expense split
@freezed
class SplitParticipant with _$SplitParticipant {
  const factory SplitParticipant({
    required String userId,
    required double amount,
    @Default(SplitStatus.pending) SplitStatus status,
    DateTime? settledAt,
    String? paymentMethod,
    String? notes,
  }) = _SplitParticipant;

  const SplitParticipant._();

  /// Check if participant has settled their share
  bool get isSettled => status == SplitStatus.settled;

  /// Mark as settled
  SplitParticipant settle({String? paymentMethod, String? notes}) {
    return copyWith(
      status: SplitStatus.settled,
      settledAt: DateTime.now(),
      paymentMethod: paymentMethod,
      notes: notes,
    );
  }
}

/// Status of expense split or participant payment
enum SplitStatus {
  pending,
  partial,
  settled,
  disputed,
}

/// Settlement record for tracking payments
@freezed
class Settlement with _$Settlement {
  const factory Settlement({
    required String id,
    required String expenseSplitId,
    required String fromUserId,
    required String toUserId,
    required double amount,
    required DateTime settledAt,
    String? paymentMethod,
    String? notes,
    @Default(true) bool isConfirmed,
  }) = _Settlement;

  const Settlement._();

  /// Get payer user
  User? get fromUser => null; // TODO: Implement with user repository

  /// Get receiver user
  User? get toUser => null; // TODO: Implement with user repository
}