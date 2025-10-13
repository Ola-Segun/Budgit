# Complete Budget Tracking App: Features, Logic, Implementation & Workflow

Looking at the extensive documentation provided, I'll analyze and complete the budgeting system comprehensively, identifying gaps and providing complete implementations.

## 1. Core Gap Analysis

The documentation covers architecture and UI extensively but lacks:

1. **Complete Budget Calculation Engine** - State transitions and edge cases
2. **Integration Points** - How budgets interact with transactions, accounts, goals
3. **Real-time Synchronization** - Budget updates when transactions change
4. **Historical Tracking** - Budget performance over time
5. **Conflict Resolution** - Multiple budget updates, data consistency
6. **Export & Analysis** - Actionable budget insights

---

## 2. Complete Budget System Architecture

### 2.1 Domain Layer - Enhanced Budget Model

```dart
// lib/features/budgets/domain/entities/budget.dart

@freezed
class Budget with _$Budget {
  const factory Budget({
    required String id,
    required String name,
    required BudgetPeriod period,
    required DateTime startDate,
    required DateTime endDate,
    required List<CategoryBudget> categories,
    
    // Account linkage
    @Default([]) List<String> accountIds,
    @Default(true) bool trackAllAccounts,
    
    // Budget configuration
    required BudgetType type,
    @Default(false) bool rolloverUnspent,
    @Default(false) bool isActive,
    @Default(0) double carryOverAmount,
    
    // Tracking
    @Default(0) double totalSpent,
    @Default({}) Map<String, double> categorySpending,
    
    // Metadata
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version, // For optimistic locking
  }) = _Budget;
  
  factory Budget.fromJson(Map<String, dynamic> json) =>
      _$BudgetFromJson(json);
}

@freezed
class CategoryBudget with _$CategoryBudget {
  const factory CategoryBudget({
    required String id,
    required String categoryId,
    required String categoryName,
    required double allocatedAmount,
    
    // Spending tracking
    @Default(0) double spentAmount,
    @Default(0) double carryOverAmount,
    @Default([]) List<String> transactionIds,
    
    // Alerts
    @Default(AlertThreshold(percentage: 80, isEnabled: true))
    AlertThreshold alertThreshold,
    
    // Status
    @Default(false) bool isLocked,
    String? lockReason,
  }) = _CategoryBudget;
  
  factory CategoryBudget.fromJson(Map<String, dynamic> json) =>
      _$CategoryBudgetFromJson(json);
}

@freezed
class AlertThreshold with _$AlertThreshold {
  const factory AlertThreshold({
    required double percentage,
    required bool isEnabled,
  }) = _AlertThreshold;
  
  factory AlertThreshold.fromJson(Map<String, dynamic> json) =>
      _$AlertThresholdFromJson(json);
}

// Extension with computed properties
extension BudgetExtension on Budget {
  bool get isCurrentPeriod {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }
  
  bool get isOverBudget {
    return categorySpending.values.fold<double>(0, (sum, spent) => sum + spent) >
        categories.fold<double>(0, (sum, cat) => sum + cat.allocatedAmount);
  }
  
  double get remainingBudget {
    final totalAllocated = categories.fold<double>(
      0,
      (sum, cat) => sum + cat.allocatedAmount,
    );
    final totalSpent = categorySpending.values.fold<double>(0, (sum, x) => sum + x);
    return totalAllocated - totalSpent;
  }
  
  double get percentageUsed {
    final totalAllocated = categories.fold<double>(
      0,
      (sum, cat) => sum + cat.allocatedAmount,
    );
    if (totalAllocated == 0) return 0;
    final totalSpent = categorySpending.values.fold<double>(0, (sum, x) => sum + x);
    return (totalSpent / totalAllocated * 100).clamp(0, 200);
  }
  
  int get daysRemaining => endDate.difference(DateTime.now()).inDays;
  
  double get recommendedDailySpending {
    if (daysRemaining <= 0) return 0;
    return remainingBudget / daysRemaining;
  }
}

extension CategoryBudgetExtension on CategoryBudget {
  double get remaining => allocatedAmount - spentAmount;
  
  double get percentageUsed => allocatedAmount > 0
      ? (spentAmount / allocatedAmount * 100).clamp(0, 200)
      : 0;
  
  bool get isOverBudget => spentAmount > allocatedAmount;
  
  BudgetHealthStatus get healthStatus {
    if (percentageUsed > 100) return BudgetHealthStatus.overBudget;
    if (percentageUsed >= 90) return BudgetHealthStatus.critical;
    if (percentageUsed >= 75) return BudgetHealthStatus.warning;
    return BudgetHealthStatus.healthy;
  }
  
  bool get shouldAlert => alertThreshold.isEnabled &&
      percentageUsed >= alertThreshold.percentage &&
      healthStatus != BudgetHealthStatus.overBudget;
}

enum BudgetType {
  zeroBased,
  fiftyThirtyTwenty,
  envelope,
  percentageBased,
  custom,
}

enum BudgetPeriod {
  weekly,
  biWeekly,
  monthly,
  quarterly,
  yearly,
  custom,
}

enum BudgetHealthStatus {
  healthy,
  warning,
  critical,
  overBudget,
}
```

### 2.2 Repository Interface

