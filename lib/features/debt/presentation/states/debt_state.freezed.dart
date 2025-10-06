// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DebtState {
  List<Debt> get debts => throw _privateConstructorUsedError;
  List<Debt> get filteredDebts => throw _privateConstructorUsedError;
  List<Debt> get activeDebts => throw _privateConstructorUsedError;
  List<Debt> get overdueDebts => throw _privateConstructorUsedError;
  Debt? get selectedDebt => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  DebtFilter? get filter => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DebtStateCopyWith<DebtState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebtStateCopyWith<$Res> {
  factory $DebtStateCopyWith(DebtState value, $Res Function(DebtState) then) =
      _$DebtStateCopyWithImpl<$Res, DebtState>;
  @useResult
  $Res call(
      {List<Debt> debts,
      List<Debt> filteredDebts,
      List<Debt> activeDebts,
      List<Debt> overdueDebts,
      Debt? selectedDebt,
      String? searchQuery,
      DebtFilter? filter,
      bool isLoading,
      String? error});

  $DebtCopyWith<$Res>? get selectedDebt;
}

/// @nodoc
class _$DebtStateCopyWithImpl<$Res, $Val extends DebtState>
    implements $DebtStateCopyWith<$Res> {
  _$DebtStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? debts = null,
    Object? filteredDebts = null,
    Object? activeDebts = null,
    Object? overdueDebts = null,
    Object? selectedDebt = freezed,
    Object? searchQuery = freezed,
    Object? filter = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      debts: null == debts
          ? _value.debts
          : debts // ignore: cast_nullable_to_non_nullable
              as List<Debt>,
      filteredDebts: null == filteredDebts
          ? _value.filteredDebts
          : filteredDebts // ignore: cast_nullable_to_non_nullable
              as List<Debt>,
      activeDebts: null == activeDebts
          ? _value.activeDebts
          : activeDebts // ignore: cast_nullable_to_non_nullable
              as List<Debt>,
      overdueDebts: null == overdueDebts
          ? _value.overdueDebts
          : overdueDebts // ignore: cast_nullable_to_non_nullable
              as List<Debt>,
      selectedDebt: freezed == selectedDebt
          ? _value.selectedDebt
          : selectedDebt // ignore: cast_nullable_to_non_nullable
              as Debt?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as DebtFilter?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DebtCopyWith<$Res>? get selectedDebt {
    if (_value.selectedDebt == null) {
      return null;
    }

    return $DebtCopyWith<$Res>(_value.selectedDebt!, (value) {
      return _then(_value.copyWith(selectedDebt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DebtStateImplCopyWith<$Res>
    implements $DebtStateCopyWith<$Res> {
  factory _$$DebtStateImplCopyWith(
          _$DebtStateImpl value, $Res Function(_$DebtStateImpl) then) =
      __$$DebtStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Debt> debts,
      List<Debt> filteredDebts,
      List<Debt> activeDebts,
      List<Debt> overdueDebts,
      Debt? selectedDebt,
      String? searchQuery,
      DebtFilter? filter,
      bool isLoading,
      String? error});

  @override
  $DebtCopyWith<$Res>? get selectedDebt;
}

/// @nodoc
class __$$DebtStateImplCopyWithImpl<$Res>
    extends _$DebtStateCopyWithImpl<$Res, _$DebtStateImpl>
    implements _$$DebtStateImplCopyWith<$Res> {
  __$$DebtStateImplCopyWithImpl(
      _$DebtStateImpl _value, $Res Function(_$DebtStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? debts = null,
    Object? filteredDebts = null,
    Object? activeDebts = null,
    Object? overdueDebts = null,
    Object? selectedDebt = freezed,
    Object? searchQuery = freezed,
    Object? filter = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$DebtStateImpl(
      debts: null == debts
          ? _value._debts
          : debts // ignore: cast_nullable_to_non_nullable
              as List<Debt>,
      filteredDebts: null == filteredDebts
          ? _value._filteredDebts
          : filteredDebts // ignore: cast_nullable_to_non_nullable
              as List<Debt>,
      activeDebts: null == activeDebts
          ? _value._activeDebts
          : activeDebts // ignore: cast_nullable_to_non_nullable
              as List<Debt>,
      overdueDebts: null == overdueDebts
          ? _value._overdueDebts
          : overdueDebts // ignore: cast_nullable_to_non_nullable
              as List<Debt>,
      selectedDebt: freezed == selectedDebt
          ? _value.selectedDebt
          : selectedDebt // ignore: cast_nullable_to_non_nullable
              as Debt?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as DebtFilter?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DebtStateImpl extends _DebtState {
  const _$DebtStateImpl(
      {final List<Debt> debts = const [],
      final List<Debt> filteredDebts = const [],
      final List<Debt> activeDebts = const [],
      final List<Debt> overdueDebts = const [],
      this.selectedDebt,
      this.searchQuery,
      this.filter,
      this.isLoading = false,
      this.error})
      : _debts = debts,
        _filteredDebts = filteredDebts,
        _activeDebts = activeDebts,
        _overdueDebts = overdueDebts,
        super._();

  final List<Debt> _debts;
  @override
  @JsonKey()
  List<Debt> get debts {
    if (_debts is EqualUnmodifiableListView) return _debts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_debts);
  }

  final List<Debt> _filteredDebts;
  @override
  @JsonKey()
  List<Debt> get filteredDebts {
    if (_filteredDebts is EqualUnmodifiableListView) return _filteredDebts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredDebts);
  }

  final List<Debt> _activeDebts;
  @override
  @JsonKey()
  List<Debt> get activeDebts {
    if (_activeDebts is EqualUnmodifiableListView) return _activeDebts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeDebts);
  }

  final List<Debt> _overdueDebts;
  @override
  @JsonKey()
  List<Debt> get overdueDebts {
    if (_overdueDebts is EqualUnmodifiableListView) return _overdueDebts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_overdueDebts);
  }

  @override
  final Debt? selectedDebt;
  @override
  final String? searchQuery;
  @override
  final DebtFilter? filter;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'DebtState(debts: $debts, filteredDebts: $filteredDebts, activeDebts: $activeDebts, overdueDebts: $overdueDebts, selectedDebt: $selectedDebt, searchQuery: $searchQuery, filter: $filter, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebtStateImpl &&
            const DeepCollectionEquality().equals(other._debts, _debts) &&
            const DeepCollectionEquality()
                .equals(other._filteredDebts, _filteredDebts) &&
            const DeepCollectionEquality()
                .equals(other._activeDebts, _activeDebts) &&
            const DeepCollectionEquality()
                .equals(other._overdueDebts, _overdueDebts) &&
            (identical(other.selectedDebt, selectedDebt) ||
                other.selectedDebt == selectedDebt) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_debts),
      const DeepCollectionEquality().hash(_filteredDebts),
      const DeepCollectionEquality().hash(_activeDebts),
      const DeepCollectionEquality().hash(_overdueDebts),
      selectedDebt,
      searchQuery,
      filter,
      isLoading,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DebtStateImplCopyWith<_$DebtStateImpl> get copyWith =>
      __$$DebtStateImplCopyWithImpl<_$DebtStateImpl>(this, _$identity);
}

abstract class _DebtState extends DebtState {
  const factory _DebtState(
      {final List<Debt> debts,
      final List<Debt> filteredDebts,
      final List<Debt> activeDebts,
      final List<Debt> overdueDebts,
      final Debt? selectedDebt,
      final String? searchQuery,
      final DebtFilter? filter,
      final bool isLoading,
      final String? error}) = _$DebtStateImpl;
  const _DebtState._() : super._();

  @override
  List<Debt> get debts;
  @override
  List<Debt> get filteredDebts;
  @override
  List<Debt> get activeDebts;
  @override
  List<Debt> get overdueDebts;
  @override
  Debt? get selectedDebt;
  @override
  String? get searchQuery;
  @override
  DebtFilter? get filter;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$DebtStateImplCopyWith<_$DebtStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DebtStats {
  double get totalDebt => throw _privateConstructorUsedError;
  double get totalRemaining => throw _privateConstructorUsedError;
  double get totalPaid => throw _privateConstructorUsedError;
  int get debtCount => throw _privateConstructorUsedError;
  double get averageDebtAmount => throw _privateConstructorUsedError;
  int get overdueCount => throw _privateConstructorUsedError;
  int get activeCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DebtStatsCopyWith<DebtStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebtStatsCopyWith<$Res> {
  factory $DebtStatsCopyWith(DebtStats value, $Res Function(DebtStats) then) =
      _$DebtStatsCopyWithImpl<$Res, DebtStats>;
  @useResult
  $Res call(
      {double totalDebt,
      double totalRemaining,
      double totalPaid,
      int debtCount,
      double averageDebtAmount,
      int overdueCount,
      int activeCount});
}

/// @nodoc
class _$DebtStatsCopyWithImpl<$Res, $Val extends DebtStats>
    implements $DebtStatsCopyWith<$Res> {
  _$DebtStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalDebt = null,
    Object? totalRemaining = null,
    Object? totalPaid = null,
    Object? debtCount = null,
    Object? averageDebtAmount = null,
    Object? overdueCount = null,
    Object? activeCount = null,
  }) {
    return _then(_value.copyWith(
      totalDebt: null == totalDebt
          ? _value.totalDebt
          : totalDebt // ignore: cast_nullable_to_non_nullable
              as double,
      totalRemaining: null == totalRemaining
          ? _value.totalRemaining
          : totalRemaining // ignore: cast_nullable_to_non_nullable
              as double,
      totalPaid: null == totalPaid
          ? _value.totalPaid
          : totalPaid // ignore: cast_nullable_to_non_nullable
              as double,
      debtCount: null == debtCount
          ? _value.debtCount
          : debtCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageDebtAmount: null == averageDebtAmount
          ? _value.averageDebtAmount
          : averageDebtAmount // ignore: cast_nullable_to_non_nullable
              as double,
      overdueCount: null == overdueCount
          ? _value.overdueCount
          : overdueCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeCount: null == activeCount
          ? _value.activeCount
          : activeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DebtStatsImplCopyWith<$Res>
    implements $DebtStatsCopyWith<$Res> {
  factory _$$DebtStatsImplCopyWith(
          _$DebtStatsImpl value, $Res Function(_$DebtStatsImpl) then) =
      __$$DebtStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalDebt,
      double totalRemaining,
      double totalPaid,
      int debtCount,
      double averageDebtAmount,
      int overdueCount,
      int activeCount});
}

/// @nodoc
class __$$DebtStatsImplCopyWithImpl<$Res>
    extends _$DebtStatsCopyWithImpl<$Res, _$DebtStatsImpl>
    implements _$$DebtStatsImplCopyWith<$Res> {
  __$$DebtStatsImplCopyWithImpl(
      _$DebtStatsImpl _value, $Res Function(_$DebtStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalDebt = null,
    Object? totalRemaining = null,
    Object? totalPaid = null,
    Object? debtCount = null,
    Object? averageDebtAmount = null,
    Object? overdueCount = null,
    Object? activeCount = null,
  }) {
    return _then(_$DebtStatsImpl(
      totalDebt: null == totalDebt
          ? _value.totalDebt
          : totalDebt // ignore: cast_nullable_to_non_nullable
              as double,
      totalRemaining: null == totalRemaining
          ? _value.totalRemaining
          : totalRemaining // ignore: cast_nullable_to_non_nullable
              as double,
      totalPaid: null == totalPaid
          ? _value.totalPaid
          : totalPaid // ignore: cast_nullable_to_non_nullable
              as double,
      debtCount: null == debtCount
          ? _value.debtCount
          : debtCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageDebtAmount: null == averageDebtAmount
          ? _value.averageDebtAmount
          : averageDebtAmount // ignore: cast_nullable_to_non_nullable
              as double,
      overdueCount: null == overdueCount
          ? _value.overdueCount
          : overdueCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeCount: null == activeCount
          ? _value.activeCount
          : activeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DebtStatsImpl extends _DebtStats {
  const _$DebtStatsImpl(
      {this.totalDebt = 0.0,
      this.totalRemaining = 0.0,
      this.totalPaid = 0.0,
      this.debtCount = 0,
      this.averageDebtAmount = 0.0,
      this.overdueCount = 0,
      this.activeCount = 0})
      : super._();

  @override
  @JsonKey()
  final double totalDebt;
  @override
  @JsonKey()
  final double totalRemaining;
  @override
  @JsonKey()
  final double totalPaid;
  @override
  @JsonKey()
  final int debtCount;
  @override
  @JsonKey()
  final double averageDebtAmount;
  @override
  @JsonKey()
  final int overdueCount;
  @override
  @JsonKey()
  final int activeCount;

  @override
  String toString() {
    return 'DebtStats(totalDebt: $totalDebt, totalRemaining: $totalRemaining, totalPaid: $totalPaid, debtCount: $debtCount, averageDebtAmount: $averageDebtAmount, overdueCount: $overdueCount, activeCount: $activeCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebtStatsImpl &&
            (identical(other.totalDebt, totalDebt) ||
                other.totalDebt == totalDebt) &&
            (identical(other.totalRemaining, totalRemaining) ||
                other.totalRemaining == totalRemaining) &&
            (identical(other.totalPaid, totalPaid) ||
                other.totalPaid == totalPaid) &&
            (identical(other.debtCount, debtCount) ||
                other.debtCount == debtCount) &&
            (identical(other.averageDebtAmount, averageDebtAmount) ||
                other.averageDebtAmount == averageDebtAmount) &&
            (identical(other.overdueCount, overdueCount) ||
                other.overdueCount == overdueCount) &&
            (identical(other.activeCount, activeCount) ||
                other.activeCount == activeCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalDebt, totalRemaining,
      totalPaid, debtCount, averageDebtAmount, overdueCount, activeCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DebtStatsImplCopyWith<_$DebtStatsImpl> get copyWith =>
      __$$DebtStatsImplCopyWithImpl<_$DebtStatsImpl>(this, _$identity);
}

abstract class _DebtStats extends DebtStats {
  const factory _DebtStats(
      {final double totalDebt,
      final double totalRemaining,
      final double totalPaid,
      final int debtCount,
      final double averageDebtAmount,
      final int overdueCount,
      final int activeCount}) = _$DebtStatsImpl;
  const _DebtStats._() : super._();

  @override
  double get totalDebt;
  @override
  double get totalRemaining;
  @override
  double get totalPaid;
  @override
  int get debtCount;
  @override
  double get averageDebtAmount;
  @override
  int get overdueCount;
  @override
  int get activeCount;
  @override
  @JsonKey(ignore: true)
  _$$DebtStatsImplCopyWith<_$DebtStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
