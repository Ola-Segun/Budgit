import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/account.dart';

part 'account_state.freezed.dart';

/// State for account management
@freezed
class AccountState with _$AccountState {
  const factory AccountState({
    @Default([]) List<Account> accounts,
    @Default(false) bool isLoading,
    String? error,
    String? searchQuery,
    AccountType? filterType,
    @Default(0.0) double totalBalance,
    @Default(0.0) double netWorth,
  }) = _AccountState;

  const AccountState._();

  /// Get filtered accounts based on search query and filter
  List<Account> get filteredAccounts {
    var filtered = accounts;

    // Apply search filter
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      filtered = filtered.where((account) {
        return account.name.toLowerCase().contains(query) ||
               (account.institution?.toLowerCase().contains(query) ?? false) ||
               (account.description?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Apply type filter
    if (filterType != null) {
      filtered = filtered.where((account) => account.type == filterType).toList();
    }

    return filtered;
  }

  /// Get accounts grouped by type
  Map<AccountType, List<Account>> get accountsByType {
    final grouped = <AccountType, List<Account>>{};

    for (final account in filteredAccounts) {
      grouped[account.type] ??= [];
      grouped[account.type]!.add(account);
    }

    // Sort accounts within each type by name
    for (final type in grouped.keys) {
      grouped[type]!.sort((a, b) => a.name.compareTo(b.name));
    }

    return grouped;
  }

  /// Get asset accounts
  List<Account> get assetAccounts =>
      filteredAccounts.where((account) => account.isAsset).toList();

  /// Get liability accounts
  List<Account> get liabilityAccounts =>
      filteredAccounts.where((account) => account.isLiability).toList();

  /// Get active accounts only
  List<Account> get activeAccounts =>
      filteredAccounts.where((account) => account.isActive).toList();

  /// Get accounts with alerts (overdrawn, over limit, etc.)
  List<Account> get accountsWithAlerts {
    return filteredAccounts.where((account) {
      return account.isOverdrawn || account.isOverLimit;
    }).toList();
  }

  /// Check if there are any accounts with alerts
  bool get hasAlerts => accountsWithAlerts.isNotEmpty;

  /// Get total assets
  double get totalAssets =>
      assetAccounts.fold(0.0, (sum, account) => sum + account.balance);

  /// Get total liabilities
  double get totalLiabilities =>
      liabilityAccounts.fold(0.0, (sum, account) => sum + account.balance.abs());

  /// Get calculated net worth (should match netWorth from state)
  double get calculatedNetWorth => totalAssets - totalLiabilities;

  /// Get accounts count by type
  Map<AccountType, int> get accountsCountByType {
    final counts = <AccountType, int>{};
    for (final account in filteredAccounts) {
      counts[account.type] = (counts[account.type] ?? 0) + 1;
    }
    return counts;
  }

  /// Check if state has data
  bool get hasData => accounts.isNotEmpty;

  /// Check if filtered results are empty
  bool get isFilteredEmpty => filteredAccounts.isEmpty && hasData;
}