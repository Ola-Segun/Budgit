import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';

/// Calendar event entity for bill reminders
@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent({
    required String id,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    String? location,
    @Default(false) bool isAllDay,
    String? recurrenceRule,
    String? billId,
  }) = _CalendarEvent;

  const CalendarEvent._();

  /// Create event from bill data
  factory CalendarEvent.fromBill({
    required String billId,
    required String billName,
    required double amount,
    required DateTime dueDate,
    String? description,
  }) {
    final startDate = DateTime(dueDate.year, dueDate.month, dueDate.day, 9, 0); // 9 AM
    final endDate = startDate.add(const Duration(hours: 1));

    return CalendarEvent(
      id: 'bill_$billId',
      title: 'Bill Due: $billName - \$${amount.toStringAsFixed(2)}',
      description: description ?? 'Payment due for $billName',
      startDate: startDate,
      endDate: endDate,
      billId: billId,
    );
  }
}

/// Calendar sync settings
@freezed
class CalendarSyncSettings with _$CalendarSyncSettings {
  const factory CalendarSyncSettings({
    @Default(true) bool isEnabled,
    String? selectedCalendarId,
    @Default(7) int reminderDaysBefore, // days before due date to create event
    @Default(true) bool includeAmountInTitle,
    @Default(true) bool createRecurringEvents,
  }) = _CalendarSyncSettings;

  const CalendarSyncSettings._();
}