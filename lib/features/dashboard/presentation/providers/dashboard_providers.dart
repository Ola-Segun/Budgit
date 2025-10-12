import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart' as core_providers;
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/usecases/get_dashboard_data.dart';
import '../../domain/usecases/calculate_dashboard_data.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../../transactions/presentation/providers/transaction_providers.dart';
import '../../../budgets/presentation/providers/budget_providers.dart';
import '../../../bills/presentation/providers/bill_providers.dart';
import '../../../accounts/presentation/providers/account_providers.dart';

// Repository providers
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(
    ref.watch(core_providers.transactionRepositoryProvider),
    ref.watch(core_providers.budgetRepositoryProvider),
    ref.watch(core_providers.billRepositoryProvider),
    ref.watch(core_providers.accountRepositoryProvider),
    ref.watch(core_providers.insightRepositoryProvider),
    ref.watch(core_providers.transactionCategoryRepositoryProvider),
    ref.watch(core_providers.calculateBudgetStatusProvider),
  );
});

// Use case providers
final getDashboardDataUseCaseProvider = Provider<GetDashboardData>((ref) {
  return GetDashboardData(ref.watch(dashboardRepositoryProvider));
});

final calculateDashboardDataUseCaseProvider = Provider<CalculateDashboardData>((ref) {
  return CalculateDashboardData(ref.watch(dashboardRepositoryProvider));
});

// Cache for dashboard data to avoid recomputation
class _DashboardCache {
  DashboardData? _cachedData;
  DateTime? _lastFetchTime;
  static const Duration _cacheDuration = Duration(minutes: 5); // Cache for 5 minutes

  bool get isValid => _cachedData != null &&
      _lastFetchTime != null &&
      DateTime.now().difference(_lastFetchTime!) < _cacheDuration;

  DashboardData? get data => isValid ? _cachedData : null;

  void setData(DashboardData data) {
    _cachedData = data;
    _lastFetchTime = DateTime.now();
  }

  void invalidate() {
    _cachedData = null;
    _lastFetchTime = null;
  }
}

final _dashboardCache = _DashboardCache();

// State providers
final dashboardDataProvider = FutureProvider<DashboardData>((ref) async {
  // Watch reactive providers to trigger invalidation when data changes
  ref.watch(transactionNotifierProvider);
  ref.watch(budgetNotifierProvider);
  ref.watch(billNotifierProvider);
  ref.watch(accountNotifierProvider);

  // Invalidate cache when underlying data changes
  ref.listen(transactionNotifierProvider, (previous, next) {
    if (previous != next) {
      _dashboardCache.invalidate();
    }
  });

  ref.listen(budgetNotifierProvider, (previous, next) {
    if (previous != next) {
      _dashboardCache.invalidate();
    }
  });

  ref.listen(billNotifierProvider, (previous, next) {
    if (previous != next) {
      _dashboardCache.invalidate();
    }
  });

  // Return cached data if valid and no data changes
  if (_dashboardCache.isValid) {
    return _dashboardCache.data!;
  }

  // Use the async use case for computation
  final calculateDashboardData = ref.watch(calculateDashboardDataUseCaseProvider);
  final result = await calculateDashboardData();

  return result.when(
    success: (data) {
      // Cache the result
      _dashboardCache.setData(data);
      return data;
    },
    error: (failure) {
      throw failure;
    },
  );
});

// Provider for refreshing dashboard data
final refreshDashboardProvider = FutureProvider<void>((ref) async {
  _dashboardCache.invalidate();
  final calculateDashboardData = ref.watch(calculateDashboardDataUseCaseProvider);
  final result = await calculateDashboardData.refresh();

  return result.when(
    success: (_) => null,
    error: (failure) => throw failure,
  );
});
