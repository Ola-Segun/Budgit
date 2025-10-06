// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionState {
  List<Transaction> get transactions => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  TransactionFilter? get filter => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get currentOffset => throw _privateConstructorUsedError;
  bool get hasMoreData => throw _privateConstructorUsedError;
  bool get isInitialized => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionStateCopyWith<TransactionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionStateCopyWith<$Res> {
  factory $TransactionStateCopyWith(
          TransactionState value, $Res Function(TransactionState) then) =
      _$TransactionStateCopyWithImpl<$Res, TransactionState>;
  @useResult
  $Res call(
      {List<Transaction> transactions,
      bool isLoading,
      bool isLoadingMore,
      String? error,
      String? searchQuery,
      TransactionFilter? filter,
      int pageSize,
      int currentOffset,
      bool hasMoreData,
      bool isInitialized});

  $TransactionFilterCopyWith<$Res>? get filter;
}

/// @nodoc
class _$TransactionStateCopyWithImpl<$Res, $Val extends TransactionState>
    implements $TransactionStateCopyWith<$Res> {
  _$TransactionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactions = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
    Object? searchQuery = freezed,
    Object? filter = freezed,
    Object? pageSize = null,
    Object? currentOffset = null,
    Object? hasMoreData = null,
    Object? isInitialized = null,
  }) {
    return _then(_value.copyWith(
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
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
              as TransactionFilter?,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      currentOffset: null == currentOffset
          ? _value.currentOffset
          : currentOffset // ignore: cast_nullable_to_non_nullable
              as int,
      hasMoreData: null == hasMoreData
          ? _value.hasMoreData
          : hasMoreData // ignore: cast_nullable_to_non_nullable
              as bool,
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionFilterCopyWith<$Res>? get filter {
    if (_value.filter == null) {
      return null;
    }

    return $TransactionFilterCopyWith<$Res>(_value.filter!, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionStateImplCopyWith<$Res>
    implements $TransactionStateCopyWith<$Res> {
  factory _$$TransactionStateImplCopyWith(_$TransactionStateImpl value,
          $Res Function(_$TransactionStateImpl) then) =
      __$$TransactionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Transaction> transactions,
      bool isLoading,
      bool isLoadingMore,
      String? error,
      String? searchQuery,
      TransactionFilter? filter,
      int pageSize,
      int currentOffset,
      bool hasMoreData,
      bool isInitialized});

  @override
  $TransactionFilterCopyWith<$Res>? get filter;
}

/// @nodoc
class __$$TransactionStateImplCopyWithImpl<$Res>
    extends _$TransactionStateCopyWithImpl<$Res, _$TransactionStateImpl>
    implements _$$TransactionStateImplCopyWith<$Res> {
  __$$TransactionStateImplCopyWithImpl(_$TransactionStateImpl _value,
      $Res Function(_$TransactionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactions = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
    Object? searchQuery = freezed,
    Object? filter = freezed,
    Object? pageSize = null,
    Object? currentOffset = null,
    Object? hasMoreData = null,
    Object? isInitialized = null,
  }) {
    return _then(_$TransactionStateImpl(
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
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
              as TransactionFilter?,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      currentOffset: null == currentOffset
          ? _value.currentOffset
          : currentOffset // ignore: cast_nullable_to_non_nullable
              as int,
      hasMoreData: null == hasMoreData
          ? _value.hasMoreData
          : hasMoreData // ignore: cast_nullable_to_non_nullable
              as bool,
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TransactionStateImpl extends _TransactionState {
  const _$TransactionStateImpl(
      {final List<Transaction> transactions = const [],
      this.isLoading = false,
      this.isLoadingMore = false,
      this.error,
      this.searchQuery,
      this.filter,
      this.pageSize = 20,
      this.currentOffset = 0,
      this.hasMoreData = false,
      this.isInitialized = false})
      : _transactions = transactions,
        super._();

  final List<Transaction> _transactions;
  @override
  @JsonKey()
  List<Transaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final String? error;
  @override
  final String? searchQuery;
  @override
  final TransactionFilter? filter;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final int currentOffset;
  @override
  @JsonKey()
  final bool hasMoreData;
  @override
  @JsonKey()
  final bool isInitialized;

  @override
  String toString() {
    return 'TransactionState(transactions: $transactions, isLoading: $isLoading, isLoadingMore: $isLoadingMore, error: $error, searchQuery: $searchQuery, filter: $filter, pageSize: $pageSize, currentOffset: $currentOffset, hasMoreData: $hasMoreData, isInitialized: $isInitialized)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionStateImpl &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.currentOffset, currentOffset) ||
                other.currentOffset == currentOffset) &&
            (identical(other.hasMoreData, hasMoreData) ||
                other.hasMoreData == hasMoreData) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_transactions),
      isLoading,
      isLoadingMore,
      error,
      searchQuery,
      filter,
      pageSize,
      currentOffset,
      hasMoreData,
      isInitialized);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionStateImplCopyWith<_$TransactionStateImpl> get copyWith =>
      __$$TransactionStateImplCopyWithImpl<_$TransactionStateImpl>(
          this, _$identity);
}

abstract class _TransactionState extends TransactionState {
  const factory _TransactionState(
      {final List<Transaction> transactions,
      final bool isLoading,
      final bool isLoadingMore,
      final String? error,
      final String? searchQuery,
      final TransactionFilter? filter,
      final int pageSize,
      final int currentOffset,
      final bool hasMoreData,
      final bool isInitialized}) = _$TransactionStateImpl;
  const _TransactionState._() : super._();

  @override
  List<Transaction> get transactions;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  String? get error;
  @override
  String? get searchQuery;
  @override
  TransactionFilter? get filter;
  @override
  int get pageSize;
  @override
  int get currentOffset;
  @override
  bool get hasMoreData;
  @override
  bool get isInitialized;
  @override
  @JsonKey(ignore: true)
  _$$TransactionStateImplCopyWith<_$TransactionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionStats {
  double get totalIncome => throw _privateConstructorUsedError;
  double get totalExpenses => throw _privateConstructorUsedError;
  double get netAmount => throw _privateConstructorUsedError;
  int get transactionCount => throw _privateConstructorUsedError;
  double get averageTransactionAmount => throw _privateConstructorUsedError;
  double get largestExpense => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionStatsCopyWith<TransactionStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionStatsCopyWith<$Res> {
  factory $TransactionStatsCopyWith(
          TransactionStats value, $Res Function(TransactionStats) then) =
      _$TransactionStatsCopyWithImpl<$Res, TransactionStats>;
  @useResult
  $Res call(
      {double totalIncome,
      double totalExpenses,
      double netAmount,
      int transactionCount,
      double averageTransactionAmount,
      double largestExpense});
}

/// @nodoc
class _$TransactionStatsCopyWithImpl<$Res, $Val extends TransactionStats>
    implements $TransactionStatsCopyWith<$Res> {
  _$TransactionStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncome = null,
    Object? totalExpenses = null,
    Object? netAmount = null,
    Object? transactionCount = null,
    Object? averageTransactionAmount = null,
    Object? largestExpense = null,
  }) {
    return _then(_value.copyWith(
      totalIncome: null == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double,
      totalExpenses: null == totalExpenses
          ? _value.totalExpenses
          : totalExpenses // ignore: cast_nullable_to_non_nullable
              as double,
      netAmount: null == netAmount
          ? _value.netAmount
          : netAmount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageTransactionAmount: null == averageTransactionAmount
          ? _value.averageTransactionAmount
          : averageTransactionAmount // ignore: cast_nullable_to_non_nullable
              as double,
      largestExpense: null == largestExpense
          ? _value.largestExpense
          : largestExpense // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionStatsImplCopyWith<$Res>
    implements $TransactionStatsCopyWith<$Res> {
  factory _$$TransactionStatsImplCopyWith(_$TransactionStatsImpl value,
          $Res Function(_$TransactionStatsImpl) then) =
      __$$TransactionStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalIncome,
      double totalExpenses,
      double netAmount,
      int transactionCount,
      double averageTransactionAmount,
      double largestExpense});
}

/// @nodoc
class __$$TransactionStatsImplCopyWithImpl<$Res>
    extends _$TransactionStatsCopyWithImpl<$Res, _$TransactionStatsImpl>
    implements _$$TransactionStatsImplCopyWith<$Res> {
  __$$TransactionStatsImplCopyWithImpl(_$TransactionStatsImpl _value,
      $Res Function(_$TransactionStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncome = null,
    Object? totalExpenses = null,
    Object? netAmount = null,
    Object? transactionCount = null,
    Object? averageTransactionAmount = null,
    Object? largestExpense = null,
  }) {
    return _then(_$TransactionStatsImpl(
      totalIncome: null == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double,
      totalExpenses: null == totalExpenses
          ? _value.totalExpenses
          : totalExpenses // ignore: cast_nullable_to_non_nullable
              as double,
      netAmount: null == netAmount
          ? _value.netAmount
          : netAmount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageTransactionAmount: null == averageTransactionAmount
          ? _value.averageTransactionAmount
          : averageTransactionAmount // ignore: cast_nullable_to_non_nullable
              as double,
      largestExpense: null == largestExpense
          ? _value.largestExpense
          : largestExpense // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$TransactionStatsImpl extends _TransactionStats {
  const _$TransactionStatsImpl(
      {this.totalIncome = 0.0,
      this.totalExpenses = 0.0,
      this.netAmount = 0.0,
      this.transactionCount = 0,
      this.averageTransactionAmount = 0.0,
      this.largestExpense = 0.0})
      : super._();

  @override
  @JsonKey()
  final double totalIncome;
  @override
  @JsonKey()
  final double totalExpenses;
  @override
  @JsonKey()
  final double netAmount;
  @override
  @JsonKey()
  final int transactionCount;
  @override
  @JsonKey()
  final double averageTransactionAmount;
  @override
  @JsonKey()
  final double largestExpense;

  @override
  String toString() {
    return 'TransactionStats(totalIncome: $totalIncome, totalExpenses: $totalExpenses, netAmount: $netAmount, transactionCount: $transactionCount, averageTransactionAmount: $averageTransactionAmount, largestExpense: $largestExpense)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionStatsImpl &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.totalExpenses, totalExpenses) ||
                other.totalExpenses == totalExpenses) &&
            (identical(other.netAmount, netAmount) ||
                other.netAmount == netAmount) &&
            (identical(other.transactionCount, transactionCount) ||
                other.transactionCount == transactionCount) &&
            (identical(
                    other.averageTransactionAmount, averageTransactionAmount) ||
                other.averageTransactionAmount == averageTransactionAmount) &&
            (identical(other.largestExpense, largestExpense) ||
                other.largestExpense == largestExpense));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalIncome, totalExpenses,
      netAmount, transactionCount, averageTransactionAmount, largestExpense);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionStatsImplCopyWith<_$TransactionStatsImpl> get copyWith =>
      __$$TransactionStatsImplCopyWithImpl<_$TransactionStatsImpl>(
          this, _$identity);
}

abstract class _TransactionStats extends TransactionStats {
  const factory _TransactionStats(
      {final double totalIncome,
      final double totalExpenses,
      final double netAmount,
      final int transactionCount,
      final double averageTransactionAmount,
      final double largestExpense}) = _$TransactionStatsImpl;
  const _TransactionStats._() : super._();

  @override
  double get totalIncome;
  @override
  double get totalExpenses;
  @override
  double get netAmount;
  @override
  int get transactionCount;
  @override
  double get averageTransactionAmount;
  @override
  double get largestExpense;
  @override
  @JsonKey(ignore: true)
  _$$TransactionStatsImplCopyWith<_$TransactionStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
