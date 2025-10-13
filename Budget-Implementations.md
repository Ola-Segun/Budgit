# Comprehensive Analysis: Budgeting Features, Logic & Implementation in Flutter Budget App

## 1. Core Budgeting Concepts & Architecture

### Budgeting Philosophy

```
┌─────────────────────────────────────────────────────────────────┐
│                    BUDGETING SYSTEM LAYERS                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  Layer 1: BUDGET DEFINITION                                      │
│  ┌────────────────────────────────────────────────────┐         │
│  │ - What to track (categories)                       │         │
│  │ - How much to allocate (amounts)                   │         │
│  │ - When to track (time period)                      │         │
│  │ - Where to track from (accounts)                   │         │
│  └────────────────────────────────────────────────────┘         │
│                          ▼                                        │
│  Layer 2: BUDGET TRACKING                                        │
│  ┌────────────────────────────────────────────────────┐         │
│  │ - Capture transactions                             │         │
│  │ - Calculate spending                               │         │
│  │ - Compare against limits                           │         │
│  │ - Track over time                                  │         │
│  └────────────────────────────────────────────────────┘         │
│                          ▼                                        │
│  Layer 3: BUDGET INSIGHTS                                        │
│  ┌────────────────────────────────────────────────────┐         │
│  │ - Spending patterns                                │         │
│  │ - Trend analysis                                   │         │
│  │ - Predictions                                      │         │
│  │ - Recommendations                                  │         │
│  └────────────────────────────────────────────────────┘         │
│                          ▼                                        │
│  Layer 4: BUDGET ACTIONS                                         │
│  ┌────────────────────────────────────────────────────┐         │
│  │ - Alerts & notifications                           │         │
│  │ - Adjustments                                      │         │
│  │ - Optimization                                     │         │
│  │ - Period rollover                                  │         │
│  └────────────────────────────────────────────────────┘         │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## 2. Budget Types & Templates

### A. Zero-Based Budget

```dart
// lib/features/budgets/domain/entities/budget_templates.dart

