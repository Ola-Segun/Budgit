import 'dart:io';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';

import '../entities/receipt_data.dart';
import '../repositories/receipt_scanning_repository.dart';

/// Use case for processing receipt images and extracting data
class ProcessReceiptImage {
  final ReceiptScanningRepository _repository;

  ProcessReceiptImage(this._repository);

  /// Processes a receipt image and returns extracted data
  Future<Result<ReceiptData>> call(File image) async {
    try {
      return await _repository.processReceiptImage(image);
    } catch (e) {
      return Result.error(UnknownFailure('Failed to process receipt: $e'));
    }
  }
}