import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

/// Use case for calculating bills summary for dashboard
class CalculateBillsSummary {
  const CalculateBillsSummary(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<BillsSummary>> call() async {
    try {
      // Get all bills
      final allBillsResult = await _repository.getAll();
      if (allBillsResult.isError) {
        return Result.error(allBillsResult.failureOrNull!);
      }

      final allBills = allBillsResult.dataOrNull ?? [];

      // Get current month bills
      final now = DateTime.now();
      final currentMonth = DateTime(now.year, now.month);

      final currentMonthBills = allBills.where((bill) {
        final billMonth = DateTime(bill.dueDate.year, bill.dueDate.month);
        return billMonth == currentMonth;
      }).toList();

      // Calculate metrics
      final totalBills = allBills.length;
      final paidThisMonth = currentMonthBills.where((bill) => bill.isPaid).length;
      final dueThisMonth = currentMonthBills.length;
      final overdue = allBills.where((bill) => bill.isOverdue).length;

      final totalMonthlyAmount = currentMonthBills.fold<double>(0.0, (sum, bill) => sum + bill.amount);
      final paidAmount = currentMonthBills
          .where((bill) => bill.isPaid)
          .fold<double>(0.0, (sum, bill) => sum + bill.amount);
      final remainingAmount = totalMonthlyAmount - paidAmount;

      // Get upcoming bills (next 30 days)
      final upcomingBillsResult = await _repository.getDueWithin(30);
      if (upcomingBillsResult.isError) {
        return Result.error(upcomingBillsResult.failureOrNull!);
      }

      final upcomingBillsRaw = upcomingBillsResult.dataOrNull ?? [];
      final upcomingBillStatuses = <BillStatus>[];

      for (final bill in upcomingBillsRaw) {
        final statusResult = await _repository.getBillStatus(bill.id);
        if (statusResult.isSuccess) {
          upcomingBillStatuses.add(statusResult.dataOrNull!);
        }
      }

      // Sort upcoming bills by urgency
      upcomingBillStatuses.sort((a, b) {
        // Overdue first
        if (a.isOverdue && !b.isOverdue) return -1;
        if (!a.isOverdue && b.isOverdue) return 1;

        // Then due soon
        if (a.isDueSoon && !b.isDueSoon) return -1;
        if (!a.isDueSoon && b.isDueSoon) return 1;

        // Then by days until due
        return a.daysUntilDue.compareTo(b.daysUntilDue);
      });

      // Take top 5 upcoming bills
      final topUpcomingBills = upcomingBillStatuses.take(5).toList();

      final summary = BillsSummary(
        totalBills: totalBills,
        paidThisMonth: paidThisMonth,
        dueThisMonth: dueThisMonth,
        overdue: overdue,
        totalMonthlyAmount: totalMonthlyAmount,
        paidAmount: paidAmount,
        remainingAmount: remainingAmount,
        upcomingBills: topUpcomingBills,
      );

      return Result.success(summary);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to calculate bills summary: $e'));
    }
  }
}

/// Use case for calculating bill status
class CalculateBillStatus {
  const CalculateBillStatus(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<BillStatus>> call(String billId) async {
    try {
      // Validate bill ID
      if (billId.trim().isEmpty) {
        return Result.error(Failure.validation(
          'Bill ID cannot be empty',
          {'billId': 'ID is required'},
        ));
      }

      // Get bill
      final billResult = await _repository.getById(billId);
      if (billResult.isError) {
        return Result.error(billResult.failureOrNull!);
      }

      final bill = billResult.dataOrNull;
      if (bill == null) {
        return Result.error(Failure.validation(
          'Bill not found',
          {'billId': 'Bill does not exist'},
        ));
      }

      // Calculate status metrics
      final daysUntilDue = bill.daysUntilDue;
      final isOverdue = bill.isOverdue;
      final isDueSoon = bill.isDueSoon;
      final isDueToday = bill.isDueToday;

      // Determine urgency
      final urgency = _calculateUrgency(daysUntilDue, isOverdue, isDueSoon, isDueToday);

      final status = BillStatus(
        bill: bill,
        daysUntilDue: daysUntilDue,
        isOverdue: isOverdue,
        isDueSoon: isDueSoon,
        isDueToday: isDueToday,
        urgency: urgency,
      );

      return Result.success(status);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to calculate bill status: $e'));
    }
  }

  /// Calculate bill urgency level
  BillUrgency _calculateUrgency(int daysUntilDue, bool isOverdue, bool isDueSoon, bool isDueToday) {
    if (isOverdue) return BillUrgency.overdue;
    if (isDueToday) return BillUrgency.dueToday;
    if (isDueSoon) return BillUrgency.dueSoon;
    return BillUrgency.normal;
  }
}

/// Use case for calculating all bills statuses
class CalculateAllBillsStatuses {
  const CalculateAllBillsStatuses(this._repository);

  final BillRepository _repository;

  /// Execute the use case
  Future<Result<List<BillStatus>>> call() async {
    try {
      // Get all bills
      final billsResult = await _repository.getAll();
      if (billsResult.isError) {
        return Result.error(billsResult.failureOrNull!);
      }

      final bills = billsResult.dataOrNull ?? [];
      final statuses = <BillStatus>[];

      // Calculate status for each bill
      for (final bill in bills) {
        final statusResult = await CalculateBillStatus(_repository).call(bill.id);
        if (statusResult.isSuccess) {
          statuses.add(statusResult.dataOrNull!);
        }
      }

      // Sort by urgency and days until due
      statuses.sort((a, b) {
        // Overdue first
        if (a.isOverdue && !b.isOverdue) return -1;
        if (!a.isOverdue && b.isOverdue) return 1;

        // Then due soon
        if (a.isDueSoon && !b.isDueSoon) return -1;
        if (!a.isDueSoon && b.isDueSoon) return 1;

        // Then by days until due
        return a.daysUntilDue.compareTo(b.daysUntilDue);
      });

      return Result.success(statuses);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to calculate all bills statuses: $e'));
    }
  }
}