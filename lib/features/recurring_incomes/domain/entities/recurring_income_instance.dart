import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';

part 'recurring_income_instance.freezed.dart';
part 'recurring_income_instance.g.dart';

/// Entity representing a single instance of recurring income receipt
@freezed
class RecurringIncomeInstance with _$RecurringIncomeInstance {
  const factory RecurringIncomeInstance({
    required String id,
    required double amount,
    required DateTime receivedDate,
    String? transactionId,
    String? notes,
    String? accountId, // Account where income was deposited
  }) = _RecurringIncomeInstance;

  const RecurringIncomeInstance._();

  /// Validate income instance data
  Result<RecurringIncomeInstance> validate() {
    if (amount <= 0) {
      return Result.error(Failure.validation(
        'Amount must be greater than 0',
        {'amount': 'Amount must be positive'},
      ));
    }
    if (receivedDate.isAfter(DateTime.now().add(const Duration(days: 1)))) {
      return Result.error(Failure.validation(
        'Received date cannot be in the future',
        {'receivedDate': 'Date cannot be in the future'},
      ));
    }
    return Result.success(this);
  }

  /// Factory constructor for creating from JSON
  factory RecurringIncomeInstance.fromJson(Map<String, dynamic> json) =>
      _$RecurringIncomeInstanceFromJson(json);
}