import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// A centralized notification manager for consistent SnackBar implementations
/// across the entire app. Provides standardized styling, accessibility features,
/// and predefined messages for common operations.
class NotificationManager {
  // Default durations for different notification types
  static const Duration _mediumDuration = Duration(seconds: 4);
  static const Duration _longDuration = Duration(seconds: 6);

  // Default positioning
  static const SnackBarBehavior _defaultBehavior = SnackBarBehavior.floating;

  /// Shows a success notification with green styling
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = _mediumDuration,
    VoidCallback? action,
    String? actionLabel,
    SnackBarBehavior behavior = _defaultBehavior,
  }) {
    _showNotification(
      context,
      message,
      type: NotificationType.success,
      duration: duration,
      action: action,
      actionLabel: actionLabel,
      behavior: behavior,
    );
  }

  /// Shows an error notification with red styling
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = _longDuration,
    VoidCallback? action,
    String? actionLabel,
    SnackBarBehavior behavior = _defaultBehavior,
  }) {
    _showNotification(
      context,
      message,
      type: NotificationType.error,
      duration: duration,
      action: action,
      actionLabel: actionLabel,
      behavior: behavior,
    );
  }

  /// Shows a warning notification with amber styling
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = _mediumDuration,
    VoidCallback? action,
    String? actionLabel,
    SnackBarBehavior behavior = _defaultBehavior,
  }) {
    _showNotification(
      context,
      message,
      type: NotificationType.warning,
      duration: duration,
      action: action,
      actionLabel: actionLabel,
      behavior: behavior,
    );
  }

  /// Shows an info notification with cyan styling
  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = _mediumDuration,
    VoidCallback? action,
    String? actionLabel,
    SnackBarBehavior behavior = _defaultBehavior,
  }) {
    _showNotification(
      context,
      message,
      type: NotificationType.info,
      duration: duration,
      action: action,
      actionLabel: actionLabel,
      behavior: behavior,
    );
  }

  /// Predefined success messages

  /// Shows success message for transaction creation
  static void transactionAdded(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Transaction added successfully',
      action: action,
      actionLabel: 'Undo',
    );
  }

  /// Shows success message for transfer completion
  static void transferCompleted(BuildContext context, double amount, {VoidCallback? action}) {
    showSuccess(
      context,
      'Transfer of \$${amount.toStringAsFixed(2)} completed successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for account deletion
  static void accountDeleted(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Account deleted successfully',
      action: action,
      actionLabel: 'Undo',
    );
  }

  /// Shows success message for category creation
  static void categoryAdded(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Category added successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for category update
  static void categoryUpdated(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Category updated successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for category deletion
  static void categoryDeleted(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Category deleted successfully',
      action: action,
      actionLabel: 'Undo',
    );
  }

  /// Shows success message for budget creation
  static void budgetCreated(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Budget created successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for budget update
  static void budgetUpdated(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Budget updated successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for budget deletion
  static void budgetDeleted(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Budget deleted successfully',
      action: action,
      actionLabel: 'Undo',
    );
  }

  /// Shows success message for goal creation
  static void goalCreated(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Goal created successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for goal update
  static void goalUpdated(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Goal updated successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for goal deletion
  static void goalDeleted(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Goal deleted successfully',
      action: action,
      actionLabel: 'Undo',
    );
  }

  /// Shows success message for bill creation
  static void billAdded(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Bill added successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for bill update
  static void billUpdated(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Bill updated successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for bill deletion
  static void billDeleted(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Bill deleted successfully',
      action: action,
      actionLabel: 'Undo',
    );
  }

  /// Shows success message for payment recording
  static void paymentRecorded(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Payment recorded successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for contribution addition
  static void contributionAdded(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Contribution added successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for transaction update
  static void transactionUpdated(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Transaction updated successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Shows success message for transaction deletion
  static void transactionDeleted(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Transaction deleted successfully',
      action: action,
      actionLabel: 'Undo',
    );
  }

  /// Shows success message for transaction duplication
  static void transactionDuplicated(BuildContext context, {VoidCallback? action}) {
    showSuccess(
      context,
      'Transaction duplicated successfully',
      action: action,
      actionLabel: 'View',
    );
  }

  /// Predefined error messages

  /// Shows error message for insufficient funds
  static void insufficientFunds(BuildContext context, {VoidCallback? action}) {
    showError(
      context,
      'Insufficient funds for this transaction',
      action: action,
      actionLabel: 'Add Funds',
    );
  }

  /// Shows error message for failed transaction addition
  static void transactionAddFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to add transaction: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed transaction update
  static void transactionUpdateFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to update transaction: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed transaction deletion
  static void transactionDeleteFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to delete transaction: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed category addition
  static void categoryAddFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to add category: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed category update
  static void categoryUpdateFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to update category: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed category deletion
  static void categoryDeleteFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to delete category: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed budget creation
  static void budgetCreateFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to create budget: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed budget update
  static void budgetUpdateFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to update budget: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed goal creation
  static void goalCreateFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to create goal: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed goal update
  static void goalUpdateFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to update goal: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed bill addition
  static void billAddFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to add bill: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed bill update
  static void billUpdateFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to update bill: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed payment recording
  static void paymentRecordFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to record payment: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed contribution addition
  static void contributionAddFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to add contribution: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed account creation/update
  static void accountOperationFailed(BuildContext context, String operation, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to $operation account: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for invalid amount
  static void invalidAmount(BuildContext context, {VoidCallback? action}) {
    showError(
      context,
      'Please enter a valid amount',
      action: action,
      actionLabel: 'OK',
    );
  }

  /// Shows error message for empty required field
  static void requiredFieldEmpty(BuildContext context, String fieldName, {VoidCallback? action}) {
    showError(
      context,
      'Please enter $fieldName',
      action: action,
      actionLabel: 'OK',
    );
  }

  /// Shows error message for bill not found
  static void billNotFound(BuildContext context, {VoidCallback? action}) {
    showError(
      context,
      'Bill not found',
      action: action,
      actionLabel: 'OK',
    );
  }

  /// Shows error message for failed receipt processing
  static void receiptProcessingFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to process receipt: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Shows error message for failed transaction save
  static void transactionSaveFailed(BuildContext context, String error, {VoidCallback? action}) {
    showError(
      context,
      'Failed to save transaction: $error',
      action: action,
      actionLabel: 'Retry',
    );
  }

  /// Private method to show the actual notification
  static void _showNotification(
    BuildContext context,
    String message, {
    required NotificationType type,
    required Duration duration,
    VoidCallback? action,
    String? actionLabel,
    required SnackBarBehavior behavior,
  }) {
    // Check if context is still mounted before proceeding
    if (!context.mounted) {
      debugPrint('NotificationManager: Context not mounted, skipping notification');
      return;
    }

    // Hide any existing SnackBar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Create the SnackBar with appropriate styling
    final snackBar = SnackBar(
      content: _NotificationContent(
        message: message,
        type: type,
      ),
      duration: duration,
      behavior: behavior,
      backgroundColor: _getBackgroundColor(type),
      action: action != null && actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              onPressed: action,
              textColor: Colors.white,
            )
          : null,
      // Accessibility features
      dismissDirection: DismissDirection.horizontal,
      // Ensure proper semantics for screen readers
      onVisible: () {
        // Announce to screen readers with extended duration for accessibility
        // Note: SemanticsService.announce is not available in Flutter stable
        // This would be handled by the SnackBar's built-in accessibility features
      },
    );

    // Show the SnackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Gets the background color for the notification type
  static Color _getBackgroundColor(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return AppColors.success;
      case NotificationType.error:
        return AppColors.danger;
      case NotificationType.warning:
        return AppColors.warning;
      case NotificationType.info:
        return AppColors.info;
    }
  }
}

/// Enum for notification types
enum NotificationType {
  success,
  error,
  warning,
  info,
}

/// Custom widget for notification content with proper styling
class _NotificationContent extends StatelessWidget {
  const _NotificationContent({
    required this.message,
    required this.type,
  });

  final String message;
  final NotificationType type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          _getIcon(type),
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Gets the appropriate icon for the notification type
  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Icons.check_circle_outline;
      case NotificationType.error:
        return Icons.error_outline;
      case NotificationType.warning:
        return Icons.warning_amber_outlined;
      case NotificationType.info:
        return Icons.info_outline;
    }
  }
}