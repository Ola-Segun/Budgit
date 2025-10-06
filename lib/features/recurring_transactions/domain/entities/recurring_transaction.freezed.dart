// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecurringTransaction {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  RecurrenceType get recurrenceType => throw _privateConstructorUsedError;
  int get recurrenceValue =>
      throw _privateConstructorUsedError; // e.g., every 2 weeks, every 3 months
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate =>
      throw _privateConstructorUsedError; // null means indefinite
  String get categoryId => throw _privateConstructorUsedError;
  String get accountId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String get currencyCode => throw _privateConstructorUsedError;
  DateTime? get lastProcessedDate => throw _privateConstructorUsedError;
  DateTime? get nextDueDate => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecurringTransactionCopyWith<RecurringTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringTransactionCopyWith<$Res> {
  factory $RecurringTransactionCopyWith(RecurringTransaction value,
          $Res Function(RecurringTransaction) then) =
      _$RecurringTransactionCopyWithImpl<$Res, RecurringTransaction>;
  @useResult
  $Res call(
      {String id,
      String title,
      double amount,
      RecurrenceType recurrenceType,
      int recurrenceValue,
      DateTime startDate,
      DateTime? endDate,
      String categoryId,
      String accountId,
      String? description,
      bool isActive,
      String currencyCode,
      DateTime? lastProcessedDate,
      DateTime? nextDueDate,
      List<String> tags});
}

/// @nodoc
class _$RecurringTransactionCopyWithImpl<$Res,
        $Val extends RecurringTransaction>
    implements $RecurringTransactionCopyWith<$Res> {
  _$RecurringTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? amount = null,
    Object? recurrenceType = null,
    Object? recurrenceValue = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? categoryId = null,
    Object? accountId = null,
    Object? description = freezed,
    Object? isActive = null,
    Object? currencyCode = null,
    Object? lastProcessedDate = freezed,
    Object? nextDueDate = freezed,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      recurrenceType: null == recurrenceType
          ? _value.recurrenceType
          : recurrenceType // ignore: cast_nullable_to_non_nullable
              as RecurrenceType,
      recurrenceValue: null == recurrenceValue
          ? _value.recurrenceValue
          : recurrenceValue // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      lastProcessedDate: freezed == lastProcessedDate
          ? _value.lastProcessedDate
          : lastProcessedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextDueDate: freezed == nextDueDate
          ? _value.nextDueDate
          : nextDueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecurringTransactionImplCopyWith<$Res>
    implements $RecurringTransactionCopyWith<$Res> {
  factory _$$RecurringTransactionImplCopyWith(_$RecurringTransactionImpl value,
          $Res Function(_$RecurringTransactionImpl) then) =
      __$$RecurringTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      double amount,
      RecurrenceType recurrenceType,
      int recurrenceValue,
      DateTime startDate,
      DateTime? endDate,
      String categoryId,
      String accountId,
      String? description,
      bool isActive,
      String currencyCode,
      DateTime? lastProcessedDate,
      DateTime? nextDueDate,
      List<String> tags});
}

