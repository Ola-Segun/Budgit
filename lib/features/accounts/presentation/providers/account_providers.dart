import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart' as core_providers;
import '../../domain/entities/account.dart';
import '../../domain/usecases/create_account.dart';
import '../../domain/usecases/delete_account.dart';
import '../../domain/usecases/get_accounts.dart';
import '../../domain/usecases/get_account_balance.dart';
import '../../domain/usecases/update_account.dart';
import '../notifiers/account_notifier.dart';
import '../states/account_state.dart';

/// Provider for GetAccounts use case
final getAccountsProvider = Provider<GetAccounts>((ref) {
  return ref.read(core_providers.getAccountsProvider);
});

/// Provider for CreateAccount use case
final createAccountProvider = Provider<CreateAccount>((ref) {
  return ref.read(core_providers.createAccountProvider);
});

/// Provider for UpdateAccount use case
final updateAccountProvider = Provider<UpdateAccount>((ref) {
  return ref.read(core_providers.updateAccountProvider);
});

/// Provider for DeleteAccount use case
final deleteAccountProvider = Provider<DeleteAccount>((ref) {
  return ref.read(core_providers.deleteAccountProvider);
});

/// Provider for GetAccountBalance use case
final getAccountBalanceProvider = Provider<GetAccountBalance>((ref) {
  return ref.read(core_providers.getAccountBalanceProvider);
});

/// State notifier provider for account state management
final accountNotifierProvider =
    StateNotifierProvider<AccountNotifier, AsyncValue<AccountState>>((ref) {
  final getAccounts = ref.watch(getAccountsProvider);
  final createAccount = ref.watch(createAccountProvider);
  final updateAccount = ref.watch(updateAccountProvider);
  final deleteAccount = ref.watch(deleteAccountProvider);
  final getAccountBalance = ref.watch(getAccountBalanceProvider);

  return AccountNotifier(
    getAccounts: getAccounts,
    createAccount: createAccount,
    updateAccount: updateAccount,
    deleteAccount: deleteAccount,
    getAccountBalance: getAccountBalance,
  );
});

/// Provider for filtered accounts
final filteredAccountsProvider = Provider<AsyncValue<List<Account>>>((ref) {
  final accountState = ref.watch(accountNotifierProvider);

  return accountState.when(
    data: (state) => AsyncValue.data(state.filteredAccounts),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for accounts grouped by type
final accountsByTypeProvider = Provider<AsyncValue<Map<AccountType, List<Account>>>>((ref) {
  final accountState = ref.watch(accountNotifierProvider);

  return accountState.when(
    data: (state) => AsyncValue.data(state.accountsByType),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for net worth
final netWorthProvider = Provider<AsyncValue<double>>((ref) {
  final accountState = ref.watch(accountNotifierProvider);

  return accountState.when(
    data: (state) => AsyncValue.data(state.netWorth),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for total balance
final totalBalanceProvider = Provider<AsyncValue<double>>((ref) {
  final accountState = ref.watch(accountNotifierProvider);

  return accountState.when(
    data: (state) => AsyncValue.data(state.totalBalance),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for accounts with alerts
final accountsWithAlertsProvider = Provider<AsyncValue<List<Account>>>((ref) {
  final accountState = ref.watch(accountNotifierProvider);

  return accountState.when(
    data: (state) => AsyncValue.data(state.accountsWithAlerts),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for asset accounts
final assetAccountsProvider = Provider<AsyncValue<List<Account>>>((ref) {
  final accountState = ref.watch(accountNotifierProvider);

  return accountState.when(
    data: (state) => AsyncValue.data(state.assetAccounts),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// Provider for liability accounts
final liabilityAccountsProvider = Provider<AsyncValue<List<Account>>>((ref) {
  final accountState = ref.watch(accountNotifierProvider);

  return accountState.when(
    data: (state) => AsyncValue.data(state.liabilityAccounts),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});