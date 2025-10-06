import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/receipt_data.dart';

part 'receipt_scanning_state.freezed.dart';

/// State for receipt scanning feature
@freezed
class ReceiptScanningState with _$ReceiptScanningState {
  const factory ReceiptScanningState({
    /// Whether camera is being initialized
    @Default(false) bool isInitializing,

    /// Whether camera is initialized and ready
    @Default(false) bool isInitialized,

    /// Whether receipt is being processed
    @Default(false) bool isProcessing,

    /// Extracted receipt data (null if not processed yet)
    ReceiptData? receiptData,

    /// Error message (null if no error)
    String? error,
  }) = _ReceiptScanningState;

  const ReceiptScanningState._();
}