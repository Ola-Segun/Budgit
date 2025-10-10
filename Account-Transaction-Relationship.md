# Deep Analysis: Account-Transaction Relationship in Flutter Budget App

## 1. Conceptual Relationship Model

### Core Relationship Structure

```
┌─────────────────────────────────────────────────────────────┐
│                     FINANCIAL ECOSYSTEM                      │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐         affects        ┌──────────────┐   │
│  │   ACCOUNT    │ ◄─────────────────────► │ TRANSACTION  │   │
│  │              │                         │              │   │
│  │ - Balance    │ ◄─── updates balance    │ - Amount     │   │
│  │ - Type       │                         │ - Type       │   │
│  │ - Currency   │      belongs to ───────►│ - Date       │   │
│  └──────────────┘                         │ - Category   │   │
│         │                                  └──────────────┘   │
│         │                                         │           │
│         │ links to                       triggers │           │
│         ▼                                         ▼           │
│  ┌──────────────┐                         ┌──────────────┐   │
│  │   BUDGET     │                         │   GOAL       │   │
│  │ - Account    │                         │ - Account    │   │
│  └──────────────┘                         │ - Progress   │   │
│                                            └──────────────┘   │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Domain Model Design

### Entity Definitions

```dart
// lib/features/accounts/domain/entities/account.dart

@freezed
class Account with _$Account {
  const factory Account({
    required String id,
    required String name,
    required AccountType type,
    required double balance,
    @Default('USD') String currency,
    @Default(false) bool isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? icon,
    Color? color,
    String? description,
    @Default(true) bool isActive,
  }) = _Account;
  
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}

enum AccountType {
  cash,        // Physical cash
  bank,        // Bank account (checking/savings)
  credit,      // Credit card (liability)
  investment,  // Investment account
  loan,        // Loan (liability)
  other
}

// Extension methods for business logic
extension AccountExtension on Account {
  bool get isAsset => type == AccountType.cash || 
                      type == AccountType.bank || 
                      type == AccountType.investment;
  
  bool get isLiability => type == AccountType.credit || 
                          type == AccountType.loan;
  
  double get effectiveBalance => isLiability ? -balance : balance;
}
```

```dart
// lib/features/transactions/domain/entities/transaction.dart

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required double amount,
    required String categoryId,
    required DateTime date,
    required TransactionType type,
    
    // Account relationship - CRITICAL
    String? accountId,  // Which account this transaction belongs to
    
    // Transfer-specific fields
    String? toAccountId,  // For transfers: destination account
    double? transferFee,   // Optional fee for transfers
    
    String? description,
    String? note,
    List<String>? tags,
    String? receiptPath,
    
    // Goal linking
    String? goalId,
    bool? countsTowardGoal,
    
    // Recurring transaction link
    String? recurringTransactionId,
    bool? isRecurring,
    
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Transaction;
  
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}

enum TransactionType {
  income,    // Money coming in
  expense,   // Money going out
  transfer   // Money moving between accounts
}

// Extension methods
extension TransactionExtension on Transaction {
  bool get affectsBalance => type != TransactionType.transfer || accountId != null;
  
  bool get isTransfer => type == TransactionType.transfer && toAccountId != null;
  
  double get effectiveAmount {
    switch (type) {
      case TransactionType.income:
        return amount;
      case TransactionType.expense:
        return -amount;
      case TransactionType.transfer:
        return accountId != null ? -amount : amount;
    }
  }
}
```

---

## 3. Relationship Types & Scenarios

### A. One-to-Many Relationship (Primary)

```
Account (1) ────── has many ──────► Transaction (Many)

Example:
- "Bank Account" has 500 transactions
- "Cash Wallet" has 150 transactions
- "Credit Card" has 300 transactions
```

**Implementation:**
```dart
// Getting all transactions for an account
class GetTransactionsByAccount {
  final TransactionRepository _repository;
  
  Future<Result<List<Transaction>>> call(String accountId) async {
    return await _repository.getByAccountId(accountId);
  }
}
```

### B. Transfer Relationship (Many-to-Many)

```
Account A ◄─────── Transfer ─────────► Account B
(Source)        Transaction         (Destination)

Example:
Transfer $500 from "Bank Account" to "Cash Wallet"
- Creates ONE transaction record
- Links to BOTH accounts
- Updates BOTH balances
```

**Implementation:**
```dart
class Transfer with _$Transfer {
  const factory Transfer({
    required String id,
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required DateTime date,
    double? fee,
    String? note,
  }) = _Transfer;
}

// Transfer is actually stored as a special transaction
// with type = TransactionType.transfer
```

---

## 4. Balance Calculation Logic

### Critical Rule: Account Balance Must Always Match Sum of Transactions

```dart
// lib/features/accounts/domain/usecases/calculate_account_balance.dart

class CalculateAccountBalance {
  final TransactionRepository _transactionRepository;
  
  CalculateAccountBalance(this._transactionRepository);
  
  Future<double> call(String accountId) async {
    final result = await _transactionRepository.getByAccountId(accountId);
    
    return result.when(
      success: (transactions) {
        double balance = 0.0;
        
        for (final transaction in transactions) {
          balance += _calculateTransactionImpact(transaction, accountId);
        }
        
        return balance;
      },
      error: (_) => 0.0,
    );
  }
  
  double _calculateTransactionImpact(Transaction transaction, String accountId) {
    if (transaction.type == TransactionType.income) {
      return transaction.amount;
    } 
    else if (transaction.type == TransactionType.expense) {
      return -transaction.amount;
    } 
    else if (transaction.type == TransactionType.transfer) {
      // For transfers, check if this account is source or destination
      if (transaction.accountId == accountId) {
        // This account is the source (money leaving)
        return -(transaction.amount + (transaction.transferFee ?? 0));
      } else if (transaction.toAccountId == accountId) {
        // This account is the destination (money arriving)
        return transaction.amount;
      }
    }
    
    return 0.0;
  }
}
```

### Balance Update Strategies

**Strategy 1: Eager Update (Recommended)**
```dart
class AddTransaction {
  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;
  
