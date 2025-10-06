import '../../../../core/error/result.dart';
import '../entities/debt.dart';

/// Repository interface for debt operations
/// Defines the contract for debt data access
abstract class DebtRepository {
  /// Get all debts
  Future<Result<List<Debt>>> getAll();

  /// Get debt by ID
  Future<Result<Debt?>> getById(String id);

  /// Get active debts (not paid off)
  Future<Result<List<Debt>>> getActive();

  /// Get debts by type
  Future<Result<List<Debt>>> getByType(DebtType type);

  /// Get debts by priority
  Future<Result<List<Debt>>> getByPriority(DebtPriority priority);

  /// Get overdue debts
  Future<Result<List<Debt>>> getOverdue();

  /// Add new debt
  Future<Result<Debt>> add(Debt debt);

  /// Update existing debt
  Future<Result<Debt>> update(Debt debt);

  /// Delete debt by ID
  Future<Result<void>> delete(String id);

  /// Make a payment towards a debt
  Future<Result<Debt>> makePayment(String debtId, double amount, DateTime date);

  /// Get debt summary statistics
  Future<Result<DebtSummary>> getSummary();

  /// Search debts by name or description
  Future<Result<List<Debt>>> search(String query);

  /// Get debt count
  Future<Result<int>> getCount();
}

/// Debt summary statistics
class DebtSummary {
  const DebtSummary({
    required this.totalDebts,
    required this.activeDebts,
    required this.totalAmount,
    required this.remainingAmount,
    required this.overdueDebts,
    required this.monthlyPayments,
  });

  final int totalDebts;
  final int activeDebts;
  final double totalAmount;
  final double remainingAmount;
  final int overdueDebts;
  final double monthlyPayments;

  double get payoffProgress {
    if (totalAmount <= 0) return 1.0;
    return ((totalAmount - remainingAmount) / totalAmount).clamp(0.0, 1.0);
  }

  String get formattedTotalAmount => '\$${totalAmount.toStringAsFixed(2)}';
  String get formattedRemainingAmount => '\$${remainingAmount.toStringAsFixed(2)}';
  String get formattedMonthlyPayments => '\$${monthlyPayments.toStringAsFixed(2)}';
}