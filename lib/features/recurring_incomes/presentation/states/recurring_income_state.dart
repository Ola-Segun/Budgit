import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/recurring_income.dart';

part 'recurring_income_state.freezed.dart';

/// State for recurring income-related operations
@freezed
class RecurringIncomeState with _$RecurringIncomeState {
  const factory RecurringIncomeState.initial() = _Initial;

  const factory RecurringIncomeState.loading() = _Loading;

  const factory RecurringIncomeState.loaded({
    required List<RecurringIncome> incomes,
    required RecurringIncomesSummary summary,
  }) = _Loaded;

  const factory RecurringIncomeState.error({
    required String message,
    List<RecurringIncome>? incomes,
    RecurringIncomesSummary? summary,
  }) = _Error;

  const factory RecurringIncomeState.incomeLoaded({
    required RecurringIncome income,
    required RecurringIncomeStatus status,
  }) = _IncomeLoaded;

  const factory RecurringIncomeState.incomeSaved({
    required RecurringIncome income,
  }) = _IncomeSaved;

  const factory RecurringIncomeState.incomeDeleted() = _IncomeDeleted;

  const factory RecurringIncomeState.receiptRecorded({
    required RecurringIncome income,
  }) = _ReceiptRecorded;
}

/// State for recurring income form operations
@freezed
class RecurringIncomeFormState with _$RecurringIncomeFormState {
  const factory RecurringIncomeFormState.initial({
    RecurringIncome? income,
  }) = _FormInitial;

  const factory RecurringIncomeFormState.loading() = _FormLoading;

  const factory RecurringIncomeFormState.saved({
    required RecurringIncome income,
  }) = _FormSaved;

  const factory RecurringIncomeFormState.error({
    required String message,
    required Map<String, String> errors,
  }) = _FormError;

  const factory RecurringIncomeFormState.validating() = _FormValidating;

  const factory RecurringIncomeFormState.valid({
    required RecurringIncome income,
  }) = _FormValid;
}

/// State for recurring incomes list operations
@freezed
class RecurringIncomesListState with _$RecurringIncomesListState {
  const factory RecurringIncomesListState.initial() = _ListInitial;

  const factory RecurringIncomesListState.loading() = _ListLoading;

  const factory RecurringIncomesListState.loaded({
    required List<RecurringIncomeStatus> incomeStatuses,
    String? filter,
    RecurringIncomeFrequency? frequencyFilter,
    String? categoryFilter,
  }) = _ListLoaded;

  const factory RecurringIncomesListState.error({
    required String message,
  }) = _ListError;

  const factory RecurringIncomesListState.empty() = _ListEmpty;
}

/// State for recurring income receipt operations
@freezed
class RecurringIncomeReceiptState with _$RecurringIncomeReceiptState {
  const factory RecurringIncomeReceiptState.initial() = _ReceiptInitial;

  const factory RecurringIncomeReceiptState.processing() = _ReceiptProcessing;

  const factory RecurringIncomeReceiptState.success({
    required RecurringIncome income,
    required RecurringIncomeInstance instance,
  }) = _ReceiptSuccess;

  const factory RecurringIncomeReceiptState.error({
    required String message,
  }) = _ReceiptError;
}