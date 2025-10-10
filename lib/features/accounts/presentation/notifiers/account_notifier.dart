import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/account.dart';
import '../../domain/usecases/create_account.dart';
import '../../domain/usecases/delete_account.dart';
import '../../domain/usecases/get_accounts.dart';
import '../../domain/usecases/get_account_balance.dart';
import '../../domain/usecases/update_account.dart';
import '../states/account_state.dart';

/// State notifier for account management
class AccountNotifier extends StateNotifier<AsyncValue<AccountState>> {
  final GetAccounts _getAccounts;
  final CreateAccount _createAccount;
  final UpdateAccount _updateAccount;
  final DeleteAccount _deleteAccount;
  final GetAccountBalance _getAccountBalance;

  AccountNotifier({
    required GetAccounts getAccounts,
    required CreateAccount createAccount,
    required UpdateAccount updateAccount,
    required DeleteAccount deleteAccount,
    required GetAccountBalance getAccountBalance,
  })  : _getAccounts = getAccounts,
        _createAccount = createAccount,
        _updateAccount = updateAccount,
        _deleteAccount = deleteAccount,
        _getAccountBalance = getAccountBalance,
        super(const AsyncValue.loading()) {
    loadAccounts();
  }

  /// Load all accounts and balance information
  Future<void> loadAccounts() async {
    state = const AsyncValue.loading();

    // Load accounts
    final accountsResult = await _getAccounts();

    // Load balance information
    final totalBalanceResult = await _getAccountBalance.getTotalBalance();
    final netWorthResult = await _getAccountBalance.getNetWorth();

    accountsResult.when(
      success: (accounts) {
        final totalBalance = totalBalanceResult.getOrDefault(0.0);
        final netWorth = netWorthResult.getOrDefault(0.0);

        state = AsyncValue.data(AccountState(
          accounts: accounts,
          totalBalance: totalBalance,
          netWorth: netWorth,
        ));
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
    );
  }

  /// Create a new account
  Future<bool> createAccount(Account account) async {
    final currentState = state.value;
    if (currentState == null) return false;

    // Set loading state
    state = AsyncValue.data(currentState.copyWith(isLoading: true));

    final result = await _createAccount(account);

    return result.when(
      success: (createdAccount) {
        // Update with server response
        final updatedAccounts = [createdAccount, ...currentState.accounts];
        final newTotalBalance = currentState.totalBalance + createdAccount.currentBalance;
        final newNetWorth = createdAccount.isAsset
            ? currentState.netWorth + createdAccount.currentBalance
            : currentState.netWorth - createdAccount.currentBalance;

        state = AsyncValue.data(currentState.copyWith(
          accounts: updatedAccounts,
          totalBalance: newTotalBalance,
          netWorth: newNetWorth,
          isLoading: false,
        ));
        return true;
      },
      error: (failure) {
        // Revert to original state with error
        state = AsyncValue.data(currentState.copyWith(
          isLoading: false,
          error: failure.message,
        ));
        return false;
      },
    );
  }

  /// Update an existing account
  Future<bool> updateAccount(Account account) async {
    final currentState = state.value;
    if (currentState == null) return false;

    final oldAccount = currentState.accounts.firstWhere(
      (a) => a.id == account.id,
      orElse: () => account,
    );

    final result = await _updateAccount(account);

    return result.when(
      success: (updatedAccount) {
        final updatedAccounts = currentState.accounts.map((a) {
          return a.id == account.id ? updatedAccount : a;
        }).toList();

        // Recalculate balances
        final balanceDiff = updatedAccount.currentBalance - oldAccount.currentBalance;
        final netWorthDiff = updatedAccount.isAsset
            ? (oldAccount.isAsset ? balanceDiff : updatedAccount.currentBalance - (-oldAccount.currentBalance))
            : (oldAccount.isLiability ? -balanceDiff : -updatedAccount.currentBalance - oldAccount.currentBalance);

        state = AsyncValue.data(currentState.copyWith(
          accounts: updatedAccounts,
          totalBalance: currentState.totalBalance + balanceDiff,
          netWorth: currentState.netWorth + netWorthDiff,
        ));
        return true;
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
    );
  }

  /// Delete an account
  Future<bool> deleteAccount(String accountId) async {
    final currentState = state.value;
    if (currentState == null) return false;

    final accountToDelete = currentState.accounts.firstWhere(
      (a) => a.id == accountId,
      orElse: () => throw Exception('Account not found'),
    );

    final result = await _deleteAccount(accountId);

    return result.when(
      success: (_) {
        final updatedAccounts = currentState.accounts
            .where((a) => a.id != accountId)
            .toList();

        // Update balances
        final newTotalBalance = currentState.totalBalance - accountToDelete.currentBalance;
        final newNetWorth = accountToDelete.isAsset
            ? currentState.netWorth - accountToDelete.currentBalance
            : currentState.netWorth + accountToDelete.currentBalance;

        state = AsyncValue.data(currentState.copyWith(
          accounts: updatedAccounts,
          totalBalance: newTotalBalance,
          netWorth: newNetWorth,
        ));
        return true;
      },
      error: (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return false;
      },
    );
  }

  /// Search accounts
  void searchAccounts(String query) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(searchQuery: query));
  }

  /// Filter by account type
  void filterByType(AccountType? type) {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(filterType: type));
  }

  /// Clear search
  void clearSearch() {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(searchQuery: null));
  }

  /// Clear filter
  void clearFilter() {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(filterType: null));
  }

  /// Refresh balances
  Future<void> refreshBalances() async {
    final currentState = state.value;
    if (currentState == null) return;

    final totalBalanceResult = await _getAccountBalance.getTotalBalance();
    final netWorthResult = await _getAccountBalance.getNetWorth();

    final totalBalance = totalBalanceResult.getOrDefault(currentState.totalBalance);
    final netWorth = netWorthResult.getOrDefault(currentState.netWorth);

    state = AsyncValue.data(currentState.copyWith(
      totalBalance: totalBalance,
      netWorth: netWorth,
    ));
  }
}