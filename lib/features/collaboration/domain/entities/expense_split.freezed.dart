// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_split.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExpenseSplit {
  String get id => throw _privateConstructorUsedError;
  String get sharedBudgetId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  String get paidByUserId => throw _privateConstructorUsedError;
  List<SplitParticipant> get participants => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  SplitStatus get status => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get receiptUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpenseSplitCopyWith<ExpenseSplit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseSplitCopyWith<$Res> {
  factory $ExpenseSplitCopyWith(
          ExpenseSplit value, $Res Function(ExpenseSplit) then) =
      _$ExpenseSplitCopyWithImpl<$Res, ExpenseSplit>;
  @useResult
  $Res call(
      {String id,
      String sharedBudgetId,
      String title,
      String? description,
      double totalAmount,
      String paidByUserId,
      List<SplitParticipant> participants,
      DateTime createdAt,
      DateTime? updatedAt,
      SplitStatus status,
      String? category,
      String? receiptUrl});
}

/// @nodoc
class _$ExpenseSplitCopyWithImpl<$Res, $Val extends ExpenseSplit>
    implements $ExpenseSplitCopyWith<$Res> {
  _$ExpenseSplitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sharedBudgetId = null,
    Object? title = null,
    Object? description = freezed,
    Object? totalAmount = null,
    Object? paidByUserId = null,
    Object? participants = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? status = null,
    Object? category = freezed,
    Object? receiptUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sharedBudgetId: null == sharedBudgetId
          ? _value.sharedBudgetId
          : sharedBudgetId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paidByUserId: null == paidByUserId
          ? _value.paidByUserId
          : paidByUserId // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<SplitParticipant>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SplitStatus,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseSplitImplCopyWith<$Res>
    implements $ExpenseSplitCopyWith<$Res> {
  factory _$$ExpenseSplitImplCopyWith(
          _$ExpenseSplitImpl value, $Res Function(_$ExpenseSplitImpl) then) =
      __$$ExpenseSplitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sharedBudgetId,
      String title,
      String? description,
      double totalAmount,
      String paidByUserId,
      List<SplitParticipant> participants,
      DateTime createdAt,
      DateTime? updatedAt,
      SplitStatus status,
      String? category,
      String? receiptUrl});
}

