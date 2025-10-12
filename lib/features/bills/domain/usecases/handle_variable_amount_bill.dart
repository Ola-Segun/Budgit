import 'dart:math' as math;

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

/// Use case for handling variable amount bills
/// Manages bills with changing amounts and validates payment amounts
class HandleVariableAmountBill {
  const HandleVariableAmountBill(this._billRepository);

  final BillRepository _billRepository;

  /// Update the amount of a variable bill
  Future<Result<Bill>> updateBillAmount({
    required String billId,
    required double newAmount,
    String? reason,
    DateTime? effectiveDate,
  }) async {
    // Get the bill
    final billResult = await _billRepository.getById(billId);
    if (billResult.isError) {
      return Result.error(billResult.failureOrNull!);
    }

    final bill = billResult.dataOrNull!;

    // Validate that this is a variable amount bill
    if (!bill.isVariableAmount) {
      return Result.error(Failure.validation(
        'Bill is not variable amount',
        {'billId': 'This bill does not support amount changes'},
      ));
    }

    // Validate new amount
    final amountValidation = _validateAmountUpdate(bill, newAmount);
    if (amountValidation.isError) {
      return Result.error(amountValidation.failureOrNull!);
    }

    // Create updated bill
    final updatedBill = bill.copyWith(
      amount: newAmount,
      lastPriceIncrease: effectiveDate ?? DateTime.now(),
    );

    // Update bill in repository
    final updateResult = await _billRepository.update(updatedBill);
    if (updateResult.isError) {
      return Result.error(updateResult.failureOrNull!);
    }

    return Result.success(updatedBill);
  }

  /// Validate payment amount for variable bill
  Result<void> validatePaymentAmount(Bill bill, double paymentAmount) {
    if (!bill.isVariableAmount) {
      // For fixed amount bills, payment should match or be partial
      if (paymentAmount > bill.amount) {
        return Result.error(Failure.validation(
          'Payment exceeds bill amount',
          {
            'paymentAmount': paymentAmount.toStringAsFixed(2),
            'billAmount': bill.amount.toStringAsFixed(2),
            'excess': (paymentAmount - bill.amount).toStringAsFixed(2),
          },
        ));
      }
      return Result.success(null);
    }

    // For variable amount bills, validate against constraints
    if (bill.minAmount != null && paymentAmount < bill.minAmount!) {
      return Result.error(Failure.validation(
        'Payment below minimum amount',
        {
          'paymentAmount': paymentAmount.toStringAsFixed(2),
          'minAmount': bill.minAmount!.toStringAsFixed(2),
          'shortfall': (bill.minAmount! - paymentAmount).toStringAsFixed(2),
        },
      ));
    }

    if (bill.maxAmount != null && paymentAmount > bill.maxAmount!) {
      return Result.error(Failure.validation(
        'Payment exceeds maximum amount',
        {
          'paymentAmount': paymentAmount.toStringAsFixed(2),
          'maxAmount': bill.maxAmount!.toStringAsFixed(2),
          'excess': (paymentAmount - bill.maxAmount!).toStringAsFixed(2),
        },
      ));
    }

    return Result.success(null);
  }

  /// Get suggested payment amounts for variable bill
  VariableAmountSuggestions getPaymentSuggestions(Bill bill) {
    if (!bill.isVariableAmount) {
      return VariableAmountSuggestions(
        suggestedAmounts: [bill.amount],
        minAmount: bill.amount,
        maxAmount: bill.amount,
        typicalAmount: bill.amount,
      );
    }

    final suggestions = <double>[];

    // Add minimum amount if available
    if (bill.minAmount != null) {
      suggestions.add(bill.minAmount!);
    }

    // Add typical amount (current bill amount)
    suggestions.add(bill.amount);

    // Add maximum amount if available
    if (bill.maxAmount != null) {
      suggestions.add(bill.maxAmount!);
    }

    // Add average of min and max if both available
    if (bill.minAmount != null && bill.maxAmount != null) {
      final average = (bill.minAmount! + bill.maxAmount!) / 2;
      if (!suggestions.contains(average)) {
        suggestions.add(average);
      }
    }

    // Sort suggestions
    suggestions.sort();

    return VariableAmountSuggestions(
      suggestedAmounts: suggestions,
      minAmount: bill.minAmount ?? 0,
      maxAmount: bill.maxAmount,
      typicalAmount: bill.amount,
    );
  }

