import 'package:device_calendar/device_calendar.dart' as dc;
import 'package:timezone/timezone.dart' as tz;

import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart' as app_result;
import '../../domain/entities/calendar_event.dart';
import '../../domain/repositories/calendar_repository.dart';

/// Data source for calendar operations using device_calendar plugin
abstract class CalendarDataSource {
  /// Get available calendars
  Future<app_result.Result<List<CalendarInfo>>> getAvailableCalendars();

  /// Create calendar event
  Future<app_result.Result<String>> createEvent(CalendarEvent event, String calendarId);

  /// Update calendar event
  Future<app_result.Result<void>> updateEvent(CalendarEvent event, String eventId, String calendarId);

  /// Delete calendar event
  Future<app_result.Result<void>> deleteEvent(String eventId, String calendarId);

  /// Get calendar permissions
  Future<app_result.Result<bool>> hasPermissions();

  /// Request calendar permissions
  Future<app_result.Result<bool>> requestPermissions();
}

/// Implementation of CalendarDataSource
class CalendarDataSourceImpl implements CalendarDataSource {
  CalendarDataSourceImpl(this._deviceCalendarPlugin);

  final dc.DeviceCalendarPlugin _deviceCalendarPlugin;

  @override
  Future<app_result.Result<List<CalendarInfo>>> getAvailableCalendars() async {
    try {
      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
      if (!calendarsResult.isSuccess || calendarsResult.data == null) {
        return app_result.Result.error(Failure.unknown('Failed to retrieve calendars'));
      }

      final calendars = calendarsResult.data!
          .map((calendar) => CalendarInfo(
                id: calendar.id!,
                name: calendar.name ?? 'Unnamed Calendar',
                isReadOnly: calendar.isReadOnly ?? false,
                isDefault: calendar.isDefault ?? false,
              ))
          .toList();

      return app_result.Result.success(calendars);
    } catch (e) {
      return app_result.Result.error(Failure.unknown('Failed to get calendars: $e'));
    }
  }

  @override
  Future<app_result.Result<String>> createEvent(CalendarEvent event, String calendarId) async {
    try {
      final eventToCreate = dc.Event(calendarId)
        ..title = event.title
        ..description = event.description
        ..start = tz.TZDateTime.from(event.startDate, tz.local)
        ..end = tz.TZDateTime.from(event.endDate, tz.local)
        ..allDay = event.isAllDay;

      if (event.location != null) {
        eventToCreate.location = event.location;
      }

      // TODO: Handle recurrence rule parsing
      // if (event.recurrenceRule != null) {
      //   eventToCreate.recurrenceRule = dc.RecurrenceRule.fromString(event.recurrenceRule!);
      // }

      final createResult = await _deviceCalendarPlugin.createOrUpdateEvent(eventToCreate);
      if (!createResult!.isSuccess || createResult.data == null) {
        return app_result.Result.error(Failure.unknown('Failed to create calendar event'));
      }

      return app_result.Result.success(createResult.data!);
    } catch (e) {
      return app_result.Result.error(Failure.unknown('Failed to create event: $e'));
    }
  }

  @override
  Future<app_result.Result<void>> updateEvent(CalendarEvent event, String eventId, String calendarId) async {
    try {
      final eventToUpdate = dc.Event(calendarId)
        ..eventId = eventId
        ..title = event.title
        ..description = event.description
        ..start = tz.TZDateTime.from(event.startDate, tz.local)
        ..end = tz.TZDateTime.from(event.endDate, tz.local)
        ..allDay = event.isAllDay;

      if (event.location != null) {
        eventToUpdate.location = event.location;
      }

      // TODO: Handle recurrence rule parsing
      // if (event.recurrenceRule != null) {
      //   eventToUpdate.recurrenceRule = dc.RecurrenceRule.fromString(event.recurrenceRule!);
      // }

      final updateResult = await _deviceCalendarPlugin.createOrUpdateEvent(eventToUpdate);
      if (!updateResult!.isSuccess) {
        return app_result.Result.error(Failure.unknown('Failed to update calendar event'));
      }

      return const app_result.Result.success(null);
    } catch (e) {
      return app_result.Result.error(Failure.unknown('Failed to update event: $e'));
    }
  }

  @override
  Future<app_result.Result<void>> deleteEvent(String eventId, String calendarId) async {
    try {
      final deleteResult = await _deviceCalendarPlugin.deleteEvent(calendarId, eventId);
      if (!deleteResult.isSuccess) {
        return app_result.Result.error(Failure.unknown('Failed to delete calendar event'));
      }

      return const app_result.Result.success(null);
    } catch (e) {
      return app_result.Result.error(Failure.unknown('Failed to delete event: $e'));
    }
  }

  @override
  Future<app_result.Result<bool>> hasPermissions() async {
    try {
      final permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      return app_result.Result.success(permissionsGranted.isSuccess && permissionsGranted.data == true);
    } catch (e) {
      return app_result.Result.error(Failure.unknown('Failed to check permissions: $e'));
    }
  }

  @override
  Future<app_result.Result<bool>> requestPermissions() async {
    try {
      final permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
      return app_result.Result.success(permissionsGranted.isSuccess && permissionsGranted.data == true);
    } catch (e) {
      return app_result.Result.error(Failure.unknown('Failed to request permissions: $e'));
    }
  }
}