```dart
// lib/features/budgets/domain/repositories/budget_repository.dart

abstract class BudgetRepository {
  // CRUD Operations
  Future<Result<Budget>> create(Budget budget);
  Future<Result<Budget>> getById(String budgetId);
  Future<Result<List<Budget>>> getAll();
  Future<Result<List<Budget>>> getActiveBudgets();
  Future<Result<Budget>> update(Budget budget);
  Future<Result<void>> delete(String budgetId);
  
  // Queries
  Future<Result<Budget?>> getCurrentBudget();
  Future<Result<List<Budget>>> getByDateRange(DateTime start, DateTime end);
  Future<Result<Budget>> getBudgetForCategory(String categoryId);
  
  // Calculations
  Future<Result<BudgetStatus>> calculateBudgetStatus(String budgetId);
  Future<Result<double>> calculateCategorySpending(
    String budgetId,
    String categoryId,
  );
  
  // Updates
  Future<Result<void>> updateCategorySpending(
    String budgetId,
    String categoryId,
    double amount,
  );
  
  // Templates
  Future<Result<List<BudgetTemplate>>> getTemplates();
  Future<Result<Budget>> createFromTemplate(
    String templateId,
    DateTime startDate,
  );
}

@freezed
class BudgetStatus with _$BudgetStatus {
  const factory BudgetStatus({
    required Budget budget,
    required List<CategoryStatus> categoryStatuses,
    required double totalAllocated,
    required double totalSpent,
    required double totalRemaining,
    required double percentageUsed,
    required BudgetHealthStatus overallHealth,
    required int daysRemaining,
    required double recommendedDailySpending,
    required List<String> alertCategories,
  }) = _BudgetStatus;
}

@freezed
class CategoryStatus with _$CategoryStatus {
  const factory CategoryStatus({
    required String categoryId,
    required String categoryName,
    required double allocated,
    required double spent,
    required double remaining,
    required double percentageUsed,
    required BudgetHealthStatus health,
    required int transactionCount,
    required List<String> transactionIds,
  }) = _CategoryStatus;
}

@freezed
class BudgetTemplate with _$BudgetTemplate {
  const factory BudgetTemplate({
    required String id,
    required String name,
    required BudgetType type,
    required List<TemplateCategory> categories,
  }) = _BudgetTemplate;
}

@freezed
class TemplateCategory with _$TemplateCategory {
  const factory TemplateCategory({
    required String categoryId,
    required String categoryName,
    required double percentageOfIncome,
  }) = _TemplateCategory;
}
```

### 2.3 Use Cases - Complete Business Logic

