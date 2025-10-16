import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/bill.dart';
import '../../domain/usecases/calculate_bills_summary.dart';
import '../../domain/usecases/create_bill.dart';
import '../../domain/usecases/delete_bill.dart';
import '../../domain/usecases/get_bills.dart';
import '../../domain/usecases/get_upcoming_bills.dart';
import '../../domain/usecases/mark_bill_as_paid.dart';
import '../../domain/usecases/update_bill.dart';
import '../states/bill_state.dart';

/// State notifier for bill management
class BillNotifier extends StateNotifier<BillState> {
  final GetBills _getBills;
  final CreateBill _createBill;
  final UpdateBill _updateBill;
  final DeleteBill _deleteBill;
  final CalculateBillsSummary _calculateBillsSummary;
  final MarkBillAsPaid _markBillAsPaid;
  final GetUpcomingBills _getUpcomingBills;

  BillNotifier({
    required GetBills getBills,
    required CreateBill createBill,
    required UpdateBill updateBill,
    required DeleteBill deleteBill,
    required CalculateBillsSummary calculateBillsSummary,
    required MarkBillAsPaid markBillAsPaid,
    required GetUpcomingBills getUpcomingBills,
  })  : _getBills = getBills,
        _createBill = createBill,
        _updateBill = updateBill,
        _deleteBill = deleteBill,
        _calculateBillsSummary = calculateBillsSummary,
        _markBillAsPaid = markBillAsPaid,
        _getUpcomingBills = getUpcomingBills,
        super(const BillState.initial()) {
    loadBills();
  }

  /// Load all bills and summary
  Future<void> loadBills() async {
    state = const BillState.loading();

    final billsResult = await _getBills();
    final summaryResult = await _calculateBillsSummary();

    if (billsResult.isSuccess && summaryResult.isSuccess) {
      state = BillState.loaded(
        bills: billsResult.dataOrNull ?? [],
        summary: summaryResult.dataOrNull!,
      );
    } else {
      final errorMessage = billsResult.failureOrNull?.message ??
                          summaryResult.failureOrNull?.message ??
                          'Failed to load bills';
      state = BillState.error(message: errorMessage);
    }
  }

  /// Create a new bill
  Future<bool> createBill(Bill bill) async {
    final result = await _createBill(bill);

    return result.when(
      success: (createdBill) {
        state = BillState.billSaved(bill: createdBill);
        loadBills(); // Refresh the list
        return true;
      },
      error: (failure) {
        state = BillState.error(message: failure.message);
        return false;
      },
    );
  }

  /// Update an existing bill
  Future<bool> updateBill(Bill bill) async {
    final result = await _updateBill(bill);

    return result.when(
      success: (updatedBill) {
        state = BillState.billSaved(bill: updatedBill);
        loadBills(); // Refresh the list
        return true;
      },
      error: (failure) {
        state = BillState.error(message: failure.message);
        return false;
      },
    );
  }

  /// Delete a bill
  Future<bool> deleteBill(String billId) async {
    final result = await _deleteBill(billId);

    return result.when(
      success: (_) {
        state = const BillState.billDeleted();
        loadBills(); // Refresh the list
        return true;
      },
      error: (failure) {
        state = BillState.error(message: failure.message);
        return false;
      },
    );
  }

  /// Mark bill as paid
  Future<bool> markBillAsPaid(String billId, BillPayment payment, {String? accountId}) async {
    final result = await _markBillAsPaid(billId, payment, accountId: accountId);

    return result.when(
      success: (updatedBill) {
        state = BillState.paymentMarked(bill: updatedBill);
        loadBills(); // Refresh the list
        return true;
      },
      error: (failure) {
        state = BillState.error(message: failure.message);
        return false;
      },
    );
  }

  /// Load upcoming bills
  Future<void> loadUpcomingBills({int days = 30}) async {
    state = const BillState.loading();

    final result = await _getUpcomingBills(daysAhead: days);

    result.when(
      success: (bills) {
        // For now, just load all bills again
        // In a more complex implementation, we might have separate state for upcoming bills
        loadBills();
      },
      error: (failure) {
        state = BillState.error(message: failure.message);
      },
    );
  }

  /// Refresh bills data
  Future<void> refresh() async {
    await loadBills();
  }

  Future<void> clearError() async {
  // Simply reload the bills to clear the error state
  await loadBills();
}
}