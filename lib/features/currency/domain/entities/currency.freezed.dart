// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Currency {
  String get code => throw _privateConstructorUsedError; // USD, EUR, GBP, etc.
  String get name =>
      throw _privateConstructorUsedError; // US Dollar, Euro, British Pound, etc.
  String get symbol => throw _privateConstructorUsedError; // $, €, £, etc.
  String get flag =>
      throw _privateConstructorUsedError; // 🇺🇸, 🇪🇺, 🇬🇧, etc.
  int get decimalPlaces => throw _privateConstructorUsedError; // Usually 2
  bool get isActive => throw _privateConstructorUsedError;
  bool get isBaseCurrency => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CurrencyCopyWith<Currency> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrencyCopyWith<$Res> {
  factory $CurrencyCopyWith(Currency value, $Res Function(Currency) then) =
      _$CurrencyCopyWithImpl<$Res, Currency>;
  @useResult
  $Res call(
      {String code,
      String name,
      String symbol,
      String flag,
      int decimalPlaces,
      bool isActive,
      bool isBaseCurrency});
}

/// @nodoc
class _$CurrencyCopyWithImpl<$Res, $Val extends Currency>
    implements $CurrencyCopyWith<$Res> {
  _$CurrencyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? symbol = null,
    Object? flag = null,
    Object? decimalPlaces = null,
    Object? isActive = null,
    Object? isBaseCurrency = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
      decimalPlaces: null == decimalPlaces
          ? _value.decimalPlaces
          : decimalPlaces // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isBaseCurrency: null == isBaseCurrency
          ? _value.isBaseCurrency
          : isBaseCurrency // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrencyImplCopyWith<$Res>
    implements $CurrencyCopyWith<$Res> {
  factory _$$CurrencyImplCopyWith(
          _$CurrencyImpl value, $Res Function(_$CurrencyImpl) then) =
      __$$CurrencyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String name,
      String symbol,
      String flag,
      int decimalPlaces,
      bool isActive,
      bool isBaseCurrency});
}

/// @nodoc
class __$$CurrencyImplCopyWithImpl<$Res>
    extends _$CurrencyCopyWithImpl<$Res, _$CurrencyImpl>
    implements _$$CurrencyImplCopyWith<$Res> {
  __$$CurrencyImplCopyWithImpl(
      _$CurrencyImpl _value, $Res Function(_$CurrencyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? symbol = null,
    Object? flag = null,
    Object? decimalPlaces = null,
    Object? isActive = null,
    Object? isBaseCurrency = null,
  }) {
    return _then(_$CurrencyImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      flag: null == flag
          ? _value.flag
          : flag // ignore: cast_nullable_to_non_nullable
              as String,
      decimalPlaces: null == decimalPlaces
          ? _value.decimalPlaces
          : decimalPlaces // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isBaseCurrency: null == isBaseCurrency
          ? _value.isBaseCurrency
          : isBaseCurrency // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CurrencyImpl extends _Currency {
  const _$CurrencyImpl(
      {required this.code,
      required this.name,
      required this.symbol,
      required this.flag,
      required this.decimalPlaces,
      this.isActive = true,
      this.isBaseCurrency = false})
      : super._();

  @override
  final String code;
// USD, EUR, GBP, etc.
  @override
  final String name;
// US Dollar, Euro, British Pound, etc.
  @override
  final String symbol;
// $, €, £, etc.
  @override
  final String flag;
// 🇺🇸, 🇪🇺, 🇬🇧, etc.
  @override
  final int decimalPlaces;
// Usually 2
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isBaseCurrency;

  @override
  String toString() {
    return 'Currency(code: $code, name: $name, symbol: $symbol, flag: $flag, decimalPlaces: $decimalPlaces, isActive: $isActive, isBaseCurrency: $isBaseCurrency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrencyImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.flag, flag) || other.flag == flag) &&
            (identical(other.decimalPlaces, decimalPlaces) ||
                other.decimalPlaces == decimalPlaces) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isBaseCurrency, isBaseCurrency) ||
                other.isBaseCurrency == isBaseCurrency));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, name, symbol, flag,
      decimalPlaces, isActive, isBaseCurrency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrencyImplCopyWith<_$CurrencyImpl> get copyWith =>
      __$$CurrencyImplCopyWithImpl<_$CurrencyImpl>(this, _$identity);
}

abstract class _Currency extends Currency {
  const factory _Currency(
      {required final String code,
      required final String name,
      required final String symbol,
      required final String flag,
      required final int decimalPlaces,
      final bool isActive,
      final bool isBaseCurrency}) = _$CurrencyImpl;
  const _Currency._() : super._();

