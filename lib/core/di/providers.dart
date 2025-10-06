import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../storage/hive_storage.dart';
import '../router/app_router.dart';
import '../../features/transactions/data/datasources/transaction_hive_datasource.dart';
import '../../features/transactions/data/datasources/transaction_category_hive_datasource.dart';
import '../../features/transactions/data/repositories/transaction_repository_impl.dart';
import '../../features/transactions/data/repositories/transaction_category_repository_impl.dart';
import '../../features/transactions/domain/repositories/transaction_repository.dart';
import '../../features/transactions/domain/usecases/add_transaction.dart';
import '../../features/transactions/domain/usecases/get_transactions.dart';
import '../../features/transactions/domain/usecases/update_transaction.dart';
import '../../features/transactions/domain/usecases/delete_transaction.dart';
import '../../features/budgets/data/datasources/budget_hive_datasource.dart';
import '../../features/budgets/data/repositories/budget_repository_impl.dart';
import '../../features/budgets/domain/repositories/budget_repository.dart';
import '../../features/budgets/domain/usecases/create_budget.dart';
import '../../features/budgets/domain/usecases/get_budgets.dart';
import '../../features/budgets/domain/usecases/update_budget.dart';
import '../../features/budgets/domain/usecases/delete_budget.dart';
import '../../features/budgets/domain/usecases/calculate_budget_status.dart';
import '../../features/goals/data/datasources/goal_hive_datasource.dart';
import '../../features/goals/data/repositories/goal_repository_impl.dart';
import '../../features/goals/domain/repositories/goal_repository.dart';
import '../../features/goals/domain/usecases/create_goal.dart';
import '../../features/goals/domain/usecases/get_goals.dart';
import '../../features/goals/domain/usecases/update_goal.dart';
import '../../features/goals/domain/usecases/delete_goal.dart';
import '../../features/insights/data/datasources/insight_hive_datasource.dart';
import '../../features/insights/data/repositories/insight_repository_impl.dart';
import '../../features/insights/domain/repositories/insight_repository.dart';
import '../../features/insights/domain/usecases/get_insights.dart';
import '../../features/insights/domain/usecases/calculate_financial_health_score.dart';
import '../../features/onboarding/data/datasources/user_profile_hive_datasource.dart';
import '../../features/onboarding/presentation/providers/onboarding_providers.dart' as onboarding_providers;
import '../../features/accounts/data/datasources/account_hive_datasource.dart';
import '../../features/accounts/data/repositories/account_repository_impl.dart';
import '../../features/accounts/domain/repositories/account_repository.dart';
import '../../features/accounts/domain/usecases/create_account.dart';
import '../../features/accounts/domain/usecases/get_accounts.dart';
import '../../features/accounts/domain/usecases/update_account.dart';
import '../../features/accounts/domain/usecases/delete_account.dart';
import '../../features/accounts/domain/usecases/get_account_balance.dart';

/// Core providers for dependency injection
/// All app dependencies should be defined here

// Storage providers
final hiveStorageProvider = Provider<HiveStorage>((ref) {
  throw UnimplementedError('HiveStorage must be initialized in main.dart');
});

// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  return AppRouter.router;
});

// Theme mode provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  void setLightMode() => state = ThemeMode.light;
  void setDarkMode() => state = ThemeMode.dark;
  void setSystemMode() => state = ThemeMode.system;
}

// Error logger provider
final errorLoggerProvider = Provider<ErrorLogger>((ref) {
  return ErrorLogger();
});

class ErrorLogger {
  void logError(Object error, StackTrace? stackTrace) {
    // TODO: Implement proper error logging (Sentry, Firebase Crashlytics, etc.)
    debugPrint('Error: $error');
    if (stackTrace != null) {
      debugPrint('StackTrace: $stackTrace');
    }
  }

  void logInfo(String message) {
    debugPrint('Info: $message');
  }
}

// Transaction data sources
final transactionDataSourceProvider = Provider<TransactionHiveDataSource>((ref) {
  return TransactionHiveDataSource();
});

final transactionCategoryDataSourceProvider = Provider<TransactionCategoryHiveDataSource>((ref) {
  return TransactionCategoryHiveDataSource();
});

// Transaction repositories
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepositoryImpl(ref.read(transactionDataSourceProvider));
});

final transactionCategoryRepositoryProvider = Provider<TransactionCategoryRepository>((ref) {
  return TransactionCategoryRepositoryImpl(ref.read(transactionCategoryDataSourceProvider));
});

// Transaction use cases
final addTransactionProvider = Provider<AddTransaction>((ref) {
  return AddTransaction(ref.read(transactionRepositoryProvider));
});

final getTransactionsProvider = Provider<GetTransactions>((ref) {
  return GetTransactions(ref.read(transactionRepositoryProvider));
});

final updateTransactionProvider = Provider<UpdateTransaction>((ref) {
  return UpdateTransaction(ref.read(transactionRepositoryProvider));
});

final deleteTransactionProvider = Provider<DeleteTransaction>((ref) {
  return DeleteTransaction(ref.read(transactionRepositoryProvider));
});

// Account data sources
final accountDataSourceProvider = Provider<AccountHiveDataSource>((ref) {
  return AccountHiveDataSource();
});

// Account repositories
final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return AccountRepositoryImpl(ref.read(accountDataSourceProvider));
});

// Account use cases
final createAccountProvider = Provider<CreateAccount>((ref) {
  return CreateAccount(ref.read(accountRepositoryProvider));
});

final getAccountsProvider = Provider<GetAccounts>((ref) {
  return GetAccounts(ref.read(accountRepositoryProvider));
});

