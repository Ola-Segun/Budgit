// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BudgetState {
  List<Budget> get budgets => throw _privateConstructorUsedError;
  List<BudgetStatus> get budgetStatuses => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  BudgetFilter? get filter => throw _privateConstructorUsedError;
  Budget? get selectedBudget => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetStateCopyWith<BudgetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetStateCopyWith<$Res> {
  factory $BudgetStateCopyWith(
          BudgetState value, $Res Function(BudgetState) then) =
      _$BudgetStateCopyWithImpl<$Res, BudgetState>;
  @useResult
  $Res call(
      {List<Budget> budgets,
      List<BudgetStatus> budgetStatuses,
      bool isLoading,
      String? error,
      String? searchQuery,
      BudgetFilter? filter,
      Budget? selectedBudget});

  $BudgetFilterCopyWith<$Res>? get filter;
  $BudgetCopyWith<$Res>? get selectedBudget;
}

/// @nodoc
class _$BudgetStateCopyWithImpl<$Res, $Val extends BudgetState>
    implements $BudgetStateCopyWith<$Res> {
  _$BudgetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? budgets = null,
    Object? budgetStatuses = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? searchQuery = freezed,
    Object? filter = freezed,
    Object? selectedBudget = freezed,
  }) {
    return _then(_value.copyWith(
      budgets: null == budgets
          ? _value.budgets
          : budgets // ignore: cast_nullable_to_non_nullable
              as List<Budget>,
      budgetStatuses: null == budgetStatuses
          ? _value.budgetStatuses
          : budgetStatuses // ignore: cast_nullable_to_non_nullable
              as List<BudgetStatus>,
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
              as BudgetFilter?,
      selectedBudget: freezed == selectedBudget
          ? _value.selectedBudget
          : selectedBudget // ignore: cast_nullable_to_non_nullable
              as Budget?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetFilterCopyWith<$Res>? get filter {
    if (_value.filter == null) {
      return null;
    }

    return $BudgetFilterCopyWith<$Res>(_value.filter!, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetCopyWith<$Res>? get selectedBudget {
    if (_value.selectedBudget == null) {
      return null;
    }

    return $BudgetCopyWith<$Res>(_value.selectedBudget!, (value) {
      return _then(_value.copyWith(selectedBudget: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BudgetStateImplCopyWith<$Res>
    implements $BudgetStateCopyWith<$Res> {
  factory _$$BudgetStateImplCopyWith(
          _$BudgetStateImpl value, $Res Function(_$BudgetStateImpl) then) =
      __$$BudgetStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Budget> budgets,
      List<BudgetStatus> budgetStatuses,
      bool isLoading,
      String? error,
      String? searchQuery,
      BudgetFilter? filter,
      Budget? selectedBudget});

  @override
  $BudgetFilterCopyWith<$Res>? get filter;
  @override
  $BudgetCopyWith<$Res>? get selectedBudget;
}

/// @nodoc
class __$$BudgetStateImplCopyWithImpl<$Res>
    extends _$BudgetStateCopyWithImpl<$Res, _$BudgetStateImpl>
    implements _$$BudgetStateImplCopyWith<$Res> {
  __$$BudgetStateImplCopyWithImpl(
      _$BudgetStateImpl _value, $Res Function(_$BudgetStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? budgets = null,
    Object? budgetStatuses = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? searchQuery = freezed,
    Object? filter = freezed,
    Object? selectedBudget = freezed,
  }) {
    return _then(_$BudgetStateImpl(
      budgets: null == budgets
          ? _value._budgets
          : budgets // ignore: cast_nullable_to_non_nullable
              as List<Budget>,
      budgetStatuses: null == budgetStatuses
          ? _value._budgetStatuses
          : budgetStatuses // ignore: cast_nullable_to_non_nullable
              as List<BudgetStatus>,
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
              as BudgetFilter?,
      selectedBudget: freezed == selectedBudget
          ? _value.selectedBudget
          : selectedBudget // ignore: cast_nullable_to_non_nullable
              as Budget?,
    ));
  }
}

/// @nodoc

class _$BudgetStateImpl extends _BudgetState {
  const _$BudgetStateImpl(
      {final List<Budget> budgets = const [],
      final List<BudgetStatus> budgetStatuses = const [],
      this.isLoading = false,
      this.error,
      this.searchQuery,
      this.filter,
      this.selectedBudget})
      : _budgets = budgets,
        _budgetStatuses = budgetStatuses,
        super._();

  final List<Budget> _budgets;
  @override
  @JsonKey()
  List<Budget> get budgets {
    if (_budgets is EqualUnmodifiableListView) return _budgets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_budgets);
  }

  final List<BudgetStatus> _budgetStatuses;
  @override
  @JsonKey()
  List<BudgetStatus> get budgetStatuses {
    if (_budgetStatuses is EqualUnmodifiableListView) return _budgetStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_budgetStatuses);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  final String? searchQuery;
  @override
  final BudgetFilter? filter;
  @override
  final Budget? selectedBudget;

  @override
  String toString() {
    return 'BudgetState(budgets: $budgets, budgetStatuses: $budgetStatuses, isLoading: $isLoading, error: $error, searchQuery: $searchQuery, filter: $filter, selectedBudget: $selectedBudget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetStateImpl &&
            const DeepCollectionEquality().equals(other._budgets, _budgets) &&
            const DeepCollectionEquality()
                .equals(other._budgetStatuses, _budgetStatuses) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.selectedBudget, selectedBudget) ||
                other.selectedBudget == selectedBudget));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_budgets),
      const DeepCollectionEquality().hash(_budgetStatuses),
      isLoading,
      error,
      searchQuery,
      filter,
      selectedBudget);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetStateImplCopyWith<_$BudgetStateImpl> get copyWith =>
      __$$BudgetStateImplCopyWithImpl<_$BudgetStateImpl>(this, _$identity);
}

abstract class _BudgetState extends BudgetState {
  const factory _BudgetState(
      {final List<Budget> budgets,
      final List<BudgetStatus> budgetStatuses,
      final bool isLoading,
      final String? error,
      final String? searchQuery,
      final BudgetFilter? filter,
      final Budget? selectedBudget}) = _$BudgetStateImpl;
  const _BudgetState._() : super._();

  @override
  List<Budget> get budgets;
  @override
  List<BudgetStatus> get budgetStatuses;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  String? get searchQuery;
  @override
  BudgetFilter? get filter;
  @override
  Budget? get selectedBudget;
  @override
  @JsonKey(ignore: true)
  _$$BudgetStateImplCopyWith<_$BudgetStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BudgetFilter {
  BudgetType? get budgetType => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetFilterCopyWith<BudgetFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetFilterCopyWith<$Res> {
  factory $BudgetFilterCopyWith(
          BudgetFilter value, $Res Function(BudgetFilter) then) =
      _$BudgetFilterCopyWithImpl<$Res, BudgetFilter>;
  @useResult
  $Res call(
      {BudgetType? budgetType,
      bool? isActive,
      DateTime? startDate,
      DateTime? endDate});
}

/// @nodoc
class _$BudgetFilterCopyWithImpl<$Res, $Val extends BudgetFilter>
    implements $BudgetFilterCopyWith<$Res> {
  _$BudgetFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? budgetType = freezed,
    Object? isActive = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_value.copyWith(
      budgetType: freezed == budgetType
          ? _value.budgetType
          : budgetType // ignore: cast_nullable_to_non_nullable
              as BudgetType?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetFilterImplCopyWith<$Res>
    implements $BudgetFilterCopyWith<$Res> {
  factory _$$BudgetFilterImplCopyWith(
          _$BudgetFilterImpl value, $Res Function(_$BudgetFilterImpl) then) =
      __$$BudgetFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BudgetType? budgetType,
      bool? isActive,
      DateTime? startDate,
      DateTime? endDate});
}

/// @nodoc
class __$$BudgetFilterImplCopyWithImpl<$Res>
    extends _$BudgetFilterCopyWithImpl<$Res, _$BudgetFilterImpl>
    implements _$$BudgetFilterImplCopyWith<$Res> {
  __$$BudgetFilterImplCopyWithImpl(
      _$BudgetFilterImpl _value, $Res Function(_$BudgetFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? budgetType = freezed,
    Object? isActive = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_$BudgetFilterImpl(
      budgetType: freezed == budgetType
          ? _value.budgetType
          : budgetType // ignore: cast_nullable_to_non_nullable
              as BudgetType?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$BudgetFilterImpl extends _BudgetFilter {
  const _$BudgetFilterImpl(
      {this.budgetType, this.isActive, this.startDate, this.endDate})
      : super._();

  @override
  final BudgetType? budgetType;
  @override
  final bool? isActive;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'BudgetFilter(budgetType: $budgetType, isActive: $isActive, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetFilterImpl &&
            (identical(other.budgetType, budgetType) ||
                other.budgetType == budgetType) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, budgetType, isActive, startDate, endDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetFilterImplCopyWith<_$BudgetFilterImpl> get copyWith =>
      __$$BudgetFilterImplCopyWithImpl<_$BudgetFilterImpl>(this, _$identity);
}

abstract class _BudgetFilter extends BudgetFilter {
  const factory _BudgetFilter(
      {final BudgetType? budgetType,
      final bool? isActive,
      final DateTime? startDate,
      final DateTime? endDate}) = _$BudgetFilterImpl;
  const _BudgetFilter._() : super._();

  @override
  BudgetType? get budgetType;
  @override
  bool? get isActive;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  @JsonKey(ignore: true)
  _$$BudgetFilterImplCopyWith<_$BudgetFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
