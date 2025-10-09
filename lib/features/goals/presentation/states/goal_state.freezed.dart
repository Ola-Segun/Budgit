// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GoalState {
  List<Goal> get goals => throw _privateConstructorUsedError;
  List<GoalProgress> get goalProgress => throw _privateConstructorUsedError;
  List<GoalContribution> get contributions =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  GoalFilter? get filter => throw _privateConstructorUsedError;
  Goal? get selectedGoal => throw _privateConstructorUsedError;
  bool get showAllGoals => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GoalStateCopyWith<GoalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalStateCopyWith<$Res> {
  factory $GoalStateCopyWith(GoalState value, $Res Function(GoalState) then) =
      _$GoalStateCopyWithImpl<$Res, GoalState>;
  @useResult
  $Res call(
      {List<Goal> goals,
      List<GoalProgress> goalProgress,
      List<GoalContribution> contributions,
      bool isLoading,
      String? error,
      String? searchQuery,
      GoalFilter? filter,
      Goal? selectedGoal,
      bool showAllGoals});

  $GoalFilterCopyWith<$Res>? get filter;
  $GoalCopyWith<$Res>? get selectedGoal;
}

/// @nodoc
class _$GoalStateCopyWithImpl<$Res, $Val extends GoalState>
    implements $GoalStateCopyWith<$Res> {
  _$GoalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goals = null,
    Object? goalProgress = null,
    Object? contributions = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? searchQuery = freezed,
    Object? filter = freezed,
    Object? selectedGoal = freezed,
    Object? showAllGoals = null,
  }) {
    return _then(_value.copyWith(
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<Goal>,
      goalProgress: null == goalProgress
          ? _value.goalProgress
          : goalProgress // ignore: cast_nullable_to_non_nullable
              as List<GoalProgress>,
      contributions: null == contributions
          ? _value.contributions
          : contributions // ignore: cast_nullable_to_non_nullable
              as List<GoalContribution>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as GoalFilter?,
      selectedGoal: freezed == selectedGoal
          ? _value.selectedGoal
          : selectedGoal // ignore: cast_nullable_to_non_nullable
              as Goal?,
      showAllGoals: null == showAllGoals
          ? _value.showAllGoals
          : showAllGoals // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GoalFilterCopyWith<$Res>? get filter {
    if (_value.filter == null) {
      return null;
    }

    return $GoalFilterCopyWith<$Res>(_value.filter!, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GoalCopyWith<$Res>? get selectedGoal {
    if (_value.selectedGoal == null) {
      return null;
    }

    return $GoalCopyWith<$Res>(_value.selectedGoal!, (value) {
      return _then(_value.copyWith(selectedGoal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GoalStateImplCopyWith<$Res>
    implements $GoalStateCopyWith<$Res> {
  factory _$$GoalStateImplCopyWith(
          _$GoalStateImpl value, $Res Function(_$GoalStateImpl) then) =
      __$$GoalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Goal> goals,
      List<GoalProgress> goalProgress,
      List<GoalContribution> contributions,
      bool isLoading,
      String? error,
      String? searchQuery,
      GoalFilter? filter,
      Goal? selectedGoal,
      bool showAllGoals});

  @override
  $GoalFilterCopyWith<$Res>? get filter;
  @override
  $GoalCopyWith<$Res>? get selectedGoal;
}

/// @nodoc
class __$$GoalStateImplCopyWithImpl<$Res>
    extends _$GoalStateCopyWithImpl<$Res, _$GoalStateImpl>
    implements _$$GoalStateImplCopyWith<$Res> {
  __$$GoalStateImplCopyWithImpl(
      _$GoalStateImpl _value, $Res Function(_$GoalStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goals = null,
    Object? goalProgress = null,
    Object? contributions = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? searchQuery = freezed,
    Object? filter = freezed,
    Object? selectedGoal = freezed,
    Object? showAllGoals = null,
  }) {
    return _then(_$GoalStateImpl(
      goals: null == goals
          ? _value._goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<Goal>,
      goalProgress: null == goalProgress
          ? _value._goalProgress
          : goalProgress // ignore: cast_nullable_to_non_nullable
              as List<GoalProgress>,
      contributions: null == contributions
          ? _value._contributions
          : contributions // ignore: cast_nullable_to_non_nullable
              as List<GoalContribution>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as GoalFilter?,
      selectedGoal: freezed == selectedGoal
          ? _value.selectedGoal
          : selectedGoal // ignore: cast_nullable_to_non_nullable
              as Goal?,
      showAllGoals: null == showAllGoals
          ? _value.showAllGoals
          : showAllGoals // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GoalStateImpl extends _GoalState {
  const _$GoalStateImpl(
      {final List<Goal> goals = const [],
      final List<GoalProgress> goalProgress = const [],
      final List<GoalContribution> contributions = const [],
      this.isLoading = false,
      this.error,
      this.searchQuery,
      this.filter,
      this.selectedGoal,
      this.showAllGoals = false})
      : _goals = goals,
        _goalProgress = goalProgress,
        _contributions = contributions,
        super._();

  final List<Goal> _goals;
  @override
  @JsonKey()
  List<Goal> get goals {
    if (_goals is EqualUnmodifiableListView) return _goals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goals);
  }

  final List<GoalProgress> _goalProgress;
  @override
  @JsonKey()
  List<GoalProgress> get goalProgress {
    if (_goalProgress is EqualUnmodifiableListView) return _goalProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goalProgress);
  }

  final List<GoalContribution> _contributions;
  @override
  @JsonKey()
  List<GoalContribution> get contributions {
    if (_contributions is EqualUnmodifiableListView) return _contributions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contributions);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  final String? searchQuery;
  @override
  final GoalFilter? filter;
  @override
  final Goal? selectedGoal;
  @override
  @JsonKey()
  final bool showAllGoals;

  @override
  String toString() {
    return 'GoalState(goals: $goals, goalProgress: $goalProgress, contributions: $contributions, isLoading: $isLoading, error: $error, searchQuery: $searchQuery, filter: $filter, selectedGoal: $selectedGoal, showAllGoals: $showAllGoals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalStateImpl &&
            const DeepCollectionEquality().equals(other._goals, _goals) &&
            const DeepCollectionEquality()
                .equals(other._goalProgress, _goalProgress) &&
            const DeepCollectionEquality()
                .equals(other._contributions, _contributions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.selectedGoal, selectedGoal) ||
                other.selectedGoal == selectedGoal) &&
            (identical(other.showAllGoals, showAllGoals) ||
                other.showAllGoals == showAllGoals));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_goals),
      const DeepCollectionEquality().hash(_goalProgress),
      const DeepCollectionEquality().hash(_contributions),
      isLoading,
      error,
      searchQuery,
      filter,
      selectedGoal,
      showAllGoals);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalStateImplCopyWith<_$GoalStateImpl> get copyWith =>
      __$$GoalStateImplCopyWithImpl<_$GoalStateImpl>(this, _$identity);
}

abstract class _GoalState extends GoalState {
  const factory _GoalState(
      {final List<Goal> goals,
      final List<GoalProgress> goalProgress,
      final List<GoalContribution> contributions,
      final bool isLoading,
      final String? error,
      final String? searchQuery,
      final GoalFilter? filter,
      final Goal? selectedGoal,
      final bool showAllGoals}) = _$GoalStateImpl;
  const _GoalState._() : super._();

  @override
  List<Goal> get goals;
  @override
  List<GoalProgress> get goalProgress;
  @override
  List<GoalContribution> get contributions;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  String? get searchQuery;
  @override
  GoalFilter? get filter;
  @override
  Goal? get selectedGoal;
  @override
  bool get showAllGoals;
  @override
  @JsonKey(ignore: true)
  _$$GoalStateImplCopyWith<_$GoalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GoalFilter {
  GoalPriority? get priority => throw _privateConstructorUsedError;
  GoalCategory? get category => throw _privateConstructorUsedError;
  bool? get showCompleted => throw _privateConstructorUsedError;
  DateTime? get deadlineStart => throw _privateConstructorUsedError;
  DateTime? get deadlineEnd => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GoalFilterCopyWith<GoalFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalFilterCopyWith<$Res> {
  factory $GoalFilterCopyWith(
          GoalFilter value, $Res Function(GoalFilter) then) =
      _$GoalFilterCopyWithImpl<$Res, GoalFilter>;
  @useResult
  $Res call(
      {GoalPriority? priority,
      GoalCategory? category,
      bool? showCompleted,
      DateTime? deadlineStart,
      DateTime? deadlineEnd});
}

/// @nodoc
class _$GoalFilterCopyWithImpl<$Res, $Val extends GoalFilter>
    implements $GoalFilterCopyWith<$Res> {
  _$GoalFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = freezed,
    Object? category = freezed,
    Object? showCompleted = freezed,
    Object? deadlineStart = freezed,
    Object? deadlineEnd = freezed,
  }) {
    return _then(_value.copyWith(
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as GoalPriority?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as GoalCategory?,
      showCompleted: freezed == showCompleted
          ? _value.showCompleted
          : showCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      deadlineStart: freezed == deadlineStart
          ? _value.deadlineStart
          : deadlineStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deadlineEnd: freezed == deadlineEnd
          ? _value.deadlineEnd
          : deadlineEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalFilterImplCopyWith<$Res>
    implements $GoalFilterCopyWith<$Res> {
  factory _$$GoalFilterImplCopyWith(
          _$GoalFilterImpl value, $Res Function(_$GoalFilterImpl) then) =
      __$$GoalFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GoalPriority? priority,
      GoalCategory? category,
      bool? showCompleted,
      DateTime? deadlineStart,
      DateTime? deadlineEnd});
}

/// @nodoc
class __$$GoalFilterImplCopyWithImpl<$Res>
    extends _$GoalFilterCopyWithImpl<$Res, _$GoalFilterImpl>
    implements _$$GoalFilterImplCopyWith<$Res> {
  __$$GoalFilterImplCopyWithImpl(
      _$GoalFilterImpl _value, $Res Function(_$GoalFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = freezed,
    Object? category = freezed,
    Object? showCompleted = freezed,
    Object? deadlineStart = freezed,
    Object? deadlineEnd = freezed,
  }) {
    return _then(_$GoalFilterImpl(
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as GoalPriority?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as GoalCategory?,
      showCompleted: freezed == showCompleted
          ? _value.showCompleted
          : showCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      deadlineStart: freezed == deadlineStart
          ? _value.deadlineStart
          : deadlineStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deadlineEnd: freezed == deadlineEnd
          ? _value.deadlineEnd
          : deadlineEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$GoalFilterImpl extends _GoalFilter {
  const _$GoalFilterImpl(
      {this.priority,
      this.category,
      this.showCompleted,
      this.deadlineStart,
      this.deadlineEnd})
      : super._();

  @override
  final GoalPriority? priority;
  @override
  final GoalCategory? category;
  @override
  final bool? showCompleted;
  @override
  final DateTime? deadlineStart;
  @override
  final DateTime? deadlineEnd;

  @override
  String toString() {
    return 'GoalFilter(priority: $priority, category: $category, showCompleted: $showCompleted, deadlineStart: $deadlineStart, deadlineEnd: $deadlineEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalFilterImpl &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.showCompleted, showCompleted) ||
                other.showCompleted == showCompleted) &&
            (identical(other.deadlineStart, deadlineStart) ||
                other.deadlineStart == deadlineStart) &&
            (identical(other.deadlineEnd, deadlineEnd) ||
                other.deadlineEnd == deadlineEnd));
  }

  @override
  int get hashCode => Object.hash(runtimeType, priority, category,
      showCompleted, deadlineStart, deadlineEnd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalFilterImplCopyWith<_$GoalFilterImpl> get copyWith =>
      __$$GoalFilterImplCopyWithImpl<_$GoalFilterImpl>(this, _$identity);
}

abstract class _GoalFilter extends GoalFilter {
  const factory _GoalFilter(
      {final GoalPriority? priority,
      final GoalCategory? category,
      final bool? showCompleted,
      final DateTime? deadlineStart,
      final DateTime? deadlineEnd}) = _$GoalFilterImpl;
  const _GoalFilter._() : super._();

  @override
  GoalPriority? get priority;
  @override
  GoalCategory? get category;
  @override
  bool? get showCompleted;
  @override
  DateTime? get deadlineStart;
  @override
  DateTime? get deadlineEnd;
  @override
  @JsonKey(ignore: true)
  _$$GoalFilterImplCopyWith<_$GoalFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GoalStats {
  int get totalGoals => throw _privateConstructorUsedError;
  int get activeGoals => throw _privateConstructorUsedError;
  int get completedGoals => throw _privateConstructorUsedError;
  double get totalTargetAmount => throw _privateConstructorUsedError;
  double get totalCurrentAmount => throw _privateConstructorUsedError;
  double get overallProgress => throw _privateConstructorUsedError;
  int get highPriorityGoals => throw _privateConstructorUsedError;
  int get overdueGoals => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GoalStatsCopyWith<GoalStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalStatsCopyWith<$Res> {
  factory $GoalStatsCopyWith(GoalStats value, $Res Function(GoalStats) then) =
      _$GoalStatsCopyWithImpl<$Res, GoalStats>;
  @useResult
  $Res call(
      {int totalGoals,
      int activeGoals,
      int completedGoals,
      double totalTargetAmount,
      double totalCurrentAmount,
      double overallProgress,
      int highPriorityGoals,
      int overdueGoals});
}

/// @nodoc
class _$GoalStatsCopyWithImpl<$Res, $Val extends GoalStats>
    implements $GoalStatsCopyWith<$Res> {
  _$GoalStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalGoals = null,
    Object? activeGoals = null,
    Object? completedGoals = null,
    Object? totalTargetAmount = null,
    Object? totalCurrentAmount = null,
    Object? overallProgress = null,
    Object? highPriorityGoals = null,
    Object? overdueGoals = null,
  }) {
    return _then(_value.copyWith(
      totalGoals: null == totalGoals
          ? _value.totalGoals
          : totalGoals // ignore: cast_nullable_to_non_nullable
              as int,
      activeGoals: null == activeGoals
          ? _value.activeGoals
          : activeGoals // ignore: cast_nullable_to_non_nullable
              as int,
      completedGoals: null == completedGoals
          ? _value.completedGoals
          : completedGoals // ignore: cast_nullable_to_non_nullable
              as int,
      totalTargetAmount: null == totalTargetAmount
          ? _value.totalTargetAmount
          : totalTargetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalCurrentAmount: null == totalCurrentAmount
          ? _value.totalCurrentAmount
          : totalCurrentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      overallProgress: null == overallProgress
          ? _value.overallProgress
          : overallProgress // ignore: cast_nullable_to_non_nullable
              as double,
      highPriorityGoals: null == highPriorityGoals
          ? _value.highPriorityGoals
          : highPriorityGoals // ignore: cast_nullable_to_non_nullable
              as int,
      overdueGoals: null == overdueGoals
          ? _value.overdueGoals
          : overdueGoals // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalStatsImplCopyWith<$Res>
    implements $GoalStatsCopyWith<$Res> {
  factory _$$GoalStatsImplCopyWith(
          _$GoalStatsImpl value, $Res Function(_$GoalStatsImpl) then) =
      __$$GoalStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalGoals,
      int activeGoals,
      int completedGoals,
      double totalTargetAmount,
      double totalCurrentAmount,
      double overallProgress,
      int highPriorityGoals,
      int overdueGoals});
}

/// @nodoc
class __$$GoalStatsImplCopyWithImpl<$Res>
    extends _$GoalStatsCopyWithImpl<$Res, _$GoalStatsImpl>
    implements _$$GoalStatsImplCopyWith<$Res> {
  __$$GoalStatsImplCopyWithImpl(
      _$GoalStatsImpl _value, $Res Function(_$GoalStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalGoals = null,
    Object? activeGoals = null,
    Object? completedGoals = null,
    Object? totalTargetAmount = null,
    Object? totalCurrentAmount = null,
    Object? overallProgress = null,
    Object? highPriorityGoals = null,
    Object? overdueGoals = null,
  }) {
    return _then(_$GoalStatsImpl(
      totalGoals: null == totalGoals
          ? _value.totalGoals
          : totalGoals // ignore: cast_nullable_to_non_nullable
              as int,
      activeGoals: null == activeGoals
          ? _value.activeGoals
          : activeGoals // ignore: cast_nullable_to_non_nullable
              as int,
      completedGoals: null == completedGoals
          ? _value.completedGoals
          : completedGoals // ignore: cast_nullable_to_non_nullable
              as int,
      totalTargetAmount: null == totalTargetAmount
          ? _value.totalTargetAmount
          : totalTargetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalCurrentAmount: null == totalCurrentAmount
          ? _value.totalCurrentAmount
          : totalCurrentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      overallProgress: null == overallProgress
          ? _value.overallProgress
          : overallProgress // ignore: cast_nullable_to_non_nullable
              as double,
      highPriorityGoals: null == highPriorityGoals
          ? _value.highPriorityGoals
          : highPriorityGoals // ignore: cast_nullable_to_non_nullable
              as int,
      overdueGoals: null == overdueGoals
          ? _value.overdueGoals
          : overdueGoals // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GoalStatsImpl extends _GoalStats {
  const _$GoalStatsImpl(
      {this.totalGoals = 0,
      this.activeGoals = 0,
      this.completedGoals = 0,
      this.totalTargetAmount = 0.0,
      this.totalCurrentAmount = 0.0,
      this.overallProgress = 0.0,
      this.highPriorityGoals = 0,
      this.overdueGoals = 0})
      : super._();

  @override
  @JsonKey()
  final int totalGoals;
  @override
  @JsonKey()
  final int activeGoals;
  @override
  @JsonKey()
  final int completedGoals;
  @override
  @JsonKey()
  final double totalTargetAmount;
  @override
  @JsonKey()
  final double totalCurrentAmount;
  @override
  @JsonKey()
  final double overallProgress;
  @override
  @JsonKey()
  final int highPriorityGoals;
  @override
  @JsonKey()
  final int overdueGoals;

  @override
  String toString() {
    return 'GoalStats(totalGoals: $totalGoals, activeGoals: $activeGoals, completedGoals: $completedGoals, totalTargetAmount: $totalTargetAmount, totalCurrentAmount: $totalCurrentAmount, overallProgress: $overallProgress, highPriorityGoals: $highPriorityGoals, overdueGoals: $overdueGoals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalStatsImpl &&
            (identical(other.totalGoals, totalGoals) ||
                other.totalGoals == totalGoals) &&
            (identical(other.activeGoals, activeGoals) ||
                other.activeGoals == activeGoals) &&
            (identical(other.completedGoals, completedGoals) ||
                other.completedGoals == completedGoals) &&
            (identical(other.totalTargetAmount, totalTargetAmount) ||
                other.totalTargetAmount == totalTargetAmount) &&
            (identical(other.totalCurrentAmount, totalCurrentAmount) ||
                other.totalCurrentAmount == totalCurrentAmount) &&
            (identical(other.overallProgress, overallProgress) ||
                other.overallProgress == overallProgress) &&
            (identical(other.highPriorityGoals, highPriorityGoals) ||
                other.highPriorityGoals == highPriorityGoals) &&
            (identical(other.overdueGoals, overdueGoals) ||
                other.overdueGoals == overdueGoals));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalGoals,
      activeGoals,
      completedGoals,
      totalTargetAmount,
      totalCurrentAmount,
      overallProgress,
      highPriorityGoals,
      overdueGoals);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalStatsImplCopyWith<_$GoalStatsImpl> get copyWith =>
      __$$GoalStatsImplCopyWithImpl<_$GoalStatsImpl>(this, _$identity);
}

abstract class _GoalStats extends GoalStats {
  const factory _GoalStats(
      {final int totalGoals,
      final int activeGoals,
      final int completedGoals,
      final double totalTargetAmount,
      final double totalCurrentAmount,
      final double overallProgress,
      final int highPriorityGoals,
      final int overdueGoals}) = _$GoalStatsImpl;
  const _GoalStats._() : super._();

  @override
  int get totalGoals;
  @override
  int get activeGoals;
  @override
  int get completedGoals;
  @override
  double get totalTargetAmount;
  @override
  double get totalCurrentAmount;
  @override
  double get overallProgress;
  @override
  int get highPriorityGoals;
  @override
  int get overdueGoals;
  @override
  @JsonKey(ignore: true)
  _$$GoalStatsImplCopyWith<_$GoalStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