class ZeroBasedBudget {
  /// Every dollar has a purpose - Income must equal Total Budget
  static Budget create({
    required double monthlyIncome,
    required DateTime startDate,
  }) {
    return Budget(
      id: const Uuid().v4(),
      name: 'Zero-Based Budget',
      type: BudgetType.zeroBased,
      period: BudgetPeriod.monthly,
      startDate: startDate,
      endDate: DateTime(startDate.year, startDate.month + 1, startDate.day)
          .subtract(Duration(days: 1)),
      trackAllAccounts: true,
      categories: [
        // FIXED EXPENSES (50-60% of income)
        CategoryBudget(
          id: 'housing',
          categoryId: 'housing',
          amount: monthlyIncome * 0.30, // 30% to housing
          alertThreshold: AlertThreshold(percentage: 90, isEnabled: true),
        ),
        CategoryBudget(
          id: 'utilities',
          categoryId: 'utilities',
          amount: monthlyIncome * 0.10, // 10% to utilities
          alertThreshold: AlertThreshold(percentage: 85, isEnabled: true),
        ),
        CategoryBudget(
          id: 'transportation',
          categoryId: 'transportation',
          amount: monthlyIncome * 0.15, // 15% to transportation
          alertThreshold: AlertThreshold(percentage: 90, isEnabled: true),
        ),
        
        // VARIABLE EXPENSES (20-30% of income)
        CategoryBudget(
          id: 'food',
          categoryId: 'food',
          amount: monthlyIncome * 0.12, // 12% to food
          alertThreshold: AlertThreshold(percentage: 80, isEnabled: true),
        ),
        CategoryBudget(
          id: 'entertainment',
          categoryId: 'entertainment',
          amount: monthlyIncome * 0.05, // 5% to entertainment
          alertThreshold: AlertThreshold(percentage: 75, isEnabled: true),
        ),
        CategoryBudget(
          id: 'shopping',
          categoryId: 'shopping',
          amount: monthlyIncome * 0.08, // 8% to shopping
          alertThreshold: AlertThreshold(percentage: 80, isEnabled: true),
        ),
        
        // SAVINGS & DEBT (20% of income)
        CategoryBudget(
          id: 'savings',
          categoryId: 'savings',
          amount: monthlyIncome * 0.15, // 15% to savings
          alertThreshold: AlertThreshold(percentage: 100, isEnabled: false),
        ),
        CategoryBudget(
          id: 'debt',
          categoryId: 'debt',
          amount: monthlyIncome * 0.05, // 5% to debt payment
          alertThreshold: AlertThreshold(percentage: 90, isEnabled: true),
        ),
      ],
    );
  }
}
```

### B. 50/30/20 Budget

```dart
class FiftyThirtyTwentyBudget {
  /// 50% Needs, 30% Wants, 20% Savings
  static Budget create({
    required double monthlyIncome,
    required DateTime startDate,
  }) {
    return Budget(
      id: const Uuid().v4(),
      name: '50/30/20 Budget',
      type: BudgetType.fiftyThirtyTwenty,
      period: BudgetPeriod.monthly,
      startDate: startDate,
      endDate: DateTime(startDate.year, startDate.month + 1, startDate.day)
          .subtract(Duration(days: 1)),
      trackAllAccounts: true,
      categories: [
        // NEEDS (50%)
        CategoryBudget(
          id: 'needs',
          categoryId: 'needs',
          amount: monthlyIncome * 0.50,
          alertThreshold: AlertThreshold(percentage: 90, isEnabled: true),
        ),
        
        // WANTS (30%)
        CategoryBudget(
          id: 'wants',
          categoryId: 'wants',
          amount: monthlyIncome * 0.30,
          alertThreshold: AlertThreshold(percentage: 85, isEnabled: true),
        ),
        
        // SAVINGS & DEBT (20%)
        CategoryBudget(
          id: 'savings_debt',
          categoryId: 'savings',
          amount: monthlyIncome * 0.20,
          alertThreshold: AlertThreshold(percentage: 100, isEnabled: false),
        ),
      ],
    );
  }
}
```

### C. Envelope Budget

```dart
class EnvelopeBudget {
  /// Traditional envelope system - cash allocated to specific purposes
  static Budget create({
    required Map<String, double> envelopes,
    required DateTime startDate,
  }) {
    return Budget(
      id: const Uuid().v4(),
      name: 'Envelope Budget',
      type: BudgetType.envelope,
      period: BudgetPeriod.monthly,
      startDate: startDate,
      endDate: DateTime(startDate.year, startDate.month + 1, startDate.day)
          .subtract(Duration(days: 1)),
      trackAllAccounts: false, // Usually tracks specific cash account
      accountIds: ['cash_account_id'],
      rolloverUnspent: true, // Key feature of envelope method
      categories: envelopes.entries.map((entry) {
        return CategoryBudget(
          id: entry.key,
          categoryId: entry.key,
          amount: entry.value,
          alertThreshold: AlertThreshold(percentage: 90, isEnabled: true),
        );
      }).toList(),
    );
  }
}
```

### D. Custom Budget

```dart
class CustomBudget {
  /// User-defined allocations
  static Budget create({
    required String name,
    required List<CategoryBudgetInput> categories,
    required DateTime startDate,
    required BudgetPeriod period,
    List<String>? accountIds,
    bool trackAllAccounts = true,
  }) {
    final endDate = _calculateEndDate(startDate, period);
    
    return Budget(
      id: const Uuid().v4(),
      name: name,
      type: BudgetType.custom,
      period: period,
      startDate: startDate,
      endDate: endDate,
      trackAllAccounts: trackAllAccounts,
      accountIds: accountIds,
      categories: categories.map((input) {
        return CategoryBudget(
          id: input.categoryId,
          categoryId: input.categoryId,
          amount: input.amount,
          alertThreshold: input.alertThreshold ??
              AlertThreshold(percentage: 85, isEnabled: true),
        );
      }).toList(),
    );
  }
  
  static DateTime _calculateEndDate(DateTime start, BudgetPeriod period) {
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
        return start.add(Duration(days: 30)); // Default to monthly
    }
  }
}

@freezed
class CategoryBudgetInput with _$CategoryBudgetInput {
  const factory CategoryBudgetInput({
    required String categoryId,
    required double amount,
    AlertThreshold? alertThreshold,
  }) = _CategoryBudgetInput;
}
```

---

## 3. Budget Creation & Management Use Cases

### A. Create Budget Use Case

```dart
// lib/features/budgets/domain/usecases/create_budget.dart

class CreateBudget {
  final BudgetRepository _budgetRepository;
  final TransactionRepository _transactionRepository;
  
  CreateBudget(this._budgetRepository, this._transactionRepository);
  