  @override
  String get code;
  @override // USD, EUR, GBP, etc.
  String get name;
  @override // US Dollar, Euro, British Pound, etc.
  String get symbol;
  @override // $, €, £, etc.
  String get flag;
  @override // 🇺🇸, 🇪🇺, 🇬🇧, etc.
  int get decimalPlaces;
  @override // Usually 2
  bool get isActive;
  @override
  bool get isBaseCurrency;
  @override
  @JsonKey(ignore: true)
  _$$CurrencyImplCopyWith<_$CurrencyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExchangeRate {
  String get fromCurrency => throw _privateConstructorUsedError;
  String get toCurrency => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExchangeRateCopyWith<ExchangeRate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExchangeRateCopyWith<$Res> {
  factory $ExchangeRateCopyWith(
          ExchangeRate value, $Res Function(ExchangeRate) then) =
      _$ExchangeRateCopyWithImpl<$Res, ExchangeRate>;
  @useResult
  $Res call(
      {String fromCurrency,
      String toCurrency,
      double rate,
      DateTime lastUpdated,
      String? source});
}

/// @nodoc
class _$ExchangeRateCopyWithImpl<$Res, $Val extends ExchangeRate>
    implements $ExchangeRateCopyWith<$Res> {
  _$ExchangeRateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromCurrency = null,
    Object? toCurrency = null,
    Object? rate = null,
    Object? lastUpdated = null,
    Object? source = freezed,
  }) {
    return _then(_value.copyWith(
      fromCurrency: null == fromCurrency
          ? _value.fromCurrency
          : fromCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      toCurrency: null == toCurrency
          ? _value.toCurrency
          : toCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExchangeRateImplCopyWith<$Res>
    implements $ExchangeRateCopyWith<$Res> {
  factory _$$ExchangeRateImplCopyWith(
          _$ExchangeRateImpl value, $Res Function(_$ExchangeRateImpl) then) =
      __$$ExchangeRateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fromCurrency,
      String toCurrency,
      double rate,
      DateTime lastUpdated,
      String? source});
}

/// @nodoc
class __$$ExchangeRateImplCopyWithImpl<$Res>
    extends _$ExchangeRateCopyWithImpl<$Res, _$ExchangeRateImpl>
    implements _$$ExchangeRateImplCopyWith<$Res> {
  __$$ExchangeRateImplCopyWithImpl(
      _$ExchangeRateImpl _value, $Res Function(_$ExchangeRateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromCurrency = null,
    Object? toCurrency = null,
    Object? rate = null,
    Object? lastUpdated = null,
    Object? source = freezed,
  }) {
    return _then(_$ExchangeRateImpl(
      fromCurrency: null == fromCurrency
          ? _value.fromCurrency
          : fromCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      toCurrency: null == toCurrency
          ? _value.toCurrency
          : toCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ExchangeRateImpl extends _ExchangeRate {
  const _$ExchangeRateImpl(
      {required this.fromCurrency,
      required this.toCurrency,
      required this.rate,
      required this.lastUpdated,
      this.source})
      : super._();

  @override
  final String fromCurrency;
  @override
  final String toCurrency;
  @override
  final double rate;
  @override
  final DateTime lastUpdated;
  @override
  final String? source;

  @override
  String toString() {
    return 'ExchangeRate(fromCurrency: $fromCurrency, toCurrency: $toCurrency, rate: $rate, lastUpdated: $lastUpdated, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExchangeRateImpl &&
            (identical(other.fromCurrency, fromCurrency) ||
                other.fromCurrency == fromCurrency) &&
            (identical(other.toCurrency, toCurrency) ||
                other.toCurrency == toCurrency) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.source, source) || other.source == source));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, fromCurrency, toCurrency, rate, lastUpdated, source);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExchangeRateImplCopyWith<_$ExchangeRateImpl> get copyWith =>
      __$$ExchangeRateImplCopyWithImpl<_$ExchangeRateImpl>(this, _$identity);
}

abstract class _ExchangeRate extends ExchangeRate {
  const factory _ExchangeRate(
      {required final String fromCurrency,
      required final String toCurrency,
      required final double rate,
      required final DateTime lastUpdated,
      final String? source}) = _$ExchangeRateImpl;
  const _ExchangeRate._() : super._();

  @override
  String get fromCurrency;
  @override
  String get toCurrency;
  @override
  double get rate;
  @override
  DateTime get lastUpdated;
  @override
  String? get source;
  @override
  @JsonKey(ignore: true)
  _$$ExchangeRateImplCopyWith<_$ExchangeRateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