```dart
// lib/features/budgets/domain/usecases/create_budget.dart

class CreateBudget {
  final BudgetRepository _budgetRepository;
  final TransactionRepository _transactionRepository;
  
  CreateBudget(this._budgetRepository, this._transactionRepository);
  
  Future<Result<Budget>> call(CreateBudgetParams params) async {
    // 1. Validation
    final validation = _validateBudgetParams(params);
    if (validation.isError) return validation;
    
    // 2. Check for overlapping budgets
    final existingBudgets = await _budgetRepository.getByDateRange(
      params.startDate,
      params.endDate,
    );
    
    if (existingBudgets.isSuccess && existingBudgets.dataOrNull!.isNotEmpty) {
      return Result.error(
        Failure.validation(
          'Budget period overlaps with existing budget',
          {'period': 'Overlapping period detected'},
        ),
      );
    }
    
    // 3. Initialize category spending from existing transactions
    final initializedBudget = await _initializeCategorySpending(
      params,
    );
    
    // 4. Create budget
    final result = await _budgetRepository.create(initializedBudget);
    
    // 5. Send confirmation notification
    if (result.isSuccess) {
      // Notify user
    }
    
    return result;
  }
  
  Result<Budget> _validateBudgetParams(CreateBudgetParams params) {
    // Date validation
    if (params.endDate.isBefore(params.startDate)) {
      return Result.error(
        Failure.validation(
          'End date must be after start date',
          {'date': 'Invalid date range'},
        ),
      );
    }
    
    // Categories validation
    if (params.categories.isEmpty) {
      return Result.error(
        Failure.validation(
          'Budget must have at least one category',
          {'categories': 'No categories provided'},
        ),
      );
    }
    
    // Amount validation
    for (final category in params.categories) {
      if (category.amount < 0) {
        return Result.error(
          Failure.validation(
            'Category amounts must be positive',
            {category.name: 'Negative amount'},
          ),
        );
      }
    }
    
    return Result.success(params.toBudget());
  }
  
  Future<Budget> _initializeCategorySpending(
    CreateBudgetParams params,
  ) async {
    // Get existing transactions in this period
    final txResult = await _transactionRepository.getByDateRange(
      params.startDate,
      params.endDate,
    );
    
    final transactions = txResult.dataOrNull ?? [];
    
    // Calculate spending by category
    final categorySpending = <String, double>{};
    final categoryTransactions = <String, List<String>>{};
    
    for (final tx in transactions) {
      if (tx.type != TransactionType.expense) continue;
      
      // Only include if in budget scope
      if (!_isTransactionInScope(tx, params)) continue;
      
      categorySpending[tx.categoryId] =
          (categorySpending[tx.categoryId] ?? 0) + tx.amount;
      
      categoryTransactions[tx.categoryId] ??= [];
      categoryTransactions[tx.categoryId]!.add(tx.id);
    }
    
    // Update categories with initial spending
    final updatedCategories = params.categories.map((cat) {
      return cat.copyWith(
        spentAmount: categorySpending[cat.categoryId] ?? 0,
        transactionIds: categoryTransactions[cat.categoryId] ?? [],
      );
    }).toList();
    
    final budget = params.toBudget().copyWith(
      categories: updatedCategories,
      categorySpending: categorySpending,
      totalSpent: categorySpending.values.fold(0, (a, b) => a + b),
    );
    
    return budget;
  }
  
  bool _isTransactionInScope(Transaction tx, CreateBudgetParams params) {
    // Check account filter
    if (!params.trackAllAccounts && params.accountIds.isNotEmpty) {
      if (tx.accountId == null) return false;
      if (!params.accountIds.contains(tx.accountId)) return false;
    }
    
    // Check category filter
    final categoryIds = params.categories.map((c) => c.categoryId).toList();
    return categoryIds.contains(tx.categoryId);
  }
}

@freezed
class CreateBudgetParams with _$CreateBudgetParams {
  const factory CreateBudgetParams({
    required String name,
    required BudgetType type,
    required BudgetPeriod period,
    required DateTime startDate,
    required DateTime endDate,
    required List<CreateCategoryBudgetParams> categories,
    @Default([]) List<String> accountIds,
    @Default(true) bool trackAllAccounts,
    @Default(false) bool rolloverUnspent,
    String? description,
  }) = _CreateBudgetParams;
  
  Budget toBudget() => Budget(
    id: const Uuid().v4(),
    name: name,
    type: type,
    period: period,
    startDate: startDate,
    endDate: endDate,
    categories: categories.map((c) => c.toCategoryBudget()).toList(),
    accountIds: accountIds,
    trackAllAccounts: trackAllAccounts,
    rolloverUnspent: rolloverUnspent,
    description: description,
    isActive: true,
    createdAt: DateTime.now(),
  );
}

@freezed
class CreateCategoryBudgetParams with _$CreateCategoryBudgetParams {
  const factory CreateCategoryBudgetParams({
    required String categoryId,
    required String categoryName,
    required double amount,
  }) = _CreateCategoryBudgetParams;
  
  CategoryBudget toCategoryBudget() => CategoryBudget(
    id: const Uuid().v4(),
    categoryId: categoryId,
    categoryName: categoryName,
    allocatedAmount: amount,
  );
}

// ============================================

// lib/features/budgets/domain/usecases/calculate_budget_status.dart

class CalculateBudgetStatus {
  final TransactionRepository _transactionRepository;
  
  CalculateBudgetStatus(this._transactionRepository);
  
  Future<Result<BudgetStatus>> call(Budget budget) async {
    // 1. Get all transactions for budget period
    final transactionsResult = await _transactionRepository.getByDateRange(
      budget.startDate,
      budget.endDate,
    );
    
    if (transactionsResult.isError) {
      return Result.error(transactionsResult.failureOrNull!);
    }
    
    final transactions = transactionsResult.dataOrNull!;
    
    // 2. Filter to budget scope
    final relevantTransactions = _filterTransactions(transactions, budget);
    
    // 3. Calculate spending by category
    final categoryStatuses = _calculateCategoryStatuses(
      budget,
      relevantTransactions,
    );
    
    // 4. Calculate overall status
    final totalAllocated = budget.categories.fold<double>(
      0,
      (sum, cat) => sum + cat.allocatedAmount,
    );
    
    final totalSpent = categoryStatuses.fold<double>(
      0,
      (sum, status) => sum + status.spent,
    );
    
    final totalRemaining = totalAllocated - totalSpent;
    
    // 5. Determine alert categories
    final alertCategories = categoryStatuses
        .where((status) => status.health != BudgetHealthStatus.healthy)
        .map((status) => status.categoryId)
        .toList();
    
    // 6. Calculate recommendations
    final daysRemaining = budget.daysRemaining;
    final recommendedDailySpending =
        daysRemaining > 0 ? totalRemaining / daysRemaining : 0;
    
    return Result.success(
      BudgetStatus(
        budget: budget,
        categoryStatuses: categoryStatuses,
        totalAllocated: totalAllocated,
        totalSpent: totalSpent,
        totalRemaining: totalRemaining,
        percentageUsed: totalAllocated > 0
            ? (totalSpent / totalAllocated * 100)
            : 0,
        overallHealth: _calculateOverallHealth(totalSpent, totalAllocated),
        daysRemaining: daysRemaining,
        recommendedDailySpending: recommendedDailySpending,
        alertCategories: alertCategories,
      ),
    );
  }
  
  List<Transaction> _filterTransactions(
    List<Transaction> transactions,
    Budget budget,
  ) {
    return transactions.where((tx) {
      // Must be expense
      if (tx.type != TransactionType.expense) return false;
      
      // Must be in budget categories
      final categoryIds = budget.categories
          .map((c) => c.categoryId)
          .toList();
      if (!categoryIds.contains(tx.categoryId)) return false;
      
      // Check account scope
      if (!budget.trackAllAccounts && budget.accountIds.isNotEmpty) {
        if (tx.accountId == null) return false;
        if (!budget.accountIds.contains(tx.accountId)) return false;
      }
      
      return true;
    }).toList();
  }
  
  List<CategoryStatus> _calculateCategoryStatuses(
    Budget budget,
    List<Transaction> transactions,
  ) {
    return budget.categories.map((categoryBudget) {
      final categoryTransactions = transactions
          .where((tx) => tx.categoryId == categoryBudget.categoryId)
          .toList();
      
      final spent = categoryTransactions.fold<double>(
        0,
        (sum, tx) => sum + tx.amount,
      );
      
      final remaining = categoryBudget.allocatedAmount - spent;
      final percentageUsed =
          (spent / categoryBudget.allocatedAmount * 100).clamp(0, 200);
      
      final health = _calculateCategoryHealth(
        spent,
        categoryBudget.allocatedAmount,
      );
      
      return CategoryStatus(
        categoryId: categoryBudget.categoryId,
        categoryName: categoryBudget.categoryName,
        allocated: categoryBudget.allocatedAmount,
        spent: spent,
        remaining: remaining,
        percentageUsed: percentageUsed,
        health: health,
        transactionCount: categoryTransactions.length,
        transactionIds: categoryTransactions.map((tx) => tx.id).toList(),
      );
    }).toList();
  }
  
  BudgetHealthStatus _calculateCategoryHealth(
    double spent,
    double allocated,
  ) {
    if (allocated == 0) return BudgetHealthStatus.healthy;
    
    final percentage = (spent / allocated * 100);
    
    if (percentage > 100) return BudgetHealthStatus.overBudget;
    if (percentage >= 90) return BudgetHealthStatus.critical;
    if (percentage >= 75) return BudgetHealthStatus.warning;
    return BudgetHealthStatus.healthy;
  }
  
  BudgetHealthStatus _calculateOverallHealth(
    double totalSpent,
    double totalAllocated,
  ) {
    return _calculateCategoryHealth(totalSpent, totalAllocated);
  }
}

// ============================================

// lib/features/budgets/domain/usecases/update_budget_on_transaction.dart

class UpdateBudgetOnTransaction {
  final BudgetRepository _budgetRepository;
  
  UpdateBudgetOnTransaction(this._budgetRepository);
  
  /// Called when a transaction is added/deleted
  /// Updates the affected budget's spending tracking
  Future<Result<void>> call(TransactionChangeParams params) async {
    // 1. Find budgets affected by this transaction
    final budgets = await _budgetRepository.getActiveBudgets();
    
    if (budgets.isError) return Result.error(budgets.failureOrNull!);
    
    final affectedBudgets = budgets.dataOrNull!
        .where((budget) => _isBudgetAffected(budget, params.transaction))
        .toList();
    
    // 2. Update each affected budget
    for (final budget in affectedBudgets) {
      final updatedBudget = _updateBudgetSpending(
        budget,
        params,
      );
      
      final result = await _budgetRepository.update(updatedBudget);
      
      if (result.isError) {
        return Result.error(result.failureOrNull!);
      }
    }
    
    return Result.success(null);
  }
  
  bool _isBudgetAffected(Budget budget, Transaction transaction) {
    // Check time period
    if (transaction.date.isBefore(budget.startDate) ||
        transaction.date.isAfter(budget.endDate)) {
      return false;
    }
    
    // Check transaction type
    if (transaction.type != TransactionType.expense) return false;
    
    // Check category
    final categoryIds = budget.categories
        .map((c) => c.categoryId)
        .toList();
    if (!categoryIds.contains(transaction.categoryId)) return false;
    
    // Check account scope
    if (!budget.trackAllAccounts && budget.accountIds.isNotEmpty) {
      if (transaction.accountId == null) return false;
      if (!budget.accountIds.contains(transaction.accountId)) return false;
    }
    
    return true;
  }
  
  Budget _updateBudgetSpending(
    Budget budget,
    TransactionChangeParams params,
  ) {
    final categorySpending =
        Map<String, double>.from(budget.categorySpending);
    
    final categoryId = params.transaction.categoryId;
    final amount = params.transaction.amount;
    
    // Update category spending
    switch (params.changeType) {
      case TransactionChangeType.added:
        categorySpending[categoryId] =
            (categorySpending[categoryId] ?? 0) + amount;
        break;
      case TransactionChangeType.deleted:
        categorySpending[categoryId] =
            (categorySpending[categoryId] ?? 0) - amount;
        break;
      case TransactionChangeType.modified:
        final oldAmount = params.oldAmount ?? 0;
        final delta = amount - oldAmount;
        categorySpending[categoryId] =
            (categorySpending[categoryId] ?? 0) + delta;
        break;
    }
    
    // Ensure non-negative
    categorySpending[categoryId] =
        (categorySpending[categoryId] ?? 0).clamp(0, double.infinity);
    
    // Calculate total
    final totalSpent = categorySpending.values
        .fold<double>(0, (sum, x) => sum + x);
    
    // Update category budget record
    final updatedCategories = budget.categories.map((cat) {
      if (cat.categoryId == categoryId) {
        final txIds = List<String>.from(cat.transactionIds);
        
        switch (params.changeType) {
          case TransactionChangeType.added:
            txIds.add(params.transaction.id);
            break;
          case TransactionChangeType.deleted:
            txIds.remove(params.transaction.id);
            break;
          case TransactionChangeType.modified:
            // Keep same transaction ID
            break;
        }
        
        return cat.copyWith(
          spentAmount: categorySpending[categoryId] ?? 0,
          transactionIds: txIds,
        );
      }
      return cat;
    }).toList();
    
    return budget.copyWith(
      categories: updatedCategories,
      categorySpending: categorySpending,
      totalSpent: totalSpent,
      updatedAt: DateTime.now(),
      version: (budget.version ?? 0) + 1,
    );
  }
}

@freezed
class TransactionChangeParams with _$TransactionChangeParams {
  const factory TransactionChangeParams({
    required Transaction transaction,
    required TransactionChangeType changeType,
    double? oldAmount,
    String? oldCategoryId,
  }) = _TransactionChangeParams;
}

enum TransactionChangeType {
  added,
  deleted,
  modified,
}
```

