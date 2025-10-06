import '../../domain/entities/debt.dart';
import '../../domain/repositories/debt_repository.dart';
import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../datasources/debt_hive_datasource.dart';
import '../models/debt_dto.dart';

/// Implementation of DebtRepository using Hive data source
class DebtRepositoryImpl implements DebtRepository {
  const DebtRepositoryImpl(this._dataSource);

  final DebtHiveDataSource _dataSource;

  @override
  Future<Result<List<Debt>>> getAll() async {
    try {
      final dtos = await _dataSource.getAll();
      final debts = dtos.map((dto) => dto.toDomain()).toList();
      return Result.success(debts);
    } catch (e) {
      return Result.error(CacheFailure('Failed to load debts: $e'));
    }
  }

  @override
  Future<Result<Debt?>> getById(String id) async {
    try {
      final dto = await _dataSource.getById(id);
      final debt = dto?.toDomain();
      return Result.success(debt);
    } catch (e) {
      return Result.error(CacheFailure('Failed to load debt: $e'));
    }
  }

  @override
  Future<Result<List<Debt>>> getActive() async {
    try {
      final dtos = await _dataSource.getAll();
      final activeDebts = dtos
          .map((dto) => dto.toDomain())
          .where((debt) => !debt.isPaidOff)
          .toList();
      return Result.success(activeDebts);
    } catch (e) {
      return Result.error(CacheFailure('Failed to load active debts: $e'));
    }
  }

  @override
  Future<Result<List<Debt>>> getByType(DebtType type) async {
    try {
      final dtos = await _dataSource.getAll();
      final filteredDebts = dtos
          .map((dto) => dto.toDomain())
          .where((debt) => debt.type == type)
          .toList();
      return Result.success(filteredDebts);
    } catch (e) {
      return Result.error(CacheFailure('Failed to load debts by type: $e'));
    }
  }

  @override
  Future<Result<List<Debt>>> getByPriority(DebtPriority priority) async {
    try {
      final dtos = await _dataSource.getAll();
      final filteredDebts = dtos
          .map((dto) => dto.toDomain())
          .where((debt) => debt.priority == priority)
          .toList();
      return Result.success(filteredDebts);
    } catch (e) {
      return Result.error(CacheFailure('Failed to load debts by priority: $e'));
    }
  }

  @override
  Future<Result<List<Debt>>> getOverdue() async {
    try {
      final dtos = await _dataSource.getAll();
      final overdueDebts = dtos
          .map((dto) => dto.toDomain())
          .where((debt) => debt.isOverdue)
          .toList();
      return Result.success(overdueDebts);
    } catch (e) {
      return Result.error(CacheFailure('Failed to load overdue debts: $e'));
    }
  }

  @override
  Future<Result<Debt>> add(Debt debt) async {
    try {
      final dto = DebtDto.fromDomain(debt);
      final savedDto = await _dataSource.add(dto);
      final savedDebt = savedDto.toDomain();
      return Result.success(savedDebt);
    } catch (e) {
      return Result.error(CacheFailure('Failed to add debt: $e'));
    }
  }

  @override
  Future<Result<Debt>> update(Debt debt) async {
    try {
      final dto = DebtDto.fromDomain(debt);
      final updatedDto = await _dataSource.update(dto);
      final updatedDebt = updatedDto.toDomain();
      return Result.success(updatedDebt);
    } catch (e) {
      return Result.error(CacheFailure('Failed to update debt: $e'));
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await _dataSource.delete(id);
      return const Result.success(null);
    } catch (e) {
      return Result.error(CacheFailure('Failed to delete debt: $e'));
    }
  }

  @override
  Future<Result<Debt>> makePayment(String debtId, double amount, DateTime date) async {
    try {
      final dto = await _dataSource.getById(debtId);
      if (dto == null) {
        return Result.error(NotFoundFailure('Debt not found'));
      }

      final debt = dto.toDomain();
      final newRemainingAmount = (debt.remainingAmount - amount).clamp(0.0, double.infinity);

      final updatedDebt = debt.copyWith(
        remainingAmount: newRemainingAmount,
        updatedAt: DateTime.now(),
      );

      final updatedDto = DebtDto.fromDomain(updatedDebt);
      final savedDto = await _dataSource.update(updatedDto);
      final savedDebt = savedDto.toDomain();

      return Result.success(savedDebt);
    } catch (e) {
      return Result.error(CacheFailure('Failed to make payment: $e'));
    }
  }

  @override
  Future<Result<DebtSummary>> getSummary() async {
    try {
      final dtos = await _dataSource.getAll();
      final debts = dtos.map((dto) => dto.toDomain()).toList();

      final totalDebts = debts.length;
      final activeDebts = debts.where((debt) => !debt.isPaidOff).length;
      final totalAmount = debts.fold<double>(0, (sum, debt) => sum + debt.amount);
      final remainingAmount = debts.fold<double>(0, (sum, debt) => sum + debt.remainingAmount);
      final overdueDebts = debts.where((debt) => debt.isOverdue).length;
      final monthlyPayments = debts.fold<double>(
        0,
        (sum, debt) => sum + debt.totalMonthlyPayment,
      );

      final summary = DebtSummary(
        totalDebts: totalDebts,
        activeDebts: activeDebts,
        totalAmount: totalAmount,
        remainingAmount: remainingAmount,
        overdueDebts: overdueDebts,
        monthlyPayments: monthlyPayments,
      );

      return Result.success(summary);
    } catch (e) {
      return Result.error(CacheFailure('Failed to get debt summary: $e'));
    }
  }

  @override
  Future<Result<List<Debt>>> search(String query) async {
    try {
      final dtos = await _dataSource.search(query);
      final debts = dtos.map((dto) => dto.toDomain()).toList();
      return Result.success(debts);
    } catch (e) {
      return Result.error(CacheFailure('Failed to search debts: $e'));
    }
  }

  @override
  Future<Result<int>> getCount() async {
    try {
      final count = await _dataSource.getCount();
      return Result.success(count);
    } catch (e) {
      return Result.error(CacheFailure('Failed to get debt count: $e'));
    }
  }
}