import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../datasources/calendar_datasource.dart';

/// Implementation of CalendarRepository
class CalendarRepositoryImpl implements CalendarRepository {
  const CalendarRepositoryImpl(this._calendarDataSource);

  final CalendarDataSource _calendarDataSource;

  @override
  Future<Result<List<CalendarInfo>>> getAvailableCalendars() {
    return _calendarDataSource.getAvailableCalendars();
  }

  @override
  Future<Result<CalendarSyncSettings>> getSyncSettings() async {
    // TODO: Implement settings storage
    return Result.success(const CalendarSyncSettings());
  }

  @override
  Future<Result<CalendarSyncSettings>> updateSyncSettings(CalendarSyncSettings settings) async {
    // TODO: Implement settings storage
    return Result.success(settings);
  }

  @override
  Future<Result<void>> syncBillsToCalendar(List<BillInfo> bills) async {
    try {
      final settingsResult = await getSyncSettings();
      if (settingsResult.isError) {
        return Result.error(settingsResult.failureOrNull!);
      }

      final settings = settingsResult.getOrThrow();
      if (!settings.isEnabled || settings.selectedCalendarId == null) {
        return const Result.success(null);
      }

      // Create events for upcoming bills
      for (final bill in bills) {
        final event = CalendarEvent.fromBill(
          billId: bill.id,
          billName: bill.name,
          amount: bill.amount,
          dueDate: bill.dueDate,
          description: bill.description,
        );

        final createResult = await _calendarDataSource.createEvent(
          event,
          settings.selectedCalendarId!,
        );

        if (createResult.isError) {
          // Log error but continue with other bills
          continue;
        }
      }

      return const Result.success(null);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to sync bills: $e'));
    }
  }

  @override
  Future<Result<void>> removeBillEventsFromCalendar(List<String> billIds) async {
    try {
      final settingsResult = await getSyncSettings();
      if (settingsResult.isError) {
        return Result.error(settingsResult.failureOrNull!);
      }

      final settings = settingsResult.getOrThrow();
      if (!settings.isEnabled || settings.selectedCalendarId == null) {
        return const Result.success(null);
      }

      for (final billId in billIds) {
        final eventId = 'bill_$billId';
        final deleteResult = await _calendarDataSource.deleteEvent(
          eventId,
          settings.selectedCalendarId!,
        );

        if (deleteResult.isError) {
          // Log error but continue
          continue;
        }
      }

      return const Result.success(null);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to remove bill events: $e'));
    }
  }

  @override
  Future<Result<bool>> hasCalendarPermissions() {
    return _calendarDataSource.hasPermissions();
  }

  @override
  Future<Result<bool>> requestCalendarPermissions() {
    return _calendarDataSource.requestPermissions();
  }
}