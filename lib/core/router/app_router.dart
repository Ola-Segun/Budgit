import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/transactions/presentation/screens/transaction_list_screen.dart';
import '../../features/transactions/presentation/widgets/add_transaction_bottom_sheet.dart';
import '../../features/transactions/presentation/providers/transaction_providers.dart';
import '../../features/budgets/presentation/screens/budget_list_screen.dart';
import '../../features/budgets/presentation/screens/budget_creation_screen.dart';
import '../../features/budgets/presentation/screens/budget_detail_screen.dart';
import '../../features/insights/presentation/screens/insights_dashboard_screen.dart';
import '../widgets/app_bottom_sheet.dart';
import '../navigation/main_navigation_scaffold.dart';

/// App router configuration using GoRouter
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Home/Dashboard
      GoRoute(
        path: '/',
        builder: (context, state) => const _HomeScreen(),
        routes: [
          // Transaction routes
          GoRoute(
            path: 'transactions',
            builder: (context, state) => const _TransactionsScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return _TransactionDetailScreen(id: id);
                },
              ),
              GoRoute(
                path: 'add',
                builder: (context, state) => const _AddTransactionScreen(),
              ),
            ],
          ),

          // Budget routes
          GoRoute(
            path: 'budgets',
            builder: (context, state) => const _BudgetsScreen(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const _AddBudgetScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return _BudgetDetailScreen(id: id);
                },
              ),
            ],
          ),

          // Goals routes
          GoRoute(
            path: 'goals',
            builder: (context, state) => const _GoalsScreen(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const _AddGoalScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return _GoalDetailScreen(id: id);
                },
              ),
            ],
          ),

          // Bills routes
          GoRoute(
            path: 'bills',
            builder: (context, state) => const _BillsScreen(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const _AddBillScreen(),
              ),
            ],
          ),

          // Insights routes
          GoRoute(
            path: 'insights',
            builder: (context, state) => const _InsightsScreen(),
          ),

          // Settings
          GoRoute(
            path: 'settings',
            builder: (context, state) => const _SettingsScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => _ErrorScreen(
      error: state.error,
    ),
  );
}

// Actual implemented screens
class _HomeScreen extends ConsumerWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MainNavigationScaffold();
  }
}

class _TransactionsScreen extends ConsumerWidget {
  const _TransactionsScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const TransactionListScreen();
  }
}

class _TransactionDetailScreen extends StatelessWidget {
  const _TransactionDetailScreen({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Details')),
      body: Center(child: Text('Transaction Detail: $id - Coming Soon')),
    );
  }
}

class _AddTransactionScreen extends ConsumerWidget {
  const _AddTransactionScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Show the add transaction bottom sheet immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppBottomSheet.show(
        context: context,
        child: AddTransactionBottomSheet(
          onSubmit: (transaction) async {
            await ref
                .read(transactionNotifierProvider.notifier)
                .addTransaction(transaction);

            if (context.mounted) {
              Navigator.pop(context); // Close bottom sheet
              context.go('/'); // Go back to home
            }
          },
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: const Center(child: Text('Loading...')),
    );
  }
}

class _BudgetsScreen extends ConsumerWidget {
  const _BudgetsScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BudgetListScreen();
  }
}

class _AddBudgetScreen extends ConsumerWidget {
  const _AddBudgetScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BudgetCreationScreen();
  }
}

class _BudgetDetailScreen extends StatelessWidget {
  const _BudgetDetailScreen({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BudgetDetailScreen(budgetId: id);
  }
}

class _GoalsScreen extends StatelessWidget {
  const _GoalsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      body: const Center(child: Text('Goals Screen - Coming Soon')),
    );
  }
}

class _AddGoalScreen extends StatelessWidget {
  const _AddGoalScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Goal')),
      body: const Center(child: Text('Add Goal Screen - Coming Soon')),
    );
  }
}

class _GoalDetailScreen extends StatelessWidget {
  const _GoalDetailScreen({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goal Details')),
      body: Center(child: Text('Goal Detail: $id - Coming Soon')),
    );
  }
}

class _BillsScreen extends StatelessWidget {
  const _BillsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bills')),
      body: const Center(child: Text('Bills Screen - Coming Soon')),
    );
  }
}

class _AddBillScreen extends StatelessWidget {
  const _AddBillScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Bill')),
      body: const Center(child: Text('Add Bill Screen - Coming Soon')),
    );
  }
}

class _InsightsScreen extends ConsumerWidget {
  const _InsightsScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const InsightsDashboardScreen();
  }
}

class _SettingsScreen extends StatelessWidget {
  const _SettingsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen - Coming Soon')),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({required this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Something went wrong'),
            if (error != null) Text('Error: $error'),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}