---

## 3. Data Layer Implementation

### 3.1 DTOs and Mappers

```dart
// lib/features/budgets/data/models/budget_dto.dart

@HiveType(typeId: 2)
class BudgetDTO extends HiveObject {
  @HiveField(0, indexed: true)
  String id;
  
  @HiveField(1)
  String name;
  
  @HiveField(2)
  String type; // BudgetType
  
  @HiveField(3)
  String period; // BudgetPeriod
  
  @HiveField(4, indexed: true)
  int startDate;
  
  @HiveField(5, indexed: true)
  int endDate;
  
  @HiveField(6)
  List<CategoryBudgetDTO> categories;
  
  @HiveField(7)
  List<String> accountIds;
  
  @HiveField(8)
  bool trackAllAccounts;
  
  @HiveField(9)
  bool rolloverUnspent;
  
  @HiveField(10)
  bool isActive;
  
  @HiveField(11)
  double carryOverAmount;
  
  @HiveField(12)
  double totalSpent;
  
  @HiveField(13)
  Map<String, double> categorySpending;
  
  @HiveField(14)
  String? description;
  
  @HiveField(15)
  int? createdAt;
  
  @HiveField(16)
  int? updatedAt;
  
  @HiveField(17)
  int? version;
  
  BudgetDTO({
    required this.id,
    required this.name,
    required this.type,
    required this.period,
    required this.startDate,
    required this.endDate,
    required this.categories,
    this.accountIds = const [],
    this.trackAllAccounts = true,
    this.rolloverUnspent = false,
    this.isActive = true,
    this.carryOverAmount = 0,
    this.totalSpent = 0,
    this.categorySpending = const {},
    this.description,
    this.createdAt,
    this.updatedAt,
    this.version,
  });
}

@HiveType(typeId: 3)
class CategoryBudgetDTO extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String categoryId;
  
  @HiveField(2)
  String categoryName;
  
  @HiveField(3)
  double allocatedAmount;
  
  @HiveField(4)
  double spentAmount;
  
  @HiveField(5)
  double carryOverAmount;
  
  @HiveField(6)
  List<String> transactionIds;
  
  @HiveField(7)
  double alertThresholdPercentage;
  
  @HiveField(8)
  bool alertThresholdEnabled;
  
  @HiveField(9)
  bool isLocked;
  
  @HiveField(10)
  String? lockReason;
  
  CategoryBudgetDTO({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.allocatedAmount,
    this.spentAmount = 0,
    this.carryOverAmount = 0,
    this.transactionIds = const [],
    this.alertThresholdPercentage = 80,
    this.alertThresholdEnabled = true,
    this.isLocked = false,
    this.lockReason,
  });
}

// Mappers
class BudgetMapper {
  static Budget toDomain(BudgetDTO dto) {
    return Budget(
      id: dto.id,
      name: dto.name,
      type: _parseType(dto.type),
      period: _parsePeriod(dto.period),
      startDate: DateTime.fromMillisecondsSinceEpoch(dto.startDate),
      endDate: DateTime.fromMillisecondsSinceEpoch(dto.endDate),
      categories: dto.categories
          .map(CategoryBudgetMapper.toDomain)
          .toList(),
      accountIds: dto.accountIds,
      trackAllAccounts: dto.trackAllAccounts,
      rolloverUnspent: dto.rolloverUnspent,
      isActive: dto.isActive,
      carryOverAmount: dto.carryOverAmount,
      totalSpent: dto.totalSpent,
      categorySpending: dto.categorySpending,
      description: dto.description,
      createdAt: dto.createdAt != null
          ? DateTime.fromMillisecondsSinceEpoch(dto.createdAt!)
          : null,
      updatedAt: dto.updatedAt != null
          ? DateTime.fromMillisecondsSinceEpoch(dto.updatedAt!)
          : null,
      version: dto.version,
    );
  }
  
  static BudgetDTO toDTO(Budget domain) {
    return BudgetDTO(
      id: domain.id,
      name: domain.name,
      type: domain.type.toString(),
      period: domain.period.toString(),
      startDate: domain.startDate.millisecondsSinceEpoch,
      endDate: domain.endDate.millisecondsSinceEpoch,
      categories: domain.categories
          .map(CategoryBudgetMapper.toDTO)
          .toList(),
      accountIds: domain.accountIds,
      trackAllAccounts: domain.trackAllAccounts,
      rolloverUnspent: domain.rolloverUnspent,
      isActive: domain.isActive,
      carryOverAmount: domain.carryOverAmount,
      totalSpent: domain.totalSpent,
      categorySpending: domain.categorySpending,
      description: domain.description,
      createdAt: domain.createdAt?.millisecondsSinceEpoch,
      updatedAt: domain.updatedAt?.millisecondsSinceEpoch,
      version: domain.version,
    );
  }
  
  static BudgetType _parseType(String type) {
    return BudgetType.values
        .firstWhere((t) => t.toString() == type);
  }
  
  static BudgetPeriod _parsePeriod(String period) {
    return BudgetPeriod.values
        .firstWhere((p) => p.toString() == period);
  }
}

class CategoryBudgetMapper {
  static CategoryBudget toDomain(CategoryBudgetDTO dto) {
    return CategoryBudget(
      id: dto.id,
      categoryId: dto.categoryId,
      categoryName: dto.categoryName,
      allocatedAmount: dto.allocatedAmount,
      spentAmount: dto.spentAmount,
      carryOverAmount: dto.carryOverAmount,
      transactionIds: dto.transactionIds,
      alertThreshold: AlertThreshold(
        percentage: dto.alertThresholdPercentage,
        isEnabled: dto.alertThresholdEnabled,
      ),
      isLocked: dto.isLocked,
      lockReason: dto.lockReason,
    );
  }
  
  static CategoryBudgetDTO toDTO(CategoryBudget domain) {
    return CategoryBudgetDTO(
      id: domain.id,
      categoryId: domain.categoryId,
      categoryName: domain.categoryName,
      allocatedAmount: domain.allocatedAmount,
      spentAmount: domain.spentAmount,
      carryOverAmount: domain.carryOverAmount,
      transactionIds: domain.transactionIds,
      alertThresholdPercentage: domain.alertThreshold.percentage,
      alertThresholdEnabled: domain.alertThreshold.isEnabled,
      isLocked: domain.isLocked,
      lockReason: domain.lockReason,
    );
  }
}
```

