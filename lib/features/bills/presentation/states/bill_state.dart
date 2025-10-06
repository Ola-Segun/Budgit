import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/bill.dart';

part 'bill_state.freezed.dart';

/// State for bill-related operations
@freezed
class BillState with _$BillState {
  const factory BillState.initial() = _Initial;

  const factory BillState.loading() = _Loading;

  const factory BillState.loaded({
    required List<Bill> bills,
    required BillsSummary summary,
  }) = _Loaded;

  const factory BillState.error({
    required String message,
    List<Bill>? bills,
    BillsSummary? summary,
  }) = _Error;

  const factory BillState.billLoaded({
    required Bill bill,
    required BillStatus status,
  }) = _BillLoaded;

  const factory BillState.billSaved({
    required Bill bill,
  }) = _BillSaved;

  const factory BillState.billDeleted() = _BillDeleted;

  const factory BillState.paymentMarked({
    required Bill bill,
  }) = _PaymentMarked;
}

/// State for bill form operations
@freezed
class BillFormState with _$BillFormState {
  const factory BillFormState.initial({
    Bill? bill,
  }) = _FormInitial;

  const factory BillFormState.loading() = _FormLoading;

  const factory BillFormState.saved({
    required Bill bill,
  }) = _FormSaved;

  const factory BillFormState.error({
    required String message,
    required Map<String, String> errors,
  }) = _FormError;

  const factory BillFormState.validating() = _FormValidating;

  const factory BillFormState.valid({
    required Bill bill,
  }) = _FormValid;
}

/// State for bills list operations
@freezed
class BillsListState with _$BillsListState {
  const factory BillsListState.initial() = _ListInitial;

  const factory BillsListState.loading() = _ListLoading;

  const factory BillsListState.loaded({
    required List<BillStatus> billStatuses,
    String? filter,
    BillFrequency? frequencyFilter,
    String? categoryFilter,
  }) = _ListLoaded;

  const factory BillsListState.error({
    required String message,
  }) = _ListError;

  const factory BillsListState.empty() = _ListEmpty;
}

/// State for bill payment operations
@freezed
class BillPaymentState with _$BillPaymentState {
  const factory BillPaymentState.initial() = _PaymentInitial;

  const factory BillPaymentState.processing() = _PaymentProcessing;

  const factory BillPaymentState.success({
    required Bill bill,
    required BillPayment payment,
  }) = _PaymentSuccess;

  const factory BillPaymentState.error({
    required String message,
  }) = _PaymentError;
}