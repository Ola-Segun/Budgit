import 'dart:io';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';

import '../../domain/entities/receipt_data.dart';
import '../../domain/repositories/receipt_scanning_repository.dart';

/// Implementation of receipt scanning repository
/// Currently returns mock data. OCR integration can be added later.
class ReceiptScanningRepositoryImpl implements ReceiptScanningRepository {
  @override
  Future<Result<ReceiptData>> processReceiptImage(File image) async {
    try {
      // Simulate processing time
      await Future.delayed(const Duration(seconds: 2));

      // For now, return mock data
      // TODO: Integrate with Google ML Kit for OCR
      final receiptData = ReceiptData.mock().copyWith(
        imagePath: image.path,
      );

      return Result.success(receiptData);
    } catch (e) {
      return Result.error(UnknownFailure('Failed to process receipt image: $e'));
    }
  }

  @override
  Future<Result<String>> suggestCategory(String merchant) async {
    try {
      // Simple merchant-to-category mapping
      // TODO: Implement more sophisticated category suggestion logic
      final merchantLower = merchant.toLowerCase();

      if (merchantLower.contains('grocery') ||
          merchantLower.contains('market') ||
          merchantLower.contains('supermarket')) {
        return Result.success('food');
      } else if (merchantLower.contains('restaurant') ||
          merchantLower.contains('cafe') ||
          merchantLower.contains('diner')) {
        return Result.success('food');
      } else if (merchantLower.contains('gas') ||
          merchantLower.contains('fuel') ||
          merchantLower.contains('station')) {
        return Result.success('transportation');
      } else if (merchantLower.contains('pharmacy') ||
          merchantLower.contains('drug')) {
        return Result.success('healthcare');
      } else if (merchantLower.contains('amazon') ||
          merchantLower.contains('walmart') ||
          merchantLower.contains('target')) {
        return Result.success('shopping');
      }

      // Default category
      return Result.success('other');
    } catch (e) {
      return Result.error(UnknownFailure('Failed to suggest category: $e'));
    }
  }
}