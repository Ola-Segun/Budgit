import 'package:freezed_annotation/freezed_annotation.dart';

import 'budget.dart';

part 'budget_template.freezed.dart';

/// Budget template entity representing pre-built budget templates
@freezed
class BudgetTemplate with _$BudgetTemplate {
  const factory BudgetTemplate({
    required String id,
    required String name,
    required String description,
    required BudgetType type,
    required List<BudgetCategoryTemplate> categories,
    String? icon,
    int? color,
  }) = _BudgetTemplate;

  const BudgetTemplate._();

  /// Get total budget amount from template
  double get totalBudget => categories.fold(0.0, (sum, category) => sum + category.amount);

  /// Create budget from template with given total amount
  Budget createBudget({
    required String budgetName,
    required DateTime startDate,
    required DateTime endDate,
    required double totalAmount,
    String? description,
  }) {
    final scaleFactor = totalAmount / totalBudget;

    final budgetCategories = categories.map((templateCategory) {
      return BudgetCategory(
        id: templateCategory.id,
        name: templateCategory.name,
        amount: templateCategory.amount * scaleFactor,
        description: templateCategory.description,
        icon: templateCategory.icon,
        color: templateCategory.color,
      );
    }).toList();

    return Budget(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: budgetName,
      type: type,
      startDate: startDate,
      endDate: endDate,
      createdAt: DateTime.now(),
      categories: budgetCategories,
      description: description,
      isActive: true,
      allowRollover: false,
    );
  }
}

/// Budget category template
@freezed
class BudgetCategoryTemplate with _$BudgetCategoryTemplate {
  const factory BudgetCategoryTemplate({
    required String id,
    required String name,
    required double amount,
    String? description,
    String? icon,
    int? color,
  }) = _BudgetCategoryTemplate;

  const BudgetCategoryTemplate._();
}

/// Pre-built budget templates
class BudgetTemplates {
  const BudgetTemplates._();

  /// 50/30/20 Rule Template
  static final BudgetTemplate fiftyThirtyTwenty = BudgetTemplate(
    id: '50-30-20',
    name: '50/30/20 Rule',
    description: '50% needs, 30% wants, 20% savings and debt repayment',
    type: BudgetType.fiftyThirtyTwenty,
    icon: 'account_balance_wallet',
    color: 0xFF10B981, // Green
    categories: [
      BudgetCategoryTemplate(
        id: 'needs',
        name: 'Needs (50%)',
        amount: 500.0, // Will be scaled
        description: 'Housing, utilities, groceries, transportation, insurance, minimum debt payments',
        icon: 'home',
        color: 0xFF10B981,
      ),
      BudgetCategoryTemplate(
        id: 'wants',
        name: 'Wants (30%)',
        amount: 300.0,
        description: 'Entertainment, dining out, hobbies, vacations, shopping',
        icon: 'shopping_bag',
        color: 0xFFF59E0B,
      ),
      BudgetCategoryTemplate(
        id: 'savings',
        name: 'Savings & Debt (20%)',
        amount: 200.0,
        description: 'Emergency fund, retirement, investments, extra debt payments',
        icon: 'savings',
        color: 0xFF3B82F6,
      ),
    ],
  );

