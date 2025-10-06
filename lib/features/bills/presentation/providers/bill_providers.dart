import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/bill.dart';
import '../../domain/usecases/calculate_bills_summary.dart';
import '../../domain/usecases/create_bill.dart';
import '../../domain/usecases/get_bills.dart';
import '../../domain/usecases/update_bill.dart';
import '../notifiers/bill_notifier.dart';
import '../states/bill_state.dart';

/// Provider for GetBills use case
final getBillsProvider = Provider<GetBills>((ref) {
  // TODO: Replace with actual DI when available
  throw UnimplementedError('DI not implemented yet');
});

/// Provider for CreateBill use case
final createBillProvider = Provider<CreateBill>((ref) {
  // TODO: Replace with actual DI when available
  throw UnimplementedError('DI not implemented yet');
});

/// Provider for UpdateBill use case
final updateBillProvider = Provider<UpdateBill>((ref) {
  // TODO: Replace with actual DI when available
  throw UnimplementedError('DI not implemented yet');
});

/// Provider for DeleteBill use case
final deleteBillProvider = Provider<DeleteBill>((ref) {
  // TODO: Replace with actual DI when available
  throw UnimplementedError('DI not implemented yet');
});

/// Provider for CalculateBillsSummary use case
final calculateBillsSummaryProvider = Provider<CalculateBillsSummary>((ref) {
  // TODO: Replace with actual DI when available
  throw UnimplementedError('DI not implemented yet');
});

/// Provider for MarkBillAsPaid use case
final markBillAsPaidProvider = Provider<MarkBillAsPaid>((ref) {
  // TODO: Replace with actual DI when available
  throw UnimplementedError('DI not implemented yet');
});

/// Provider for GetUpcomingBills use case
final getUpcomingBillsProvider = Provider<GetUpcomingBills>((ref) {
  // TODO: Replace with actual DI when available
  throw UnimplementedError('DI not implemented yet');
});

/// State notifier provider for bill state management
final billNotifierProvider = StateNotifierProvider<BillNotifier, BillState>((ref) {
  final getBills = ref.watch(getBillsProvider);
  final createBill = ref.watch(createBillProvider);
  final updateBill = ref.watch(updateBillProvider);
  final deleteBill = ref.watch(deleteBillProvider);
  final calculateBillsSummary = ref.watch(calculateBillsSummaryProvider);
  final markBillAsPaid = ref.watch(markBillAsPaidProvider);
  final getUpcomingBills = ref.watch(getUpcomingBillsProvider);

  return BillNotifier(
    getBills: getBills,
    createBill: createBill,
    updateBill: updateBill,
    deleteBill: deleteBill,
    calculateBillsSummary: calculateBillsSummary,
    markBillAsPaid: markBillAsPaid,
    getUpcomingBills: getUpcomingBills,
  );
});

/// Provider for bills summary
final billsSummaryProvider = Provider<BillsSummary?>((ref) {
  final billState = ref.watch(billNotifierProvider);

  return billState.maybeWhen(
    loaded: (bills, summary) => summary,
    orElse: () => null,
  );
});

/// Provider for upcoming bills
final upcomingBillsProvider = Provider<List<BillStatus>>((ref) {
  final billState = ref.watch(billNotifierProvider);

  return billState.maybeWhen(
    loaded: (bills, summary) => summary.upcomingBills,
    orElse: () => [],
  );
});

/// Provider for overdue bills count
final overdueBillsCountProvider = Provider<int>((ref) {
  final summary = ref.watch(billsSummaryProvider);
  return summary?.overdue ?? 0;
});

/// Provider for total monthly bills amount
final totalMonthlyBillsProvider = Provider<double>((ref) {
  final summary = ref.watch(billsSummaryProvider);
  return summary?.totalMonthlyAmount ?? 0.0;
});