import 'package:hive/hive.dart';

import '../models/debt_dto.dart';

/// Hive data source for debt operations
abstract class DebtHiveDataSource {
  /// Initialize the data source
  Future<void> init();

  /// Get all debts
  Future<List<DebtDto>> getAll();

  /// Get debt by ID
  Future<DebtDto?> getById(String id);

  /// Add new debt
  Future<DebtDto> add(DebtDto debt);

  /// Update existing debt
  Future<DebtDto> update(DebtDto debt);

  /// Delete debt by ID
  Future<void> delete(String id);

  /// Search debts
  Future<List<DebtDto>> search(String query);

  /// Get debt count
  Future<int> getCount();
}

/// Implementation of DebtHiveDataSource
class DebtHiveDataSourceImpl implements DebtHiveDataSource {
  static const String _boxName = 'debts';
  Box<DebtDto>? _box;

  @override
  Future<void> init() async {
    _box = await Hive.openBox<DebtDto>(_boxName);
  }

  @override
  Future<List<DebtDto>> getAll() async {
    _ensureInitialized();
    return _box!.values.toList();
  }

  @override
  Future<DebtDto?> getById(String id) async {
    _ensureInitialized();
    return _box!.get(id);
  }

  @override
  Future<DebtDto> add(DebtDto debt) async {
    _ensureInitialized();
    await _box!.put(debt.id, debt);
    return debt;
  }

  @override
  Future<DebtDto> update(DebtDto debt) async {
    _ensureInitialized();
    await _box!.put(debt.id, debt);
    return debt;
  }

  @override
  Future<void> delete(String id) async {
    _ensureInitialized();
    await _box!.delete(id);
  }

  @override
  Future<List<DebtDto>> search(String query) async {
    _ensureInitialized();
    final lowerQuery = query.toLowerCase();
    return _box!.values.where((debt) {
      return debt.name.toLowerCase().contains(lowerQuery) ||
             debt.description.toLowerCase().contains(lowerQuery) ||
             debt.creditor?.toLowerCase().contains(lowerQuery) == true;
    }).toList();
  }

  @override
  Future<int> getCount() async {
    _ensureInitialized();
    return _box!.length;
  }

  void _ensureInitialized() {
    if (_box == null) {
      throw Exception('Debt data source not initialized');
    }
  }
}