import '../../../../core/error/result.dart';
import '../entities/bill.dart';

/// Repository interface for bill operations
abstract class BillRepository {
  /// Get all bills
  Future<Result<List<Bill>>> getAll();

  /// Get bill by ID
  Future<Result<Bill?>> getById(String id);

  /// Get bills due within specified days
  Future<Result<List<Bill>>> getDueWithin(int days);

  /// Get overdue bills
  Future<Result<List<Bill>>> getOverdue();

  /// Get paid bills for current month
  Future<Result<List<Bill>>> getPaidThisMonth();

  /// Get unpaid bills for current month
  Future<Result<List<Bill>>> getUnpaidThisMonth();

  /// Add new bill
  Future<Result<Bill>> add(Bill bill);

  /// Update existing bill
  Future<Result<Bill>> update(Bill bill);

  /// Delete bill by ID
  Future<Result<void>> delete(String id);

  /// Mark bill as paid
  Future<Result<Bill>> markAsPaid(String billId, BillPayment payment, {String? accountId});

  /// Mark bill as unpaid
  Future<Result<Bill>> markAsUnpaid(String billId);

  /// Get bill status
  Future<Result<BillStatus>> getBillStatus(String billId);

  /// Get status for all bills
  Future<Result<List<BillStatus>>> getAllBillStatuses();

  /// Get bills summary for dashboard
  Future<Result<BillsSummary>> getBillsSummary();

  /// Update next due date for recurring bill
  Future<Result<Bill>> updateNextDueDate(String billId);

  /// Reconcile bill payment data consistency
  /// Ensures bill status matches associated transactions
  Future<Result<void>> reconcileBillPayments(String billId);

  /// Check if a bill name already exists
  Future<Result<bool>> nameExists(String name, {String? excludeId});
}