import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../../core/storage/hive_storage.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../models/bill_dto.dart';
import '../../domain/entities/bill.dart';

/// Hive-based data source for bill operations
class BillHiveDataSource {
  static const String _boxName = 'bills';

  Box<BillDto>? _box;

  /// Initialize the data source
  Future<void> init() async {
    try {
      debugPrint('BillHiveDataSource: Starting initialization...');

      // Wait for Hive to be initialized
      await HiveStorage.init();
      debugPrint('BillHiveDataSource: Hive storage initialized');

      // Register adapters if not already registered
      if (!Hive.isAdapterRegistered(6)) {
        Hive.registerAdapter(BillDtoAdapter());
        debugPrint('BillHiveDataSource: BillDtoAdapter registered');
      }
      if (!Hive.isAdapterRegistered(7)) {
        Hive.registerAdapter(BillPaymentDtoAdapter());
        debugPrint('BillHiveDataSource: BillPaymentDtoAdapter registered');
      }

      // Handle box opening with proper type checking
      if (!Hive.isBoxOpen(_boxName)) {
        debugPrint('BillHiveDataSource: Opening new box $_boxName');
        _box = await Hive.openBox<BillDto>(_boxName);
      } else {
        debugPrint('BillHiveDataSource: Box $_boxName already open, getting reference');
        try {
          _box = Hive.box<BillDto>(_boxName);
        } catch (e) {
          // If the box is already open with wrong type, close and reopen
          debugPrint('BillHiveDataSource: Box type mismatch, reopening: $e');
          if (e.toString().contains('Box<dynamic>')) {
            await Hive.box(_boxName).close();
            _box = await Hive.openBox<BillDto>(_boxName);
          } else {
            rethrow;
          }
        }
      }

      debugPrint('BillHiveDataSource: Initialization completed successfully, _box is null: ${_box == null}');
    } catch (e) {
      debugPrint('BillHiveDataSource: Initialization failed: $e');
      rethrow;
    }
  }

  /// Get all bills
  Future<Result<List<Bill>>> getAll() async {
    try {
      // Initialize if not already done
      if (_box == null) {
        debugPrint('BillHiveDataSource: getAll called but _box is null - initializing data source');
        await init();
      }

      final dtos = _box!.values.toList();
      final bills = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by due date (soonest first)
      bills.sort((a, b) => a.dueDate.compareTo(b.dueDate));

      return Result.success(bills);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get bills: $e'));
    }
  }

  /// Get bill by ID
  Future<Result<Bill?>> getById(String id) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = _box!.get(id);
      if (dto == null) {
        return Result.success(null);
      }