  Future<Result<Budget>> call(Budget budget) async {
    // 1. Validation
    final validation = _validate(budget);
    if (validation.isError) return validation;
    
    // 2. Check for overlapping budgets
    final overlap = await _checkOverlappingBudgets(budget);
    if (overlap != null) {
      return Result.error(
        Failure.validation(
          'Budget period overlaps with existing budget: ${overlap.name}',
          {},
        ),
      );
    }
    
    // 3. Initialize category spending from existing transactions
    final initializedBudget = await _initializeSpending(budget);
    
    // 4. Save budget
    final result = await _budgetRepository.add(initializedBudget);
    
    return result;
  }
  
  Result<Budget> _validate(Budget budget) {
    // Validate date range
    if (budget.endDate.isBefore(budget.startDate)) {
      return Result.error(
        Failure.validation('End date must be after start date', {}),
      );
    }
    
    // Validate categories exist
    if (budget.categories.isEmpty) {
      return Result.error(
        Failure.validation('Budget must have at least one category', {}),
      );
    }
    
    // Validate amounts are positive
    for (final category in budget.categories) {
      if (category.amount < 0) {
        return Result.error(
          Failure.validation('Category amounts must be positive', {}),
        );
      }
    }
    
    // Validate account IDs if specified
    if (!budget.trackAllAccounts) {
      if (budget.accountIds == null || budget.accountIds!.isEmpty) {
        return Result.error(
          Failure.validation(
            'Must specify accounts or enable track all accounts',
            {},
          ),
        );
      }
    }
    
    return Result.success(budget);
  }
  
  Future<Budget?> _checkOverlappingBudgets(Budget newBudget) async {
    final existingResult = await _budgetRepository.getActiveBudgets();
    
    if (existingResult.isError) return null;
    
    final existingBudgets = existingResult.dataOrNull!;
    
    for (final existing in existingBudgets) {
      if (_periodsOverlap(existing, newBudget)) {
        return existing;
      }
    }
    
    return null;
  }
  
  bool _periodsOverlap(Budget budget1, Budget budget2) {
    // Check if date ranges overlap
    return budget1.startDate.isBefore(budget2.endDate) &&
           budget1.endDate.isAfter(budget2.startDate);
  }
  
  Future<Budget> _initializeSpending(Budget budget) async {
    // Get existing transactions in budget period
    final transactionsResult = await _transactionRepository.getByDateRange(
      budget.startDate,
      budget.endDate,
    );
    
    if (transactionsResult.isError) return budget;
    
    final transactions = transactionsResult.dataOrNull!;
    
    // Calculate initial spending by category
    final categorySpending = <String, double>{};
    
    for (final transaction in transactions) {
      if (transaction.type != TransactionType.expense) continue;
      
      // Check if transaction is in budget scope
      if (!_isTransactionInBudgetScope(transaction, budget)) continue;
      
      categorySpending[transaction.categoryId] = 
          (categorySpending[transaction.categoryId] ?? 0) + transaction.amount;
    }
    
    // Update category budgets with initial spending
    final updatedCategories = budget.categories.map((categoryBudget) {
      final spent = categorySpending[categoryBudget.categoryId] ?? 0;
      return categoryBudget.copyWith(spent: spent);
    }).toList();
    
    return budget.copyWith(categories: updatedCategories);
  }
  
  bool _isTransactionInBudgetScope(Transaction transaction, Budget budget) {
    // Check account filter
    if (!budget.trackAllAccounts) {
      if (budget.accountIds == null || budget.accountIds!.isEmpty) {
        return false;
      }
      
      if (transaction.accountId == null) return false;
      if (!budget.accountIds!.contains(transaction.accountId)) return false;
    }
    
    // Check if category is in budget
    final categoryIds = budget.categories.map((c) => c.categoryId).toList();
    if (!categoryIds.contains(transaction.categoryId)) return false;
    
    return true;
  }
}
```

### B. Update Budget Use Case

```dart
// lib/features/budgets/domain/usecases/update_budget.dart

class UpdateBudget {
  final BudgetRepository _budgetRepository;
  
  UpdateBudget(this._budgetRepository);
  