### 3.2 Data Source Implementation

```dart
// lib/features/budgets/data/datasources/budget_local_datasource.dart

abstract class BudgetLocalDataSource {
  Future<BudgetDTO?> getById(String id);
  Future<List<BudgetDTO>> getAll();
  Future<List<BudgetDTO>> getActiveBudgets();
  Future<List<BudgetDTO>> getByDateRange(DateTime start, DateTime end);
  Future<void> insert(BudgetDTO budget);
  Future<void> update(BudgetDTO budget);
  Future<void> delete(String id);
  Future<void> updateCategorySpending(
    String budgetId,
    String categoryId,
    double spentAmount,
  );
}

// Hive Implementation
class HiveBudgetLocalDataSource implements BudgetLocalDataSource {
  final Box<BudgetDTO> _box;
  
  HiveBudgetLocalDataSource(this._box);
  
  @override
  Future<BudgetDTO?> getById(String id) async {
    try {
      return _box.get(id);
    } catch (e) {
      throw CacheException('Failed to get budget: $e');
    }
  }
  
  @override
  Future<List<BudgetDTO>> getAll() async {
    try {
      return _box.values.toList();
    } catch (e) {
      throw CacheException('Failed to fetch budgets: $e');
    }
  }
  
  @override
  Future<List<BudgetDTO>> getActiveBudgets() async {
    try {
      return _box.values.where((budget) => budget.isActive).toList();
    } catch (e) {
      throw CacheException('Failed to fetch active budgets: $e');
    }
  }
  
  @override
  Future<List<BudgetDTO>> getByDateRange(DateTime start, DateTime end) async {
    try {
      final startMs = start.millisecondsSinceEpoch;
      final endMs = end.millisecondsSinceEpoch;
      
      return _box.values
          .where((budget) =>
              budget.startDate >= startMs &&
              budget.endDate <= endMs)
          .toList();
    } catch (e) {
      throw CacheException('Failed to fetch budgets by date range: $e');
    }
  }
  
  @override
  Future<void> insert(BudgetDTO budget) async {
    try {
      await _box.put(budget.id, budget);
    } catch (e) {
      throw CacheException('Failed to create budget: $e');
    }
  }
  
  @override
  Future<void> update(BudgetDTO budget) async {
    try {
      await _box.put(budget.id, budget);
    } catch (e) {
      throw CacheException('Failed to update budget: $e');
    }
  }
  
  @override
  Future<void> delete(String id) async {
    try {
      await _box.delete(id);
    } catch (e) {
      throw CacheException('Failed to delete budget: $e');
    }
  }
  
  @override
  Future<void> updateCategorySpending(
    String budgetId,
    String categoryId,
    double spentAmount,
  ) async {
    try {
      final budget = _box.get(budgetId);
      if (budget == null) throw CacheException('Budget not found');
      
      // Update category spending
      budget.categorySpending[categoryId] = spentAmount;
      
      // Update total spent
      budget.totalSpent =
          budget.categorySpending.values.fold(0, (a, b) => a + b);
      
      // Update category record
      final categoryIndex = budget.categories
          .indexWhere((cat) => cat.categoryId == categoryId);
      
      if (categoryIndex != -1) {
        budget.categories[categoryIndex].spentAmount = spentAmount;
      }
      
      budget.updatedAt = DateTime.now().millisecondsSinceEpoch;
      
      await _box.put(budgetId, budget);
    } catch (e) {
      throw CacheException('Failed to update category spending: $e');
    }
  }
}
```

