import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'shared_budget.freezed.dart';

/// Shared budget entity for collaborative budgeting
@freezed
class SharedBudget with _$SharedBudget {
  const factory SharedBudget({
    required String id,
    required String name,
    String? description,
    required String ownerId,
    required List<String> memberIds,
    required List<String> pendingInvites,
    required double totalBudget,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(true) bool isActive,
    String? category,
  }) = _SharedBudget;

  const SharedBudget._();

  /// Get owner user (would need to be resolved from repository)
  User? get owner => null; // TODO: Implement with user repository

  /// Get member users (would need to be resolved from repository)
  List<User> get members => []; // TODO: Implement with user repository

  /// Check if user is owner
  bool isOwner(String userId) => ownerId == userId;

  /// Check if user is member
  bool isMember(String userId) => memberIds.contains(userId);

  /// Check if user has access (owner or member)
  bool hasAccess(String userId) => isOwner(userId) || isMember(userId);

  /// Get total number of participants
  int get participantCount => memberIds.length + 1; // +1 for owner

  /// Check if budget is over budget (would need transaction data)
  bool get isOverBudget => false; // TODO: Implement with transaction data

  /// Get remaining budget
  double get remainingBudget => totalBudget; // TODO: Implement with transaction data
}

/// Budget permission levels
enum BudgetPermission {
  owner,
  editor,
  viewer,
}

/// Member role in shared budget
@freezed
class BudgetMember with _$BudgetMember {
  const factory BudgetMember({
    required String userId,
    required BudgetPermission permission,
    required DateTime joinedAt,
    DateTime? lastActivityAt,
  }) = _BudgetMember;

  const BudgetMember._();

  /// Check if member has edit permission
  bool get canEdit => permission == BudgetPermission.owner || permission == BudgetPermission.editor;

  /// Check if member is owner
  bool get isOwner => permission == BudgetPermission.owner;
}