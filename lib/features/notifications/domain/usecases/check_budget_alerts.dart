import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../budgets/domain/entities/budget.dart';
import '../../../budgets/domain/repositories/budget_repository.dart';
import '../../../budgets/domain/usecases/calculate_budget_status.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../entities/notification.dart';

/// Use case for checking budget alerts
class CheckBudgetAlerts {
  const CheckBudgetAlerts(
    this._budgetRepository,
    this._settingsRepository,
    this._calculateBudgetStatus,
  );

  final BudgetRepository _budgetRepository;
  final SettingsRepository _settingsRepository;
  final CalculateBudgetStatus _calculateBudgetStatus;

  /// Check for budget alerts and return notifications
  Future<Result<List<AppNotification>>> call() async {
    try {
      // Get settings to check if budget alerts are enabled
      final settingsResult = await _settingsRepository.getSettings();
      if (settingsResult.isError) {
        return Result.error(settingsResult.failureOrNull!);
      }

      final settings = settingsResult.dataOrNull!;
      if (!settings.budgetAlertsEnabled) {
        return const Result.success([]);
      }

      // Get all budgets
      final budgetsResult = await _budgetRepository.getAll();
      if (budgetsResult.isError) {
        return Result.error(budgetsResult.failureOrNull!);
      }

      final budgets = budgetsResult.dataOrNull!;
      final notifications = <AppNotification>[];

      for (final budget in budgets) {
        if (budget.isCurrentlyActive) {
          final alert = await _checkBudgetAlert(budget, settings.budgetAlertThreshold);
          if (alert != null) {
            notifications.add(alert);
          }
        }
      }

      return Result.success(notifications);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to check budget alerts: $e'));
    }
  }

  Future<AppNotification?> _checkBudgetAlert(Budget budget, int threshold) async {
    // Calculate budget status to get spending data
    final statusResult = await _calculateBudgetStatus(budget);
    if (statusResult.isError) return null;

    final status = statusResult.dataOrNull!;
    if (status.totalSpent <= 0 || status.totalBudget <= 0) return null;

    final spentPercentage = (status.totalSpent / status.totalBudget) * 100;
    if (spentPercentage < threshold) return null;

    final priority = spentPercentage >= 90
        ? NotificationPriority.critical
        : spentPercentage >= 75
            ? NotificationPriority.high
            : NotificationPriority.medium;

    return AppNotification(
      id: 'budget_alert_${budget.id}_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Budget Alert: ${budget.name}',
      message: 'You\'ve spent ${spentPercentage.toStringAsFixed(1)}% of your ${budget.name} budget (\$${status.totalSpent.toStringAsFixed(2)} of \$${status.totalBudget.toStringAsFixed(2)}).',
      type: NotificationType.budgetAlert,
      priority: priority,
      createdAt: DateTime.now(),
      metadata: {
        'budgetId': budget.id,
        'spentPercentage': spentPercentage,
        'threshold': threshold,
      },
    );
  }
}