  Future<Result<Transaction>> call(Transaction transaction) async {
    try {
      // 1. Add transaction
      final txResult = await _transactionRepository.add(transaction);
      
      if (txResult.isError) return txResult;
      
      // 2. Update account balance immediately
      if (transaction.accountId != null) {
        await _updateAccountBalance(
          transaction.accountId!,
          transaction.effectiveAmount,
        );
      }
      
      // 3. If transfer, update destination account
      if (transaction.isTransfer && transaction.toAccountId != null) {
        await _updateAccountBalance(
          transaction.toAccountId!,
          transaction.amount,
        );
      }
      
      return txResult;
      
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  Future<void> _updateAccountBalance(String accountId, double delta) async {
    final accountResult = await _accountRepository.getById(accountId);
    
    accountResult.when(
      success: (account) async {
        final updatedAccount = account.copyWith(
          balance: account.balance + delta,
          updatedAt: DateTime.now(),
        );
        
        await _accountRepository.update(updatedAccount);
      },
      error: (_) {},
    );
  }
}
```

**Strategy 2: Lazy Calculation (Alternative)**
```dart
// Account balance is calculated on-demand, not stored
class GetAccountBalance {
  final CalculateAccountBalance _calculateBalance;
  
  Future<double> call(String accountId) async {
    return await _calculateBalance(accountId);
  }
}

// Pros: Always accurate, no sync issues
// Cons: Performance overhead on large transaction sets
```

**Recommended Hybrid Approach:**
```dart
@freezed
class Account with _$Account {
  const factory Account({
    required String id,
    required String name,
    required AccountType type,
    required double cachedBalance,  // Eager updated
    DateTime? lastBalanceUpdate,
  }) = _Account;
}

// Recalculate balance periodically or on demand
class ReconcileAccountBalance {
  Future<void> call(String accountId) async {
    final calculatedBalance = await _calculateBalance(accountId);
    final account = await _getAccount(accountId);
    
    if ((account.cachedBalance - calculatedBalance).abs() > 0.01) {
      // Discrepancy detected, log and fix
      await _logDiscrepancy(account, calculatedBalance);
      await _updateBalance(accountId, calculatedBalance);
    }
  }
}
```

---

## 5. Transaction Flow with Account Updates

### Scenario A: Simple Expense Transaction

```
┌─────────────────────────────────────────────────────────┐
│  User adds expense: $50 for groceries from Bank Account │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 1. Create Transaction                                     │
│    - id: "tx_123"                                         │
│    - amount: 50.00                                        │
│    - type: expense                                        │
│    - accountId: "bank_001"                                │
│    - categoryId: "food"                                   │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 2. Update Account Balance                                 │
│    - Get Account "bank_001"                               │
│    - Current balance: $1000.00                            │
│    - New balance: $1000.00 - $50.00 = $950.00            │
│    - Save account                                         │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 3. Trigger Side Effects                                   │
│    - Check budget alerts                                  │
│    - Update goal progress (if linked)                     │
│    - Send notification (if enabled)                       │
│    - Sync to cloud (if online)                            │
└──────────────────────────────────────────────────────────┘
```

### Scenario B: Transfer Between Accounts

```
┌───────────────────────────────────────────────────────────┐
│  User transfers $200 from Bank to Cash Wallet (Fee: $2)  │
└───────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 1. Create Transfer Transaction                            │
│    - id: "tx_456"                                         │
│    - amount: 200.00                                       │
│    - type: transfer                                       │
│    - accountId: "bank_001" (source)                       │
│    - toAccountId: "cash_001" (destination)                │
│    - transferFee: 2.00                                    │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 2. Update Source Account (Bank)                           │
│    - Current balance: $950.00                             │
│    - Deduct: amount + fee = $202.00                       │
│    - New balance: $950.00 - $202.00 = $748.00            │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 3. Update Destination Account (Cash)                      │
│    - Current balance: $100.00                             │
│    - Add: amount = $200.00 (fee not added)                │
│    - New balance: $100.00 + $200.00 = $300.00            │
└──────────────────────────────────────────────────────────┘
```

### Scenario C: Transaction Deletion (Rollback)

```
┌──────────────────────────────────────────────────────────┐
│  User deletes transaction: $50 grocery expense            │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 1. Get Transaction Details                                │
│    - amount: 50.00                                        │
│    - type: expense                                        │
│    - accountId: "bank_001"                                │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 2. Reverse Balance Impact                                 │
│    - Current balance: $748.00                             │
│    - Add back: $50.00 (opposite of expense)               │
│    - New balance: $748.00 + $50.00 = $798.00             │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 3. Delete Transaction Record                              │
│    - Remove from database                                 │
│    - Remove from cache                                    │
│    - Update UI state                                      │
└──────────────────────────────────────────────────────────┘
```

---

## 6. Data Layer Implementation

### Database Schema (Hive)

```dart
// lib/features/accounts/data/models/account_dto.dart

@HiveType(typeId: 1)
class AccountDTO extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String name;
  
  @HiveField(2)
  String type; // 'cash', 'bank', 'credit', etc.
  
  @HiveField(3)
  double balance;
  
  @HiveField(4)
  String currency;
  
  @HiveField(5)
  bool isDefault;
  
  @HiveField(6)
  int? createdAt;
  
  @HiveField(7)
  int? updatedAt;
  
  @HiveField(8)
  bool isActive;
}
```

```dart
// lib/features/transactions/data/models/transaction_dto.dart

@HiveType(typeId: 0)
class TransactionDTO extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  double amount;
  
  @HiveField(2)
  String categoryId;
  
  @HiveField(3)
  int timestamp;
  
  @HiveField(4)
  String type; // 'income', 'expense', 'transfer'
  
  // CRITICAL: Account relationship
  @HiveField(5)
  String? accountId;
  
  // Transfer-specific
  @HiveField(6)
  String? toAccountId;
  
  @HiveField(7)
  double? transferFee;
  
  @HiveField(8)
  String? description;
  
  @HiveField(9)
  String? note;
  
  @HiveField(10)
  List<String>? tags;
  
  @HiveField(11)
  String? goalId;
}
```

### Repository with Account-Transaction Queries

```dart
// lib/features/transactions/data/repositories/transaction_repository_impl.dart

class TransactionRepositoryImpl implements TransactionRepository {
  final Box<TransactionDTO> _transactionBox;
  final Box<AccountDTO> _accountBox;
  
  @override
  Future<Result<List<Transaction>>> getByAccountId(String accountId) async {
    try {
      final dtos = _transactionBox.values
          .where((dto) => 
              dto.accountId == accountId || 
              dto.toAccountId == accountId // Include transfers TO this account
          )
          .toList()
          ..sort((a, b) => b.timestamp.compareTo(a.timestamp)); // Recent first
      
      final transactions = dtos.map(TransactionMapper.toDomain).toList();
      
      return Result.success(transactions);
    } catch (e) {
      return Result.error(Failure.cache('Failed to fetch transactions: $e'));
    }
  }
  
  @override
  Future<Result<Map<String, double>>> getBalancesByAccount() async {
    try {
      final balances = <String, double>{};
      
      // Initialize all accounts with 0
      for (final accountDto in _accountBox.values) {
        balances[accountDto.id] = 0.0;
      }
      
      // Calculate from transactions
      for (final txDto in _transactionBox.values) {
        if (txDto.accountId != null) {
          final impact = _calculateImpact(txDto, txDto.accountId!);
          balances[txDto.accountId!] = (balances[txDto.accountId!] ?? 0) + impact;
        }
        
        // Handle transfer destination
        if (txDto.type == 'transfer' && txDto.toAccountId != null) {
          balances[txDto.toAccountId!] = (balances[txDto.toAccountId!] ?? 0) + txDto.amount;
        }
      }
      
      return Result.success(balances);
    } catch (e) {
      return Result.error(Failure.cache('Failed to calculate balances: $e'));
    }
  }
  
  double _calculateImpact(TransactionDTO dto, String accountId) {
    if (dto.type == 'income') return dto.amount;
    if (dto.type == 'expense') return -dto.amount;
    if (dto.type == 'transfer' && dto.accountId == accountId) {
      return -(dto.amount + (dto.transferFee ?? 0));
    }
    return 0;
  }
}
```

---

## 7. Use Case Implementations

### A. Add Transaction with Account Update

```dart
// lib/features/transactions/domain/usecases/add_transaction.dart

class AddTransaction {
  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;
  final BudgetRepository _budgetRepository;
  final GoalRepository _goalRepository;
  
  AddTransaction(
    this._transactionRepository,
    this._accountRepository,
    this._budgetRepository,
    this._goalRepository,
  );
  
  Future<Result<Transaction>> call(Transaction transaction) async {
    // 1. Validation
    final validation = _validate(transaction);
    if (validation.isError) return validation;
    
    // 2. Check account exists and has sufficient balance (for expenses/transfers)
    if (transaction.accountId != null) {
      final accountCheck = await _checkAccountAvailability(transaction);
      if (accountCheck.isError) return Result.error(accountCheck.failureOrNull!);
    }
    
    // 3. Add transaction
    final txResult = await _transactionRepository.add(transaction);
    if (txResult.isError) return txResult;
    
    // 4. Update account balance(s)
    await _updateAccountBalances(transaction);
    
    // 5. Trigger side effects
    await _triggerSideEffects(transaction);
    
    return txResult;
  }
  
