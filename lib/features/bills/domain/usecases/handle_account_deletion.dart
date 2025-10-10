import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/domain/repositories/account_repository.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

/// Use case for handling account deletion impacts on bills
/// Manages bill migration when linked accounts are deleted
class HandleAccountDeletion {
  const HandleAccountDeletion(
    this._billRepository,
    this._accountRepository,
  );

  final BillRepository _billRepository;
  final AccountRepository _accountRepository;

  /// Handle deletion of an account that may be linked to bills
  /// This migrates bills to alternative accounts or clears account references
  Future<Result<AccountDeletionResult>> call(String deletedAccountId) async {
    try {
      // Get all bills that reference the deleted account
      final billsResult = await _billRepository.getAll();
      if (billsResult.isError) {
        return Result.error(billsResult.failureOrNull!);
      }

      final allBills = billsResult.dataOrNull ?? [];
      final affectedBills = _findAffectedBills(allBills, deletedAccountId);

      if (affectedBills.isEmpty) {
        return Result.success(AccountDeletionResult(
          deletedAccountId: deletedAccountId,
          affectedBills: [],
          migratedBills: [],
          orphanedBills: [],
        ));
      }

      // Get all available accounts for migration
      final accountsResult = await _accountRepository.getAll();
      if (accountsResult.isError) {
        return Result.error(accountsResult.failureOrNull!);
      }

      final availableAccounts = accountsResult.dataOrNull ?? [];

      // Process bill migration
      final migrationResult = await _migrateAffectedBills(
        affectedBills,
        deletedAccountId,
        availableAccounts,
      );

      return Result.success(AccountDeletionResult(
        deletedAccountId: deletedAccountId,
        affectedBills: affectedBills,
        migratedBills: migrationResult.migratedBills,
        orphanedBills: migrationResult.orphanedBills,
      ));

    } catch (e) {
      return Result.error(Failure.unknown('Account deletion handling failed: $e'));
    }
  }

  /// Find all bills affected by account deletion
  List<Bill> _findAffectedBills(List<Bill> allBills, String deletedAccountId) {
    return allBills.where((bill) {
      // Check primary account
      if (bill.defaultAccountId == deletedAccountId) return true;

      // Check legacy account field
      if (bill.accountId == deletedAccountId) return true;

      // Check allowed accounts list
      if (bill.allowedAccountIds?.contains(deletedAccountId) ?? false) return true;

      // Check recurring payment rules
      if (bill.recurringPaymentRules.any((rule) => rule.accountId == deletedAccountId)) {
        return true;
      }

      return false;
    }).toList();
  }

  /// Migrate affected bills to alternative accounts
  Future<MigrationResult> _migrateAffectedBills(
    List<Bill> affectedBills,
    String deletedAccountId,
    List<Account> availableAccounts,
  ) async {
    final migratedBills = <Bill>[];
    final orphanedBills = <Bill>[];

    for (final bill in affectedBills) {
      final migratedBill = await _migrateSingleBill(bill, deletedAccountId, availableAccounts);
      if (migratedBill != null) {
        migratedBills.add(migratedBill);
      } else {
        orphanedBills.add(bill);
      }
    }

    return MigrationResult(
      migratedBills: migratedBills,
      orphanedBills: orphanedBills,
    );
  }