final updateAccountProvider = Provider<UpdateAccount>((ref) {
  return UpdateAccount(ref.read(accountRepositoryProvider));
});

final deleteAccountProvider = Provider<DeleteAccount>((ref) {
  return DeleteAccount(ref.read(accountRepositoryProvider));
});

final getAccountBalanceProvider = Provider<GetAccountBalance>((ref) {
  return GetAccountBalance(ref.read(accountRepositoryProvider));
});

// Budget data sources
final budgetDataSourceProvider = Provider<BudgetHiveDataSource>((ref) {
  return BudgetHiveDataSource();
});

// Budget repositories
final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  return BudgetRepositoryImpl(ref.read(budgetDataSourceProvider));
});

// Budget use cases
final createBudgetProvider = Provider<CreateBudget>((ref) {
  return CreateBudget(ref.read(budgetRepositoryProvider));
});

final getBudgetsProvider = Provider<GetBudgets>((ref) {
  return GetBudgets(ref.read(budgetRepositoryProvider));
});

final getActiveBudgetsProvider = Provider<GetActiveBudgets>((ref) {
  return GetActiveBudgets(ref.read(budgetRepositoryProvider));
});

final updateBudgetProvider = Provider<UpdateBudget>((ref) {
  return UpdateBudget(ref.read(budgetRepositoryProvider));
});

final deleteBudgetProvider = Provider<DeleteBudget>((ref) {
  return DeleteBudget(ref.read(budgetRepositoryProvider));
});

final calculateBudgetStatusProvider = Provider<CalculateBudgetStatus>((ref) {
  return CalculateBudgetStatus(
    ref.read(budgetRepositoryProvider),
    ref.read(transactionRepositoryProvider),
  );
});

// Goal data sources
final goalDataSourceProvider = Provider<GoalHiveDataSource>((ref) {
  return GoalHiveDataSource();
});

// Goal repositories
final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return GoalRepositoryImpl(ref.read(goalDataSourceProvider));
});

// Goal use cases
final createGoalProvider = Provider<CreateGoal>((ref) {
  return CreateGoal(ref.read(goalRepositoryProvider));
});

final getGoalsProvider = Provider<GetGoals>((ref) {
  return GetGoals(ref.read(goalRepositoryProvider));
});

final getActiveGoalsProvider = Provider<GetActiveGoals>((ref) {
  return GetActiveGoals(ref.read(goalRepositoryProvider));
});

final getCompletedGoalsProvider = Provider<GetCompletedGoals>((ref) {
  return GetCompletedGoals(ref.read(goalRepositoryProvider));
});

final getGoalByIdProvider = Provider<GetGoalById>((ref) {
  return GetGoalById(ref.read(goalRepositoryProvider));
});

final updateGoalProvider = Provider<UpdateGoal>((ref) {
  return UpdateGoal(ref.read(goalRepositoryProvider));
});

final deleteGoalProvider = Provider<DeleteGoal>((ref) {
  return DeleteGoal(ref.read(goalRepositoryProvider));
});

final addGoalContributionProvider = Provider<AddGoalContribution>((ref) {
  return AddGoalContribution(ref.read(goalRepositoryProvider));
});

// Insight data sources
final insightDataSourceProvider = Provider<InsightHiveDataSource>((ref) {
  return InsightHiveDataSource();
});

// Insight repositories
final insightRepositoryProvider = Provider<InsightRepository>((ref) {
  return InsightRepositoryImpl(ref.read(insightDataSourceProvider));
});

// Insight use cases
final getInsightsProvider = Provider<GetInsights>((ref) {
  return GetInsights(ref.read(insightRepositoryProvider));
});

final getRecentInsightsProvider = Provider<GetRecentInsights>((ref) {
  return GetRecentInsights(ref.read(insightRepositoryProvider));
});

final markInsightAsReadProvider = Provider<MarkInsightAsRead>((ref) {
  return MarkInsightAsRead(ref.read(insightRepositoryProvider));
});

final generateInsightsSummaryProvider = Provider<GenerateInsightsSummary>((ref) {
  return GenerateInsightsSummary(ref.read(insightRepositoryProvider));
});

final calculateFinancialHealthScoreProvider = Provider<CalculateFinancialHealthScore>((ref) {
  return CalculateFinancialHealthScore(ref.read(insightRepositoryProvider));
});

final createFinancialReportProvider = Provider<CreateFinancialReport>((ref) {
  return CreateFinancialReport(ref.read(insightRepositoryProvider));
});

final getFinancialReportsProvider = Provider<GetFinancialReports>((ref) {
  return GetFinancialReports(ref.read(insightRepositoryProvider));
});

// App initialization provider
final appInitializationProvider = FutureProvider<void>((ref) async {
  // Initialize storage
  await HiveStorage.init();

  // Initialize data sources
  final transactionDataSource = ref.read(transactionDataSourceProvider);
  final categoryDataSource = ref.read(transactionCategoryDataSourceProvider);
  final accountDataSource = ref.read(accountDataSourceProvider);
  final budgetDataSource = ref.read(budgetDataSourceProvider);
  final goalDataSource = ref.read(goalDataSourceProvider);
  final insightDataSource = ref.read(insightDataSourceProvider);

  await transactionDataSource.init();
  await categoryDataSource.init();
  await accountDataSource.init();
  await budgetDataSource.init();
  await goalDataSource.init();
  await insightDataSource.init();

  // Initialize onboarding data source
  final userProfileDataSource = ref.read(onboarding_providers.userProfileDataSourceProvider);
  await userProfileDataSource.init();

  // Initialize other services here as needed
  ref.read(errorLoggerProvider).logInfo('App initialized successfully');

  // Note: Onboarding state is initialized lazily when accessed
});