/// @nodoc
class __$$RecurringTransactionImplCopyWithImpl<$Res>
    extends _$RecurringTransactionCopyWithImpl<$Res, _$RecurringTransactionImpl>
    implements _$$RecurringTransactionImplCopyWith<$Res> {
  __$$RecurringTransactionImplCopyWithImpl(_$RecurringTransactionImpl _value,
      $Res Function(_$RecurringTransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? amount = null,
    Object? recurrenceType = null,
    Object? recurrenceValue = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? categoryId = null,
    Object? accountId = null,
    Object? description = freezed,
    Object? isActive = null,
    Object? currencyCode = null,
    Object? lastProcessedDate = freezed,
    Object? nextDueDate = freezed,
    Object? tags = null,
  }) {
    return _then(_$RecurringTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      recurrenceType: null == recurrenceType
          ? _value.recurrenceType
          : recurrenceType // ignore: cast_nullable_to_non_nullable
              as RecurrenceType,
      recurrenceValue: null == recurrenceValue
          ? _value.recurrenceValue
          : recurrenceValue // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      lastProcessedDate: freezed == lastProcessedDate
          ? _value.lastProcessedDate
          : lastProcessedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextDueDate: freezed == nextDueDate
          ? _value.nextDueDate
          : nextDueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$RecurringTransactionImpl extends _RecurringTransaction {
  const _$RecurringTransactionImpl(
      {required this.id,
      required this.title,
      required this.amount,
      required this.recurrenceType,
      required this.recurrenceValue,
      required this.startDate,
      this.endDate,
      required this.categoryId,
      required this.accountId,
      this.description,
      this.isActive = true,
      this.currencyCode = 'USD',
      this.lastProcessedDate,
      this.nextDueDate,
      final List<String> tags = const []})
      : _tags = tags,
        super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final double amount;
  @override
  final RecurrenceType recurrenceType;
  @override
  final int recurrenceValue;
// e.g., every 2 weeks, every 3 months
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
// null means indefinite
  @override
  final String categoryId;
  @override
  final String accountId;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final String currencyCode;
  @override
  final DateTime? lastProcessedDate;
  @override
  final DateTime? nextDueDate;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'RecurringTransaction(id: $id, title: $title, amount: $amount, recurrenceType: $recurrenceType, recurrenceValue: $recurrenceValue, startDate: $startDate, endDate: $endDate, categoryId: $categoryId, accountId: $accountId, description: $description, isActive: $isActive, currencyCode: $currencyCode, lastProcessedDate: $lastProcessedDate, nextDueDate: $nextDueDate, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.recurrenceType, recurrenceType) ||
                other.recurrenceType == recurrenceType) &&
            (identical(other.recurrenceValue, recurrenceValue) ||
                other.recurrenceValue == recurrenceValue) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.lastProcessedDate, lastProcessedDate) ||
                other.lastProcessedDate == lastProcessedDate) &&
            (identical(other.nextDueDate, nextDueDate) ||
                other.nextDueDate == nextDueDate) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      amount,
      recurrenceType,
      recurrenceValue,
      startDate,
      endDate,
      categoryId,
      accountId,
      description,
      isActive,
      currencyCode,
      lastProcessedDate,
      nextDueDate,
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringTransactionImplCopyWith<_$RecurringTransactionImpl>
      get copyWith =>
          __$$RecurringTransactionImplCopyWithImpl<_$RecurringTransactionImpl>(
              this, _$identity);
}

