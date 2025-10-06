import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_widget.freezed.dart';

/// Home screen widget configuration for budget overview
@freezed
class BudgetWidget with _$BudgetWidget {
  const factory BudgetWidget({
    required String id,
    required String userId,
    required WidgetType type,
    required String title,
    required WidgetSize size,
    required List<WidgetData> data,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(true) bool isActive,
    String? backgroundColor,
    String? textColor,
  }) = _BudgetWidget;

  const BudgetWidget._();

  /// Get widget data by key
  WidgetData? getData(String key) {
    return data.firstWhere(
      (d) => d.key == key,
      orElse: () => WidgetData(key: key, value: '0', label: ''),
    );
  }

  /// Check if widget needs refresh (data older than 1 hour)
  bool get needsRefresh => DateTime.now().difference(updatedAt).inHours > 1;
}

/// Type of home screen widget
enum WidgetType {
  budgetOverview,
  spendingSummary,
  recentTransactions,
  upcomingBills,
  savingsGoal,
  expenseBreakdown;

  String get displayName {
    switch (this) {
      case WidgetType.budgetOverview:
        return 'Budget Overview';
      case WidgetType.spendingSummary:
        return 'Spending Summary';
      case WidgetType.recentTransactions:
        return 'Recent Transactions';
      case WidgetType.upcomingBills:
        return 'Upcoming Bills';
      case WidgetType.savingsGoal:
        return 'Savings Goal';
      case WidgetType.expenseBreakdown:
        return 'Expense Breakdown';
    }
  }
}

/// Size of the widget
enum WidgetSize {
  small, // 2x2
  medium, // 4x2
  large; // 4x4

  int get width {
    switch (this) {
      case WidgetSize.small:
        return 2;
      case WidgetSize.medium:
      case WidgetSize.large:
        return 4;
    }
  }

  int get height {
    switch (this) {
      case WidgetSize.small:
        return 2;
      case WidgetSize.medium:
        return 2;
      case WidgetSize.large:
        return 4;
    }
  }
}

/// Data item for widget
@freezed
class WidgetData with _$WidgetData {
  const factory WidgetData({
    required String key,
    required String value,
    required String label,
    String? unit,
    String? color,
    @Default(false) bool isPrimary,
  }) = _WidgetData;

  const WidgetData._();

  /// Get formatted value with unit
  String get formattedValue => unit != null ? '$value $unit' : value;

  /// Parse value as double
  double? get numericValue => double.tryParse(value);
}

/// Widget configuration for different types
@freezed
class WidgetConfig with _$WidgetConfig {
  const factory WidgetConfig({
    required WidgetType type,
    required List<String> requiredDataKeys,
    required Map<String, String> defaultLabels,
    required WidgetSize defaultSize,
    String? description,
  }) = _WidgetConfig;

  const WidgetConfig._();
}

/// Predefined widget configurations
class WidgetConfigurations {
  static const budgetOverview = WidgetConfig(
    type: WidgetType.budgetOverview,
    requiredDataKeys: ['totalBudget', 'spent', 'remaining', 'percentage'],
    defaultLabels: {
      'totalBudget': 'Total Budget',
      'spent': 'Spent',
      'remaining': 'Remaining',
      'percentage': 'Used',
    },
    defaultSize: WidgetSize.medium,
    description: 'Shows your total budget, amount spent, and remaining balance',
  );

  static const spendingSummary = WidgetConfig(
    type: WidgetType.spendingSummary,
    requiredDataKeys: ['today', 'thisWeek', 'thisMonth', 'average'],
    defaultLabels: {
      'today': 'Today',
      'thisWeek': 'This Week',
      'thisMonth': 'This Month',
      'average': 'Daily Average',
    },
    defaultSize: WidgetSize.large,
    description: 'Summary of your spending over different time periods',
  );

  static const recentTransactions = WidgetConfig(
    type: WidgetType.recentTransactions,
    requiredDataKeys: ['count', 'total', 'latest'],
    defaultLabels: {
      'count': 'Transactions',
      'total': 'Total',
      'latest': 'Latest',
    },
    defaultSize: WidgetSize.medium,
    description: 'Your most recent transactions',
  );

  static const upcomingBills = WidgetConfig(
    type: WidgetType.upcomingBills,
    requiredDataKeys: ['nextBill', 'amount', 'dueDate', 'count'],
    defaultLabels: {
      'nextBill': 'Next Bill',
      'amount': 'Amount',
      'dueDate': 'Due Date',
      'count': 'Total Bills',
    },
    defaultSize: WidgetSize.small,
    description: 'Upcoming bills and payment reminders',
  );

  static const savingsGoal = WidgetConfig(
    type: WidgetType.savingsGoal,
    requiredDataKeys: ['goal', 'current', 'remaining', 'percentage'],
    defaultLabels: {
      'goal': 'Goal',
      'current': 'Saved',
      'remaining': 'Remaining',
      'percentage': 'Progress',
    },
    defaultSize: WidgetSize.medium,
    description: 'Track your savings goal progress',
  );

  static const expenseBreakdown = WidgetConfig(
    type: WidgetType.expenseBreakdown,
    requiredDataKeys: ['topCategory', 'amount', 'percentage', 'trend'],
    defaultLabels: {
      'topCategory': 'Top Category',
      'amount': 'Amount',
      'percentage': 'Of Total',
      'trend': 'Trend',
    },
    defaultSize: WidgetSize.large,
    description: 'Breakdown of your expenses by category',
  );

  static List<WidgetConfig> get allConfigs => [
    budgetOverview,
    spendingSummary,
    recentTransactions,
    upcomingBills,
    savingsGoal,
    expenseBreakdown,
  ];

  static WidgetConfig getConfig(WidgetType type) {
    return allConfigs.firstWhere(
      (config) => config.type == type,
      orElse: () => budgetOverview,
    );
  }
}