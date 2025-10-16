// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_income_instance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecurringIncomeInstance _$RecurringIncomeInstanceFromJson(
    Map<String, dynamic> json) {
  return _RecurringIncomeInstance.fromJson(json);
}

/// @nodoc
mixin _$RecurringIncomeInstance {
  String get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get receivedDate => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get accountId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecurringIncomeInstanceCopyWith<RecurringIncomeInstance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringIncomeInstanceCopyWith<$Res> {
  factory $RecurringIncomeInstanceCopyWith(RecurringIncomeInstance value,
          $Res Function(RecurringIncomeInstance) then) =
      _$RecurringIncomeInstanceCopyWithImpl<$Res, RecurringIncomeInstance>;
  @useResult
  $Res call(
      {String id,
      double amount,
      DateTime receivedDate,
      String? transactionId,
      String? notes,
      String? accountId});
}

/// @nodoc
class _$RecurringIncomeInstanceCopyWithImpl<$Res,
        $Val extends RecurringIncomeInstance>
    implements $RecurringIncomeInstanceCopyWith<$Res> {
  _$RecurringIncomeInstanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? receivedDate = null,
    Object? transactionId = freezed,
    Object? notes = freezed,
    Object? accountId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      receivedDate: null == receivedDate
          ? _value.receivedDate
          : receivedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecurringIncomeInstanceImplCopyWith<$Res>
    implements $RecurringIncomeInstanceCopyWith<$Res> {
  factory _$$RecurringIncomeInstanceImplCopyWith(
          _$RecurringIncomeInstanceImpl value,
          $Res Function(_$RecurringIncomeInstanceImpl) then) =
      __$$RecurringIncomeInstanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      double amount,
      DateTime receivedDate,
      String? transactionId,
      String? notes,
      String? accountId});
}

/// @nodoc
class __$$RecurringIncomeInstanceImplCopyWithImpl<$Res>
    extends _$RecurringIncomeInstanceCopyWithImpl<$Res,
        _$RecurringIncomeInstanceImpl>
    implements _$$RecurringIncomeInstanceImplCopyWith<$Res> {
  __$$RecurringIncomeInstanceImplCopyWithImpl(
      _$RecurringIncomeInstanceImpl _value,
      $Res Function(_$RecurringIncomeInstanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? receivedDate = null,
    Object? transactionId = freezed,
    Object? notes = freezed,
    Object? accountId = freezed,
  }) {
    return _then(_$RecurringIncomeInstanceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      receivedDate: null == receivedDate
          ? _value.receivedDate
          : receivedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecurringIncomeInstanceImpl extends _RecurringIncomeInstance {
  const _$RecurringIncomeInstanceImpl(
      {required this.id,
      required this.amount,
      required this.receivedDate,
      this.transactionId,
      this.notes,
      this.accountId})
      : super._();

  factory _$RecurringIncomeInstanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecurringIncomeInstanceImplFromJson(json);

  @override
  final String id;
  @override
  final double amount;
  @override
  final DateTime receivedDate;
  @override
  final String? transactionId;
  @override
  final String? notes;
  @override
  final String? accountId;

  @override
  String toString() {
    return 'RecurringIncomeInstance(id: $id, amount: $amount, receivedDate: $receivedDate, transactionId: $transactionId, notes: $notes, accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringIncomeInstanceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.receivedDate, receivedDate) ||
                other.receivedDate == receivedDate) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, amount, receivedDate, transactionId, notes, accountId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringIncomeInstanceImplCopyWith<_$RecurringIncomeInstanceImpl>
      get copyWith => __$$RecurringIncomeInstanceImplCopyWithImpl<
          _$RecurringIncomeInstanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecurringIncomeInstanceImplToJson(
      this,
    );
  }
}

abstract class _RecurringIncomeInstance extends RecurringIncomeInstance {
  const factory _RecurringIncomeInstance(
      {required final String id,
      required final double amount,
      required final DateTime receivedDate,
      final String? transactionId,
      final String? notes,
      final String? accountId}) = _$RecurringIncomeInstanceImpl;
  const _RecurringIncomeInstance._() : super._();

  factory _RecurringIncomeInstance.fromJson(Map<String, dynamic> json) =
      _$RecurringIncomeInstanceImpl.fromJson;

  @override
  String get id;
  @override
  double get amount;
  @override
  DateTime get receivedDate;
  @override
  String? get transactionId;
  @override
  String? get notes;
  @override
  String? get accountId;
  @override
  @JsonKey(ignore: true)
  _$$RecurringIncomeInstanceImplCopyWith<_$RecurringIncomeInstanceImpl>
      get copyWith => throw _privateConstructorUsedError;
}