  Future<Result<Budget>> call(Budget budget) async {
    // 1. Get current budget
    final currentResult = await _budgetRepository.getById(budget.id);
    
    if (currentResult.isError) {
      return Result.error(currentResult.failureOrNull!);
    }
    
    final currentBudget = currentResult.dataOrNull!;
    
    // 2. Validate changes
    final validation = _validateUpdate(currentBudget, budget);
    if (validation.isError) return validation;
    
    // 3. Handle category changes
    final updatedBudget = _handleCategoryChanges(currentBudget, budget);
    
    // 4. Update budget
    return await _budgetRepository.update(updatedBudget);
  }
  
  Result<Budget> _validateUpdate(Budget current, Budget updated) {
    // Can't change date range if budget is active and has spending
    if (current.isActive && current.totalSpent > 0) {
      if (current.startDate != updated.startDate ||
          current.endDate != updated.endDate) {
        return Result.error(
          Failure.validation(
            'Cannot change date range of active budget with spending',
            {},
          ),
        );
      }
    }
    
    return Result.success(updated);
  }
  
  Budget _handleCategoryChanges(Budget current, Budget updated) {
    // Preserve spending data when updating category amounts
    final updatedCategories = updated.categories.map((newCategory) {
      // Find matching category in current budget
      final currentCategory = current.categories.firstWhereOrNull(
        (c) => c.categoryId == newCategory.categoryId,
      );
      
      if (currentCategory != null) {
        // Preserve spent amount
        return newCategory.copyWith(
          spent: currentCategory.spent,
          rolledOver: currentCategory.rolledOver,
        );
      }
      
      return newCategory;
    }).toList();
    
    return updated.copyWith(
      categories: updatedCategories,
      updatedAt: DateTime.now(),
    );
  }
}
```

### C. Budget Rollover Use Case

```dart
// lib/features/budgets/domain/usecases/rollover_budget.dart

class RolloverBudget {
  final BudgetRepository _budgetRepository;
  
  RolloverBudget(this._budgetRepository);
  
  Future<Result<Budget>> call(String budgetId) async {
    // 1. Get current budget
    final currentResult = await _budgetRepository.getById(budgetId);
    
    if (currentResult.isError) {
      return Result.error(currentResult.failureOrNull!);
    }
    
    final currentBudget = currentResult.dataOrNull!;
    
    // 2. Validate budget can be rolled over
    if (currentBudget.isInPeriod) {
      return Result.error(
        Failure.validation('Cannot rollover active budget', {}),
      );
    }
    
    // 3. Calculate new dates
    final duration = currentBudget.endDate.difference(currentBudget.startDate);
    final newStartDate = currentBudget.endDate.add(Duration(days: 1));
    final newEndDate = newStartDate.add(duration);
    
    // 4. Handle unspent amounts
    final newCategories = currentBudget.categories.map((category) {
      if (currentBudget.rolloverUnspent) {
        final unspent = category.remaining;
        return category.copyWith(
          spent: 0, // Reset spending
          rolledOver: unspent > 0 ? unspent : 0,
          amount: category.amount + (unspent > 0 ? unspent : 0),
        );
      } else {
        return category.copyWith(
          spent: 0, // Reset spending
          rolledOver: 0,
        );
      }
    }).toList();
    
    // 5. Create new budget
    final newBudget = currentBudget.copyWith(
      id: const Uuid().v4(),
      name: '${currentBudget.name} (${_getMonthName(newStartDate)})',
      startDate: newStartDate,
      endDate: newEndDate,
      categories: newCategories,
      createdAt: DateTime.now(),
    );
    
    // 6. Deactivate old budget
    final deactivatedBudget = currentBudget.copyWith(
      isActive: false,
      updatedAt: DateTime.now(),
    );
    
    await _budgetRepository.update(deactivatedBudget);
    
    // 7. Save new budget
    return await _budgetRepository.add(newBudget);
  }
  
  String _getMonthName(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[date.month - 1];
  }
}
```

---

## 4. Budget Analysis & Insights

### A. Spending Analysis

```dart
// lib/features/budgets/domain/usecases/analyze_spending_patterns.dart

class AnalyzeSpendingPatterns {
  final TransactionRepository _transactionRepository;
  
