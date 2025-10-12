import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

/// Use case for managing flexible recurring payment patterns
/// Handles different accounts and amounts for different payment instances
class ManageRecurringPaymentPatterns {
  const ManageRecurringPaymentPatterns(this._billRepository);

  final BillRepository _billRepository;

  /// Add a recurring payment rule to a bill
  Future<Result<Bill>> addRecurringPaymentRule({
    required String billId,
    required RecurringPaymentRule rule,
  }) async {
    // Get the bill
    final billResult = await _billRepository.getById(billId);
    if (billResult.isError) {
      return Result.error(billResult.failureOrNull!);
    }

    final bill = billResult.dataOrNull!;

    // Validate the rule
    final ruleValidation = rule.validate();
    if (ruleValidation.isError) {
      return Result.error(ruleValidation.failureOrNull!);
    }

    // Check for duplicate instance numbers
    if (bill.recurringPaymentRules.any((r) => r.instanceNumber == rule.instanceNumber)) {
      return Result.error(Failure.validation(
        'Duplicate instance number',
        {'instanceNumber': rule.instanceNumber.toString()},
      ));
    }

    // Add the rule
    final updatedRules = [...bill.recurringPaymentRules, rule];
    final updatedBill = bill.copyWith(recurringPaymentRules: updatedRules);

    // Update the bill
    final updateResult = await _billRepository.update(updatedBill);
    if (updateResult.isError) {
      return Result.error(updateResult.failureOrNull!);
    }

    return Result.success(updatedBill);
  }

  /// Update an existing recurring payment rule
  Future<Result<Bill>> updateRecurringPaymentRule({
    required String billId,
    required String ruleId,
    required RecurringPaymentRule updatedRule,
  }) async {
    // Get the bill
    final billResult = await _billRepository.getById(billId);
    if (billResult.isError) {
      return Result.error(billResult.failureOrNull!);
    }

    final bill = billResult.dataOrNull!;

    // Validate the updated rule
    final ruleValidation = updatedRule.validate();
    if (ruleValidation.isError) {
      return Result.error(ruleValidation.failureOrNull!);
    }

    // Find and update the rule
    final updatedRules = bill.recurringPaymentRules.map((rule) {
      return rule.id == ruleId ? updatedRule : rule;
    }).toList();

    // Check if the rule was found
    if (!updatedRules.any((rule) => rule.id == ruleId)) {
      return Result.error(Failure.notFound('Recurring payment rule not found'));
    }

    // Check for duplicate instance numbers (excluding the updated rule)
    final otherRules = updatedRules.where((r) => r.id != ruleId).toList();
    if (otherRules.any((r) => r.instanceNumber == updatedRule.instanceNumber)) {
      return Result.error(Failure.validation(
        'Duplicate instance number',
        {'instanceNumber': updatedRule.instanceNumber.toString()},
      ));
    }

    final updatedBill = bill.copyWith(recurringPaymentRules: updatedRules);

    // Update the bill
    final updateResult = await _billRepository.update(updatedBill);
    if (updateResult.isError) {
      return Result.error(updateResult.failureOrNull!);
    }

    return Result.success(updatedBill);
  }

  /// Remove a recurring payment rule
  Future<Result<Bill>> removeRecurringPaymentRule({
    required String billId,
    required String ruleId,
  }) async {
    // Get the bill
    final billResult = await _billRepository.getById(billId);
    if (billResult.isError) {
      return Result.error(billResult.failureOrNull!);
    }

    final bill = billResult.dataOrNull!;

    // Remove the rule
    final updatedRules = bill.recurringPaymentRules.where((rule) => rule.id != ruleId).toList();

    // Check if the rule was found and removed
    if (updatedRules.length == bill.recurringPaymentRules.length) {
      return Result.error(Failure.notFound('Recurring payment rule not found'));
    }

    final updatedBill = bill.copyWith(recurringPaymentRules: updatedRules);

    // Update the bill
    final updateResult = await _billRepository.update(updatedBill);
    if (updateResult.isError) {
      return Result.error(updateResult.failureOrNull!);
    }

    return Result.success(updatedBill);
  }

  /// Get payment details for a specific instance
  Result<RecurringPaymentDetails> getPaymentDetailsForInstance({
    required Bill bill,
    required int instanceNumber,
  }) {
    // Find the rule for this instance
    final rule = bill.recurringPaymentRules
        .where((rule) => rule.instanceNumber == instanceNumber && rule.isEnabled)
        .firstOrNull;

    if (rule != null) {
      return Result.success(RecurringPaymentDetails(
        instanceNumber: instanceNumber,
        amount: rule.amount ?? bill.amount,
        accountId: rule.accountId ?? bill.effectiveAccountId,
        notes: rule.notes,
        hasCustomAmount: rule.amount != null,
        hasCustomAccount: rule.accountId != null,
      ));
    }

    // No specific rule, use default bill settings
    return Result.success(RecurringPaymentDetails(
      instanceNumber: instanceNumber,
      amount: bill.getPaymentAmountForInstance(instanceNumber),
      accountId: bill.getAccountForInstance(instanceNumber),
      notes: null,
      hasCustomAmount: false,
      hasCustomAccount: false,
    ));
  }