  /// Zero-Based Budget Template
  static final BudgetTemplate zeroBased = BudgetTemplate(
    id: 'zero-based',
    name: 'Zero-Based Budget',
    description: 'Every dollar is assigned to a job. Income minus expenses equals zero.',
    type: BudgetType.zeroBased,
    icon: 'calculate',
    color: 0xFF8B5CF6, // Purple
    categories: [
      BudgetCategoryTemplate(
        id: 'housing',
        name: 'Housing',
        amount: 1200.0,
        description: 'Rent/mortgage, property taxes, HOA fees',
        icon: 'home',
        color: 0xFF10B981,
      ),
      BudgetCategoryTemplate(
        id: 'utilities',
        name: 'Utilities',
        amount: 200.0,
        description: 'Electricity, water, gas, internet, phone',
        icon: 'bolt',
        color: 0xFF6B7280,
      ),
      BudgetCategoryTemplate(
        id: 'groceries',
        name: 'Groceries',
        amount: 400.0,
        description: 'Food and household supplies',
        icon: 'shopping_cart',
        color: 0xFF10B981,
      ),
      BudgetCategoryTemplate(
        id: 'transportation',
        name: 'Transportation',
        amount: 300.0,
        description: 'Car payment, gas, maintenance, public transit',
        icon: 'directions_car',
        color: 0xFF6B7280,
      ),
      BudgetCategoryTemplate(
        id: 'insurance',
        name: 'Insurance',
        amount: 150.0,
        description: 'Health, auto, home, life insurance',
        icon: 'security',
        color: 0xFF6B7280,
      ),
      BudgetCategoryTemplate(
        id: 'debt',
        name: 'Debt Payments',
        amount: 200.0,
        description: 'Credit cards, loans, other debts',
        icon: 'credit_card',
        color: 0xFFEF4444,
      ),
      BudgetCategoryTemplate(
        id: 'entertainment',
        name: 'Entertainment',
        amount: 150.0,
        description: 'Movies, concerts, subscriptions, hobbies',
        icon: 'movie',
        color: 0xFFF59E0B,
      ),
      BudgetCategoryTemplate(
        id: 'dining',
        name: 'Dining Out',
        amount: 100.0,
        description: 'Restaurants, coffee shops, delivery',
        icon: 'restaurant',
        color: 0xFFF59E0B,
      ),
      BudgetCategoryTemplate(
        id: 'personal',
        name: 'Personal Care',
        amount: 100.0,
        description: 'Clothing, haircuts, toiletries, gym',
        icon: 'person',
        color: 0xFFF59E0B,
      ),
      BudgetCategoryTemplate(
        id: 'savings',
        name: 'Savings',
        amount: 300.0,
        description: 'Emergency fund, retirement, investments',
        icon: 'savings',
        color: 0xFF3B82F6,
      ),
    ],
  );

  /// Envelope System Template
  static final BudgetTemplate envelope = BudgetTemplate(
    id: 'envelope',
    name: 'Envelope System',
    description: 'Cash-based system with physical envelopes for each category',
    type: BudgetType.envelope,
    icon: 'mail',
    color: 0xFFDC2626, // Red
    categories: [
      BudgetCategoryTemplate(
        id: 'groceries',
        name: 'Groceries',
        amount: 500.0,
        description: 'Weekly grocery shopping',
        icon: 'shopping_cart',
        color: 0xFF10B981,
      ),
      BudgetCategoryTemplate(
        id: 'gas',
        name: 'Gas/Car',
        amount: 200.0,
        description: 'Fuel and car maintenance',
        icon: 'local_gas_station',
        color: 0xFF6B7280,
      ),
      BudgetCategoryTemplate(
        id: 'entertainment',
        name: 'Entertainment',
        amount: 150.0,
        description: 'Movies, games, outings',
        icon: 'movie',
        color: 0xFFF59E0B,
      ),
      BudgetCategoryTemplate(
        id: 'dining',
        name: 'Eating Out',
        amount: 100.0,
        description: 'Restaurants and takeout',
        icon: 'restaurant',
        color: 0xFFF59E0B,
      ),
      BudgetCategoryTemplate(
        id: 'personal',
        name: 'Personal',
        amount: 100.0,
        description: 'Clothing, toiletries, miscellaneous',
        icon: 'person',
        color: 0xFFF59E0B,
      ),
      BudgetCategoryTemplate(
        id: 'household',
        name: 'Household',
        amount: 100.0,
        description: 'Cleaning supplies, repairs, home items',
        icon: 'home',
        color: 0xFF6B7280,
      ),
    ],
  );

  /// All available templates
  static List<BudgetTemplate> get all => [fiftyThirtyTwenty, zeroBased, envelope];

  /// Get template by ID
  static BudgetTemplate? getById(String id) {
    return all.where((template) => template.id == id).firstOrNull;
  }

  /// Get popular templates (first 2)
  static List<BudgetTemplate> get popular => [fiftyThirtyTwenty, zeroBased];

  /// Get simple templates (fewer categories)
  static List<BudgetTemplate> get simple => [fiftyThirtyTwenty, envelope];
}