  Result<Transaction> _validate(Transaction transaction) {
    if (transaction.amount <= 0) {
      return Result.error(
        Failure.validation('Amount must be greater than zero', {}),
      );
    }
    
    if (transaction.type == TransactionType.transfer && transaction.toAccountId == null) {
      return Result.error(
        Failure.validation('Transfer must have destination account', {}),
      );
    }
    
    if (transaction.accountId == transaction.toAccountId) {
      return Result.error(
        Failure.validation('Cannot transfer to same account', {}),
      );
    }
    
    return Result.success(transaction);
  }
  
  Future<Result<void>> _checkAccountAvailability(Transaction transaction) async {
    if (transaction.accountId == null) return Result.success(null);
    
    final accountResult = await _accountRepository.getById(transaction.accountId!);
    
    return accountResult.when(
      success: (account) {
        // For expenses and transfers, check sufficient balance
        if (transaction.type == TransactionType.expense || 
            transaction.type == TransactionType.transfer) {
          final requiredAmount = transaction.type == TransactionType.transfer
              ? transaction.amount + (transaction.transferFee ?? 0)
              : transaction.amount;
          
          if (account.balance < requiredAmount) {
            return Result.error(
              Failure.validation('Insufficient balance in ${account.name}', {}),
            );
          }
        }
        
        return Result.success(null);
      },
      error: (failure) => Result.error(failure),
    );
  }
  
  Future<void> _updateAccountBalances(Transaction transaction) async {
    // Update source account
    if (transaction.accountId != null) {
      await _updateSingleAccount(
        transaction.accountId!,
        transaction.effectiveAmount,
      );
    }
    
    // Update destination account (for transfers)
    if (transaction.isTransfer && transaction.toAccountId != null) {
      await _updateSingleAccount(
        transaction.toAccountId!,
        transaction.amount,
      );
    }
  }
  
  Future<void> _updateSingleAccount(String accountId, double delta) async {
    final accountResult = await _accountRepository.getById(accountId);
    
    accountResult.when(
      success: (account) async {
        final updatedAccount = account.copyWith(
          balance: account.balance + delta,
          updatedAt: DateTime.now(),
        );
        
        await _accountRepository.update(updatedAccount);
      },
      error: (_) {
        // Log error but don't fail transaction
        // Balance can be reconciled later
      },
    );
  }
  
  Future<void> _triggerSideEffects(Transaction transaction) async {
    // Check budget alerts
    if (transaction.type == TransactionType.expense) {
      await _checkBudgetAlert(transaction);
    }
    
    // Update goal progress
    if (transaction.goalId != null && transaction.countsTowardGoal == true) {
      await _updateGoalProgress(transaction);
    }
  }
  
  Future<void> _checkBudgetAlert(Transaction transaction) async {
    final budgetResult = await _budgetRepository.getCurrentBudget();
    
    budgetResult.when(
      success: (budget) async {
        final categorySpent = await _getCategorySpending(transaction.categoryId);
        final categoryBudget = budget.getCategoryBudget(transaction.categoryId);
        
        if (categorySpent / categoryBudget >= 0.9) {
          // Trigger alert notification
        }
      },
      error: (_) {},
    );
  }
}
```

### B. Transfer Between Accounts

```dart
// lib/features/transactions/domain/usecases/create_transfer.dart

class CreateTransfer {
  final AddTransaction _addTransaction;
  
  CreateTransfer(this._addTransaction);
  
  Future<Result<Transaction>> call({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required DateTime date,
    double? fee,
    String? note,
  }) async {
    // Create transfer transaction
    final transaction = Transaction(
      id: const Uuid().v4(),
      amount: amount,
      categoryId: 'transfer', // Special category
      date: date,
      type: TransactionType.transfer,
      accountId: fromAccountId,
      toAccountId: toAccountId,
      transferFee: fee,
      note: note,
      createdAt: DateTime.now(),
    );
    
    return await _addTransaction(transaction);
  }
}
```

### C. Delete Transaction with Balance Rollback

```dart
// lib/features/transactions/domain/usecases/delete_transaction.dart

class DeleteTransaction {
  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;
  
  DeleteTransaction(
    this._transactionRepository,
    this._accountRepository,
  );
  
  Future<Result<void>> call(String transactionId) async {
    // 1. Get transaction details BEFORE deletion
    final txResult = await _transactionRepository.getById(transactionId);
    
    if (txResult.isError) return Result.error(txResult.failureOrNull!);
    
    final transaction = txResult.dataOrNull!;
    
    // 2. Delete transaction
    final deleteResult = await _transactionRepository.delete(transactionId);
    
    if (deleteResult.isError) return deleteResult;
    
    // 3. Reverse account balance changes
    await _reverseBalanceChanges(transaction);
    
    return Result.success(null);
  }
  
  Future<void> _reverseBalanceChanges(Transaction transaction) async {
    // Reverse source account
    if (transaction.accountId != null) {
      await _reverseSingleAccount(
        transaction.accountId!,
        -transaction.effectiveAmount, // Opposite sign
      );
    }
    
    // Reverse destination account (for transfers)
    if (transaction.isTransfer && transaction.toAccountId != null) {
      await _reverseSingleAccount(
        transaction.toAccountId!,
        -transaction.amount, // Opposite sign
      );
    }
  }
  
  Future<void> _reverseSingleAccount(String accountId, double delta) async {
    final accountResult = await _accountRepository.getById(accountId);
    
    accountResult.when(
      success: (account) async {
        final updatedAccount = account.copyWith(
          balance: account.balance + delta,
          updatedAt: DateTime.now(),
        );
        
        await _accountRepository.update(updatedAccount);
      },
      error: (_) {},
    );
  }
}
```

---

## 8. State Management Integration

```dart
// lib/features/accounts/presentation/providers/account_providers.dart

@riverpod
class AccountNotifier extends _$AccountNotifier {
  @override
  Future<List<Account>> build() async {
    return await _loadAccounts();
  }
  
  Future<List<Account>> _loadAccounts() async {
    final useCase = ref.read(getAccountsProvider);
    final result = await useCase();
    
    return result.when(
      success: (accounts) => accounts,
      error: (_) => [],
    );
  }
  
  // Listen to transaction changes to update account balances
  void _listenToTransactionChanges() {
    ref.listen(transactionNotifierProvider, (previous, next) {
      // When transactions change, refresh accounts
      ref.invalidateSelf();
    });
  }
}

// Account with calculated balance
@riverpod
Future<AccountWithBalance> accountWithBalance(
  AccountWithBalanceRef ref,
  String accountId,
) async {
  final account = await ref.watch(getAccountByIdProvider(accountId).future);
  final balance = await ref.watch(calculateAccountBalanceProvider(accountId).future);
  
  return AccountWithBalance(
    account: account,
    calculatedBalance: balance,
    isBalanceAccurate: (account.balance - balance).abs() < 0.01,
  );
}

@freezed
class AccountWithBalance with _$AccountWithBalance {
  const factory AccountWithBalance({
    required Account account,
    required double calculatedBalance,
    required bool isBalanceAccurate,
  }) = _AccountWithBalance;
}
```

```dart
// lib/features/transactions/presentation/providers/transaction_providers.dart

@riverpod
class TransactionNotifier extends _$TransactionNotifier {
  @override
  Future<List<Transaction>> build() async {
    return await _loadTransactions();
  }
  
