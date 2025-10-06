import 'package:hive_flutter/hive_flutter.dart';

/// Hive storage service for local data persistence
class HiveStorage {
  static const String _transactionsBox = 'transactions';
  static const String _budgetsBox = 'budgets';
  static const String _goalsBox = 'goals';
  static const String _billsBox = 'bills';
  static const String _categoriesBox = 'categories';
  static const String _settingsBox = 'settings';

  static Future<void> init() async {
    // Initialize Hive
    await Hive.initFlutter();
  }

  // Transaction box - REMOVED: Dangerous untyped box getter
  // static Box get transactionsBox => Hive.box(_transactionsBox);

  // Budget box - REMOVED: Dangerous untyped box getter
  // static Box get budgetsBox => Hive.box(_budgetsBox);

  // Goals box - REMOVED: Dangerous untyped box getter
  // static Box get goalsBox => Hive.box(_goalsBox);

  // Bills box - REMOVED: Dangerous untyped box getter
  // static Box get billsBox => Hive.box(_billsBox);

  // Categories box - REMOVED: Dangerous untyped box getter
  // static Box get categoriesBox => Hive.box(_categoriesBox);

  // Settings box - REMOVED: Dangerous untyped box getter
  // static Box get settingsBox => Hive.box(_settingsBox);

}