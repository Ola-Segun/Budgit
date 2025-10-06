// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Debt {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get remainingAmount => throw _privateConstructorUsedError;
  DebtType get type => throw _privateConstructorUsedError;
  DebtPriority get priority => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get creditor => throw _privateConstructorUsedError;
  double? get interestRate => throw _privateConstructorUsedError;
  double? get minimumPayment => throw _privateConstructorUsedError;
  String? get accountId =>
      throw _privateConstructorUsedError; // Linked account for payments
  List<String> get tags => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DebtCopyWith<Debt> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebtCopyWith<$Res> {
  factory $DebtCopyWith(Debt value, $Res Function(Debt) then) =
      _$DebtCopyWithImpl<$Res, Debt>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      double amount,
      double remainingAmount,
      DebtType type,
      DebtPriority priority,
      DateTime dueDate,
      DateTime createdAt,
      DateTime updatedAt,
      String? creditor,
      double? interestRate,
      double? minimumPayment,
      String? accountId,
      List<String> tags});
}

/// @nodoc
class _$DebtCopyWithImpl<$Res, $Val extends Debt>
    implements $DebtCopyWith<$Res> {
  _$DebtCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? amount = null,
    Object? remainingAmount = null,
    Object? type = null,
    Object? priority = null,
    Object? dueDate = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? creditor = freezed,
    Object? interestRate = freezed,
    Object? minimumPayment = freezed,
    Object? accountId = freezed,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      remainingAmount: null == remainingAmount
          ? _value.remainingAmount
          : remainingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DebtType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as DebtPriority,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      creditor: freezed == creditor
          ? _value.creditor
          : creditor // ignore: cast_nullable_to_non_nullable
              as String?,
      interestRate: freezed == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double?,
      minimumPayment: freezed == minimumPayment
          ? _value.minimumPayment
          : minimumPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DebtImplCopyWith<$Res> implements $DebtCopyWith<$Res> {
  factory _$$DebtImplCopyWith(
          _$DebtImpl value, $Res Function(_$DebtImpl) then) =
      __$$DebtImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      double amount,
      double remainingAmount,
      DebtType type,
      DebtPriority priority,
      DateTime dueDate,
      DateTime createdAt,
      DateTime updatedAt,
      String? creditor,
      double? interestRate,
      double? minimumPayment,
      String? accountId,
      List<String> tags});
}

/// @nodoc
class __$$DebtImplCopyWithImpl<$Res>
    extends _$DebtCopyWithImpl<$Res, _$DebtImpl>
    implements _$$DebtImplCopyWith<$Res> {
  __$$DebtImplCopyWithImpl(_$DebtImpl _value, $Res Function(_$DebtImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? amount = null,
    Object? remainingAmount = null,
    Object? type = null,
    Object? priority = null,
    Object? dueDate = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? creditor = freezed,
    Object? interestRate = freezed,
    Object? minimumPayment = freezed,
    Object? accountId = freezed,
    Object? tags = null,
  }) {
    return _then(_$DebtImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      remainingAmount: null == remainingAmount
          ? _value.remainingAmount
          : remainingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DebtType,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as DebtPriority,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      creditor: freezed == creditor
          ? _value.creditor
          : creditor // ignore: cast_nullable_to_non_nullable
              as String?,
      interestRate: freezed == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double?,
      minimumPayment: freezed == minimumPayment
          ? _value.minimumPayment
          : minimumPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$DebtImpl extends _Debt {
  const _$DebtImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.amount,
      required this.remainingAmount,
      required this.type,
      required this.priority,
      required this.dueDate,
      required this.createdAt,
      required this.updatedAt,
      this.creditor,
      this.interestRate,
      this.minimumPayment,
      this.accountId,
      final List<String> tags = const []})
      : _tags = tags,
        super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final double amount;
  @override
  final double remainingAmount;
  @override
  final DebtType type;
  @override
  final DebtPriority priority;
  @override
  final DateTime dueDate;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? creditor;
  @override
  final double? interestRate;
  @override
  final double? minimumPayment;
  @override
  final String? accountId;
// Linked account for payments
  final List<String> _tags;
// Linked account for payments
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Debt(id: $id, name: $name, description: $description, amount: $amount, remainingAmount: $remainingAmount, type: $type, priority: $priority, dueDate: $dueDate, createdAt: $createdAt, updatedAt: $updatedAt, creditor: $creditor, interestRate: $interestRate, minimumPayment: $minimumPayment, accountId: $accountId, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebtImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.remainingAmount, remainingAmount) ||
                other.remainingAmount == remainingAmount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.creditor, creditor) ||
                other.creditor == creditor) &&
            (identical(other.interestRate, interestRate) ||
                other.interestRate == interestRate) &&
            (identical(other.minimumPayment, minimumPayment) ||
                other.minimumPayment == minimumPayment) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      amount,
      remainingAmount,
      type,
      priority,
      dueDate,
      createdAt,
      updatedAt,
      creditor,
      interestRate,
      minimumPayment,
      accountId,
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DebtImplCopyWith<_$DebtImpl> get copyWith =>
      __$$DebtImplCopyWithImpl<_$DebtImpl>(this, _$identity);
}

abstract class _Debt extends Debt {
  const factory _Debt(
      {required final String id,
      required final String name,
      required final String description,
      required final double amount,
      required final double remainingAmount,
      required final DebtType type,
      required final DebtPriority priority,
      required final DateTime dueDate,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? creditor,
      final double? interestRate,
      final double? minimumPayment,
      final String? accountId,
      final List<String> tags}) = _$DebtImpl;
  const _Debt._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  double get amount;
  @override
  double get remainingAmount;
  @override
  DebtType get type;
  @override
  DebtPriority get priority;
  @override
  DateTime get dueDate;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String? get creditor;
  @override
  double? get interestRate;
  @override
  double? get minimumPayment;
  @override
  String? get accountId;
  @override // Linked account for payments
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$$DebtImplCopyWith<_$DebtImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