abstract class _RecurringTransaction extends RecurringTransaction {
  const factory _RecurringTransaction(
      {required final String id,
      required final String title,
      required final double amount,
      required final RecurrenceType recurrenceType,
      required final int recurrenceValue,
      required final DateTime startDate,
      final DateTime? endDate,
      required final String categoryId,
      required final String accountId,
      final String? description,
      final bool isActive,
      final String currencyCode,
      final DateTime? lastProcessedDate,
      final DateTime? nextDueDate,
      final List<String> tags}) = _$RecurringTransactionImpl;
  const _RecurringTransaction._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  double get amount;
  @override
  RecurrenceType get recurrenceType;
  @override
  int get recurrenceValue;
  @override // e.g., every 2 weeks, every 3 months
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override // null means indefinite
  String get categoryId;
  @override
  String get accountId;
  @override
  String? get description;
  @override
  bool get isActive;
  @override
  String get currencyCode;
  @override
  DateTime? get lastProcessedDate;
  @override
  DateTime? get nextDueDate;
  @override
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$$RecurringTransactionImplCopyWith<_$RecurringTransactionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GeneratedTransaction {
  String get id => throw _privateConstructorUsedError;
  String get recurringTransactionId => throw _privateConstructorUsedError;
  String get transactionId =>
      throw _privateConstructorUsedError; // ID of the actual transaction
  DateTime get generatedDate => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  bool get isProcessed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GeneratedTransactionCopyWith<GeneratedTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratedTransactionCopyWith<$Res> {
  factory $GeneratedTransactionCopyWith(GeneratedTransaction value,
          $Res Function(GeneratedTransaction) then) =
      _$GeneratedTransactionCopyWithImpl<$Res, GeneratedTransaction>;
  @useResult
  $Res call(
      {String id,
      String recurringTransactionId,
      String transactionId,
      DateTime generatedDate,
      DateTime dueDate,
      bool isProcessed});
}

/// @nodoc
class _$GeneratedTransactionCopyWithImpl<$Res,
        $Val extends GeneratedTransaction>
    implements $GeneratedTransactionCopyWith<$Res> {
  _$GeneratedTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recurringTransactionId = null,
    Object? transactionId = null,
    Object? generatedDate = null,
    Object? dueDate = null,
    Object? isProcessed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recurringTransactionId: null == recurringTransactionId
          ? _value.recurringTransactionId
          : recurringTransactionId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedDate: null == generatedDate
          ? _value.generatedDate
          : generatedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isProcessed: null == isProcessed
          ? _value.isProcessed
          : isProcessed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeneratedTransactionImplCopyWith<$Res>
    implements $GeneratedTransactionCopyWith<$Res> {
  factory _$$GeneratedTransactionImplCopyWith(_$GeneratedTransactionImpl value,
          $Res Function(_$GeneratedTransactionImpl) then) =
      __$$GeneratedTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String recurringTransactionId,
      String transactionId,
      DateTime generatedDate,
      DateTime dueDate,
      bool isProcessed});
}

/// @nodoc
class __$$GeneratedTransactionImplCopyWithImpl<$Res>
    extends _$GeneratedTransactionCopyWithImpl<$Res, _$GeneratedTransactionImpl>
    implements _$$GeneratedTransactionImplCopyWith<$Res> {
  __$$GeneratedTransactionImplCopyWithImpl(_$GeneratedTransactionImpl _value,
      $Res Function(_$GeneratedTransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? recurringTransactionId = null,
    Object? transactionId = null,
    Object? generatedDate = null,
    Object? dueDate = null,
    Object? isProcessed = null,
  }) {
    return _then(_$GeneratedTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      recurringTransactionId: null == recurringTransactionId
          ? _value.recurringTransactionId
          : recurringTransactionId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      generatedDate: null == generatedDate
          ? _value.generatedDate
          : generatedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isProcessed: null == isProcessed
          ? _value.isProcessed
          : isProcessed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GeneratedTransactionImpl extends _GeneratedTransaction {
  const _$GeneratedTransactionImpl(
      {required this.id,
      required this.recurringTransactionId,
      required this.transactionId,
      required this.generatedDate,
      required this.dueDate,
      this.isProcessed = false})
      : super._();

  @override
  final String id;
  @override
  final String recurringTransactionId;
  @override
  final String transactionId;
// ID of the actual transaction
  @override
  final DateTime generatedDate;
  @override
  final DateTime dueDate;
  @override
  @JsonKey()
  final bool isProcessed;

  @override
  String toString() {
    return 'GeneratedTransaction(id: $id, recurringTransactionId: $recurringTransactionId, transactionId: $transactionId, generatedDate: $generatedDate, dueDate: $dueDate, isProcessed: $isProcessed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratedTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recurringTransactionId, recurringTransactionId) ||
                other.recurringTransactionId == recurringTransactionId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.generatedDate, generatedDate) ||
                other.generatedDate == generatedDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.isProcessed, isProcessed) ||
                other.isProcessed == isProcessed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, recurringTransactionId,
      transactionId, generatedDate, dueDate, isProcessed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratedTransactionImplCopyWith<_$GeneratedTransactionImpl>
      get copyWith =>
          __$$GeneratedTransactionImplCopyWithImpl<_$GeneratedTransactionImpl>(
              this, _$identity);
}

abstract class _GeneratedTransaction extends GeneratedTransaction {
  const factory _GeneratedTransaction(
      {required final String id,
      required final String recurringTransactionId,
      required final String transactionId,
      required final DateTime generatedDate,
      required final DateTime dueDate,
      final bool isProcessed}) = _$GeneratedTransactionImpl;
  const _GeneratedTransaction._() : super._();

  @override
  String get id;
  @override
  String get recurringTransactionId;
  @override
  String get transactionId;
  @override // ID of the actual transaction
  DateTime get generatedDate;
  @override
  DateTime get dueDate;
  @override
  bool get isProcessed;
  @override
  @JsonKey(ignore: true)
  _$$GeneratedTransactionImplCopyWith<_$GeneratedTransactionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
