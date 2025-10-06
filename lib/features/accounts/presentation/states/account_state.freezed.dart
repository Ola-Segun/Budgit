// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountState {
  List<Account> get accounts => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  AccountType? get filterType => throw _privateConstructorUsedError;
  double get totalBalance => throw _privateConstructorUsedError;
  double get netWorth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountStateCopyWith<AccountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountStateCopyWith<$Res> {
  factory $AccountStateCopyWith(
          AccountState value, $Res Function(AccountState) then) =
      _$AccountStateCopyWithImpl<$Res, AccountState>;
  @useResult
  $Res call(
      {List<Account> accounts,
      bool isLoading,
      String? error,
      String? searchQuery,
      AccountType? filterType,
      double totalBalance,
      double netWorth});
}

/// @nodoc
class _$AccountStateCopyWithImpl<$Res, $Val extends AccountState>
    implements $AccountStateCopyWith<$Res> {
  _$AccountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? searchQuery = freezed,
    Object? filterType = freezed,
    Object? totalBalance = null,
    Object? netWorth = null,
  }) {
    return _then(_value.copyWith(
      accounts: null == accounts
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<Account>,
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
      filterType: freezed == filterType
          ? _value.filterType
          : filterType // ignore: cast_nullable_to_non_nullable
              as AccountType?,
      totalBalance: null == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double,
      netWorth: null == netWorth
          ? _value.netWorth
          : netWorth // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountStateImplCopyWith<$Res>
    implements $AccountStateCopyWith<$Res> {
  factory _$$AccountStateImplCopyWith(
          _$AccountStateImpl value, $Res Function(_$AccountStateImpl) then) =
      __$$AccountStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Account> accounts,
      bool isLoading,
      String? error,
      String? searchQuery,
      AccountType? filterType,
      double totalBalance,
      double netWorth});
}

/// @nodoc
class __$$AccountStateImplCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountStateImpl>
    implements _$$AccountStateImplCopyWith<$Res> {
  __$$AccountStateImplCopyWithImpl(
      _$AccountStateImpl _value, $Res Function(_$AccountStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? searchQuery = freezed,
    Object? filterType = freezed,
    Object? totalBalance = null,
    Object? netWorth = null,
  }) {
    return _then(_$AccountStateImpl(
      accounts: null == accounts
          ? _value._accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<Account>,
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
      filterType: freezed == filterType
          ? _value.filterType
          : filterType // ignore: cast_nullable_to_non_nullable
              as AccountType?,
      totalBalance: null == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double,
      netWorth: null == netWorth
          ? _value.netWorth
          : netWorth // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$AccountStateImpl extends _AccountState {
  const _$AccountStateImpl(
      {final List<Account> accounts = const [],
      this.isLoading = false,
      this.error,
      this.searchQuery,
      this.filterType,
      this.totalBalance = 0.0,
      this.netWorth = 0.0})
      : _accounts = accounts,
        super._();

  final List<Account> _accounts;
  @override
  @JsonKey()
  List<Account> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  final String? searchQuery;
  @override
  final AccountType? filterType;
  @override
  @JsonKey()
  final double totalBalance;
  @override
  @JsonKey()
  final double netWorth;

  @override
  String toString() {
    return 'AccountState(accounts: $accounts, isLoading: $isLoading, error: $error, searchQuery: $searchQuery, filterType: $filterType, totalBalance: $totalBalance, netWorth: $netWorth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountStateImpl &&
            const DeepCollectionEquality().equals(other._accounts, _accounts) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.totalBalance, totalBalance) ||
                other.totalBalance == totalBalance) &&
            (identical(other.netWorth, netWorth) ||
                other.netWorth == netWorth));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_accounts),
      isLoading,
      error,
      searchQuery,
      filterType,
      totalBalance,
      netWorth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountStateImplCopyWith<_$AccountStateImpl> get copyWith =>
      __$$AccountStateImplCopyWithImpl<_$AccountStateImpl>(this, _$identity);
}

abstract class _AccountState extends AccountState {
  const factory _AccountState(
      {final List<Account> accounts,
      final bool isLoading,
      final String? error,
      final String? searchQuery,
      final AccountType? filterType,
      final double totalBalance,
      final double netWorth}) = _$AccountStateImpl;
  const _AccountState._() : super._();

  @override
  List<Account> get accounts;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  String? get searchQuery;
  @override
  AccountType? get filterType;
  @override
  double get totalBalance;
  @override
  double get netWorth;
  @override
  @JsonKey(ignore: true)
  _$$AccountStateImplCopyWith<_$AccountStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
