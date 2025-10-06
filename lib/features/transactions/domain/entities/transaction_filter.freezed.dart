// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionFilter {
  TransactionType? get transactionType => throw _privateConstructorUsedError;
  List<String>? get categoryIds => throw _privateConstructorUsedError;
  String? get accountId => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  double? get minAmount => throw _privateConstructorUsedError;
  double? get maxAmount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionFilterCopyWith<TransactionFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionFilterCopyWith<$Res> {
  factory $TransactionFilterCopyWith(
          TransactionFilter value, $Res Function(TransactionFilter) then) =
      _$TransactionFilterCopyWithImpl<$Res, TransactionFilter>;
  @useResult
  $Res call(
      {TransactionType? transactionType,
      List<String>? categoryIds,
      String? accountId,
      DateTime? startDate,
      DateTime? endDate,
      double? minAmount,
      double? maxAmount});
}

/// @nodoc
class _$TransactionFilterCopyWithImpl<$Res, $Val extends TransactionFilter>
    implements $TransactionFilterCopyWith<$Res> {
  _$TransactionFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionType = freezed,
    Object? categoryIds = freezed,
    Object? accountId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? minAmount = freezed,
    Object? maxAmount = freezed,
  }) {
    return _then(_value.copyWith(
      transactionType: freezed == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as TransactionType?,
      categoryIds: freezed == categoryIds
          ? _value.categoryIds
          : categoryIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionFilterImplCopyWith<$Res>
    implements $TransactionFilterCopyWith<$Res> {
  factory _$$TransactionFilterImplCopyWith(_$TransactionFilterImpl value,
          $Res Function(_$TransactionFilterImpl) then) =
      __$$TransactionFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TransactionType? transactionType,
      List<String>? categoryIds,
      String? accountId,
      DateTime? startDate,
      DateTime? endDate,
      double? minAmount,
      double? maxAmount});
}

/// @nodoc
class __$$TransactionFilterImplCopyWithImpl<$Res>
    extends _$TransactionFilterCopyWithImpl<$Res, _$TransactionFilterImpl>
    implements _$$TransactionFilterImplCopyWith<$Res> {
  __$$TransactionFilterImplCopyWithImpl(_$TransactionFilterImpl _value,
      $Res Function(_$TransactionFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionType = freezed,
    Object? categoryIds = freezed,
    Object? accountId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? minAmount = freezed,
    Object? maxAmount = freezed,
  }) {
    return _then(_$TransactionFilterImpl(
      transactionType: freezed == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as TransactionType?,
      categoryIds: freezed == categoryIds
          ? _value._categoryIds
          : categoryIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$TransactionFilterImpl extends _TransactionFilter {
  const _$TransactionFilterImpl(
      {this.transactionType,
      final List<String>? categoryIds,
      this.accountId,
      this.startDate,
      this.endDate,
      this.minAmount,
      this.maxAmount})
      : _categoryIds = categoryIds,
        super._();

  @override
  final TransactionType? transactionType;
  final List<String>? _categoryIds;
  @override
  List<String>? get categoryIds {
    final value = _categoryIds;
    if (value == null) return null;
    if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? accountId;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final double? minAmount;
  @override
  final double? maxAmount;

  @override
  String toString() {
    return 'TransactionFilter(transactionType: $transactionType, categoryIds: $categoryIds, accountId: $accountId, startDate: $startDate, endDate: $endDate, minAmount: $minAmount, maxAmount: $maxAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionFilterImpl &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            const DeepCollectionEquality()
                .equals(other._categoryIds, _categoryIds) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.minAmount, minAmount) ||
                other.minAmount == minAmount) &&
            (identical(other.maxAmount, maxAmount) ||
                other.maxAmount == maxAmount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      transactionType,
      const DeepCollectionEquality().hash(_categoryIds),
      accountId,
      startDate,
      endDate,
      minAmount,
      maxAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionFilterImplCopyWith<_$TransactionFilterImpl> get copyWith =>
      __$$TransactionFilterImplCopyWithImpl<_$TransactionFilterImpl>(
          this, _$identity);
}

abstract class _TransactionFilter extends TransactionFilter {
  const factory _TransactionFilter(
      {final TransactionType? transactionType,
      final List<String>? categoryIds,
      final String? accountId,
      final DateTime? startDate,
      final DateTime? endDate,
      final double? minAmount,
      final double? maxAmount}) = _$TransactionFilterImpl;
  const _TransactionFilter._() : super._();

  @override
  TransactionType? get transactionType;
  @override
  List<String>? get categoryIds;
  @override
  String? get accountId;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  double? get minAmount;
  @override
  double? get maxAmount;
  @override
  @JsonKey(ignore: true)
  _$$TransactionFilterImplCopyWith<_$TransactionFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