### 3.3 Repository Implementation

```dart
// lib/features/budgets/data/repositories/budget_repository_impl.dart

class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetLocalDataSource _localDataSource;
  final BudgetRemoteDataSource? _remoteDataSource;
  final NetworkInfo _networkInfo;
  
  BudgetRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._networkInfo,
  );
  
  @override
  Future<Result<Budget>> create(Budget budget) async {
    try {
      final dto = BudgetMapper.toDTO(budget);
      await _localDataSource.insert(dto);
      
      // Attempt remote sync if connected
      if (_remoteDataSource != null && await _networkInfo.isConnected) {
        try {
          await _remoteDataSource!.create(dto);
        } catch (e) {
          // Continue without sync, will retry later
          print('Remote sync failed: $e');
        }
      }
      
      return Result.success(budget);
    } on CacheException catch (e) {
      return Result.error(Failure.cache(e.message));
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<Budget>> getById(String budgetId) async {
    try {
      final dto = await _localDataSource.getById(budgetId);
      
      if (dto == null) {
        return Result.error(
          Failure.unknown('Budget not found'),
        );
      }
      
      return Result.success(BudgetMapper.toDomain(dto));
    } on CacheException catch (e) {
      return Result.error(Failure.cache(e.message));
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<List<Budget>>> getAll() async {
    try {
      final dtos = await _localDataSource.getAll();
      final budgets = dtos.map(BudgetMapper.toDomain).toList();
      return Result.success(budgets);
    } on CacheException catch (e) {
      return Result.error(Failure.cache(e.message));
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<List<Budget>>> getActiveBudgets() async {
    try {
      final dtos = await _localDataSource.getActiveBudgets();
      final budgets = dtos.map(BudgetMapper.toDomain).toList();
      return Result.success(budgets);
    } on CacheException catch (e) {
      return Result.error(Failure.cache(e.message));
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<Budget>> update(Budget budget) async {
    try {
      final dto = BudgetMapper.toDTO(budget);
      await _localDataSource.update(dto);
      
      // Attempt remote sync
      if (_remoteDataSource != null && await _networkInfo.isConnected) {
        try {
          await _remoteDataSource!.update(dto);
        } catch (e) {
          print('Remote sync failed: $e');
        }
      }
      
      return Result.success(budget);
    } on CacheException catch (e) {
      return Result.error(Failure.cache(e.message));
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<void>> delete(String budgetId) async {
    try {
      await _localDataSource.delete(budgetId);
      
      if (_remoteDataSource != null && await _networkInfo.isConnected) {
        try {
          await _remoteDataSource!.delete(budgetId);
        } catch (e) {
          print('Remote sync failed: $e');
        }
      }
      
      return Result.success(null);
    } on CacheException catch (e) {
      return Result.error(Failure.cache(e.message));
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<List<Budget>>> getByDateRange(DateTime start, DateTime end) async {
    try {
      final dtos = await _localDataSource.getByDateRange(start, end);
      final budgets = dtos.map(BudgetMapper.toDomain).toList();
      return Result.success(budgets);
    } on CacheException catch (e) {
      return Result.error(Failure.cache(e.message));
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<Budget?>> getCurrentBudget() async {
    try {
      final now = DateTime.now();
      final dtos = await _localDataSource.getByDateRange(
        DateTime(now.year, now.month, 1),
        DateTime(now.year, now.month + 1, 0),
      );
      
      final active = dtos
          .where((dto) => dto.isActive)
          .firstOrNull;
      
      if (active == null) return Result.success(null);
      
      return Result.success(BudgetMapper.toDomain(active));
    } on CacheException catch (e) {
      return Result.error(Failure.cache(e.message));
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<Budget>> getBudgetForCategory(String categoryId) async {
    try {
      final dtos = await _localDataSource.getActiveBudgets();
      
      final budgetDto = dtos.firstWhereOrNull((budget) =>
          budget.categories.any((cat) => cat.categoryId == categoryId));
      
      if (budgetDto == null) {
        return Result.error(Failure.unknown('Budget not found for category'));
      }
      
      return Result.success(BudgetMapper.toDomain(budgetDto));
    } on CacheException catch (e) {
      return Result.error(Failure.cache(e.message));
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<BudgetStatus>> calculateBudgetStatus(String budgetId) async {
    try {
      final budgetResult = await getById(budgetId);
      
      if (budgetResult.isError) {
        return Result.error(budgetResult.failureOrNull!);
      }
      
      final budget = budgetResult.dataOrNull!;
      
      // Use injected use case
      final calculateStatus = getIt<CalculateBudgetStatus>();
      return await calculateStatus(budget);
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<double>> calculateCategorySpending(
    String budgetId,
    String categoryId,
  ) async {
    try {
      final budgetResult = await getById(budgetId);
      
      if (budgetResult.isError) {
        return Result.error(budgetResult.failureOrNull!);
      }
      
      final budget = budgetResult.dataOrNull!;
      final spent = budget.categorySpending[categoryId] ?? 0;
      
      return Result.success(spent);
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<void>> updateCategorySpending(
    String budgetId,
    String categoryId,
    double amount,
  ) async {
    try {
      await _localDataSource.updateCategorySpending(
        budgetId,
        categoryId,
        amount,
      );
      
      return Result.success(null);
    } on CacheException catch (e) {
      return Result.error(Failure.cache(e.message));
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  @override
  Future<Result<List<BudgetTemplate>>> getTemplates() async {
    // Return predefined templates
    return Result.success([
      BudgetTemplate(
        id: 'zero-based',
        name: 'Zero-Based Budget',
        type: BudgetType.zeroBased,
        categories: [
          TemplateCategory(
            categoryId: 'housing',
            categoryName: 'Housing',
            percentageOfIncome: 30,
          ),
          TemplateCategory(
            categoryId: 'food',
            categoryName: 'Food',
            percentageOfIncome: 12,
          ),
          TemplateCategory(
            categoryId: 'savings',
            categoryName: 'Savings',
            percentageOfIncome: 20,
          ),
        ],
      ),
      BudgetTemplate(
        id: '50-30-20',
        name: '50/30/20 Budget',
        type: BudgetType.fiftyThirtyTwenty,
        categories: [
          TemplateCategory(
            categoryId: 'needs',
            categoryName: 'Needs',
            percentageOfIncome: 50,
          ),
          TemplateCategory(
            categoryId: 'wants',
            categoryName: 'Wants',
            percentageOfIncome: 30,
          ),
          TemplateCategory(
            categoryId: 'savings',
            categoryName: 'Savings',
            percentageOfIncome: 20,
          ),
        ],
      ),
    ]);
  }
  
  @override
  Future<Result<Budget>> createFromTemplate(
    String templateId,
    DateTime startDate,
  ) async {
    try {
      final templates = await getTemplates();
      
      if (templates.isError) {
        return Result.error(templates.failureOrNull!);
      }
      
      final template = templates.dataOrNull!
          .firstWhereOrNull((t) => t.id == templateId);
      
      if (template == null) {
        return Result.error(
          Failure.unknown('Template not found'),
        );
      }
      
      // Create budget from template
      final endDate = _calculateEndDate(startDate, BudgetPeriod.monthly);
      
      final budget = Budget(
        id: const Uuid().v4(),
        name: template.name,
        type: template.type,
        period: BudgetPeriod.monthly,
        startDate: startDate,
        endDate: endDate,
        categories: template.categories.map((cat) {
          return CategoryBudget(
            id: const Uuid().v4(),
            categoryId: cat.categoryId,
            categoryName: cat.categoryName,
            allocatedAmount: 0, // Will be filled by user
          );
        }).toList(),
        isActive: true,
        createdAt: DateTime.now(),
      );
      
      return await create(budget);
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  DateTime _calculateEndDate(DateTime start, BudgetPeriod period) {
    switch (period) {
      case BudgetPeriod.weekly:
        return start.add(Duration(days: 7));
      case BudgetPeriod.biWeekly:
        return start.add(Duration(days: 14));
      case BudgetPeriod.monthly:
        return DateTime(start.year, start.month + 1, start.day)
            .subtract(Duration(days: 1));
      case BudgetPeriod.quarterly:
        return DateTime(start.year, start.month + 3, start.day)
            .subtract(Duration(days: 1));
      case BudgetPeriod.yearly:
        return DateTime(start.year + 1, start.month, start.day)
            .subtract(Duration(days: 1));
      case BudgetPeriod.custom:
        return start.add(Duration(days: 30));
    }
  }
}
```

