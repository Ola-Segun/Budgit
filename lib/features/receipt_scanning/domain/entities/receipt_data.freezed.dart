// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReceiptData {
  /// Merchant/store name
  String get merchant => throw _privateConstructorUsedError;

  /// Total amount from the receipt
  double get amount => throw _privateConstructorUsedError;

  /// Date of the transaction
  DateTime get date => throw _privateConstructorUsedError;

  /// List of items purchased (initially mock data)
  List<ReceiptItem> get items => throw _privateConstructorUsedError;

  /// Suggested category based on merchant
  String? get suggestedCategory => throw _privateConstructorUsedError;

  /// Receipt image path
  String? get imagePath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReceiptDataCopyWith<ReceiptData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptDataCopyWith<$Res> {
  factory $ReceiptDataCopyWith(
          ReceiptData value, $Res Function(ReceiptData) then) =
      _$ReceiptDataCopyWithImpl<$Res, ReceiptData>;
  @useResult
  $Res call(
      {String merchant,
      double amount,
      DateTime date,
      List<ReceiptItem> items,
      String? suggestedCategory,
      String? imagePath});
}

/// @nodoc
class _$ReceiptDataCopyWithImpl<$Res, $Val extends ReceiptData>
    implements $ReceiptDataCopyWith<$Res> {
  _$ReceiptDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchant = null,
    Object? amount = null,
    Object? date = null,
    Object? items = null,
    Object? suggestedCategory = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_value.copyWith(
      merchant: null == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReceiptItem>,
      suggestedCategory: freezed == suggestedCategory
          ? _value.suggestedCategory
          : suggestedCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceiptDataImplCopyWith<$Res>
    implements $ReceiptDataCopyWith<$Res> {
  factory _$$ReceiptDataImplCopyWith(
          _$ReceiptDataImpl value, $Res Function(_$ReceiptDataImpl) then) =
      __$$ReceiptDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String merchant,
      double amount,
      DateTime date,
      List<ReceiptItem> items,
      String? suggestedCategory,
      String? imagePath});
}

/// @nodoc
class __$$ReceiptDataImplCopyWithImpl<$Res>
    extends _$ReceiptDataCopyWithImpl<$Res, _$ReceiptDataImpl>
    implements _$$ReceiptDataImplCopyWith<$Res> {
  __$$ReceiptDataImplCopyWithImpl(
      _$ReceiptDataImpl _value, $Res Function(_$ReceiptDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? merchant = null,
    Object? amount = null,
    Object? date = null,
    Object? items = null,
    Object? suggestedCategory = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_$ReceiptDataImpl(
      merchant: null == merchant
          ? _value.merchant
          : merchant // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReceiptItem>,
      suggestedCategory: freezed == suggestedCategory
          ? _value.suggestedCategory
          : suggestedCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ReceiptDataImpl extends _ReceiptData {
  const _$ReceiptDataImpl(
      {required this.merchant,
      required this.amount,
      required this.date,
      required final List<ReceiptItem> items,
      this.suggestedCategory,
      this.imagePath})
      : _items = items,
        super._();

  /// Merchant/store name
  @override
  final String merchant;

  /// Total amount from the receipt
  @override
  final double amount;

  /// Date of the transaction
  @override
  final DateTime date;

  /// List of items purchased (initially mock data)
  final List<ReceiptItem> _items;

  /// List of items purchased (initially mock data)
  @override
  List<ReceiptItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Suggested category based on merchant
  @override
  final String? suggestedCategory;

  /// Receipt image path
  @override
  final String? imagePath;

  @override
  String toString() {
    return 'ReceiptData(merchant: $merchant, amount: $amount, date: $date, items: $items, suggestedCategory: $suggestedCategory, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptDataImpl &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.suggestedCategory, suggestedCategory) ||
                other.suggestedCategory == suggestedCategory) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      merchant,
      amount,
      date,
      const DeepCollectionEquality().hash(_items),
      suggestedCategory,
      imagePath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptDataImplCopyWith<_$ReceiptDataImpl> get copyWith =>
      __$$ReceiptDataImplCopyWithImpl<_$ReceiptDataImpl>(this, _$identity);
}

abstract class _ReceiptData extends ReceiptData {
  const factory _ReceiptData(
      {required final String merchant,
      required final double amount,
      required final DateTime date,
      required final List<ReceiptItem> items,
      final String? suggestedCategory,
      final String? imagePath}) = _$ReceiptDataImpl;
  const _ReceiptData._() : super._();

  @override

  /// Merchant/store name
  String get merchant;
  @override

  /// Total amount from the receipt
  double get amount;
  @override

  /// Date of the transaction
  DateTime get date;
  @override

  /// List of items purchased (initially mock data)
  List<ReceiptItem> get items;
  @override

  /// Suggested category based on merchant
  String? get suggestedCategory;
  @override

  /// Receipt image path
  String? get imagePath;
  @override
  @JsonKey(ignore: true)
  _$$ReceiptDataImplCopyWith<_$ReceiptDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReceiptItem {
  String get name => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReceiptItemCopyWith<ReceiptItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptItemCopyWith<$Res> {
  factory $ReceiptItemCopyWith(
          ReceiptItem value, $Res Function(ReceiptItem) then) =
      _$ReceiptItemCopyWithImpl<$Res, ReceiptItem>;
  @useResult
  $Res call({String name, int quantity, double price});
}

/// @nodoc
class _$ReceiptItemCopyWithImpl<$Res, $Val extends ReceiptItem>
    implements $ReceiptItemCopyWith<$Res> {
  _$ReceiptItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceiptItemImplCopyWith<$Res>
    implements $ReceiptItemCopyWith<$Res> {
  factory _$$ReceiptItemImplCopyWith(
          _$ReceiptItemImpl value, $Res Function(_$ReceiptItemImpl) then) =
      __$$ReceiptItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int quantity, double price});
}

/// @nodoc
class __$$ReceiptItemImplCopyWithImpl<$Res>
    extends _$ReceiptItemCopyWithImpl<$Res, _$ReceiptItemImpl>
    implements _$$ReceiptItemImplCopyWith<$Res> {
  __$$ReceiptItemImplCopyWithImpl(
      _$ReceiptItemImpl _value, $Res Function(_$ReceiptItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? quantity = null,
    Object? price = null,
  }) {
    return _then(_$ReceiptItemImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$ReceiptItemImpl extends _ReceiptItem {
  const _$ReceiptItemImpl(
      {required this.name, required this.quantity, required this.price})
      : super._();

  @override
  final String name;
  @override
  final int quantity;
  @override
  final double price;

  @override
  String toString() {
    return 'ReceiptItem(name: $name, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, quantity, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptItemImplCopyWith<_$ReceiptItemImpl> get copyWith =>
      __$$ReceiptItemImplCopyWithImpl<_$ReceiptItemImpl>(this, _$identity);
}

abstract class _ReceiptItem extends ReceiptItem {
  const factory _ReceiptItem(
      {required final String name,
      required final int quantity,
      required final double price}) = _$ReceiptItemImpl;
  const _ReceiptItem._() : super._();

  @override
  String get name;
  @override
  int get quantity;
  @override
  double get price;
  @override
  @JsonKey(ignore: true)
  _$$ReceiptItemImplCopyWith<_$ReceiptItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
