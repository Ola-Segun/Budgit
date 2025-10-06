// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CalendarEvent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  bool get isAllDay => throw _privateConstructorUsedError;
  String? get recurrenceRule => throw _privateConstructorUsedError;
  String? get billId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalendarEventCopyWith<CalendarEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarEventCopyWith<$Res> {
  factory $CalendarEventCopyWith(
          CalendarEvent value, $Res Function(CalendarEvent) then) =
      _$CalendarEventCopyWithImpl<$Res, CalendarEvent>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DateTime startDate,
      DateTime endDate,
      String? location,
      bool isAllDay,
      String? recurrenceRule,
      String? billId});
}

/// @nodoc
class _$CalendarEventCopyWithImpl<$Res, $Val extends CalendarEvent>
    implements $CalendarEventCopyWith<$Res> {
  _$CalendarEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? location = freezed,
    Object? isAllDay = null,
    Object? recurrenceRule = freezed,
    Object? billId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      recurrenceRule: freezed == recurrenceRule
          ? _value.recurrenceRule
          : recurrenceRule // ignore: cast_nullable_to_non_nullable
              as String?,
      billId: freezed == billId
          ? _value.billId
          : billId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarEventImplCopyWith<$Res>
    implements $CalendarEventCopyWith<$Res> {
  factory _$$CalendarEventImplCopyWith(
          _$CalendarEventImpl value, $Res Function(_$CalendarEventImpl) then) =
      __$$CalendarEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DateTime startDate,
      DateTime endDate,
      String? location,
      bool isAllDay,
      String? recurrenceRule,
      String? billId});
}