---

## 4. Presentation Layer - State Management

### 4.1 Budget State Management with Riverpod

```dart
// lib/features/budgets/presentation/providers/budget_providers.dart

// State definition
@freezed
class BudgetUIState with _$BudgetUIState {
  const factory BudgetUIState.initial() = _Initial;
  const factory BudgetUIState.loading() = _Loading;
  const factory BudgetUIState.loaded(List<Budget> budgets) = _Loaded;
  const factory BudgetUIState.budgetDetail(Budget budget, BudgetStatus status) = _BudgetDetail;
  const factory BudgetUIState.error(String message) = _Error;
}

// State notifier
@riverpod
class BudgetNotifier extends _$BudgetNotifier {
  @override
  Future<BudgetUIState> build() async {
    return const BudgetUIState.initial();
  }
  
  Future<void> loadBudgets() async {
    state = const AsyncValue.loading();
    
    final useCase = ref.read(getAllBudgetsProvider);
    final result = await useCase();
    
    result.when(
      success: (budgets) {
        state = AsyncValue.data(BudgetUIState.loaded(budgets));
      },
      error: (failure) {
        final message = _mapFailureToMessage(failure);
        state = AsyncValue.data(BudgetUIState.error(message));
      },
    );
  }
  
  Future<void> loadBudgetDetail(String budgetId) async {
    state = const AsyncValue.loading();
    
    try {
      final budgetResult = ref.read(getBudgetByIdProvider(budgetId));
      final statusResult = ref.read(calculateBudgetStatusProvider(budgetId));
      
      final budget = await budgetResult.future;
      final status = await statusResult.future;
      
      state = AsyncValue.data(
        BudgetUIState.budgetDetail(budget, status),
      );
    } catch (e) {
      state = AsyncValue.data(
        BudgetUIState.error('Failed to load budget details'),
      );
    }
  }
  
  Future<void> createBudget(CreateBudgetParams params) async {
    final useCase = ref.read(createBudgetProvider);
    final result = await useCase(params);
    
    result.when(
      success: (_) {
        // Refresh budgets list
        ref.invalidateSelf();
        SmartDialog.showToast('Budget created successfully');
      },
      error: (failure) {
        final message = _mapFailureToMessage(failure);
        SmartDialog.showToast(message);
      },
    );
  }
  
  Future<void> updateBudget(Budget budget) async {
    final useCase = ref.read(updateBudgetProvider);
    final result = await useCase(budget);
    
    result.when(
      success: (_) {
        ref.invalidateSelf();
        SmartDialog.showToast('Budget updated successfully');
      },
      error: (failure) {
        final message = _mapFailureToMessage(failure);
        SmartDialog.showToast(message);
      },
    );
  }
  
  Future<void> deleteBudget(String budgetId) async {
    final useCase = ref.read(deleteBudgetProvider);
    final result = await useCase(budgetId);
    
    result.when(
      success: (_) {
        ref.invalidateSelf();
        SmartDialog.showToast('Budget deleted successfully');
      },
      error: (failure) {
        final message = _mapFailureToMessage(failure);
        SmartDialog.showToast(message);
      },
    );
  }
  
  String _mapFailureToMessage(Failure failure) {
    return failure.when(
      network: (msg) => 'Network error: $msg',
      server: (msg, _) => 'Server error: $msg',
      cache: (msg) => 'Storage error: $msg',
      validation: (msg, _) => 'Validation error: $msg',
      unknown: (msg) => 'An error occurred: $msg',
    );
  }
}

// Providers
@riverpod
BudgetRepository budgetRepository(BudgetRepositoryRef ref) {
  final localDataSource = ref.watch(budgetLocalDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  
  return BudgetRepositoryImpl(
    localDataSource,
    null, // No remote in this version
    networkInfo,
  );
}

@riverpod
Future<List<Budget>> getAllBudgets(GetAllBudgetsRef ref) async {
  final repository = ref.watch(budgetRepositoryProvider);
  final result = await repository.getAll();
  
  return result.when(
    success: (budgets) => budgets,
    error: (failure) => throw failure,
  );
}

@riverpod
Future<Budget> getBudgetById(GetBudgetByIdRef ref, String budgetId) async {
  final repository = ref.watch(budgetRepositoryProvider);
  final result = await repository.getById(budgetId);
  
  return result.when(
    success: (budget) => budget,
    error: (failure) => throw failure,
  );
}

@riverpod
Future<BudgetStatus> calculateBudgetStatus(
  CalculateBudgetStatusRef ref,
  String budgetId,
) async {
  final repository = ref.watch(budgetRepositoryProvider);
  final result = await repository.calculateBudgetStatus(budgetId);
  
  return result.when(
    success: (status) => status,
    error: (failure) => throw failure,
  );
}

// Use case providers
@riverpod
CreateBudget createBudget(CreateBudgetRef ref) {
  final repository = ref.watch(budgetRepositoryProvider);
  final transactionRepository = ref.watch(transactionRepositoryProvider);
  
  return CreateBudget(repository, transactionRepository);
}

@riverpod
CalculateBudgetStatus calculateBudgetStatusUseCase(
  CalculateBudgetStatusUseCaseRef ref,
) {
  final transactionRepository = ref.watch(transactionRepositoryProvider);
  return CalculateBudgetStatus(transactionRepository);
}

@riverpod
UpdateBudgetOnTransaction updateBudgetOnTransaction(
  UpdateBudgetOnTransactionRef ref,
) {
  final repository = ref.watch(budgetRepositoryProvider);
  return UpdateBudgetOnTransaction(repository);
}
```

