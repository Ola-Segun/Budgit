import 'package:freezed_annotation/freezed_annotation.dart';

import 'transaction.dart';

part 'transaction_filter.freezed.dart';

/// Filter for transactions
@freezed
class TransactionFilter with _$TransactionFilter {
  const factory TransactionFilter({
    TransactionType? transactionType,
    List<String>? categoryIds,
    String? accountId,
    DateTime? startDate,
    DateTime? endDate,
    double? minAmount,
    double? maxAmount,
  }) = _TransactionFilter;

  const TransactionFilter._();

  /// Check if filter is empty (no filters applied)
  bool get isEmpty =>
      transactionType == null &&
      (categoryIds == null || categoryIds!.isEmpty) &&
      accountId == null &&
      startDate == null &&
      endDate == null &&
      minAmount == null &&
      maxAmount == null;

  /// Check if filter has any active filters
  bool get isNotEmpty => !isEmpty;
}