      return Result.success(dto.toDomain());
    } catch (e) {
      return Result.error(Failure.cache('Failed to get bill: $e'));
    }
  }

  /// Get bills due within specified days
  Future<Result<List<Bill>>> getDueWithin(int days) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final now = DateTime.now();
      final futureDate = now.add(Duration(days: days));

      final dtos = _box!.values.where((dto) {
        return dto.dueDate.isAfter(now.subtract(const Duration(days: 1))) &&
               dto.dueDate.isBefore(futureDate.add(const Duration(days: 1)));
      }).toList();

      final bills = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by due date (soonest first)
      bills.sort((a, b) => a.dueDate.compareTo(b.dueDate));

      return Result.success(bills);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get bills due within $days days: $e'));
    }
  }

  /// Get overdue bills
  Future<Result<List<Bill>>> getOverdue() async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final now = DateTime.now();
      final dtos = _box!.values.where((dto) {
        return dto.dueDate.isBefore(now) && !dto.isPaid;
      }).toList();

      final bills = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by due date (oldest first)
      bills.sort((a, b) => a.dueDate.compareTo(b.dueDate));

      return Result.success(bills);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get overdue bills: $e'));
    }
  }

  /// Get paid bills for current month
  Future<Result<List<Bill>>> getPaidThisMonth() async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final now = DateTime.now();
      final currentMonth = DateTime(now.year, now.month);

      final dtos = _box!.values.where((dto) {
        if (!dto.isPaid || dto.lastPaidDate == null) return false;
        final paidMonth = DateTime(dto.lastPaidDate!.year, dto.lastPaidDate!.month);
        return paidMonth == currentMonth;
      }).toList();

      final bills = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by payment date (newest first)
      bills.sort((a, b) => b.lastPaidDate!.compareTo(a.lastPaidDate!));

      return Result.success(bills);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get paid bills this month: $e'));
    }
  }

  /// Get unpaid bills for current month
  Future<Result<List<Bill>>> getUnpaidThisMonth() async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final now = DateTime.now();
      final currentMonth = DateTime(now.year, now.month);

      final dtos = _box!.values.where((dto) {
        final billMonth = DateTime(dto.dueDate.year, dto.dueDate.month);
        return billMonth == currentMonth && !dto.isPaid;
      }).toList();

      final bills = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by due date (soonest first)
      bills.sort((a, b) => a.dueDate.compareTo(b.dueDate));

      return Result.success(bills);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get unpaid bills this month: $e'));
    }
  }

  /// Add new bill
  Future<Result<Bill>> add(Bill bill) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = BillDto.fromDomain(bill);
      await _box!.put(bill.id, dto);

      return Result.success(bill);
    } catch (e) {
      return Result.error(Failure.cache('Failed to add bill: $e'));
    }
  }

  /// Update existing bill
  Future<Result<Bill>> update(Bill bill) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = BillDto.fromDomain(bill);
      await _box!.put(bill.id, dto);

      return Result.success(bill);
    } catch (e) {
      return Result.error(Failure.cache('Failed to update bill: $e'));
    }
  }

  /// Delete bill by ID
  Future<Result<void>> delete(String id) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      await _box!.delete(id);
      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.cache('Failed to delete bill: $e'));
    }
  }

  /// Mark bill as paid
  Future<Result<Bill>> markAsPaid(String billId, BillPayment payment, TransactionRepository transactionRepository) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = _box!.get(billId);
      if (dto == null) {
        return Result.error(Failure.cache('Bill not found'));
      }

      // Update bill status
      dto.isPaid = true;
      dto.lastPaidDate = payment.paymentDate;

      // Add payment to history
      dto.paymentHistory ??= [];
      dto.paymentHistory!.add(BillPaymentDto.fromDomain(payment));

      // Update next due date for recurring bills
      if (dto.frequency != BillFrequency.custom.name) {
        final frequency = BillFrequency.values.firstWhere(
          (e) => e.name == dto.frequency,
          orElse: () => BillFrequency.monthly,
        );
        dto.nextDueDate = _calculateNextDueDate(dto.dueDate, frequency);
      }

      await _box!.put(billId, dto);

      // Create corresponding expense transaction
      // Transaction creation is critical for balance integrity - fail if it doesn't work
      final transaction = Transaction(
        id: 'bill_${billId}_${payment.id}',
        title: 'Bill payment: ${dto.name}', // Required title field
        amount: payment.amount,
        categoryId: dto.categoryId, // Use bill's actual category
        date: payment.paymentDate,
        type: TransactionType.expense,
        accountId: dto.accountId, // Use bill's account (can be null for income bills)
        description: 'Payment for ${dto.name}', // Optional description
      );

      final transactionResult = await transactionRepository.add(transaction);
      if (transactionResult.isSuccess) {
        // Update payment with transaction ID for reference
        final paymentIndex = dto.paymentHistory!.indexWhere((p) => p.id == payment.id);
        if (paymentIndex != -1) {
          dto.paymentHistory![paymentIndex].transactionId = transaction.id;
          await _box!.put(billId, dto);
        }
      } else {
        // Transaction creation failed - this is a critical error for balance integrity
        // We should not mark the bill as paid if transaction creation fails
        return Result.error(Failure.cache(
          'Failed to create transaction for bill payment: ${transactionResult.failureOrNull?.message}'
        ));
      }

      return Result.success(dto.toDomain());
    } catch (e) {
      return Result.error(Failure.cache('Failed to mark bill as paid: $e'));
    }
  }

  /// Mark bill as unpaid
  Future<Result<Bill>> markAsUnpaid(String billId, TransactionRepository transactionRepository) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = _box!.get(billId);
      if (dto == null) {
        return Result.error(Failure.cache('Bill not found'));
      }

      // Find and delete associated transactions from payment history
      if (dto.paymentHistory != null) {
        for (final payment in dto.paymentHistory!) {
          if (payment.transactionId != null) {
            // Delete the associated transaction
            await transactionRepository.delete(payment.transactionId!);
            // Clear the transaction ID reference
            payment.transactionId = null;
          }
        }
      }

      dto.isPaid = false;
      dto.lastPaidDate = null;

      await _box!.put(billId, dto);

      return Result.success(dto.toDomain());
    } catch (e) {
      return Result.error(Failure.cache('Failed to mark bill as unpaid: $e'));
    }
  }

  /// Update next due date for recurring bill
  Future<Result<Bill>> updateNextDueDate(String billId) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = _box!.get(billId);
      if (dto == null) {
        return Result.error(Failure.cache('Bill not found'));
      }

      final frequency = BillFrequency.values.firstWhere(
        (e) => e.name == dto.frequency,
        orElse: () => BillFrequency.monthly,
      );

      dto.nextDueDate = _calculateNextDueDate(dto.dueDate, frequency);
      dto.isPaid = false; // Reset payment status for next cycle

      await _box!.put(billId, dto);

      return Result.success(dto.toDomain());
    } catch (e) {
      return Result.error(Failure.cache('Failed to update next due date: $e'));
    }
  }

  /// Calculate next due date based on frequency
  DateTime _calculateNextDueDate(DateTime currentDueDate, BillFrequency frequency) {
    switch (frequency) {
      case BillFrequency.weekly:
        return currentDueDate.add(const Duration(days: 7));
      case BillFrequency.biWeekly:
        return currentDueDate.add(const Duration(days: 14));
      case BillFrequency.monthly:
        return DateTime(currentDueDate.year, currentDueDate.month + 1, currentDueDate.day);
      case BillFrequency.quarterly:
        return DateTime(currentDueDate.year, currentDueDate.month + 3, currentDueDate.day);
      case BillFrequency.annually:
        return DateTime(currentDueDate.year + 1, currentDueDate.month, currentDueDate.day);
      case BillFrequency.custom:
        return currentDueDate; // Custom logic needed
    }
  }

  /// Close the box
  Future<void> close() async {
    await _box?.close();
    _box = null;
  }
}