// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_contribution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GoalContribution {
  String get id => throw _privateConstructorUsedError;
  String get goalId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GoalContributionCopyWith<GoalContribution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalContributionCopyWith<$Res> {
  factory $GoalContributionCopyWith(
          GoalContribution value, $Res Function(GoalContribution) then) =
      _$GoalContributionCopyWithImpl<$Res, GoalContribution>;
  @useResult
  $Res call(
      {String id,
      String goalId,
      double amount,
      DateTime date,
      String? note,
      DateTime createdAt});
}

/// @nodoc
class _$GoalContributionCopyWithImpl<$Res, $Val extends GoalContribution>
    implements $GoalContributionCopyWith<$Res> {
  _$GoalContributionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalId = null,
    Object? amount = null,
    Object? date = null,
    Object? note = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalContributionImplCopyWith<$Res>
    implements $GoalContributionCopyWith<$Res> {
  factory _$$GoalContributionImplCopyWith(_$GoalContributionImpl value,
          $Res Function(_$GoalContributionImpl) then) =
      __$$GoalContributionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String goalId,
      double amount,
      DateTime date,
      String? note,
      DateTime createdAt});
}

/// @nodoc
class __$$GoalContributionImplCopyWithImpl<$Res>
    extends _$GoalContributionCopyWithImpl<$Res, _$GoalContributionImpl>
    implements _$$GoalContributionImplCopyWith<$Res> {
  __$$GoalContributionImplCopyWithImpl(_$GoalContributionImpl _value,
      $Res Function(_$GoalContributionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalId = null,
    Object? amount = null,
    Object? date = null,
    Object? note = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$GoalContributionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$GoalContributionImpl extends _GoalContribution {
  const _$GoalContributionImpl(
      {required this.id,
      required this.goalId,
      required this.amount,
      required this.date,
      this.note,
      required this.createdAt})
      : super._();

  @override
  final String id;
  @override
  final String goalId;
  @override
  final double amount;
  @override
  final DateTime date;
  @override
  final String? note;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'GoalContribution(id: $id, goalId: $goalId, amount: $amount, date: $date, note: $note, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalContributionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, goalId, amount, date, note, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalContributionImplCopyWith<_$GoalContributionImpl> get copyWith =>
      __$$GoalContributionImplCopyWithImpl<_$GoalContributionImpl>(
          this, _$identity);
}

abstract class _GoalContribution extends GoalContribution {
  const factory _GoalContribution(
      {required final String id,
      required final String goalId,
      required final double amount,
      required final DateTime date,
      final String? note,
      required final DateTime createdAt}) = _$GoalContributionImpl;
  const _GoalContribution._() : super._();

  @override
  String get id;
  @override
  String get goalId;
  @override
  double get amount;
  @override
  DateTime get date;
  @override
  String? get note;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$GoalContributionImplCopyWith<_$GoalContributionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