### 4.2 Integration with Transaction Changes

```dart
// lib/features/transactions/presentation/providers/transaction_providers.dart

@riverpod
class TransactionNotifier extends _$TransactionNotifier {
  @override
  Future<List<Transaction>> build() async {
    return const [];
  }
  
  Future<void> addTransaction(Transaction transaction) async {
    final useCase = ref.read(addTransactionProvider);
    final result = await useCase(transaction);
    
    result.when(
      success: (tx) async {
        // Update budgets affected by this transaction
        await _updateAffectedBudgets(
          tx,
          TransactionChangeType.added,
        );
        
        // Refresh transaction list
        ref.invalidateSelf();
        
        // Trigger UI notifications
        SmartDialog.showToast('Transaction added!');
      },
      error: (failure) {
        SmartDialog.showToast('Failed to add transaction');
      },
    );
  }
  
  Future<void> deleteTransaction(String transactionId) async {
    final useCase = ref.read(deleteTransactionProvider);
    
    // Get transaction before deletion for budget updates
    final txResult = await ref.read(getTransactionByIdProvider(transactionId).future);
    
    final result = await useCase(transactionId);
    
    result.when(
      success: (_) async {
        if (txResult != null) {
          // Reverse budget updates
          await _updateAffectedBudgets(
            txResult,
            TransactionChangeType.deleted,
          );
        }
        
        ref.invalidateSelf();
        SmartDialog.showToast('Transaction deleted');
      },
      error: (failure) {
        SmartDialog.showToast('Failed to delete transaction');
      },
    );
  }
  
  Future<void> _updateAffectedBudgets(
    Transaction transaction,
    TransactionChangeType changeType,
  ) async {
    try {
      final useCase = ref.read(updateBudgetOnTransaction);
      
      await useCase(
        TransactionChangeParams(
          transaction: transaction,
          changeType: changeType,
        ),
      );
      
      // Refresh budget data
      ref.invalidate(getAllBudgets);
      ref.invalidate(calculateBudgetStatusUseCase);
    } catch (e) {
      print('Failed to update budgets: $e');
    }
  }
}
```

---

## 5. Presentation Layer - UI Components

### 5.1 Budget Dashboard Screen

```dart
// lib/features/budgets/presentation/screens/budget_screen.dart

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetState = ref.watch(budgetNotifierProvider);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Budgets',
          style: AppTypography.headlineLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_rounded),
            onPressed: () => _showCreateBudgetSheet(context, ref),
          ),
        ],
      ),
      body: budgetState.when(
        initial: () => _buildInitialState(context, ref),
        loading: () => _buildLoadingState(),
        loaded: (budgets) => _buildLoadedState(context, ref, budgets),
        budgetDetail: (budget, status) =>
            _buildDetailState(context, ref, budget, status),
        error: (message) => _buildErrorState(context, ref, message),
      ),
    );
  }
  
  Widget _buildInitialState(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ref.read(budgetNotifierProvider.notifier).loadBudgets();
        },
        child: Text('Load Budgets'),
      ),
    );
  }
  
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Gap(AppSpacing.md),
          Text('Loading budgets...'),
        ],
      ),
    );
  }
  
  Widget _buildLoadedState(
    BuildContext context,
    WidgetRef ref,
    List<Budget> budgets,
  ) {
    if (budgets.isEmpty) {
      return _buildEmptyState(context, ref);
    }
    
    // Separate active and inactive
    final activeBudgets = budgets.where((b) => b.isActive).toList();
    final inactiveBudgets = budgets.where((b) => !b.isActive).toList();
    
    return CustomScrollView(
      slivers: [
        // Summary card
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: _BudgetSummaryCard(budgets: activeBudgets),
          ),
        ),
        
        // Active budgets
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              'Active Budgets',
              style: AppTypography.headlineMedium,
            ),
          ),
        ),
        
        SliverPadding(
          padding: EdgeInsets.all(AppSpacing.lg),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final budget = activeBudgets[index];
                return _BudgetListItem(
                  budget: budget,
                  onTap: () => _showBudgetDetail(context, ref, budget),
                  onEdit: () => _showEditBudgetSheet(context, ref, budget),
                  onDelete: () => _showDeleteConfirmation(context, ref, budget),
                );
              },
              childCount: activeBudgets.length,
            ),
          ),
        ),
        
        // Inactive budgets (if any)
        if (inactiveBudgets.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                'Past Budgets',
                style: AppTypography.headlineMedium,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(AppSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final budget = inactiveBudgets[index];
                  return _BudgetListItem(
                    budget: budget,
                    isPast: true,
                    onTap: () => _showBudgetDetail(context, ref, budget),