import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../entities/recurring_transaction.dart';
import '../repositories/recurring_transaction_repository.dart';

/// Use case for processing recurring transactions and generating actual transactions
class ProcessRecurringTransactions {
  const ProcessRecurringTransactions(
    this._recurringRepository,
    this._transactionRepository,
  );

  final RecurringTransactionRepository _recurringRepository;
  final TransactionRepository _transactionRepository;

  /// Execute the use case - process all due recurring transactions
  Future<Result<List<String>>> call({DateTime? processDate}) async {
    try {
      final now = processDate ?? DateTime.now();

      // Get all active recurring transactions
      final recurringResult = await _recurringRepository.getActiveRecurringTransactions();
      if (recurringResult.isError) {
        return Result.error(recurringResult.failureOrNull!);
      }

      final recurringTransactions = recurringResult.dataOrNull!;
      final processedIds = <String>[];

      for (final recurring in recurringTransactions) {
        // Check if this recurring transaction should be processed today
        if (recurring.shouldProcessOn(now)) {
          final transactionResult = await _createTransactionFromRecurring(recurring, now);
          if (transactionResult.isSuccess) {
            processedIds.add(recurring.id);

            // Update last processed date
            await _recurringRepository.updateLastProcessedDate(recurring.id, now);
          }
        }
      }

      return Result.success(processedIds);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to process recurring transactions: $e'));
    }
  }

  /// Create a regular transaction from a recurring transaction
  Future<Result<Transaction>> _createTransactionFromRecurring(
    RecurringTransaction recurring,
    DateTime processDate,
  ) async {
    // Create the transaction
    final transaction = Transaction(
      id: _generateTransactionId(),
      title: recurring.title,
      amount: recurring.amount,
      type: TransactionType.expense, // Recurring transactions are typically expenses
      date: processDate,
      categoryId: recurring.categoryId,
      accountId: recurring.accountId,
      description: recurring.description,
      tags: recurring.tags,
      currencyCode: recurring.currencyCode,
    );

    // Add to transaction repository
    return await _transactionRepository.add(transaction);
  }

  /// Generate a unique transaction ID
  String _generateTransactionId() {
    return 'txn_recurring_${DateTime.now().millisecondsSinceEpoch}';
  }
}