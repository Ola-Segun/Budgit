import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../budgets/domain/repositories/budget_repository.dart';
import '../../../budgets/domain/usecases/calculate_budget_status.dart';
import '../../../insights/domain/repositories/insight_repository.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/usecases/get_dashboard_data.dart';

// Repository providers
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(
    ref.watch(transactionRepositoryProvider),
    ref.watch(budgetRepositoryProvider),
    ref.watch(billRepositoryProvider),
    ref.watch(insightRepositoryProvider),
    CalculateBudgetStatus(
      ref.watch(budgetRepositoryProvider),
      ref.watch(transactionRepositoryProvider),
    ),
  );
});

// Use case providers
final getDashboardDataUseCaseProvider = Provider<GetDashboardData>((ref) {
  return GetDashboardData(ref.watch(dashboardRepositoryProvider));
});

// State providers
final dashboardDataProvider = FutureProvider((ref) {
  final useCase = ref.watch(getDashboardDataUseCaseProvider);
  return useCase();
});