  Future<void> addTransaction(Transaction transaction) async {
    state = const AsyncValue.loading();
    
    final useCase = ref.read(addTransactionProvider);
    final result = await useCase(transaction);
    
    result.when(
      success: (_) {
        // Refresh both transactions AND accounts
        ref.invalidateSelf();
        ref.invalidate(accountNotifierProvider);
      },
      error: (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
    );
  }
}

// Transactions filtered by account
@riverpod
Future<List<Transaction>> transactionsByAccount(
  TransactionsByAccountRef ref,
  String accountId,
) async {
  final useCase = ref.watch(getTransactionsByAccountProvider);
  final result = await useCase(accountId);
  
  return result.when(
    success: (transactions) => transactions,
    error: (_) => [],
  );
}
```

---

## 9. UI Integration Patterns

### Account Detail Screen with Transactions

```dart
// lib/features/accounts/presentation/screens/account_detail_screen.dart

class AccountDetailScreen extends ConsumerWidget {
  final String accountId;
  
  const AccountDetailScreen({required this.accountId});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountAsync = ref.watch(accountWithBalanceProvider(accountId));
    final transactionsAsync = ref.watch(transactionsByAccountProvider(accountId));
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _editAccount(context, accountId),
          ),
        ],
      ),
      body: accountAsync.when(
        data: (accountWithBalance) => transactionsAsync.when(
          data: (transactions) => _buildContent(
            context,
            ref,
            accountWithBalance,
            transactions,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorView(message: error.toString()),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(message: error.toString()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addTransactionToAccount(context, ref, accountId),
        icon: Icon(Icons.add),
        label: Text('Add Transaction'),
      ),
    );
  }
  
  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    AccountWithBalance accountWithBalance,
    List<Transaction> transactions,
  ) {
    final account = accountWithBalance.account;
    
    return CustomScrollView(
      slivers: [
        // Account Balance Header
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: _AccountBalanceCard(
              account: account,
              calculatedBalance: accountWithBalance.calculatedBalance,
              isAccurate: accountWithBalance.isBalanceAccurate,
              onReconcile: () => _reconcileBalance(ref, account.id),
            ),
          ),
        ),
        
        // Statistics Section
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _AccountStatistics(
              transactions: transactions,
              account: account,
            ),
          ),
        ),
        
        // Transactions List
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () => _viewAllTransactions(context, account.id),
                  child: Text('View All'),
                ),
              ],
            ),
          ),
        ),
        
        // Grouped Transactions
        _buildTransactionsList(context, ref, transactions),
      ],
    );
  }
  
  Widget _buildTransactionsList(
    BuildContext context,
    WidgetRef ref,
    List<Transaction> transactions,
  ) {
    if (transactions.isEmpty) {
      return SliverFillRemaining(
        child: EmptyState(
          icon: Icons.receipt_long,
          title: 'No Transactions',
          message: 'Add your first transaction to this account',
          actionLabel: 'Add Transaction',
          onAction: () => _addTransactionToAccount(context, ref, accountId),
        ),
      );
    }
    
    // Group by date
    final grouped = groupBy<Transaction, String>(
      transactions,
      (tx) => DateFormat('yyyy-MM-dd').format(tx.date),
    );
    
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final dateKey = grouped.keys.elementAt(index);
          final dayTransactions = grouped[dateKey]!;
          final date = DateTime.parse(dateKey);
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  _formatDateHeader(date),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ...dayTransactions.map((transaction) {
                return TransactionTile(
                  transaction: transaction,
                  showAccount: false, // Already in account context
                  onTap: () => _viewTransactionDetail(context, transaction.id),
                  onDelete: () => _deleteTransaction(ref, transaction.id),
                );
              }).toList(),
            ],
          );
        },
        childCount: grouped.length,
      ),
    );
  }
  
  Future<void> _reconcileBalance(WidgetRef ref, String accountId) async {
    final reconcile = ref.read(reconcileAccountBalanceProvider);
    await reconcile(accountId);
    ref.invalidate(accountWithBalanceProvider(accountId));
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account balance reconciled')),
      );
    }
  }
  
  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);
    
    if (transactionDate == today) return 'Today';
    if (transactionDate == yesterday) return 'Yesterday';
    return DateFormat('MMMM dd, yyyy').format(date);
  }
}

// Account Balance Card Widget
class _AccountBalanceCard extends StatelessWidget {
  final Account account;
  final double calculatedBalance;
  final bool isAccurate;
  final VoidCallback onReconcile;
  