/// @nodoc
class __$$CalendarEventImplCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$CalendarEventImpl>
    implements _$$CalendarEventImplCopyWith<$Res> {
  __$$CalendarEventImplCopyWithImpl(
      _$CalendarEventImpl _value, $Res Function(_$CalendarEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? location = freezed,
    Object? isAllDay = null,
    Object? recurrenceRule = freezed,
    Object? billId = freezed,
  }) {
    return _then(_$CalendarEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      recurrenceRule: freezed == recurrenceRule
          ? _value.recurrenceRule
          : recurrenceRule // ignore: cast_nullable_to_non_nullable
              as String?,
      billId: freezed == billId
          ? _value.billId
          : billId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CalendarEventImpl extends _CalendarEvent {
  const _$CalendarEventImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      this.location,
      this.isAllDay = false,
      this.recurrenceRule,
      this.billId})
      : super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String? location;
  @override
  @JsonKey()
  final bool isAllDay;
  @override
  final String? recurrenceRule;
  @override
  final String? billId;

  @override
  String toString() {
    return 'CalendarEvent(id: $id, title: $title, description: $description, startDate: $startDate, endDate: $endDate, location: $location, isAllDay: $isAllDay, recurrenceRule: $recurrenceRule, billId: $billId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            (identical(other.recurrenceRule, recurrenceRule) ||
                other.recurrenceRule == recurrenceRule) &&
            (identical(other.billId, billId) || other.billId == billId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      startDate, endDate, location, isAllDay, recurrenceRule, billId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarEventImplCopyWith<_$CalendarEventImpl> get copyWith =>
      __$$CalendarEventImplCopyWithImpl<_$CalendarEventImpl>(this, _$identity);
}

abstract class _CalendarEvent extends CalendarEvent {
  const factory _CalendarEvent(
      {required final String id,
      required final String title,
      required final String description,
      required final DateTime startDate,
      required final DateTime endDate,
      final String? location,
      final bool isAllDay,
      final String? recurrenceRule,
      final String? billId}) = _$CalendarEventImpl;
  const _CalendarEvent._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String? get location;
  @override
  bool get isAllDay;
  @override
  String? get recurrenceRule;
  @override
  String? get billId;
  @override
  @JsonKey(ignore: true)
  _$$CalendarEventImplCopyWith<_$CalendarEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CalendarSyncSettings {
  bool get isEnabled => throw _privateConstructorUsedError;
  String? get selectedCalendarId => throw _privateConstructorUsedError;
  int get reminderDaysBefore =>
      throw _privateConstructorUsedError; // days before due date to create event
  bool get includeAmountInTitle => throw _privateConstructorUsedError;
  bool get createRecurringEvents => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalendarSyncSettingsCopyWith<CalendarSyncSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarSyncSettingsCopyWith<$Res> {
  factory $CalendarSyncSettingsCopyWith(CalendarSyncSettings value,
          $Res Function(CalendarSyncSettings) then) =
      _$CalendarSyncSettingsCopyWithImpl<$Res, CalendarSyncSettings>;
  @useResult
  $Res call(
      {bool isEnabled,
      String? selectedCalendarId,
      int reminderDaysBefore,
      bool includeAmountInTitle,
      bool createRecurringEvents});
}

/// @nodoc
class _$CalendarSyncSettingsCopyWithImpl<$Res,
        $Val extends CalendarSyncSettings>
    implements $CalendarSyncSettingsCopyWith<$Res> {
  _$CalendarSyncSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? selectedCalendarId = freezed,
    Object? reminderDaysBefore = null,
    Object? includeAmountInTitle = null,
    Object? createRecurringEvents = null,
  }) {
    return _then(_value.copyWith(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedCalendarId: freezed == selectedCalendarId
          ? _value.selectedCalendarId
          : selectedCalendarId // ignore: cast_nullable_to_non_nullable
              as String?,
      reminderDaysBefore: null == reminderDaysBefore
          ? _value.reminderDaysBefore
          : reminderDaysBefore // ignore: cast_nullable_to_non_nullable
              as int,
      includeAmountInTitle: null == includeAmountInTitle
          ? _value.includeAmountInTitle
          : includeAmountInTitle // ignore: cast_nullable_to_non_nullable
              as bool,
      createRecurringEvents: null == createRecurringEvents
          ? _value.createRecurringEvents
          : createRecurringEvents // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarSyncSettingsImplCopyWith<$Res>
    implements $CalendarSyncSettingsCopyWith<$Res> {
  factory _$$CalendarSyncSettingsImplCopyWith(_$CalendarSyncSettingsImpl value,
          $Res Function(_$CalendarSyncSettingsImpl) then) =
      __$$CalendarSyncSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isEnabled,
      String? selectedCalendarId,
      int reminderDaysBefore,
      bool includeAmountInTitle,
      bool createRecurringEvents});
}

/// @nodoc
class __$$CalendarSyncSettingsImplCopyWithImpl<$Res>
    extends _$CalendarSyncSettingsCopyWithImpl<$Res, _$CalendarSyncSettingsImpl>
    implements _$$CalendarSyncSettingsImplCopyWith<$Res> {
  __$$CalendarSyncSettingsImplCopyWithImpl(_$CalendarSyncSettingsImpl _value,
      $Res Function(_$CalendarSyncSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? selectedCalendarId = freezed,
    Object? reminderDaysBefore = null,
    Object? includeAmountInTitle = null,
    Object? createRecurringEvents = null,
  }) {
    return _then(_$CalendarSyncSettingsImpl(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedCalendarId: freezed == selectedCalendarId
          ? _value.selectedCalendarId
          : selectedCalendarId // ignore: cast_nullable_to_non_nullable
              as String?,
      reminderDaysBefore: null == reminderDaysBefore
          ? _value.reminderDaysBefore
          : reminderDaysBefore // ignore: cast_nullable_to_non_nullable
              as int,
      includeAmountInTitle: null == includeAmountInTitle
          ? _value.includeAmountInTitle
          : includeAmountInTitle // ignore: cast_nullable_to_non_nullable
              as bool,
      createRecurringEvents: null == createRecurringEvents
          ? _value.createRecurringEvents
          : createRecurringEvents // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CalendarSyncSettingsImpl extends _CalendarSyncSettings {
  const _$CalendarSyncSettingsImpl(
      {this.isEnabled = true,
      this.selectedCalendarId,
      this.reminderDaysBefore = 7,
      this.includeAmountInTitle = true,
      this.createRecurringEvents = true})
      : super._();

  @override
  @JsonKey()
  final bool isEnabled;
  @override
  final String? selectedCalendarId;
  @override
  @JsonKey()
  final int reminderDaysBefore;
// days before due date to create event
  @override
  @JsonKey()
  final bool includeAmountInTitle;
  @override
  @JsonKey()
  final bool createRecurringEvents;

  @override
  String toString() {
    return 'CalendarSyncSettings(isEnabled: $isEnabled, selectedCalendarId: $selectedCalendarId, reminderDaysBefore: $reminderDaysBefore, includeAmountInTitle: $includeAmountInTitle, createRecurringEvents: $createRecurringEvents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarSyncSettingsImpl &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.selectedCalendarId, selectedCalendarId) ||
                other.selectedCalendarId == selectedCalendarId) &&
            (identical(other.reminderDaysBefore, reminderDaysBefore) ||
                other.reminderDaysBefore == reminderDaysBefore) &&
            (identical(other.includeAmountInTitle, includeAmountInTitle) ||
                other.includeAmountInTitle == includeAmountInTitle) &&
            (identical(other.createRecurringEvents, createRecurringEvents) ||
                other.createRecurringEvents == createRecurringEvents));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEnabled, selectedCalendarId,
      reminderDaysBefore, includeAmountInTitle, createRecurringEvents);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarSyncSettingsImplCopyWith<_$CalendarSyncSettingsImpl>
      get copyWith =>
          __$$CalendarSyncSettingsImplCopyWithImpl<_$CalendarSyncSettingsImpl>(
              this, _$identity);
}

abstract class _CalendarSyncSettings extends CalendarSyncSettings {
  const factory _CalendarSyncSettings(
      {final bool isEnabled,
      final String? selectedCalendarId,
      final int reminderDaysBefore,
      final bool includeAmountInTitle,
      final bool createRecurringEvents}) = _$CalendarSyncSettingsImpl;
  const _CalendarSyncSettings._() : super._();

  @override
  bool get isEnabled;
  @override
  String? get selectedCalendarId;
  @override
  int get reminderDaysBefore;
  @override // days before due date to create event
  bool get includeAmountInTitle;
  @override
  bool get createRecurringEvents;
  @override
  @JsonKey(ignore: true)
  _$$CalendarSyncSettingsImplCopyWith<_$CalendarSyncSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