  /// Get all upcoming payment instances with their details
  Result<List<RecurringPaymentDetails>> getUpcomingPaymentSchedule({
    required Bill bill,
    required int numberOfInstances,
  }) {
    final schedule = <RecurringPaymentDetails>[];

    for (int i = 1; i <= numberOfInstances; i++) {
      final detailsResult = getPaymentDetailsForInstance(
        bill: bill,
        instanceNumber: i,
      );

      if (detailsResult.isSuccess) {
        final details = detailsResult.dataOrNull;
        if (details != null) {
          schedule.add(details);
        }
      }
    }

    return Result.success(schedule);
  }

  /// Validate recurring payment rules for a bill
  Result<void> validateRecurringPaymentRules(Bill bill) {
    final rules = bill.recurringPaymentRules;

    // Check for duplicate instance numbers
    final instanceNumbers = <int>{};
    for (final rule in rules) {
      if (instanceNumbers.contains(rule.instanceNumber)) {
        return Result.error(Failure.validation(
          'Duplicate instance number in recurring rules',
          {'instanceNumber': rule.instanceNumber.toString()},
        ));
      }
      instanceNumbers.add(rule.instanceNumber);
    }

    // Validate each rule
    for (final rule in rules) {
      final ruleValidation = rule.validate();
      if (ruleValidation.isError) {
        return Result.error(Failure.validation(
          'Invalid recurring payment rule: ${ruleValidation.failureOrNull!.message}',
          {'ruleId': rule.id},
        ));
      }
    }

    // Check for reasonable instance numbers (not too far in the future)
    const maxReasonableInstances = 100; // Arbitrary limit
    for (final rule in rules) {
      if (rule.instanceNumber > maxReasonableInstances) {
        return Result.error(Failure.validation(
          'Instance number too high',
          {
            'instanceNumber': rule.instanceNumber.toString(),
            'maxAllowed': maxReasonableInstances.toString(),
          },
        ));
      }
    }

    return Result.success(null);
  }

  /// Generate suggested recurring payment rules based on bill history
  Result<List<RecurringPaymentRule>> generateSuggestedRules(Bill bill) {
    final suggestions = <RecurringPaymentRule>[];

    // Analyze payment history for patterns
    final payments = bill.paymentHistory;
    if (payments.length < 3) {
      return Result.success([]); // Need more history for suggestions
    }

    // Look for amount patterns
    final amounts = payments.map((p) => p.amount).toList();
    final uniqueAmounts = amounts.toSet();

    if (uniqueAmounts.length > 1) {
      // Multiple different amounts - suggest rules for different instances
      final sortedAmounts = uniqueAmounts.toList()..sort();

      for (int i = 0; i < sortedAmounts.length && i < 3; i++) {
        // Suggest rules for the first few instances with different amounts
        suggestions.add(RecurringPaymentRule(
          id: 'suggested_amount_${i + 1}',
          instanceNumber: i + 1,
          amount: sortedAmounts[i],
          notes: 'Suggested based on payment history',
          isEnabled: false, // User needs to enable
        ));
      }
    }

    return Result.success(suggestions);
  }
}

/// Details for a specific recurring payment instance
class RecurringPaymentDetails {
  const RecurringPaymentDetails({
    required this.instanceNumber,
    required this.amount,
    required this.accountId,
    required this.notes,
    required this.hasCustomAmount,
    required this.hasCustomAccount,
  });

  final int instanceNumber;
  final double amount;
  final String? accountId;
  final String? notes;
  final bool hasCustomAmount;
  final bool hasCustomAccount;

  String get description {
    final parts = <String>[];

    if (hasCustomAmount) {
      parts.add('Custom amount: \$${amount.toStringAsFixed(2)}');
    } else {
      parts.add('Standard amount: \$${amount.toStringAsFixed(2)}');
    }

    if (hasCustomAccount && accountId != null) {
      parts.add('Custom account: $accountId');
    } else if (accountId != null) {
      parts.add('Default account: $accountId');
    }

    if (notes != null && notes!.isNotEmpty) {
      parts.add('Notes: $notes');
    }

    return parts.join(', ');
  }
}