  const _AccountBalanceCard({
    required this.account,
    required this.calculatedBalance,
    required this.isAccurate,
    required this.onReconcile,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF14B8A6), Color(0xFF2DD4BF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF14B8A6).withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                account.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getAccountTypeLabel(account.type),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          
          Text(
            'Current Balance',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          
          Text(
            NumberFormat.currency(symbol: '\$', decimalDigits: 2)
                .format(account.balance),
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w700,
              height: 1.1,
              letterSpacing: -1.5,
            ),
          ),
          
          // Balance accuracy indicator
          if (!isAccurate) ...[
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Balance mismatch detected',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    onPressed: onReconcile,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Fix',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  String _getAccountTypeLabel(AccountType type) {
    switch (type) {
      case AccountType.cash:
        return 'Cash';
      case AccountType.bank:
        return 'Bank';
      case AccountType.credit:
        return 'Credit';
      case AccountType.investment:
        return 'Investment';
      case AccountType.loan:
        return 'Loan';
      case AccountType.other:
        return 'Other';
    }
  }
}

// Account Statistics Widget
class _AccountStatistics extends StatelessWidget {
  final List<Transaction> transactions;
  final Account account;
  
  const _AccountStatistics({
    required this.transactions,
    required this.account,
  });
  
  @override
  Widget build(BuildContext context) {
    final thisMonth = DateTime.now();
    final monthStart = DateTime(thisMonth.year, thisMonth.month, 1);
    
    final monthTransactions = transactions.where(
      (tx) => tx.date.isAfter(monthStart) || tx.date.isAtSameMomentAs(monthStart),
    ).toList();
    
    final income = monthTransactions
        .where((tx) => tx.type == TransactionType.income)
        .fold<double>(0, (sum, tx) => sum + tx.amount);
    
    final expenses = monthTransactions
        .where((tx) => tx.type == TransactionType.expense)
        .fold<double>(0, (sum, tx) => sum + tx.amount);
    
    final transfersIn = monthTransactions
        .where((tx) => tx.type == TransactionType.transfer && tx.toAccountId == account.id)
        .fold<double>(0, (sum, tx) => sum + tx.amount);
    
    final transfersOut = monthTransactions
        .where((tx) => tx.type == TransactionType.transfer && tx.accountId == account.id)
        .fold<double>(0, (sum, tx) => sum + tx.amount + (tx.transferFee ?? 0));
    
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.arrow_downward,
            label: 'Income',
            amount: income,
            color: Color(0xFF10B981),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.arrow_upward,
            label: 'Expenses',
            amount: expenses,
            color: Color(0xFFEF4444),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.swap_horiz,
            label: 'Transfers',
            amount: transfersIn - transfersOut,
            color: Color(0xFF3B82F6),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final double amount;
  final Color color;
  
  const _StatCard({
    required this.icon,
    required this.label,
    required this.amount,
    required this.color,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 4),
          Text(
            NumberFormat.currency(symbol: '\$', decimalDigits: 0).format(amount.abs()),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 10. Transaction Form with Account Selection

```dart
// lib/features/transactions/presentation/widgets/add_transaction_sheet.dart

class AddTransactionSheet extends ConsumerStatefulWidget {
  final String? preselectedAccountId;
  
  const AddTransactionSheet({
    this.preselectedAccountId,
  });
  
  @override
  ConsumerState<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends ConsumerState<AddTransactionSheet> {
  TransactionType _type = TransactionType.expense;
  double _amount = 0;
  String? _selectedAccountId;
  String? _selectedToAccountId; // For transfers
  String? _selectedCategoryId;
  DateTime _date = DateTime.now();
  String? _note;
  
  @override
  void initState() {
    super.initState();
    _selectedAccountId = widget.preselectedAccountId;
  }
  
  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountNotifierProvider);
    
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New Transaction',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 20),
          
          // Type Selector
          SegmentedControl(
            options: [
              SegmentOption(
                value: TransactionType.expense,
                label: 'Expense',
                icon: Icons.remove_circle_outline,
              ),
              SegmentOption(
                value: TransactionType.income,
                label: 'Income',
                icon: Icons.add_circle_outline,
              ),
              SegmentOption(
                value: TransactionType.transfer,
                label: 'Transfer',
                icon: Icons.swap_horiz,
              ),
            ],
            selected: _type,
            onChanged: (value) => setState(() => _type = value),
          ),
          SizedBox(height: 24),
          
          // Amount Input
          CurrencyInput(
            value: _amount,
            onChanged: (value) => setState(() => _amount = value),
          ),
          SizedBox(height: 24),
          
          // Account Selection
          accountsAsync.when(
            data: (accounts) => _buildAccountFields(accounts),
            loading: () => CircularProgressIndicator(),
            error: (_, __) => Text('Error loading accounts'),
          ),
          
          // Category Selection (not for transfers)
          if (_type != TransactionType.transfer) ...[
            SizedBox(height: 16),
            CategorySelector(
              selectedCategoryId: _selectedCategoryId,
              type: _type,
              onSelected: (id) => setState(() => _selectedCategoryId = id),
            ),
          ],
          
          // Date Picker
          SizedBox(height: 16),
          DatePickerField(
            label: 'Date',
            date: _date,
            onChanged: (date) => setState(() => _date = date),
          ),
          
          // Note Field
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Note (optional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 2,
            onChanged: (value) => _note = value,
          ),
          
          SizedBox(height: 24),
          
          // Submit Button
          AppButton(
            label: 'Add Transaction',
            onPressed: _isValid ? _submit : null,
            isFullWidth: true,
            isLoading: ref.watch(transactionNotifierProvider).isLoading,
          ),
        ],
      ),
    );
  }
  
  Widget _buildAccountFields(List<Account> accounts) {
    if (_type == TransactionType.transfer) {
      return Column(
        children: [
          // From Account
          DropdownButtonFormField<String>(
            value: _selectedAccountId,
            decoration: InputDecoration(
              labelText: 'From Account',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: accounts.map((account) {
              return DropdownMenuItem(
                value: account.id,
                child: Row(
                  children: [
                    Icon(
                      _getAccountIcon(account.type),
                      size: 20,
                      color: Color(0xFF14B8A6),
                    ),
                    SizedBox(width: 12),
                    Text(account.name),
                    Spacer(),
                    Text(
                      NumberFormat.currency(symbol: '\$', decimalDigits: 0)
                          .format(account.balance),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedAccountId = value),
          ),
          SizedBox(height: 16),
          
          // To Account
          DropdownButtonFormField<String>(
            value: _selectedToAccountId,
            decoration: InputDecoration(
              labelText: 'To Account',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: accounts
                .where((account) => account.id != _selectedAccountId)
                .map((account) {
              return DropdownMenuItem(
                value: account.id,
                child: Row(
                  children: [
                    Icon(
                      _getAccountIcon(account.type),
                      size: 20,
                      color: Color(0xFF14B8A6),
                    ),
                    SizedBox(width: 12),
                    Text(account.name),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedToAccountId = value),
          ),
        ],
      );
    } else {
      // Single account selector for income/expense
      return DropdownButtonFormField<String>(
        value: _selectedAccountId,
        decoration: InputDecoration(
          labelText: 'Account',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        items: accounts.map((account) {
          return DropdownMenuItem(
            value: account.id,
            child: Row(
              children: [
                Icon(
                  _getAccountIcon(account.type),
                  size: 20,
                  color: Color(0xFF14B8A6),
                ),
                SizedBox(width: 12),
                Expanded(child: Text(account.name)),
                Text(
                  NumberFormat.currency(symbol: '\$', decimalDigits: 0)
                      .format(account.balance),
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) => setState(() => _selectedAccountId = value),
      );
    }
  }
  
  bool get _isValid {
    if (_amount <= 0) return false;
    if (_selectedAccountId == null) return false;
    
    if (_type == TransactionType.transfer) {
      if (_selectedToAccountId == null) return false;
      if (_selectedAccountId == _selectedToAccountId) return false;
    } else {
      if (_selectedCategoryId == null) return false;
    }
    
    return true;
  }
  
  Future<void> _submit() async {
    if (!_isValid) return;
    
    final transaction = Transaction(
      id: const Uuid().v4(),
      amount: _amount,
      categoryId: _selectedCategoryId ?? 'transfer',
      date: _date,
      type: _type,
      accountId: _selectedAccountId,
      toAccountId: _selectedToAccountId,
      note: _note,
      createdAt: DateTime.now(),
    );
    
    await ref.read(transactionNotifierProvider.notifier).addTransaction(transaction);
    
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transaction added successfully')),
      );
    }
  }
  
  IconData _getAccountIcon(AccountType type) {
    switch (type) {
      case AccountType.cash:
        return Icons.payments_outlined;
      case AccountType.bank:
        return Icons.account_balance;
      case AccountType.credit:
        return Icons.credit_card;
      case AccountType.investment:
        return Icons.trending_up;
      case AccountType.loan:
        return Icons.money_off;
      case AccountType.other:
        return Icons.wallet;
    }
  }
}
```

---

## 11. Critical Edge Cases & Solutions

### Edge Case 1: Concurrent Transaction Additions

**Problem:** Multiple transactions added simultaneously affecting same account

**Solution: Optimistic Locking with Version Control**
```dart
@freezed
class Account with _$Account {
  const factory Account({
    required String id,
    required String name,
    required double balance,
    required int version, // Add version field
    // ... other fields
  }) = _Account;
}

class AddTransaction {
  Future<Result<Transaction>> call(Transaction transaction) async {
    int maxRetries = 3;
    int attempt = 0;
    
    while (attempt < maxRetries) {
      try {
        final accountResult = await _accountRepository.getById(transaction.accountId!);
        
        if (accountResult.isError) return Result.error(accountResult.failureOrNull!);
        
        final account = accountResult.dataOrNull!;
        final currentVersion = account.version;
        
        // Add transaction
        final txResult = await _transactionRepository.add(transaction);
        if (txResult.isError) return txResult;
        
        // Update account with version check
        final updatedAccount = account.copyWith(
          balance: account.balance + transaction.effectiveAmount,
          version: currentVersion + 1,
          updatedAt: DateTime.now(),
        );
        
        final updateResult = await _accountRepository.updateWithVersionCheck(
          updatedAccount,
          expectedVersion: currentVersion,
        );
        
        if (updateResult.isSuccess) {
          return txResult;
        }
        
        // Version conflict, retry
        attempt++;
        await Future.delayed(Duration(milliseconds: 100 * attempt));
        
      } catch (e) {
        return Result.error(Failure.unknown(e.toString()));
      }
    }
    
    return Result.error(Failure.unknown('Failed after $maxRetries attempts'));
  }
}
```

### Edge Case 2: Orphaned Transactions

**Problem:** Transaction exists but linked account was deleted

**Solution: Cascade Deletion with Safeguards**
```dart
class DeleteAccount {
  final AccountRepository _accountRepository;
  final TransactionRepository _transactionRepository;
  
  Future<Result<void>> call(String accountId) async {
    // 1. Check if account has transactions
    final transactionsResult = await _transactionRepository.getByAccountId(accountId);
    
    if (transactionsResult.isError) return Result.error(transactionsResult.failureOrNull!);
    
    final transactions = transactionsResult.dataOrNull!;
    
    if (transactions.isNotEmpty) {
      // Option 1: Prevent deletion
      return Result.error(
        Failure.validation(
          'Cannot delete account with existing transactions. '
          'Please delete or move ${transactions.length} transactions first.',
          {},
        ),
      );
      
      // Option 2: Move to default account
      // final defaultAccount = await _getDefaultAccount();
      // await _moveTransactions(transactions, defaultAccount.id);
      
      // Option 3: Soft delete (recommended)
      // await _softDeleteAccount(accountId);
    }
    
    // 2. Delete account
    return await _accountRepository.delete(accountId);
  }
}
```

### Edge Case 3: Transfer Consistency

**Problem:** Transfer partially completes (one account updated, other fails)

**Solution: Transaction Pattern (All or Nothing)**
```dart
class CreateTransfer {
  Future<Result<Transaction>> call({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    double? fee,
  }) async {
    // Use database transaction if available, or implement manual rollback
    
    Transaction? createdTransaction;
    bool sourceUpdated = false;
    bool destinationUpdated = false;
    
    try {
      // 1. Create transfer record
      final transaction = Transaction(
        id: const Uuid().v4(),
        amount: amount,
        type: TransactionType.transfer,
        accountId: fromAccountId,
        toAccountId: toAccountId,
        transferFee: fee,
        categoryId: 'transfer',
        date: DateTime.now(),
        createdAt: DateTime.now(),
      );
      
      final txResult = await _transactionRepository.add(transaction);
      if (txResult.isError) throw Exception('Failed to create transfer');
      
      createdTransaction = txResult.dataOrNull!;
      
      // 2. Update source account
      final sourceResult = await _updateAccount(
        fromAccountId,
        -(amount + (fee ?? 0)),
      );
      if (sourceResult.isError) throw Exception('Failed to update source');
      
      sourceUpdated = true;
      
      // 3. Update destination account
      final destResult = await _updateAccount(toAccountId, amount);
      if (destResult.isError) throw Exception('Failed to update destination');
      
      destinationUpdated = true;
      
      return Result.success(createdTransaction);
      
    } catch (e) {
      // Rollback on any failure
      if (createdTransaction != null) {
        await _transactionRepository.delete(createdTransaction.id);
      }
      
      if (sourceUpdated) {
        await _updateAccount(fromAccountId, amount + (fee ?? 0));
      }
      
      if (destinationUpdated) {
        await _updateAccount(toAccountId, -amount);
      }
      
      return Result.error(Failure.unknown('Transfer failed: $e'));
    }
  }
}
```

---

## 12. Performance Optimization Strategies

### Strategy 1: Indexed Queries
```dart
// Hive composite index for efficient queries
@HiveType(typeId: 0)
class TransactionDTO extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(5)
  @HiveField(indexed: true) // Index account_id for fast lookups
  String? accountId;
  
  @HiveField(3)
  @HiveField(indexed: true) // Index timestamp for date range queries
  int timestamp;
  
  // Composite index key for account + date queries
  String get compositeKey => '${accountId}_${timestamp ~/ 86400000}'; // Day precision
}
```

### Strategy 2: Balance Caching
```dart
class BalanceCache {
  final Map<String, CachedBalance> _cache = {};
  
  void updateCache(String accountId, double balance, DateTime timestamp) {
    _cache[accountId] = CachedBalance(
      balance: balance,
      timestamp: timestamp,
      isValid: true,
    );
  }
  
  double? getCachedBalance(String accountId, {Duration maxAge = const Duration(minutes: 5)}) {
    final cached = _cache[accountId];
    if (cached == null) return null;
    
    if (DateTime.now().difference(cached.timestamp) > maxAge) {
      return null; // Cache expired
    }
    
    return cached.balance;
  }
  
  void invalidate(String accountId) {
    _cache[accountId] = _cache[accountId]?.copyWith(isValid: false);
  }
}
```

### Strategy 3: Pagination for Large Transaction Lists
```dart
class GetPaginatedTransactions {
  static const int pageSize = 50;
  
  Future<Result<PaginatedTransactions>> call({
    required String accountId,
    required int page,
  }) async {
    final skip = page * pageSize;
    
    final allTransactions = await _repository.getByAccountId(accountId);
    
    return allTransactions.when(
      success: (transactions) {
        final paginatedItems = transactions
            .skip(skip)
            .take(pageSize)
            .toList();
        
        return Result.success(
          PaginatedTransactions(
            items: paginatedItems,
            page: page,
            totalItems: transactions.length,
            hasMore: transactions.length > (page + 1) * pageSize,
          ),
        );
      },
      error: (failure) => Result.error(failure),
    );
  }
}
```

---

## 13. Summary: Key Relationship Patterns

| **Pattern** | **Description** | **Implementation** |
|-------------|-----------------|-------------------|
| **One-to-Many** | One account has many transactions | `Transaction.accountId → Account.id` |
| **Transfer Link** | Transfer connects two accounts | `Transaction.accountId → Account.id (source)`<br>`Transaction.toAccountId → Account.id (destination)` |
| **Balance Sync** | Transaction updates account balance | Eager update on transaction add/delete |
| **Cascade Query** | Get all transactions for account | `repository.getByAccountId(accountId)` |
| **Balance Reconciliation** | Verify balance matches transactions | Periodic: `calculateBalance()` vs `account.balance` |
| **Optimistic Locking** | Prevent concurrent update conflicts | Version field + retry logic |
| **Soft Delete** | Mark deleted, preserve history | `isActive: false` instead of actual deletion |
| **Transaction Pattern** | Atomic transfers (all-or-nothing) | Manual rollback on partial failure |
```

---

## 14. Testing Strategy for Account-Transaction Relationship

### Unit Tests

```dart
// test/features/transactions/domain/usecases/add_transaction_test.dart

void main() {
  late AddTransaction useCase;
  late MockTransactionRepository mockTransactionRepo;
  late MockAccountRepository mockAccountRepo;
  
  setUp(() {
    mockTransactionRepo = MockTransactionRepository();
    mockAccountRepo = MockAccountRepository();
    useCase = AddTransaction(mockTransactionRepo, mockAccountRepo);
  });
  
  group('AddTransaction - Account Balance Update', () {
    final account = Account(
      id: 'acc_1',
      name: 'Bank Account',
      type: AccountType.bank,
      balance: 1000.0,
      currency: 'USD',
    );
    
    final expenseTransaction = Transaction(
      id: 'tx_1',
      amount: 50.0,
      categoryId: 'food',
      date: DateTime.now(),
      type: TransactionType.expense,
      accountId: 'acc_1',
    );
    
    test('should update account balance when adding expense', () async {
      // Arrange
      when(mockAccountRepo.getById('acc_1'))
          .thenAnswer((_) async => Result.success(account));
      
      when(mockTransactionRepo.add(any))
          .thenAnswer((_) async => Result.success(expenseTransaction));
      
      when(mockAccountRepo.update(any))
          .thenAnswer((_) async => Result.success(null));
      
      // Act
      final result = await useCase(expenseTransaction);
      
      // Assert
      expect(result.isSuccess, true);
      
      final capturedAccount = verify(
        mockAccountRepo.update(captureAny),
      ).captured.single as Account;
      
      expect(capturedAccount.balance, 950.0); // 1000 - 50
    });
    
    test('should rollback transaction if account update fails', () async {
      // Arrange
      when(mockAccountRepo.getById('acc_1'))
          .thenAnswer((_) async => Result.success(account));
      
      when(mockTransactionRepo.add(any))
          .thenAnswer((_) async => Result.success(expenseTransaction));
      
      when(mockAccountRepo.update(any))
          .thenAnswer((_) async => Result.error(Failure.cache('Update failed')));
      
      when(mockTransactionRepo.delete(any))
          .thenAnswer((_) async => Result.success(null));
      
      // Act
      final result = await useCase(expenseTransaction);
      
      // Assert
      expect(result.isError, true);
      verify(mockTransactionRepo.delete(expenseTransaction.id)).called(1);
    });
    
    test('should update both accounts for transfer', () async {
      // Arrange
      final sourceAccount = account;
      final destinationAccount = Account(
        id: 'acc_2',
        name: 'Cash Wallet',
        type: AccountType.cash,
        balance: 100.0,
        currency: 'USD',
      );
      
      final transferTransaction = Transaction(
        id: 'tx_2',
        amount: 200.0,
        categoryId: 'transfer',
        date: DateTime.now(),
        type: TransactionType.transfer,
        accountId: 'acc_1',
        toAccountId: 'acc_2',
        transferFee: 2.0,
      );
      
      when(mockAccountRepo.getById('acc_1'))
          .thenAnswer((_) async => Result.success(sourceAccount));
      
      when(mockAccountRepo.getById('acc_2'))
          .thenAnswer((_) async => Result.success(destinationAccount));
      
      when(mockTransactionRepo.add(any))
          .thenAnswer((_) async => Result.success(transferTransaction));
      
      when(mockAccountRepo.update(any))
          .thenAnswer((_) async => Result.success(null));
      
      // Act
      final result = await useCase(transferTransaction);
      
      // Assert
      expect(result.isSuccess, true);
      
      final capturedAccounts = verify(
        mockAccountRepo.update(captureAny),
      ).captured.cast<Account>();
      
      expect(capturedAccounts.length, 2);
      
      // Source account: 1000 - 200 - 2 = 798
      expect(
        capturedAccounts.firstWhere((a) => a.id == 'acc_1').balance,
        798.0,
      );
      
      // Destination account: 100 + 200 = 300
      expect(
        capturedAccounts.firstWhere((a) => a.id == 'acc_2').balance,
        300.0,
      );
    });
    
    test('should prevent expense exceeding account balance', () async {
      // Arrange
      final lowBalanceAccount = account.copyWith(balance: 30.0);
      
      when(mockAccountRepo.getById('acc_1'))
          .thenAnswer((_) async => Result.success(lowBalanceAccount));
      
      // Act
      final result = await useCase(expenseTransaction); // Trying to spend 50
      
      // Assert
      expect(result.isError, true);
      expect(
        result.failureOrNull,
        isA<ValidationFailure>(),
      );
      verifyNever(mockTransactionRepo.add(any));
    });
  });
  
  group('DeleteTransaction - Balance Rollback', () {
    test('should reverse balance change when deleting transaction', () async {
      // Arrange
      final account = Account(
        id: 'acc_1',
        name: 'Bank Account',
        type: AccountType.bank,
        balance: 950.0, // Already deducted 50
        currency: 'USD',
      );
      
      final transaction = Transaction(
        id: 'tx_1',
        amount: 50.0,
        categoryId: 'food',
        date: DateTime.now(),
        type: TransactionType.expense,
        accountId: 'acc_1',
      );
      
      final deleteUseCase = DeleteTransaction(
        mockTransactionRepo,
        mockAccountRepo,
      );
      
      when(mockTransactionRepo.getById('tx_1'))
          .thenAnswer((_) async => Result.success(transaction));
      
      when(mockAccountRepo.getById('acc_1'))
          .thenAnswer((_) async => Result.success(account));
      
      when(mockTransactionRepo.delete('tx_1'))
          .thenAnswer((_) async => Result.success(null));
      
      when(mockAccountRepo.update(any))
          .thenAnswer((_) async => Result.success(null));
      
      // Act
      final result = await deleteUseCase('tx_1');
      
      // Assert
      expect(result.isSuccess, true);
      
      final capturedAccount = verify(
        mockAccountRepo.update(captureAny),
      ).captured.single as Account;
      
      // Balance should be restored: 950 + 50 = 1000
      expect(capturedAccount.balance, 1000.0);
    });
  });
}
```

### Integration Tests

```dart
// test/features/transactions/transaction_account_integration_test.dart

void main() {
  late Box<AccountDTO> accountBox;
  late Box<TransactionDTO> transactionBox;
  late AccountRepository accountRepo;
  late TransactionRepository transactionRepo;
  late AddTransaction addTransaction;
  
  setUp(() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AccountDTOAdapter());
    Hive.registerAdapter(TransactionDTOAdapter());
    
    accountBox = await Hive.openBox<AccountDTO>('test_accounts');
    transactionBox = await Hive.openBox<TransactionDTO>('test_transactions');
    
    accountRepo = AccountRepositoryImpl(HiveAccountDataSource(accountBox));
    transactionRepo = TransactionRepositoryImpl(HiveTransactionDataSource(transactionBox));
    
    addTransaction = AddTransaction(transactionRepo, accountRepo);
  });
  
  tearDown(() async {
    await accountBox.clear();
    await transactionBox.clear();
    await Hive.close();
  });
  
  test('complete transaction flow updates account balance correctly', () async {
    // 1. Create account
    final account = Account(
      id: 'acc_1',
      name: 'Test Account',
      type: AccountType.bank,
      balance: 1000.0,
      currency: 'USD',
    );
    
    await accountRepo.add(account);
    
    // 2. Add income transaction
    final income = Transaction(
      id: 'tx_1',
      amount: 500.0,
      categoryId: 'salary',
      date: DateTime.now(),
      type: TransactionType.income,
      accountId: 'acc_1',
    );
    
    await addTransaction(income);
    
    // 3. Verify balance increased
    var updatedAccount = await accountRepo.getById('acc_1');
    expect(updatedAccount.dataOrNull?.balance, 1500.0);
    
    // 4. Add expense transaction
    final expense = Transaction(
      id: 'tx_2',
      amount: 200.0,
      categoryId: 'food',
      date: DateTime.now(),
      type: TransactionType.expense,
      accountId: 'acc_1',
    );
    
    await addTransaction(expense);
    
    // 5. Verify balance decreased
    updatedAccount = await accountRepo.getById('acc_1');
    expect(updatedAccount.dataOrNull?.balance, 1300.0);
    
    // 6. Verify transactions are linked
    final transactions = await transactionRepo.getByAccountId('acc_1');
    expect(transactions.dataOrNull?.length, 2);
    
    // 7. Calculate balance from transactions
    final calculatedBalance = transactions.dataOrNull!.fold<double>(
      0,
      (sum, tx) => sum + tx.effectiveAmount,
    );
    
    expect(calculatedBalance, 300.0); // +500 (income) -200 (expense)
    expect(
      updatedAccount.dataOrNull!.balance - account.balance,
      calculatedBalance,
    );
  });
  
  test('transfer between accounts works correctly', () async {
    // 1. Create two accounts
    final bankAccount = Account(
      id: 'acc_1',
      name: 'Bank',
      type: AccountType.bank,
      balance: 1000.0,
      currency: 'USD',
    );
    
    final cashAccount = Account(
      id: 'acc_2',
      name: 'Cash',
      type: AccountType.cash,
      balance: 100.0,
      currency: 'USD',
    );
    
    await accountRepo.add(bankAccount);
    await accountRepo.add(cashAccount);
    
    // 2. Create transfer
    final transfer = Transaction(
      id: 'tx_1',
      amount: 300.0,
      categoryId: 'transfer',
      date: DateTime.now(),
      type: TransactionType.transfer,
      accountId: 'acc_1', // From bank
      toAccountId: 'acc_2', // To cash
      transferFee: 5.0,
    );
    
    await addTransaction(transfer);
    
    // 3. Verify both accounts updated
    final updatedBank = await accountRepo.getById('acc_1');
    final updatedCash = await accountRepo.getById('acc_2');
    
    // Bank: 1000 - 300 - 5 = 695
    expect(updatedBank.dataOrNull?.balance, 695.0);
    
    // Cash: 100 + 300 = 400
    expect(updatedCash.dataOrNull?.balance, 400.0);
    
    // 4. Verify total system balance unchanged (minus fee)
    final totalBefore = bankAccount.balance + cashAccount.balance;
    final totalAfter = updatedBank.dataOrNull!.balance + 
                       updatedCash.dataOrNull!.balance;
    
    expect(totalBefore - totalAfter, 5.0); // Only fee is "lost"
  });
}
```

---

## 15. Real-World Implementation Checklist

### Phase 1: Foundation ✓
```
☐ Define Account entity with all fields
☐ Define Transaction entity with account links
☐ Create AccountType and TransactionType enums
☐ Implement DTOs for both entities
☐ Create mappers for domain ↔ data conversion
☐ Set up Hive boxes and adapters
☐ Register type adapters in main.dart
```

### Phase 2: Repository Layer ✓
```
☐ Implement AccountRepository interface
☐ Implement TransactionRepository interface
☐ Add getByAccountId() to transaction repository
☐ Add balance calculation methods
☐ Implement account update methods
☐ Add transaction CRUD operations
☐ Write repository unit tests
```

### Phase 3: Business Logic ✓
```
☐ Create AddTransaction use case with balance update
☐ Create DeleteTransaction with balance rollback
☐ Create CreateTransfer with dual account updates
☐ Create CalculateAccountBalance use case
☐ Create ReconcileAccountBalance use case
☐ Implement validation logic
☐ Add error handling and rollback logic
☐ Write use case unit tests
```

### Phase 4: State Management ✓
```
☐ Create AccountNotifier with Riverpod
☐ Create TransactionNotifier with Riverpod
☐ Link providers (transaction changes → account refresh)
☐ Create derived providers (accountWithBalance)
☐ Implement loading/error states
☐ Add optimistic updates
```

### Phase 5: UI Implementation ✓
```
☐ Build AccountDetailScreen
☐ Build TransactionListScreen with account filter
☐ Build AddTransactionSheet with account selector
☐ Build TransferSheet with from/to account selection
☐ Add balance display components
☐ Implement transaction tiles with account info
☐ Add account statistics widgets
```

### Phase 6: Edge Cases & Polish ✓
```
☐ Handle concurrent transaction additions
☐ Prevent orphaned transactions
☐ Implement transfer consistency checks
☐ Add balance reconciliation
☐ Implement soft delete for accounts
☐ Add data validation
☐ Optimize queries with indexes
☐ Implement caching strategy
```

### Phase 7: Testing & Validation ✓
```
☐ Unit tests for all use cases
☐ Integration tests for account-transaction flow
☐ Widget tests for UI components
☐ End-to-end tests for complete flows
☐ Performance testing with large datasets
☐ Edge case testing
☐ Error scenario testing
```

---

## 16. Critical Implementation Rules

### Rule 1: Always Update Balance When Transaction Changes
```dart
// ❌ WRONG: Only adding transaction
await transactionRepository.add(transaction);

// ✅ CORRECT: Add transaction AND update account
await transactionRepository.add(transaction);
await updateAccountBalance(transaction.accountId, transaction.effectiveAmount);
```

### Rule 2: Always Use Effective Amount for Balance Calculation
```dart
// ❌ WRONG: Using raw amount
balance += transaction.amount;

// ✅ CORRECT: Using effective amount (considers type)
balance += transaction.effectiveAmount; // Handles +/- based on type
```

### Rule 3: Always Validate Account Before Transaction
```dart
// ❌ WRONG: No validation
await addTransaction(transaction);

// ✅ CORRECT: Validate first
if (transaction.type == TransactionType.expense) {
  final account = await getAccount(transaction.accountId);
  if (account.balance < transaction.amount) {
    throw InsufficientBalanceException();
  }
}
await addTransaction(transaction);
```

### Rule 4: Always Handle Transfer as Atomic Operation
```dart
// ❌ WRONG: Separate, non-atomic operations
await updateAccount(fromAccountId, -amount);
await updateAccount(toAccountId, amount);

// ✅ CORRECT: Atomic with rollback
try {
  await updateAccount(fromAccountId, -amount);
  await updateAccount(toAccountId, amount);
} catch (e) {
  await rollback();
  throw e;
}
```

### Rule 5: Never Directly Modify Balance Without Transaction Record
```dart
// ❌ WRONG: Direct balance manipulation
account.balance += 100;
await saveAccount(account);

// ✅ CORRECT: Always through transaction
final transaction = Transaction(
  amount: 100,
  type: TransactionType.income,
  accountId: account.id,
  // ...
);
await addTransaction(transaction); // This updates balance
```

### Rule 6: Always Reconcile Periodically
```dart
// Scheduled reconciliation
class ReconciliationService {
  Future<void> reconcileAllAccounts() async {
    final accounts = await getAllAccounts();
    
    for (final account in accounts) {
      final calculatedBalance = await calculateBalance(account.id);
      
      if ((account.balance - calculatedBalance).abs() > 0.01) {
        await logDiscrepancy(account.id, account.balance, calculatedBalance);
        await updateAccountBalance(account.id, calculatedBalance);
      }
    }
  }
}

// Run daily at midnight
Timer.periodic(Duration(days: 1), (_) {
  reconciliationService.reconcileAllAccounts();
});
```

---

## 17. Performance Benchmarks

### Expected Performance Metrics:

```
Single Transaction Add: < 50ms
Account Balance Calculation (1000 tx): < 100ms
Transfer Operation: < 100ms
Account Query with Transactions: < 200ms
Balance Reconciliation (10 accounts): < 500ms

Memory Usage:
- 1000 transactions: ~2MB
- 10 accounts: ~50KB
- Cache overhead: ~1MB
```

---

## Summary

The Account-Transaction relationship is the **core foundation** of the budget tracking app. Key takeaways:

1. **One-to-Many**: One account has many transactions
2. **Balance Integrity**: Balance must ALWAYS equal sum of transaction effects
3. **Transfer Complexity**: Transfers link two accounts and require atomic updates
4. **Eager Updates**: Update balance immediately when transaction added/deleted
5. **Reconciliation**: Periodic checks ensure data integrity
6. **Error Recovery**: Always implement rollback for failed operations
7. **Testing**: Comprehensive tests for all edge cases critical
8. **Performance**: Use indexes, caching, and pagination for scale

This relationship pattern forms the backbone of financial data integrity in the application.