  Future<Result<SpendingAnalysis>> call(Budget budget) async {
    final transactionsResult = await _transactionRepository.getByDateRange(
      budget.startDate,
      budget.endDate,
    );
    
    if (transactionsResult.isError) {
      return Result.error(transactionsResult.failureOrNull!);
    }
    
    final allTransactions = transactionsResult.dataOrNull!;
    
    // Filter to budget scope
    final budgetTransactions = allTransactions.where((tx) {
      return tx.type == TransactionType.expense &&
             _isInBudgetScope(tx, budget);
    }).toList();
    
    // Analyze patterns
    final dailySpending = _analyzeDailySpending(budgetTransactions);
    final categoryTrends = _analyzeCategoryTrends(budgetTransactions, budget);
    final weekdayPatterns = _analyzeWeekdayPatterns(budgetTransactions);
    final largestExpenses = _findLargestExpenses(budgetTransactions);
    final unusualSpending = _detectUnusualSpending(budgetTransactions);
    
    return Result.success(
      SpendingAnalysis(
        budget: budget,
        dailySpending: dailySpending,
        categoryTrends: categoryTrends,
        weekdayPatterns: weekdayPatterns,
        largestExpenses: largestExpenses,
        unusualTransactions: unusualSpending,
        insights: _generateInsights(
          budget,
          dailySpending,
          categoryTrends,
        ),
      ),
    );
  }
  
  Map<DateTime, double> _analyzeDailySpending(List<Transaction> transactions) {
    final dailySpending = <DateTime, double>{};
    
    for (final transaction in transactions) {
      final dateKey = DateTime(
        transaction.date.year,
        transaction.date.month,
        transaction.date.day,
      );
      
      dailySpending[dateKey] = 
          (dailySpending[dateKey] ?? 0) + transaction.amount;
    }
    
    return dailySpending;
  }
  
  Map<String, CategoryTrend> _analyzeCategoryTrends(
    List<Transaction> transactions,
    Budget budget,
  ) {
    final trends = <String, CategoryTrend>{};
    
    for (final categoryBudget in budget.categories) {
      final categoryTransactions = transactions.where(
        (tx) => tx.categoryId == categoryBudget.categoryId,
      ).toList();
      
      if (categoryTransactions.isEmpty) {
        trends[categoryBudget.categoryId] = CategoryTrend(
          categoryId: categoryBudget.categoryId,
          transactionCount: 0,
          totalSpent: 0,
          averageTransaction: 0,
          trend: TrendDirection.flat,
        );
        continue;
      }
      
      final totalSpent = categoryTransactions.fold<double>(
        0,
        (sum, tx) => sum + tx.amount,
      );
      
      final averageTransaction = totalSpent / categoryTransactions.length;
      
      // Determine trend by comparing first half vs second half of period
      final midpoint = budget.startDate.add(
        budget.endDate.difference(budget.startDate) ~/ 2,
      );
      
      final firstHalfSpending = categoryTransactions
          .where((tx) => tx.date.isBefore(midpoint))
          .fold<double>(0, (sum, tx) => sum + tx.amount);
      
      final secondHalfSpending = categoryTransactions
          .where((tx) => tx.date.isAfter(midpoint))
          .fold<double>(0, (sum, tx) => sum + tx.amount);
      
      TrendDirection trend;
      if (secondHalfSpending > firstHalfSpending * 1.1) {
        trend = TrendDirection.increasing;
      } else if (secondHalfSpending < firstHalfSpending * 0.9) {
        trend = TrendDirection.decreasing;
      } else {
        trend = TrendDirection.flat;
      }
      
      trends[categoryBudget.categoryId] = CategoryTrend(
        categoryId: categoryBudget.categoryId,
        transactionCount: categoryTransactions.length,
        totalSpent: totalSpent,
        averageTransaction: averageTransaction,
        trend: trend,
      );
    }
    
    return trends;
  }
  
  Map<int, double> _analyzeWeekdayPatterns(List<Transaction> transactions) {
    final weekdaySpending = <int, double>{};
    
    for (final transaction in transactions) {
      final weekday = transaction.date.weekday; // 1=Monday, 7=Sunday
      weekdaySpending[weekday] = 
          (weekdaySpending[weekday] ?? 0) + transaction.amount;
    }
    
    return weekdaySpending;
  }
  
  List<Transaction> _findLargestExpenses(
    List<Transaction> transactions,
  ) {
    final sorted = List<Transaction>.from(transactions)
      ..sort((a, b) => b.amount.compareTo(a.amount));
    
    return sorted.take(5).toList();
  }
  
