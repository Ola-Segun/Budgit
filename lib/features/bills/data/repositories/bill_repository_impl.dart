import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/bill.dart';
import '../../domain/repositories/bill_repository.dart';
import '../datasources/bill_hive_datasource.dart';

/// Implementation of BillRepository using Hive data source
class BillRepositoryImpl implements BillRepository {
  const BillRepositoryImpl(this._dataSource);

  final BillHiveDataSource _dataSource;

  @override
  Future<Result<List<Bill>>> getAll() => _dataSource.getAll();

  @override
  Future<Result<Bill?>> getById(String id) => _dataSource.getById(id);

  @override
  Future<Result<List<Bill>>> getDueWithin(int days) => _dataSource.getDueWithin(days);

  @override
  Future<Result<List<Bill>>> getOverdue() => _dataSource.getOverdue();

  @override
  Future<Result<List<Bill>>> getPaidThisMonth() => _dataSource.getPaidThisMonth();

  @override
  Future<Result<List<Bill>>> getUnpaidThisMonth() => _dataSource.getUnpaidThisMonth();

  @override
  Future<Result<Bill>> add(Bill bill) => _dataSource.add(bill);

  @override
  Future<Result<Bill>> update(Bill bill) => _dataSource.update(bill);

  @override
  Future<Result<void>> delete(String id) => _dataSource.delete(id);

  @override
  Future<Result<Bill>> markAsPaid(String billId, BillPayment payment) =>
      _dataSource.markAsPaid(billId, payment);

  @override
  Future<Result<Bill>> markAsUnpaid(String billId) => _dataSource.markAsUnpaid(billId);

  @override
  Future<Result<BillStatus>> getBillStatus(String billId) async {
    final billResult = await _dataSource.getById(billId);
    if (billResult.isError) {
      return Result.error(billResult.failureOrNull!);
    }

    final bill = billResult.dataOrNull;
    if (bill == null) {
      return Result.error(Failure.validation('Bill not found', {'billId': 'Bill does not exist'}));
    }

    // Calculate status (this logic could be moved to a use case)
    final daysUntilDue = bill.daysUntilDue;
    final isOverdue = bill.isOverdue;
    final isDueSoon = bill.isDueSoon;
    final isDueToday = bill.isDueToday;

    BillUrgency urgency;
    if (isOverdue) {
      urgency = BillUrgency.overdue;
    } else if (isDueToday) {
      urgency = BillUrgency.dueToday;
    } else if (isDueSoon) {
      urgency = BillUrgency.dueSoon;
    } else {
      urgency = BillUrgency.normal;
    }

    final status = BillStatus(
      bill: bill,
      daysUntilDue: daysUntilDue,
      isOverdue: isOverdue,
      isDueSoon: isDueSoon,
      isDueToday: isDueToday,
      urgency: urgency,
    );

    return Result.success(status);
  }

  @override
  Future<Result<List<BillStatus>>> getAllBillStatuses() async {
    final billsResult = await _dataSource.getAll();
    if (billsResult.isError) {
      return Result.error(billsResult.failureOrNull!);
    }

    final bills = billsResult.dataOrNull ?? [];
    final statuses = <BillStatus>[];

    for (final bill in bills) {
      final statusResult = await getBillStatus(bill.id);
      if (statusResult.isSuccess) {
        statuses.add(statusResult.dataOrNull!);
      }
    }

    // Sort by urgency
    statuses.sort((a, b) {
      if (a.isOverdue && !b.isOverdue) return -1;
      if (!a.isOverdue && b.isOverdue) return 1;
      if (a.isDueSoon && !b.isDueSoon) return -1;
      if (!a.isDueSoon && b.isDueSoon) return 1;
      return a.daysUntilDue.compareTo(b.daysUntilDue);
    });

    return Result.success(statuses);
  }

  @override
  Future<Result<BillsSummary>> getBillsSummary() async {
    final allBillsResult = await _dataSource.getAll();
    if (allBillsResult.isError) {
      return Result.error(allBillsResult.failureOrNull!);
    }

    final allBills = allBillsResult.dataOrNull ?? [];
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);

    // Calculate metrics
    final totalBills = allBills.length;
    final currentMonthBills = allBills.where((bill) {
      final billMonth = DateTime(bill.dueDate.year, bill.dueDate.month);
      return billMonth == currentMonth;
    }).toList();

    final paidThisMonth = currentMonthBills.where((bill) => bill.isPaid).length;
    final dueThisMonth = currentMonthBills.length;
    final overdue = allBills.where((bill) => bill.isOverdue).length;

    final totalMonthlyAmount = currentMonthBills.fold<double>(0.0, (sum, bill) => sum + bill.amount);
    final paidAmount = currentMonthBills.where((bill) => bill.isPaid).fold<double>(0.0, (sum, bill) => sum + bill.amount);
    final remainingAmount = totalMonthlyAmount - paidAmount;

    // Get upcoming bills
    final upcomingBillsResult = await _dataSource.getDueWithin(30);
    if (upcomingBillsResult.isError) {
      return Result.error(upcomingBillsResult.failureOrNull!);
    }

    final upcomingBillsRaw = upcomingBillsResult.dataOrNull ?? [];
    final upcomingBillStatuses = <BillStatus>[];

    for (final bill in upcomingBillsRaw.take(5)) {
      final statusResult = await getBillStatus(bill.id);
      if (statusResult.isSuccess) {
        upcomingBillStatuses.add(statusResult.dataOrNull!);
      }
    }

    final summary = BillsSummary(
      totalBills: totalBills,
      paidThisMonth: paidThisMonth,
      dueThisMonth: dueThisMonth,
      overdue: overdue,
      totalMonthlyAmount: totalMonthlyAmount,
      paidAmount: paidAmount,
      remainingAmount: remainingAmount,
      upcomingBills: upcomingBillStatuses,
    );

    return Result.success(summary);
  }

  @override
  Future<Result<Bill>> updateNextDueDate(String billId) => _dataSource.updateNextDueDate(billId);
}