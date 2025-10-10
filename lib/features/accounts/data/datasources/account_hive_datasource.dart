import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../../core/storage/hive_storage.dart';
import '../models/account_dto.dart';
import '../../domain/entities/account.dart';

/// Hive-based data source for account operations
class AccountHiveDataSource {
  static const String _boxName = 'accounts';

  Box<AccountDto>? _box;

  /// Initialize the data source
  Future<void> init() async {
    try {
      // Wait for Hive to be initialized
      await HiveStorage.init();

      // Register adapter if not already registered
      if (!Hive.isAdapterRegistered(8)) {
        Hive.registerAdapter(AccountDtoAdapter());
      }

      // Handle box opening with proper type checking
      if (!Hive.isBoxOpen(_boxName)) {
        _box = await Hive.openBox<AccountDto>(_boxName);
      } else {
        try {
          _box = Hive.box<AccountDto>(_boxName);
        } catch (e) {
          // If the box is already open with wrong type, close and reopen
          if (e.toString().contains('Box<dynamic>')) {
            await Hive.box(_boxName).close();
            _box = await Hive.openBox<AccountDto>(_boxName);
          } else {
            rethrow;
          }
        }
      }

      // Try to read all values to check for serialization issues
      if (_box != null) {
        final values = _box!.values.toList();
        for (final dto in values) {
          try {
            dto.toDomain(); // This will trigger deserialization
          } catch (e) {
            debugPrint('Error deserializing account DTO: $e');
            debugPrint('DTO data: ${dto.toString()}');
            // Clear the box if deserialization fails due to incompatible data
            debugPrint('Clearing account box due to incompatible data');
            await _box!.clear();
            break;
          }
        }
      }
    } catch (e) {
      debugPrint('Error initializing AccountHiveDataSource: $e');
      rethrow;
    }
  }

  /// Get all accounts
  Future<Result<List<Account>>> getAll() async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _box!.values.toList();
      final accounts = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by name
      accounts.sort((a, b) => a.name.compareTo(b.name));

      return Result.success(accounts);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get accounts: $e'));
    }
  }

  /// Get account by ID
  Future<Result<Account?>> getById(String id) async {
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
      return Result.error(Failure.cache('Failed to get account: $e'));
    }
  }

  /// Get accounts by type
  Future<Result<List<Account>>> getByType(AccountType type) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _box!.values.where((dto) => dto.type == type.name).toList();
      final accounts = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by name
      accounts.sort((a, b) => a.name.compareTo(b.name));

      return Result.success(accounts);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get accounts by type: $e'));
    }
  }

  /// Get active accounts only
  Future<Result<List<Account>>> getActive() async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _box!.values.where((dto) => dto.isActive != false).toList();
      final accounts = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by name
      accounts.sort((a, b) => a.name.compareTo(b.name));

      return Result.success(accounts);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get active accounts: $e'));
    }
  }

  /// Add new account
  Future<Result<Account>> add(Account account) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = AccountDto.fromDomain(account);
      await _box!.put(account.id, dto);

      return Result.success(account);
    } catch (e) {
      return Result.error(Failure.cache('Failed to add account: $e'));
    }
  }

  /// Update existing account
  Future<Result<Account>> update(Account account) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dto = AccountDto.fromDomain(account);
      await _box!.put(account.id, dto);

      return Result.success(account);
    } catch (e) {
      return Result.error(Failure.cache('Failed to update account: $e'));
    }
  }

  /// Delete account by ID
  Future<Result<void>> delete(String id) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      await _box!.delete(id);
      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.cache('Failed to delete account: $e'));
    }
  }

  /// Get total balance across all accounts
  Future<Result<double>> getTotalBalance() async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _box!.values.where((dto) => dto.isActive != false).toList();
      final total = dtos.fold<double>(0.0, (sum, dto) {
        final account = dto.toDomain();
        return sum + account.currentBalance;
      });

      return Result.success(total);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get total balance: $e'));
    }
  }

  /// Get net worth (assets - liabilities)
  Future<Result<double>> getNetWorth() async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final dtos = _box!.values.where((dto) => dto.isActive != false).toList();
      final netWorth = dtos.fold<double>(0.0, (sum, dto) {
        final account = dto.toDomain();
        // Assets add to net worth, liabilities subtract
        return sum + (account.isAsset ? account.currentBalance : -account.currentBalance);
      });

      return Result.success(netWorth);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get net worth: $e'));
    }
  }

  /// Search accounts by name or institution
  Future<Result<List<Account>>> search(String query) async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      final lowerQuery = query.toLowerCase();
      final dtos = _box!.values.where((dto) {
        return dto.name.toLowerCase().contains(lowerQuery) ||
               (dto.institution?.toLowerCase().contains(lowerQuery) ?? false);
      }).toList();

      final accounts = dtos.map((dto) => dto.toDomain()).toList();

      // Sort by name
      accounts.sort((a, b) => a.name.compareTo(b.name));

      return Result.success(accounts);
    } catch (e) {
      return Result.error(Failure.cache('Failed to search accounts: $e'));
    }
  }

  /// Get account count
  Future<Result<int>> getCount() async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      return Result.success(_box!.length);
    } catch (e) {
      return Result.error(Failure.cache('Failed to get account count: $e'));
    }
  }

  /// Clear all accounts
  Future<Result<void>> clear() async {
    try {
      if (_box == null) {
        return Result.error(Failure.cache('Data source not initialized'));
      }

      await _box!.clear();
      return Result.success(null);
    } catch (e) {
      return Result.error(Failure.cache('Failed to clear accounts: $e'));
    }
  }

  /// Close the box
  Future<void> close() async {
    await _box?.close();
    _box = null;
  }
}