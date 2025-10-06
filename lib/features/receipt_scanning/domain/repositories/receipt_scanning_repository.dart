import 'dart:io';

import 'package:budget_tracker/core/error/result.dart';

import '../entities/receipt_data.dart';

/// Repository interface for receipt scanning operations
abstract class ReceiptScanningRepository {
  /// Processes a receipt image and extracts data
  /// For now, returns mock data. OCR integration can be added later.
  Future<Result<ReceiptData>> processReceiptImage(File image);

  /// Suggests a category based on merchant name
  Future<Result<String>> suggestCategory(String merchant);
}