  /// Migrate a single bill by finding alternative accounts
  Future<Bill?> _migrateSingleBill(
    Bill bill,
    String deletedAccountId,
    List<Account> availableAccounts,
  ) async {
    // Try to find alternative accounts in order of preference
    final alternativeAccount = _findAlternativeAccount(bill, deletedAccountId, availableAccounts);

    if (alternativeAccount == null) {
      // No alternative found - clear account references
      final orphanedBill = bill.copyWith(
        defaultAccountId: null,
        allowedAccountIds: _removeAccountFromList(bill.allowedAccountIds, deletedAccountId),
        accountId: bill.accountId == deletedAccountId ? null : bill.accountId,
        recurringPaymentRules: _updateRecurringRulesForDeletedAccount(bill.recurringPaymentRules, deletedAccountId),
      );

      final result = await _billRepository.update(orphanedBill);
      return result.isSuccess ? orphanedBill : null;
    }

    // Migrate to alternative account
    final migratedBill = bill.copyWith(
      defaultAccountId: alternativeAccount.id,
      allowedAccountIds: _removeAccountFromList(bill.allowedAccountIds, deletedAccountId),
      accountId: bill.accountId == deletedAccountId ? alternativeAccount.id : bill.accountId,
      recurringPaymentRules: _updateRecurringRulesForDeletedAccount(bill.recurringPaymentRules, deletedAccountId, alternativeAccount.id),
    );

    final result = await _billRepository.update(migratedBill);
    return result.isSuccess ? migratedBill : null;
  }

  /// Find the best alternative account for a bill
  Account? _findAlternativeAccount(Bill bill, String deletedAccountId, List<Account> availableAccounts) {
    // Filter out inactive accounts and the deleted account
    final eligibleAccounts = availableAccounts.where((account) =>
      account.isActive && account.id != deletedAccountId
    ).toList();

    if (eligibleAccounts.isEmpty) return null;

    // Priority 1: Use existing allowed accounts (excluding deleted one)
    final existingAllowed = eligibleAccounts.where((account) =>
      bill.allowedAccountIds?.contains(account.id) ?? false
    ).toList();

    if (existingAllowed.isNotEmpty) {
      return _selectBestAccount(existingAllowed, bill);
    }

    // Priority 2: Use accounts with similar transaction patterns
    // This would require transaction analysis - for now, just pick the first eligible
    return _selectBestAccount(eligibleAccounts, bill);
  }

  /// Select the best account from a list based on bill requirements
  Account _selectBestAccount(List<Account> accounts, Bill bill) {
    // For now, prefer bank accounts over credit cards for bills
    final bankAccounts = accounts.where((acc) => acc.type == AccountType.bankAccount).toList();
    if (bankAccounts.isNotEmpty) {
      return bankAccounts.first;
    }

    // Fallback to any account
    return accounts.first;
  }

  /// Remove an account ID from a list of account IDs
  List<String>? _removeAccountFromList(List<String>? accountIds, String accountToRemove) {
    if (accountIds == null) return null;
    return accountIds.where((id) => id != accountToRemove).toList();
  }

  /// Update recurring payment rules when an account is deleted
  List<RecurringPaymentRule> _updateRecurringRulesForDeletedAccount(
    List<RecurringPaymentRule> rules,
    String deletedAccountId, [
    String? replacementAccountId,
  ]) {
    return rules.map((rule) {
      if (rule.accountId == deletedAccountId) {
        return rule.copyWith(
          accountId: replacementAccountId,
          isEnabled: replacementAccountId != null ? rule.isEnabled : false,
        );
      }
      return rule;
    }).toList();
  }
}

/// Result of account deletion handling
class AccountDeletionResult {
  const AccountDeletionResult({
    required this.deletedAccountId,
    required this.affectedBills,
    required this.migratedBills,
    required this.orphanedBills,
  });

  final String deletedAccountId;
  final List<Bill> affectedBills;
  final List<Bill> migratedBills;
  final List<Bill> orphanedBills;

  bool get hasAffectedBills => affectedBills.isNotEmpty;
  bool get hasMigratedBills => migratedBills.isNotEmpty;
  bool get hasOrphanedBills => orphanedBills.isNotEmpty;

  int get migrationSuccessRate {
    if (affectedBills.isEmpty) return 100;
    return ((migratedBills.length / affectedBills.length) * 100).round();
  }
}

/// Internal migration result
class MigrationResult {
  const MigrationResult({
    required this.migratedBills,
    required this.orphanedBills,
  });

  final List<Bill> migratedBills;
  final List<Bill> orphanedBills;
}