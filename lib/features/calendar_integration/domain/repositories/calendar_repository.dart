import '../../../../core/error/result.dart';
import '../entities/calendar_event.dart';

/// Repository interface for calendar operations
abstract class CalendarRepository {
  /// Get available calendars on device
  Future<Result<List<CalendarInfo>>> getAvailableCalendars();

  /// Get calendar sync settings
  Future<Result<CalendarSyncSettings>> getSyncSettings();

  /// Update calendar sync settings
  Future<Result<CalendarSyncSettings>> updateSyncSettings(CalendarSyncSettings settings);

  /// Sync bill reminders to calendar
  Future<Result<void>> syncBillsToCalendar(List<BillInfo> bills);

  /// Remove bill events from calendar
  Future<Result<void>> removeBillEventsFromCalendar(List<String> billIds);

  /// Check if calendar permissions are granted
  Future<Result<bool>> hasCalendarPermissions();

  /// Request calendar permissions
  Future<Result<bool>> requestCalendarPermissions();
}

/// Calendar information
class CalendarInfo {
  const CalendarInfo({
    required this.id,
    required this.name,
    required this.isReadOnly,
    required this.isDefault,
  });

  final String id;
  final String name;
  final bool isReadOnly;
  final bool isDefault;
}

/// Bill information for calendar sync
class BillInfo {
  const BillInfo({
    required this.id,
    required this.name,
    required this.amount,
    required this.dueDate,
    this.description,
    this.frequency,
  });

  final String id;
  final String name;
  final double amount;
  final DateTime dueDate;
  final String? description;
  final String? frequency;
}