import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/budget_widget.dart';

/// Use case for creating a new budget widget
class CreateBudgetWidget {
  const CreateBudgetWidget();

  /// Execute the use case
  Future<Result<BudgetWidget>> call({
    required String userId,
    required WidgetType type,
    String? title,
    WidgetSize? size,
    String? backgroundColor,
    String? textColor,
  }) async {
    try {
      // Get widget configuration
      final config = WidgetConfigurations.getConfig(type);

      // Create widget
      final widget = BudgetWidget(
        id: _generateWidgetId(),
        userId: userId,
        type: type,
        title: title ?? config.defaultLabels['title'] ?? type.displayName,
        size: size ?? config.defaultSize,
        data: [], // Will be populated when widget data is refreshed
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        backgroundColor: backgroundColor,
        textColor: textColor,
      );

      // TODO: Save widget to repository
      // For now, just return success

      return Result.success(widget);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to create budget widget: $e'));
    }
  }

  /// Generate unique widget ID
  String _generateWidgetId() {
    return 'widget_${DateTime.now().millisecondsSinceEpoch}';
  }
}