  List<Transaction> _detectUnusualSpending(List<Transaction> transactions) {
    if (transactions.length < 5) return [];
    
    // Calculate mean and standard deviation
    final amounts = transactions.map((tx) => tx.amount).toList();
    final mean = amounts.reduce((a, b) => a + b) / amounts.length;
    
    final variance = amounts.fold<double>(
      0,
      (sum, amount) => sum + pow(amount - mean, 2),
    ) / amounts.length;
    
    final stdDev = sqrt(variance);
    
    // Find transactions > 2 standard deviations from mean
    return transactions.where(
      (tx) => tx.amount > mean + (2 * stdDev),
    ).toList();
  }
  
  List<String> _generateInsights(
    Budget budget,
    Map<DateTime, double> dailySpending,
    Map<String, CategoryTrend> categoryTrends,
  ) {
    final insights = <String>[];
    
    // Insight 1: Overall budget health
    if (budget.isOverBudget) {
      insights.add(
        'You\'re over budget by \$${(budget.totalSpent - budget.totalBudget).toStringAsFixed(2)}',
      );
    } else if (budget.percentageUsed > 90) {
      insights.add(
        'You\'ve used ${budget.percentageUsed.toStringAsFixed(0)}% of your budget with ${budget.daysRemaining} days left',
      );
    }
    
    // Insight 2: Top spending category
    final topCategory = categoryTrends.entries
        .reduce((a, b) => a.value.totalSpent > b.value.totalSpent ? a : b);
    
    insights.add(
      'Your highest spending is in ${topCategory.key} (\$${topCategory.value.totalSpent.toStringAsFixed(0)})',
    );
    
    // Insight 3: Trending categories
    final increasingCategories = categoryTrends.entries
        .where((e) => e.value.trend == TrendDirection.increasing)
        .toList();
    
    if (increasingCategories.isNotEmpty) {
      insights.add(
        'Spending is increasing in: ${increasingCategories.map((e) => e.key).join(', ')}',
      );
    }
    
    // Insight 4: Daily spending recommendations
    if (budget.recommendedDailySpending < budget.averageDailySpending) {
      insights.add(
        'To stay on budget, reduce daily spending to \$${budget.recommendedDailySpending.toStringAsFixed(0)}',
      );
    }
    
    return insights;
  }
  
  bool _isInBudgetScope(Transaction transaction, Budget budget) {
    if (!budget.trackAllAccounts && budget.accountIds != null) {
      if (transaction.accountId == null) return false;
      if (!budget.accountIds!.contains(transaction.accountId)) return false;
    }
    
    final categoryIds = budget.categories.map((c) => c.categoryId).toList();
    return categoryIds.contains(transaction.categoryId);
  }
}

@freezed
class SpendingAnalysis with _$SpendingAnalysis {
  const factory SpendingAnalysis({
    required Budget budget,
    required Map<DateTime, double> dailySpending,
    required Map<String, CategoryTrend> categoryTrends,
    required Map<int, double> weekdayPatterns,
    required List<Transaction> largestExpenses,
    required List<Transaction> unusualTransactions,
    required List<String> insights,
  }) = _SpendingAnalysis;
}

@freezed
class CategoryTrend with _$CategoryTrend {
  const factory CategoryTrend({
    required String categoryId,
    required int transactionCount,
    required double totalSpent,
    required double averageTransaction,
    required TrendDirection trend,
  }) = _CategoryTrend;
}

enum TrendDirection { increasing, decreasing, flat }
```

### B. Budget Optimization

```dart
// lib/features/budgets/domain/usecases/optimize_budget.dart

class OptimizeBudget {
  final TransactionRepository _transactionRepository;
  
  Future<Result<BudgetOptimization>> call(Budget budget) async {
    // Get historical data (last 3-6 months)
    final historicalResult = await _getHistoricalData(budget);
    
    if (historicalResult.isError) {
      return Result.error(historicalResult.failureOrNull!);
    }
    
    final historicalData = historicalResult.dataOrNull!;
    
    // Analyze actual spending patterns
    final actualSpending = _calculateAverageSpending(historicalData);
    
    // Generate recommendations
    final recommendations = _generateRecommendations(
      budget,
      actualSpending,
    );
    
    // Create optimized budget
    final optimizedBudget = _createOptimizedBudget(
      budget,
      recommendations,
    );
    
    return Result.success(
      BudgetOptimization(
        currentBudget: budget,
        optimizedBudget: optimizedBudget,
        recommendations: recommendations,
        estimatedSavings: _calculatePotentialSavings(
          budget,
          optimizedB