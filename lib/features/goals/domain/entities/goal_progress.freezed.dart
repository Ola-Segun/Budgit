// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GoalProgress {
  Goal get goal => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  DateTime? get projectedCompletionDate => throw _privateConstructorUsedError;
  bool get isOnTrack => throw _privateConstructorUsedError;
  double get requiredMonthlyContribution => throw _privateConstructorUsedError;
  double get totalContributed => throw _privateConstructorUsedError;
  int get totalContributions => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GoalProgressCopyWith<GoalProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalProgressCopyWith<$Res> {
  factory $GoalProgressCopyWith(
          GoalProgress value, $Res Function(GoalProgress) then) =
      _$GoalProgressCopyWithImpl<$Res, GoalProgress>;
  @useResult
  $Res call(
      {Goal goal,
      double percentage,
      DateTime? projectedCompletionDate,
      bool isOnTrack,
      double requiredMonthlyContribution,
      double totalContributed,
      int totalContributions});

  $GoalCopyWith<$Res> get goal;
}

/// @nodoc
class _$GoalProgressCopyWithImpl<$Res, $Val extends GoalProgress>
    implements $GoalProgressCopyWith<$Res> {
  _$GoalProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goal = null,
    Object? percentage = null,
    Object? projectedCompletionDate = freezed,
    Object? isOnTrack = null,
    Object? requiredMonthlyContribution = null,
    Object? totalContributed = null,
    Object? totalContributions = null,
  }) {
    return _then(_value.copyWith(
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as Goal,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      projectedCompletionDate: freezed == projectedCompletionDate
          ? _value.projectedCompletionDate
          : projectedCompletionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOnTrack: null == isOnTrack
          ? _value.isOnTrack
          : isOnTrack // ignore: cast_nullable_to_non_nullable
              as bool,
      requiredMonthlyContribution: null == requiredMonthlyContribution
          ? _value.requiredMonthlyContribution
          : requiredMonthlyContribution // ignore: cast_nullable_to_non_nullable
              as double,
      totalContributed: null == totalContributed
          ? _value.totalContributed
          : totalContributed // ignore: cast_nullable_to_non_nullable
              as double,
      totalContributions: null == totalContributions
          ? _value.totalContributions
          : totalContributions // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GoalCopyWith<$Res> get goal {
    return $GoalCopyWith<$Res>(_value.goal, (value) {
      return _then(_value.copyWith(goal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GoalProgressImplCopyWith<$Res>
    implements $GoalProgressCopyWith<$Res> {
  factory _$$GoalProgressImplCopyWith(
          _$GoalProgressImpl value, $Res Function(_$GoalProgressImpl) then) =
      __$$GoalProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Goal goal,
      double percentage,
      DateTime? projectedCompletionDate,
      bool isOnTrack,
      double requiredMonthlyContribution,
      double totalContributed,
      int totalContributions});

  @override
  $GoalCopyWith<$Res> get goal;
}

/// @nodoc
class __$$GoalProgressImplCopyWithImpl<$Res>
    extends _$GoalProgressCopyWithImpl<$Res, _$GoalProgressImpl>
    implements _$$GoalProgressImplCopyWith<$Res> {
  __$$GoalProgressImplCopyWithImpl(
      _$GoalProgressImpl _value, $Res Function(_$GoalProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goal = null,
    Object? percentage = null,
    Object? projectedCompletionDate = freezed,
    Object? isOnTrack = null,
    Object? requiredMonthlyContribution = null,
    Object? totalContributed = null,
    Object? totalContributions = null,
  }) {
    return _then(_$GoalProgressImpl(
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as Goal,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      projectedCompletionDate: freezed == projectedCompletionDate
          ? _value.projectedCompletionDate
          : projectedCompletionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOnTrack: null == isOnTrack
          ? _value.isOnTrack
          : isOnTrack // ignore: cast_nullable_to_non_nullable
              as bool,
      requiredMonthlyContribution: null == requiredMonthlyContribution
          ? _value.requiredMonthlyContribution
          : requiredMonthlyContribution // ignore: cast_nullable_to_non_nullable
              as double,
      totalContributed: null == totalContributed
          ? _value.totalContributed
          : totalContributed // ignore: cast_nullable_to_non_nullable
              as double,
      totalContributions: null == totalContributions
          ? _value.totalContributions
          : totalContributions // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GoalProgressImpl extends _GoalProgress {
  const _$GoalProgressImpl(
      {required this.goal,
      required this.percentage,
      this.projectedCompletionDate,
      required this.isOnTrack,
      required this.requiredMonthlyContribution,
      required this.totalContributed,
      required this.totalContributions})
      : super._();

  @override
  final Goal goal;
  @override
  final double percentage;
  @override
  final DateTime? projectedCompletionDate;
  @override
  final bool isOnTrack;
  @override
  final double requiredMonthlyContribution;
  @override
  final double totalContributed;
  @override
  final int totalContributions;

  @override
  String toString() {
    return 'GoalProgress(goal: $goal, percentage: $percentage, projectedCompletionDate: $projectedCompletionDate, isOnTrack: $isOnTrack, requiredMonthlyContribution: $requiredMonthlyContribution, totalContributed: $totalContributed, totalContributions: $totalContributions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalProgressImpl &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(
                    other.projectedCompletionDate, projectedCompletionDate) ||
                other.projectedCompletionDate == projectedCompletionDate) &&
            (identical(other.isOnTrack, isOnTrack) ||
                other.isOnTrack == isOnTrack) &&
            (identical(other.requiredMonthlyContribution,
                    requiredMonthlyContribution) ||
                other.requiredMonthlyContribution ==
                    requiredMonthlyContribution) &&
            (identical(other.totalContributed, totalContributed) ||
                other.totalContributed == totalContributed) &&
            (identical(other.totalContributions, totalContributions) ||
                other.totalContributions == totalContributions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      goal,
      percentage,
      projectedCompletionDate,
      isOnTrack,
      requiredMonthlyContribution,
      totalContributed,
      totalContributions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalProgressImplCopyWith<_$GoalProgressImpl> get copyWith =>
      __$$GoalProgressImplCopyWithImpl<_$GoalProgressImpl>(this, _$identity);
}

abstract class _GoalProgress extends GoalProgress {
  const factory _GoalProgress(
      {required final Goal goal,
      required final double percentage,
      final DateTime? projectedCompletionDate,
      required final bool isOnTrack,
      required final double requiredMonthlyContribution,
      required final double totalContributed,
      required final int totalContributions}) = _$GoalProgressImpl;
  const _GoalProgress._() : super._();

  @override
  Goal get goal;
  @override
  double get percentage;
  @override
  DateTime? get projectedCompletionDate;
  @override
  bool get isOnTrack;
  @override
  double get requiredMonthlyContribution;
  @override
  double get totalContributed;
  @override
  int get totalContributions;
  @override
  @JsonKey(ignore: true)
  _$$GoalProgressImplCopyWith<_$GoalProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