  /// Calculate amount change statistics
  Future<Result<AmountChangeStats>> getAmountChangeStats(String billId) async {
    final billResult = await _billRepository.getById(billId);
    if (billResult.isError) {
      return Result.error(billResult.failureOrNull!);
    }

    final bill = billResult.dataOrNull!;

    if (!bill.isVariableAmount) {
      return Result.success(AmountChangeStats(
        totalChanges: 0,
        averageChange: 0,
        lastChangeDate: null,
        changeFrequency: Duration.zero,
        isIncreasing: false,
        volatility: 0,
      ));
    }

    // Analyze payment history for amount changes
    final payments = bill.paymentHistory;
    if (payments.length < 2) {
      return Result.success(AmountChangeStats(
        totalChanges: 0,
        averageChange: 0,
        lastChangeDate: bill.lastPriceIncrease,
        changeFrequency: Duration.zero,
        isIncreasing: false,
        volatility: 0,
      ));
    }

    // Calculate changes between consecutive payments
    final changes = <double>[];
    for (int i = 1; i < payments.length; i++) {
      final change = payments[i].amount - payments[i - 1].amount;
      changes.add(change);
    }

    final totalChanges = changes.length;
    final averageChange = changes.reduce((a, b) => a + b) / totalChanges;
    final isIncreasing = averageChange > 0;

    // Calculate volatility (standard deviation of changes)
    final variance = changes.map((change) => (change - averageChange) * (change - averageChange)).reduce((a, b) => a + b) / totalChanges;
    final volatility = variance > 0 ? math.sqrt(variance) : 0;

    // Calculate change frequency
    final firstPayment = payments.first.paymentDate;
    final lastPayment = payments.last.paymentDate;
    final totalDuration = lastPayment.difference(firstPayment);
    final changeFrequency = totalChanges > 0 ? totalDuration ~/ totalChanges : Duration.zero;

    return Result.success(AmountChangeStats(
      totalChanges: totalChanges,
      averageChange: averageChange,
      lastChangeDate: bill.lastPriceIncrease,
      changeFrequency: changeFrequency,
      isIncreasing: isIncreasing,
      volatility: volatility.toDouble(),
    ));
  }

  /// Validate amount update for variable bill
  Result<void> _validateAmountUpdate(Bill bill, double newAmount) {
    if (newAmount <= 0) {
      return Result.error(Failure.validation(
        'Invalid amount',
        {'newAmount': 'Amount must be positive'},
      ));
    }

    // Check against min/max constraints
    if (bill.minAmount != null && newAmount < bill.minAmount!) {
      return Result.error(Failure.validation(
        'Amount below minimum',
        {
          'newAmount': newAmount.toStringAsFixed(2),
          'minAmount': bill.minAmount!.toStringAsFixed(2),
        },
      ));
    }

    if (bill.maxAmount != null && newAmount > bill.maxAmount!) {
      return Result.error(Failure.validation(
        'Amount above maximum',
        {
          'newAmount': newAmount.toStringAsFixed(2),
          'maxAmount': bill.maxAmount!.toStringAsFixed(2),
        },
      ));
    }

    // Check for reasonable change (not more than 100% increase/decrease at once)
    final changePercent = ((newAmount - bill.amount) / bill.amount).abs();
    const maxChangePercent = 1.0; // 100%

    if (changePercent > maxChangePercent) {
      return Result.error(Failure.validation(
        'Amount change too large',
        {
          'changePercent': '${(changePercent * 100).toStringAsFixed(1)}%',
          'maxAllowed': '${(maxChangePercent * 100).toStringAsFixed(1)}%',
          'currentAmount': bill.amount.toStringAsFixed(2),
          'newAmount': newAmount.toStringAsFixed(2),
        },
      ));
    }

    return Result.success(null);
  }
}

/// Suggestions for variable amount bill payments
class VariableAmountSuggestions {
  const VariableAmountSuggestions({
    required this.suggestedAmounts,
    required this.minAmount,
    required this.maxAmount,
    required this.typicalAmount,
  });

  final List<double> suggestedAmounts;
  final double minAmount;
  final double? maxAmount;
  final double typicalAmount;

  bool get hasMinConstraint => minAmount > 0;
  bool get hasMaxConstraint => maxAmount != null;
}

/// Statistics about amount changes for variable bills
class AmountChangeStats {
  const AmountChangeStats({
    required this.totalChanges,
    required this.averageChange,
    required this.lastChangeDate,
    required this.changeFrequency,
    required this.isIncreasing,
    required this.volatility,
  });

  final int totalChanges;
  final double averageChange;
  final DateTime? lastChangeDate;
  final Duration changeFrequency;
  final bool isIncreasing;
  final double volatility;

  String get averageChangeDescription {
    if (totalChanges == 0) return 'No changes recorded';

    final direction = isIncreasing ? 'increasing' : 'decreasing';
    final amount = averageChange.abs().toStringAsFixed(2);
    return 'Average $direction of \$$amount per payment';
  }

  String get volatilityDescription {
    if (volatility < 1) return 'Stable amounts';
    if (volatility < 5) return 'Moderate variation';
    if (volatility < 10) return 'High variation';
    return 'Very volatile amounts';
  }
}