/// @nodoc
class __$$ExpenseSplitImplCopyWithImpl<$Res>
    extends _$ExpenseSplitCopyWithImpl<$Res, _$ExpenseSplitImpl>
    implements _$$ExpenseSplitImplCopyWith<$Res> {
  __$$ExpenseSplitImplCopyWithImpl(
      _$ExpenseSplitImpl _value, $Res Function(_$ExpenseSplitImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sharedBudgetId = null,
    Object? title = null,
    Object? description = freezed,
    Object? totalAmount = null,
    Object? paidByUserId = null,
    Object? participants = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? status = null,
    Object? category = freezed,
    Object? receiptUrl = freezed,
  }) {
    return _then(_$ExpenseSplitImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sharedBudgetId: null == sharedBudgetId
          ? _value.sharedBudgetId
          : sharedBudgetId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paidByUserId: null == paidByUserId
          ? _value.paidByUserId
          : paidByUserId // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<SplitParticipant>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SplitStatus,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ExpenseSplitImpl extends _ExpenseSplit {
  const _$ExpenseSplitImpl(
      {required this.id,
      required this.sharedBudgetId,
      required this.title,
      this.description,
      required this.totalAmount,
      required this.paidByUserId,
      required final List<SplitParticipant> participants,
      required this.createdAt,
      this.updatedAt,
      this.status = SplitStatus.pending,
      this.category,
      this.receiptUrl})
      : _participants = participants,
        super._();

  @override
  final String id;
  @override
  final String sharedBudgetId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final double totalAmount;
  @override
  final String paidByUserId;
  final List<SplitParticipant> _participants;
  @override
  List<SplitParticipant> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final SplitStatus status;
  @override
  final String? category;
  @override
  final String? receiptUrl;

  @override
  String toString() {
    return 'ExpenseSplit(id: $id, sharedBudgetId: $sharedBudgetId, title: $title, description: $description, totalAmount: $totalAmount, paidByUserId: $paidByUserId, participants: $participants, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, category: $category, receiptUrl: $receiptUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseSplitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sharedBudgetId, sharedBudgetId) ||
                other.sharedBudgetId == sharedBudgetId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paidByUserId, paidByUserId) ||
                other.paidByUserId == paidByUserId) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sharedBudgetId,
      title,
      description,
      totalAmount,
      paidByUserId,
      const DeepCollectionEquality().hash(_participants),
      createdAt,
      updatedAt,
      status,
      category,
      receiptUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseSplitImplCopyWith<_$ExpenseSplitImpl> get copyWith =>
      __$$ExpenseSplitImplCopyWithImpl<_$ExpenseSplitImpl>(this, _$identity);
}

abstract class _ExpenseSplit extends ExpenseSplit {
  const factory _ExpenseSplit(
      {required final String id,
      required final String sharedBudgetId,
      required final String title,
      final String? description,
      required final double totalAmount,
      required final String paidByUserId,
      required final List<SplitParticipant> participants,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final SplitStatus status,
      final String? category,
      final String? receiptUrl}) = _$ExpenseSplitImpl;
  const _ExpenseSplit._() : super._();

  @override
  String get id;
  @override
  String get sharedBudgetId;
  @override
  String get title;
  @override
  String? get description;
  @override
  double get totalAmount;
  @override
  String get paidByUserId;
  @override
  List<SplitParticipant> get participants;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  SplitStatus get status;
  @override
  String? get category;
  @override
  String? get receiptUrl;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseSplitImplCopyWith<_$ExpenseSplitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SplitParticipant {
  String get userId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  SplitStatus get status => throw _privateConstructorUsedError;
  DateTime? get settledAt => throw _privateConstructorUsedError;
  String? get paymentMethod => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SplitParticipantCopyWith<SplitParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplitParticipantCopyWith<$Res> {
  factory $SplitParticipantCopyWith(
          SplitParticipant value, $Res Function(SplitParticipant) then) =
      _$SplitParticipantCopyWithImpl<$Res, SplitParticipant>;
  @useResult
  $Res call(
      {String userId,
      double amount,
      SplitStatus status,
      DateTime? settledAt,
      String? paymentMethod,
      String? notes});
}

/// @nodoc
class _$SplitParticipantCopyWithImpl<$Res, $Val extends SplitParticipant>
    implements $SplitParticipantCopyWith<$Res> {
  _$SplitParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? amount = null,
    Object? status = null,
    Object? settledAt = freezed,
    Object? paymentMethod = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SplitStatus,
      settledAt: freezed == settledAt
          ? _value.settledAt
          : settledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SplitParticipantImplCopyWith<$Res>
    implements $SplitParticipantCopyWith<$Res> {
  factory _$$SplitParticipantImplCopyWith(_$SplitParticipantImpl value,
          $Res Function(_$SplitParticipantImpl) then) =
      __$$SplitParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      double amount,
      SplitStatus status,
      DateTime? settledAt,
      String? paymentMethod,
      String? notes});
}

/// @nodoc
class __$$SplitParticipantImplCopyWithImpl<$Res>
    extends _$SplitParticipantCopyWithImpl<$Res, _$SplitParticipantImpl>
    implements _$$SplitParticipantImplCopyWith<$Res> {
  __$$SplitParticipantImplCopyWithImpl(_$SplitParticipantImpl _value,
      $Res Function(_$SplitParticipantImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? amount = null,
    Object? status = null,
    Object? settledAt = freezed,
    Object? paymentMethod = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$SplitParticipantImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SplitStatus,
      settledAt: freezed == settledAt
          ? _value.settledAt
          : settledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SplitParticipantImpl extends _SplitParticipant {
  const _$SplitParticipantImpl(
      {required this.userId,
      required this.amount,
      this.status = SplitStatus.pending,
      this.settledAt,
      this.paymentMethod,
      this.notes})
      : super._();

  @override
  final String userId;
  @override
  final double amount;
  @override
  @JsonKey()
  final SplitStatus status;
  @override
  final DateTime? settledAt;
  @override
  final String? paymentMethod;
  @override
  final String? notes;

  @override
  String toString() {
    return 'SplitParticipant(userId: $userId, amount: $amount, status: $status, settledAt: $settledAt, paymentMethod: $paymentMethod, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SplitParticipantImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.settledAt, settledAt) ||
                other.settledAt == settledAt) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, userId, amount, status, settledAt, paymentMethod, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SplitParticipantImplCopyWith<_$SplitParticipantImpl> get copyWith =>
      __$$SplitParticipantImplCopyWithImpl<_$SplitParticipantImpl>(
          this, _$identity);
}

abstract class _SplitParticipant extends SplitParticipant {
  const factory _SplitParticipant(
      {required final String userId,
      required final double amount,
      final SplitStatus status,
      final DateTime? settledAt,
      final String? paymentMethod,
      final String? notes}) = _$SplitParticipantImpl;
  const _SplitParticipant._() : super._();

  @override
  String get userId;
  @override
  double get amount;
  @override
  SplitStatus get status;
  @override
  DateTime? get settledAt;
  @override
  String? get paymentMethod;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$SplitParticipantImplCopyWith<_$SplitParticipantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Settlement {
  String get id => throw _privateConstructorUsedError;
  String get expenseSplitId => throw _privateConstructorUsedError;
  String get fromUserId => throw _privateConstructorUsedError;
  String get toUserId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get settledAt => throw _privateConstructorUsedError;
  String? get paymentMethod => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool get isConfirmed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettlementCopyWith<Settlement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettlementCopyWith<$Res> {
  factory $SettlementCopyWith(
          Settlement value, $Res Function(Settlement) then) =
      _$SettlementCopyWithImpl<$Res, Settlement>;
  @useResult
  $Res call(
      {String id,
      String expenseSplitId,
      String fromUserId,
      String toUserId,
      double amount,
      DateTime settledAt,
      String? paymentMethod,
      String? notes,
      bool isConfirmed});
}

/// @nodoc
class _$SettlementCopyWithImpl<$Res, $Val extends Settlement>
    implements $SettlementCopyWith<$Res> {
  _$SettlementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? expenseSplitId = null,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? amount = null,
    Object? settledAt = null,
    Object? paymentMethod = freezed,
    Object? notes = freezed,
    Object? isConfirmed = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      expenseSplitId: null == expenseSplitId
          ? _value.expenseSplitId
          : expenseSplitId // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      settledAt: null == settledAt
          ? _value.settledAt
          : settledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettlementImplCopyWith<$Res>
    implements $SettlementCopyWith<$Res> {
  factory _$$SettlementImplCopyWith(
          _$SettlementImpl value, $Res Function(_$SettlementImpl) then) =
      __$$SettlementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String expenseSplitId,
      String fromUserId,
      String toUserId,
      double amount,
      DateTime settledAt,
      String? paymentMethod,
      String? notes,
      bool isConfirmed});
}

/// @nodoc
class __$$SettlementImplCopyWithImpl<$Res>
    extends _$SettlementCopyWithImpl<$Res, _$SettlementImpl>
    implements _$$SettlementImplCopyWith<$Res> {
  __$$SettlementImplCopyWithImpl(
      _$SettlementImpl _value, $Res Function(_$SettlementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? expenseSplitId = null,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? amount = null,
    Object? settledAt = null,
    Object? paymentMethod = freezed,
    Object? notes = freezed,
    Object? isConfirmed = null,
  }) {
    return _then(_$SettlementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      expenseSplitId: null == expenseSplitId
          ? _value.expenseSplitId
          : expenseSplitId // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      toUserId: null == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      settledAt: null == settledAt
          ? _value.settledAt
          : settledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SettlementImpl extends _Settlement {
  const _$SettlementImpl(
      {required this.id,
      required this.expenseSplitId,
      required this.fromUserId,
      required this.toUserId,
      required this.amount,
      required this.settledAt,
      this.paymentMethod,
      this.notes,
      this.isConfirmed = true})
      : super._();

  @override
  final String id;
  @override
  final String expenseSplitId;
  @override
  final String fromUserId;
  @override
  final String toUserId;
  @override
  final double amount;
  @override
  final DateTime settledAt;
  @override
  final String? paymentMethod;
  @override
  final String? notes;
  @override
  @JsonKey()
  final bool isConfirmed;

  @override
  String toString() {
    return 'Settlement(id: $id, expenseSplitId: $expenseSplitId, fromUserId: $fromUserId, toUserId: $toUserId, amount: $amount, settledAt: $settledAt, paymentMethod: $paymentMethod, notes: $notes, isConfirmed: $isConfirmed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettlementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.expenseSplitId, expenseSplitId) ||
                other.expenseSplitId == expenseSplitId) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.settledAt, settledAt) ||
                other.settledAt == settledAt) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isConfirmed, isConfirmed) ||
                other.isConfirmed == isConfirmed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, expenseSplitId, fromUserId,
      toUserId, amount, settledAt, paymentMethod, notes, isConfirmed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettlementImplCopyWith<_$SettlementImpl> get copyWith =>
      __$$SettlementImplCopyWithImpl<_$SettlementImpl>(this, _$identity);
}

abstract class _Settlement extends Settlement {
  const factory _Settlement(
      {required final String id,
      required final String expenseSplitId,
      required final String fromUserId,
      required final String toUserId,
      required final double amount,
      required final DateTime settledAt,
      final String? paymentMethod,
      final String? notes,
      final bool isConfirmed}) = _$SettlementImpl;
  const _Settlement._() : super._();

  @override
  String get id;
  @override
  String get expenseSplitId;
  @override
  String get fromUserId;
  @override
  String get toUserId;
  @override
  double get amount;
  @override
  DateTime get settledAt;
  @override
  String? get paymentMethod;
  @override
  String? get notes;
  @override
  bool get isConfirmed;
  @override
  @JsonKey(ignore: true)
  _$$SettlementImplCopyWith<_$SettlementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
