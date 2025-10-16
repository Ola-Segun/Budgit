// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_income.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecurringIncome {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  RecurringIncomeFrequency get frequency => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get payer => throw _privateConstructorUsedError;
  DateTime? get endDate =>
      throw _privateConstructorUsedError; // Optional end date for temporary incomes
  String? get website => throw _privateConstructorUsedError;
  String? get notes =>
      throw _privateConstructorUsedError; // ═══ ACCOUNT RELATIONSHIP ═══
  String? get defaultAccountId =>
      throw _privateConstructorUsedError; // Primary account for deposits
  List<String>? get allowedAccountIds =>
      throw _privateConstructorUsedError; // Alternative accounts for deposits
  String? get accountId =>
      throw _privateConstructorUsedError; // Legacy field for backward compatibility
// ═══ VARIABLE AMOUNT SUPPORT ═══
  bool get isVariableAmount => throw _privateConstructorUsedError;
  double? get minAmount => throw _privateConstructorUsedError;
  double? get maxAmount =>
      throw _privateConstructorUsedError; // ═══ CURRENCY SUPPORT ═══
  String? get currencyCode =>
      throw _privateConstructorUsedError; // ═══ RECURRING FLEXIBILITY ═══
  List<RecurringIncomeRule> get recurringIncomeRules =>
      throw _privateConstructorUsedError; // ═══ TRACKING ═══
  List<RecurringIncomeInstance> get incomeHistory =>
      throw _privateConstructorUsedError;
  DateTime? get lastReceivedDate => throw _privateConstructorUsedError;
  DateTime? get nextExpectedDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecurringIncomeCopyWith<RecurringIncome> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringIncomeCopyWith<$Res> {
  factory $RecurringIncomeCopyWith(
          RecurringIncome value, $Res Function(RecurringIncome) then) =
      _$RecurringIncomeCopyWithImpl<$Res, RecurringIncome>;
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      DateTime startDate,
      RecurringIncomeFrequency frequency,
      String categoryId,
      String? description,
      String? payer,
      DateTime? endDate,
      String? website,
      String? notes,
      String? defaultAccountId,
      List<String>? allowedAccountIds,
      String? accountId,
      bool isVariableAmount,
      double? minAmount,
      double? maxAmount,
      String? currencyCode,
      List<RecurringIncomeRule> recurringIncomeRules,
      List<RecurringIncomeInstance> incomeHistory,
      DateTime? lastReceivedDate,
      DateTime? nextExpectedDate});
}

/// @nodoc
class _$RecurringIncomeCopyWithImpl<$Res, $Val extends RecurringIncome>
    implements $RecurringIncomeCopyWith<$Res> {
  _$RecurringIncomeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? startDate = null,
    Object? frequency = null,
    Object? categoryId = null,
    Object? description = freezed,
    Object? payer = freezed,
    Object? endDate = freezed,
    Object? website = freezed,
    Object? notes = freezed,
    Object? defaultAccountId = freezed,
    Object? allowedAccountIds = freezed,
    Object? accountId = freezed,
    Object? isVariableAmount = null,
    Object? minAmount = freezed,
    Object? maxAmount = freezed,
    Object? currencyCode = freezed,
    Object? recurringIncomeRules = null,
    Object? incomeHistory = null,
    Object? lastReceivedDate = freezed,
    Object? nextExpectedDate = freezed,
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as RecurringIncomeFrequency,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      payer: freezed == payer
          ? _value.payer
          : payer // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultAccountId: freezed == defaultAccountId
          ? _value.defaultAccountId
          : defaultAccountId // ignore: cast_nullable_to_non_nullable
              as String?,
      allowedAccountIds: freezed == allowedAccountIds
          ? _value.allowedAccountIds
          : allowedAccountIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      isVariableAmount: null == isVariableAmount
          ? _value.isVariableAmount
          : isVariableAmount // ignore: cast_nullable_to_non_nullable
              as bool,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      recurringIncomeRules: null == recurringIncomeRules
          ? _value.recurringIncomeRules
          : recurringIncomeRules // ignore: cast_nullable_to_non_nullable
              as List<RecurringIncomeRule>,
      incomeHistory: null == incomeHistory
          ? _value.incomeHistory
          : incomeHistory // ignore: cast_nullable_to_non_nullable
              as List<RecurringIncomeInstance>,
      lastReceivedDate: freezed == lastReceivedDate
          ? _value.lastReceivedDate
          : lastReceivedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextExpectedDate: freezed == nextExpectedDate
          ? _value.nextExpectedDate
          : nextExpectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecurringIncomeImplCopyWith<$Res>
    implements $RecurringIncomeCopyWith<$Res> {
  factory _$$RecurringIncomeImplCopyWith(_$RecurringIncomeImpl value,
          $Res Function(_$RecurringIncomeImpl) then) =
      __$$RecurringIncomeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      DateTime startDate,
      RecurringIncomeFrequency frequency,
      String categoryId,
      String? description,
      String? payer,
      DateTime? endDate,
      String? website,
      String? notes,
      String? defaultAccountId,
      List<String>? allowedAccountIds,
      String? accountId,
      bool isVariableAmount,
      double? minAmount,
      double? maxAmount,
      String? currencyCode,
      List<RecurringIncomeRule> recurringIncomeRules,
      List<RecurringIncomeInstance> incomeHistory,
      DateTime? lastReceivedDate,
      DateTime? nextExpectedDate});
}

/// @nodoc
class __$$RecurringIncomeImplCopyWithImpl<$Res>
    extends _$RecurringIncomeCopyWithImpl<$Res, _$RecurringIncomeImpl>
    implements _$$RecurringIncomeImplCopyWith<$Res> {
  __$$RecurringIncomeImplCopyWithImpl(
      _$RecurringIncomeImpl _value, $Res Function(_$RecurringIncomeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? startDate = null,
    Object? frequency = null,
    Object? categoryId = null,
    Object? description = freezed,
    Object? payer = freezed,
    Object? endDate = freezed,
    Object? website = freezed,
    Object? notes = freezed,
    Object? defaultAccountId = freezed,
    Object? allowedAccountIds = freezed,
    Object? accountId = freezed,
    Object? isVariableAmount = null,
    Object? minAmount = freezed,
    Object? maxAmount = freezed,
    Object? currencyCode = freezed,
    Object? recurringIncomeRules = null,
    Object? incomeHistory = null,
    Object? lastReceivedDate = freezed,
    Object? nextExpectedDate = freezed,
  }) {
    return _then(_$RecurringIncomeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as RecurringIncomeFrequency,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      payer: freezed == payer
          ? _value.payer
          : payer // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultAccountId: freezed == defaultAccountId
          ? _value.defaultAccountId
          : defaultAccountId // ignore: cast_nullable_to_non_nullable
              as String?,
      allowedAccountIds: freezed == allowedAccountIds
          ? _value._allowedAccountIds
          : allowedAccountIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      isVariableAmount: null == isVariableAmount
          ? _value.isVariableAmount
          : isVariableAmount // ignore: cast_nullable_to_non_nullable
              as bool,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      recurringIncomeRules: null == recurringIncomeRules
          ? _value._recurringIncomeRules
          : recurringIncomeRules // ignore: cast_nullable_to_non_nullable
              as List<RecurringIncomeRule>,
      incomeHistory: null == incomeHistory
          ? _value._incomeHistory
          : incomeHistory // ignore: cast_nullable_to_non_nullable
              as List<RecurringIncomeInstance>,
      lastReceivedDate: freezed == lastReceivedDate
          ? _value.lastReceivedDate
          : lastReceivedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextExpectedDate: freezed == nextExpectedDate
          ? _value.nextExpectedDate
          : nextExpectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$RecurringIncomeImpl extends _RecurringIncome {
  const _$RecurringIncomeImpl(
      {required this.id,
      required this.name,
      required this.amount,
      required this.startDate,
      required this.frequency,
      required this.categoryId,
      this.description,
      this.payer,
      this.endDate,
      this.website,
      this.notes,
      this.defaultAccountId,
      final List<String>? allowedAccountIds,
      this.accountId,
      this.isVariableAmount = false,
      this.minAmount,
      this.maxAmount,
      this.currencyCode,
      final List<RecurringIncomeRule> recurringIncomeRules = const [],
      final List<RecurringIncomeInstance> incomeHistory = const [],
      this.lastReceivedDate,
      this.nextExpectedDate})
      : _allowedAccountIds = allowedAccountIds,
        _recurringIncomeRules = recurringIncomeRules,
        _incomeHistory = incomeHistory,
        super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final double amount;
  @override
  final DateTime startDate;
  @override
  final RecurringIncomeFrequency frequency;
  @override
  final String categoryId;
  @override
  final String? description;
  @override
  final String? payer;
  @override
  final DateTime? endDate;
// Optional end date for temporary incomes
  @override
  final String? website;
  @override
  final String? notes;
// ═══ ACCOUNT RELATIONSHIP ═══
  @override
  final String? defaultAccountId;
// Primary account for deposits
  final List<String>? _allowedAccountIds;
// Primary account for deposits
  @override
  List<String>? get allowedAccountIds {
    final value = _allowedAccountIds;
    if (value == null) return null;
    if (_allowedAccountIds is EqualUnmodifiableListView)
      return _allowedAccountIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Alternative accounts for deposits
  @override
  final String? accountId;
// Legacy field for backward compatibility
// ═══ VARIABLE AMOUNT SUPPORT ═══
  @override
  @JsonKey()
  final bool isVariableAmount;
  @override
  final double? minAmount;
  @override
  final double? maxAmount;
// ═══ CURRENCY SUPPORT ═══
  @override
  final String? currencyCode;
// ═══ RECURRING FLEXIBILITY ═══
  final List<RecurringIncomeRule> _recurringIncomeRules;
// ═══ RECURRING FLEXIBILITY ═══
  @override
  @JsonKey()
  List<RecurringIncomeRule> get recurringIncomeRules {
    if (_recurringIncomeRules is EqualUnmodifiableListView)
      return _recurringIncomeRules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recurringIncomeRules);
  }

// ═══ TRACKING ═══
  final List<RecurringIncomeInstance> _incomeHistory;
// ═══ TRACKING ═══
  @override
  @JsonKey()
  List<RecurringIncomeInstance> get incomeHistory {
    if (_incomeHistory is EqualUnmodifiableListView) return _incomeHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incomeHistory);
  }

  @override
  final DateTime? lastReceivedDate;
  @override
  final DateTime? nextExpectedDate;

  @override
  String toString() {
    return 'RecurringIncome(id: $id, name: $name, amount: $amount, startDate: $startDate, frequency: $frequency, categoryId: $categoryId, description: $description, payer: $payer, endDate: $endDate, website: $website, notes: $notes, defaultAccountId: $defaultAccountId, allowedAccountIds: $allowedAccountIds, accountId: $accountId, isVariableAmount: $isVariableAmount, minAmount: $minAmount, maxAmount: $maxAmount, currencyCode: $currencyCode, recurringIncomeRules: $recurringIncomeRules, incomeHistory: $incomeHistory, lastReceivedDate: $lastReceivedDate, nextExpectedDate: $nextExpectedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringIncomeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.payer, payer) || other.payer == payer) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.defaultAccountId, defaultAccountId) ||
                other.defaultAccountId == defaultAccountId) &&
            const DeepCollectionEquality()
                .equals(other._allowedAccountIds, _allowedAccountIds) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.isVariableAmount, isVariableAmount) ||
                other.isVariableAmount == isVariableAmount) &&
            (identical(other.minAmount, minAmount) ||
                other.minAmount == minAmount) &&
            (identical(other.maxAmount, maxAmount) ||
                other.maxAmount == maxAmount) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            const DeepCollectionEquality()
                .equals(other._recurringIncomeRules, _recurringIncomeRules) &&
            const DeepCollectionEquality()
                .equals(other._incomeHistory, _incomeHistory) &&
            (identical(other.lastReceivedDate, lastReceivedDate) ||
                other.lastReceivedDate == lastReceivedDate) &&
            (identical(other.nextExpectedDate, nextExpectedDate) ||
                other.nextExpectedDate == nextExpectedDate));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        amount,
        startDate,
        frequency,
        categoryId,
        description,
        payer,
        endDate,
        website,
        notes,
        defaultAccountId,
        const DeepCollectionEquality().hash(_allowedAccountIds),
        accountId,
        isVariableAmount,
        minAmount,
        maxAmount,
        currencyCode,
        const DeepCollectionEquality().hash(_recurringIncomeRules),
        const DeepCollectionEquality().hash(_incomeHistory),
        lastReceivedDate,
        nextExpectedDate
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringIncomeImplCopyWith<_$RecurringIncomeImpl> get copyWith =>
      __$$RecurringIncomeImplCopyWithImpl<_$RecurringIncomeImpl>(
          this, _$identity);
}

abstract class _RecurringIncome extends RecurringIncome {
  const factory _RecurringIncome(
      {required final String id,
      required final String name,
      required final double amount,
      required final DateTime startDate,
      required final RecurringIncomeFrequency frequency,
      required final String categoryId,
      final String? description,
      final String? payer,
      final DateTime? endDate,
      final String? website,
      final String? notes,
      final String? defaultAccountId,
      final List<String>? allowedAccountIds,
      final String? accountId,
      final bool isVariableAmount,
      final double? minAmount,
      final double? maxAmount,
      final String? currencyCode,
      final List<RecurringIncomeRule> recurringIncomeRules,
      final List<RecurringIncomeInstance> incomeHistory,
      final DateTime? lastReceivedDate,
      final DateTime? nextExpectedDate}) = _$RecurringIncomeImpl;
  const _RecurringIncome._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  double get amount;
  @override
  DateTime get startDate;
  @override
  RecurringIncomeFrequency get frequency;
  @override
  String get categoryId;
  @override
  String? get description;
  @override
  String? get payer;
  @override
  DateTime? get endDate;
  @override // Optional end date for temporary incomes
  String? get website;
  @override
  String? get notes;
  @override // ═══ ACCOUNT RELATIONSHIP ═══
  String? get defaultAccountId;
  @override // Primary account for deposits
  List<String>? get allowedAccountIds;
  @override // Alternative accounts for deposits
  String? get accountId;
  @override // Legacy field for backward compatibility
// ═══ VARIABLE AMOUNT SUPPORT ═══
  bool get isVariableAmount;
  @override
  double? get minAmount;
  @override
  double? get maxAmount;
  @override // ═══ CURRENCY SUPPORT ═══
  String? get currencyCode;
  @override // ═══ RECURRING FLEXIBILITY ═══
  List<RecurringIncomeRule> get recurringIncomeRules;
  @override // ═══ TRACKING ═══
  List<RecurringIncomeInstance> get incomeHistory;
  @override
  DateTime? get lastReceivedDate;
  @override
  DateTime? get nextExpectedDate;
  @override
  @JsonKey(ignore: true)
  _$$RecurringIncomeImplCopyWith<_$RecurringIncomeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecurringIncomeRule {
  String get id => throw _privateConstructorUsedError;
  int get instanceNumber =>
      throw _privateConstructorUsedError; // Which occurrence (1st, 2nd, etc.)
  String? get accountId =>
      throw _privateConstructorUsedError; // Specific account for this instance
  double? get amount =>
      throw _privateConstructorUsedError; // Specific amount for this instance (overrides income amount)
  String? get notes => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecurringIncomeRuleCopyWith<RecurringIncomeRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringIncomeRuleCopyWith<$Res> {
  factory $RecurringIncomeRuleCopyWith(
          RecurringIncomeRule value, $Res Function(RecurringIncomeRule) then) =
      _$RecurringIncomeRuleCopyWithImpl<$Res, RecurringIncomeRule>;
  @useResult
  $Res call(
      {String id,
      int instanceNumber,
      String? accountId,
      double? amount,
      String? notes,
      bool isEnabled});
}

/// @nodoc
class _$RecurringIncomeRuleCopyWithImpl<$Res, $Val extends RecurringIncomeRule>
    implements $RecurringIncomeRuleCopyWith<$Res> {
  _$RecurringIncomeRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? instanceNumber = null,
    Object? accountId = freezed,
    Object? amount = freezed,
    Object? notes = freezed,
    Object? isEnabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      instanceNumber: null == instanceNumber
          ? _value.instanceNumber
          : instanceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecurringIncomeRuleImplCopyWith<$Res>
    implements $RecurringIncomeRuleCopyWith<$Res> {
  factory _$$RecurringIncomeRuleImplCopyWith(_$RecurringIncomeRuleImpl value,
          $Res Function(_$RecurringIncomeRuleImpl) then) =
      __$$RecurringIncomeRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int instanceNumber,
      String? accountId,
      double? amount,
      String? notes,
      bool isEnabled});
}

/// @nodoc
class __$$RecurringIncomeRuleImplCopyWithImpl<$Res>
    extends _$RecurringIncomeRuleCopyWithImpl<$Res, _$RecurringIncomeRuleImpl>
    implements _$$RecurringIncomeRuleImplCopyWith<$Res> {
  __$$RecurringIncomeRuleImplCopyWithImpl(_$RecurringIncomeRuleImpl _value,
      $Res Function(_$RecurringIncomeRuleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? instanceNumber = null,
    Object? accountId = freezed,
    Object? amount = freezed,
    Object? notes = freezed,
    Object? isEnabled = null,
  }) {
    return _then(_$RecurringIncomeRuleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      instanceNumber: null == instanceNumber
          ? _value.instanceNumber
          : instanceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RecurringIncomeRuleImpl extends _RecurringIncomeRule {
  const _$RecurringIncomeRuleImpl(
      {required this.id,
      required this.instanceNumber,
      this.accountId,
      this.amount,
      this.notes,
      this.isEnabled = true})
      : super._();

  @override
  final String id;
  @override
  final int instanceNumber;
// Which occurrence (1st, 2nd, etc.)
  @override
  final String? accountId;
// Specific account for this instance
  @override
  final double? amount;
// Specific amount for this instance (overrides income amount)
  @override
  final String? notes;
  @override
  @JsonKey()
  final bool isEnabled;

  @override
  String toString() {
    return 'RecurringIncomeRule(id: $id, instanceNumber: $instanceNumber, accountId: $accountId, amount: $amount, notes: $notes, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringIncomeRuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.instanceNumber, instanceNumber) ||
                other.instanceNumber == instanceNumber) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, instanceNumber, accountId, amount, notes, isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringIncomeRuleImplCopyWith<_$RecurringIncomeRuleImpl> get copyWith =>
      __$$RecurringIncomeRuleImplCopyWithImpl<_$RecurringIncomeRuleImpl>(
          this, _$identity);
}

abstract class _RecurringIncomeRule extends RecurringIncomeRule {
  const factory _RecurringIncomeRule(
      {required final String id,
      required final int instanceNumber,
      final String? accountId,
      final double? amount,
      final String? notes,
      final bool isEnabled}) = _$RecurringIncomeRuleImpl;
  const _RecurringIncomeRule._() : super._();

  @override
  String get id;
  @override
  int get instanceNumber;
  @override // Which occurrence (1st, 2nd, etc.)
  String? get accountId;
  @override // Specific account for this instance
  double? get amount;
  @override // Specific amount for this instance (overrides income amount)
  String? get notes;
  @override
  bool get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$RecurringIncomeRuleImplCopyWith<_$RecurringIncomeRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecurringIncomesSummary {
  int get totalIncomes => throw _privateConstructorUsedError;
  int get activeIncomes => throw _privateConstructorUsedError;
  int get expectedThisMonth => throw _privateConstructorUsedError;
  double get totalMonthlyAmount => throw _privateConstructorUsedError;
  double get receivedThisMonth => throw _privateConstructorUsedError;
  double get expectedAmount => throw _privateConstructorUsedError;
  List<RecurringIncomeStatus> get upcomingIncomes =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecurringIncomesSummaryCopyWith<RecurringIncomesSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringIncomesSummaryCopyWith<$Res> {
  factory $RecurringIncomesSummaryCopyWith(RecurringIncomesSummary value,
          $Res Function(RecurringIncomesSummary) then) =
      _$RecurringIncomesSummaryCopyWithImpl<$Res, RecurringIncomesSummary>;
  @useResult
  $Res call(
      {int totalIncomes,
      int activeIncomes,
      int expectedThisMonth,
      double totalMonthlyAmount,
      double receivedThisMonth,
      double expectedAmount,
      List<RecurringIncomeStatus> upcomingIncomes});
}

/// @nodoc
class _$RecurringIncomesSummaryCopyWithImpl<$Res,
        $Val extends RecurringIncomesSummary>
    implements $RecurringIncomesSummaryCopyWith<$Res> {
  _$RecurringIncomesSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncomes = null,
    Object? activeIncomes = null,
    Object? expectedThisMonth = null,
    Object? totalMonthlyAmount = null,
    Object? receivedThisMonth = null,
    Object? expectedAmount = null,
    Object? upcomingIncomes = null,
  }) {
    return _then(_value.copyWith(
      totalIncomes: null == totalIncomes
          ? _value.totalIncomes
          : totalIncomes // ignore: cast_nullable_to_non_nullable
              as int,
      activeIncomes: null == activeIncomes
          ? _value.activeIncomes
          : activeIncomes // ignore: cast_nullable_to_non_nullable
              as int,
      expectedThisMonth: null == expectedThisMonth
          ? _value.expectedThisMonth
          : expectedThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      totalMonthlyAmount: null == totalMonthlyAmount
          ? _value.totalMonthlyAmount
          : totalMonthlyAmount // ignore: cast_nullable_to_non_nullable
              as double,
      receivedThisMonth: null == receivedThisMonth
          ? _value.receivedThisMonth
          : receivedThisMonth // ignore: cast_nullable_to_non_nullable
              as double,
      expectedAmount: null == expectedAmount
          ? _value.expectedAmount
          : expectedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      upcomingIncomes: null == upcomingIncomes
          ? _value.upcomingIncomes
          : upcomingIncomes // ignore: cast_nullable_to_non_nullable
              as List<RecurringIncomeStatus>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecurringIncomesSummaryImplCopyWith<$Res>
    implements $RecurringIncomesSummaryCopyWith<$Res> {
  factory _$$RecurringIncomesSummaryImplCopyWith(
          _$RecurringIncomesSummaryImpl value,
          $Res Function(_$RecurringIncomesSummaryImpl) then) =
      __$$RecurringIncomesSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalIncomes,
      int activeIncomes,
      int expectedThisMonth,
      double totalMonthlyAmount,
      double receivedThisMonth,
      double expectedAmount,
      List<RecurringIncomeStatus> upcomingIncomes});
}

/// @nodoc
class __$$RecurringIncomesSummaryImplCopyWithImpl<$Res>
    extends _$RecurringIncomesSummaryCopyWithImpl<$Res,
        _$RecurringIncomesSummaryImpl>
    implements _$$RecurringIncomesSummaryImplCopyWith<$Res> {
  __$$RecurringIncomesSummaryImplCopyWithImpl(
      _$RecurringIncomesSummaryImpl _value,
      $Res Function(_$RecurringIncomesSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncomes = null,
    Object? activeIncomes = null,
    Object? expectedThisMonth = null,
    Object? totalMonthlyAmount = null,
    Object? receivedThisMonth = null,
    Object? expectedAmount = null,
    Object? upcomingIncomes = null,
  }) {
    return _then(_$RecurringIncomesSummaryImpl(
      totalIncomes: null == totalIncomes
          ? _value.totalIncomes
          : totalIncomes // ignore: cast_nullable_to_non_nullable
              as int,
      activeIncomes: null == activeIncomes
          ? _value.activeIncomes
          : activeIncomes // ignore: cast_nullable_to_non_nullable
              as int,
      expectedThisMonth: null == expectedThisMonth
          ? _value.expectedThisMonth
          : expectedThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      totalMonthlyAmount: null == totalMonthlyAmount
          ? _value.totalMonthlyAmount
          : totalMonthlyAmount // ignore: cast_nullable_to_non_nullable
              as double,
      receivedThisMonth: null == receivedThisMonth
          ? _value.receivedThisMonth
          : receivedThisMonth // ignore: cast_nullable_to_non_nullable
              as double,
      expectedAmount: null == expectedAmount
          ? _value.expectedAmount
          : expectedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      upcomingIncomes: null == upcomingIncomes
          ? _value._upcomingIncomes
          : upcomingIncomes // ignore: cast_nullable_to_non_nullable
              as List<RecurringIncomeStatus>,
    ));
  }
}

/// @nodoc

class _$RecurringIncomesSummaryImpl extends _RecurringIncomesSummary {
  const _$RecurringIncomesSummaryImpl(
      {required this.totalIncomes,
      required this.activeIncomes,
      required this.expectedThisMonth,
      required this.totalMonthlyAmount,
      required this.receivedThisMonth,
      required this.expectedAmount,
      required final List<RecurringIncomeStatus> upcomingIncomes})
      : _upcomingIncomes = upcomingIncomes,
        super._();

  @override
  final int totalIncomes;
  @override
  final int activeIncomes;
  @override
  final int expectedThisMonth;
  @override
  final double totalMonthlyAmount;
  @override
  final double receivedThisMonth;
  @override
  final double expectedAmount;
  final List<RecurringIncomeStatus> _upcomingIncomes;
  @override
  List<RecurringIncomeStatus> get upcomingIncomes {
    if (_upcomingIncomes is EqualUnmodifiableListView) return _upcomingIncomes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingIncomes);
  }

  @override
  String toString() {
    return 'RecurringIncomesSummary(totalIncomes: $totalIncomes, activeIncomes: $activeIncomes, expectedThisMonth: $expectedThisMonth, totalMonthlyAmount: $totalMonthlyAmount, receivedThisMonth: $receivedThisMonth, expectedAmount: $expectedAmount, upcomingIncomes: $upcomingIncomes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringIncomesSummaryImpl &&
            (identical(other.totalIncomes, totalIncomes) ||
                other.totalIncomes == totalIncomes) &&
            (identical(other.activeIncomes, activeIncomes) ||
                other.activeIncomes == activeIncomes) &&
            (identical(other.expectedThisMonth, expectedThisMonth) ||
                other.expectedThisMonth == expectedThisMonth) &&
            (identical(other.totalMonthlyAmount, totalMonthlyAmount) ||
                other.totalMonthlyAmount == totalMonthlyAmount) &&
            (identical(other.receivedThisMonth, receivedThisMonth) ||
                other.receivedThisMonth == receivedThisMonth) &&
            (identical(other.expectedAmount, expectedAmount) ||
                other.expectedAmount == expectedAmount) &&
            const DeepCollectionEquality()
                .equals(other._upcomingIncomes, _upcomingIncomes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalIncomes,
      activeIncomes,
      expectedThisMonth,
      totalMonthlyAmount,
      receivedThisMonth,
      expectedAmount,
      const DeepCollectionEquality().hash(_upcomingIncomes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringIncomesSummaryImplCopyWith<_$RecurringIncomesSummaryImpl>
      get copyWith => __$$RecurringIncomesSummaryImplCopyWithImpl<
          _$RecurringIncomesSummaryImpl>(this, _$identity);
}

abstract class _RecurringIncomesSummary extends RecurringIncomesSummary {
  const factory _RecurringIncomesSummary(
          {required final int totalIncomes,
          required final int activeIncomes,
          required final int expectedThisMonth,
          required final double totalMonthlyAmount,
          required final double receivedThisMonth,
          required final double expectedAmount,
          required final List<RecurringIncomeStatus> upcomingIncomes}) =
      _$RecurringIncomesSummaryImpl;
  const _RecurringIncomesSummary._() : super._();

  @override
  int get totalIncomes;
  @override
  int get activeIncomes;
  @override
  int get expectedThisMonth;
  @override
  double get totalMonthlyAmount;
  @override
  double get receivedThisMonth;
  @override
  double get expectedAmount;
  @override
  List<RecurringIncomeStatus> get upcomingIncomes;
  @override
  @JsonKey(ignore: true)
  _$$RecurringIncomesSummaryImplCopyWith<_$RecurringIncomesSummaryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecurringIncomeStatus {
  RecurringIncome get income => throw _privateConstructorUsedError;
  int get daysUntilExpected => throw _privateConstructorUsedError;
  bool get isExpectedSoon => throw _privateConstructorUsedError;
  bool get isExpectedToday => throw _privateConstructorUsedError;
  bool get isOverdue => throw _privateConstructorUsedError;
  RecurringIncomeUrgency get urgency => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecurringIncomeStatusCopyWith<RecurringIncomeStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringIncomeStatusCopyWith<$Res> {
  factory $RecurringIncomeStatusCopyWith(RecurringIncomeStatus value,
          $Res Function(RecurringIncomeStatus) then) =
      _$RecurringIncomeStatusCopyWithImpl<$Res, RecurringIncomeStatus>;
  @useResult
  $Res call(
      {RecurringIncome income,
      int daysUntilExpected,
      bool isExpectedSoon,
      bool isExpectedToday,
      bool isOverdue,
      RecurringIncomeUrgency urgency});

  $RecurringIncomeCopyWith<$Res> get income;
}

/// @nodoc
class _$RecurringIncomeStatusCopyWithImpl<$Res,
        $Val extends RecurringIncomeStatus>
    implements $RecurringIncomeStatusCopyWith<$Res> {
  _$RecurringIncomeStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? income = null,
    Object? daysUntilExpected = null,
    Object? isExpectedSoon = null,
    Object? isExpectedToday = null,
    Object? isOverdue = null,
    Object? urgency = null,
  }) {
    return _then(_value.copyWith(
      income: null == income
          ? _value.income
          : income // ignore: cast_nullable_to_non_nullable
              as RecurringIncome,
      daysUntilExpected: null == daysUntilExpected
          ? _value.daysUntilExpected
          : daysUntilExpected // ignore: cast_nullable_to_non_nullable
              as int,
      isExpectedSoon: null == isExpectedSoon
          ? _value.isExpectedSoon
          : isExpectedSoon // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpectedToday: null == isExpectedToday
          ? _value.isExpectedToday
          : isExpectedToday // ignore: cast_nullable_to_non_nullable
              as bool,
      isOverdue: null == isOverdue
          ? _value.isOverdue
          : isOverdue // ignore: cast_nullable_to_non_nullable
              as bool,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as RecurringIncomeUrgency,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RecurringIncomeCopyWith<$Res> get income {
    return $RecurringIncomeCopyWith<$Res>(_value.income, (value) {
      return _then(_value.copyWith(income: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecurringIncomeStatusImplCopyWith<$Res>
    implements $RecurringIncomeStatusCopyWith<$Res> {
  factory _$$RecurringIncomeStatusImplCopyWith(
          _$RecurringIncomeStatusImpl value,
          $Res Function(_$RecurringIncomeStatusImpl) then) =
      __$$RecurringIncomeStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RecurringIncome income,
      int daysUntilExpected,
      bool isExpectedSoon,
      bool isExpectedToday,
      bool isOverdue,
      RecurringIncomeUrgency urgency});

  @override
  $RecurringIncomeCopyWith<$Res> get income;
}

/// @nodoc
class __$$RecurringIncomeStatusImplCopyWithImpl<$Res>
    extends _$RecurringIncomeStatusCopyWithImpl<$Res,
        _$RecurringIncomeStatusImpl>
    implements _$$RecurringIncomeStatusImplCopyWith<$Res> {
  __$$RecurringIncomeStatusImplCopyWithImpl(_$RecurringIncomeStatusImpl _value,
      $Res Function(_$RecurringIncomeStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? income = null,
    Object? daysUntilExpected = null,
    Object? isExpectedSoon = null,
    Object? isExpectedToday = null,
    Object? isOverdue = null,
    Object? urgency = null,
  }) {
    return _then(_$RecurringIncomeStatusImpl(
      income: null == income
          ? _value.income
          : income // ignore: cast_nullable_to_non_nullable
              as RecurringIncome,
      daysUntilExpected: null == daysUntilExpected
          ? _value.daysUntilExpected
          : daysUntilExpected // ignore: cast_nullable_to_non_nullable
              as int,
      isExpectedSoon: null == isExpectedSoon
          ? _value.isExpectedSoon
          : isExpectedSoon // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpectedToday: null == isExpectedToday
          ? _value.isExpectedToday
          : isExpectedToday // ignore: cast_nullable_to_non_nullable
              as bool,
      isOverdue: null == isOverdue
          ? _value.isOverdue
          : isOverdue // ignore: cast_nullable_to_non_nullable
              as bool,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as RecurringIncomeUrgency,
    ));
  }
}

/// @nodoc

class _$RecurringIncomeStatusImpl extends _RecurringIncomeStatus {
  const _$RecurringIncomeStatusImpl(
      {required this.income,
      required this.daysUntilExpected,
      required this.isExpectedSoon,
      required this.isExpectedToday,
      required this.isOverdue,
      required this.urgency})
      : super._();

  @override
  final RecurringIncome income;
  @override
  final int daysUntilExpected;
  @override
  final bool isExpectedSoon;
  @override
  final bool isExpectedToday;
  @override
  final bool isOverdue;
  @override
  final RecurringIncomeUrgency urgency;

  @override
  String toString() {
    return 'RecurringIncomeStatus(income: $income, daysUntilExpected: $daysUntilExpected, isExpectedSoon: $isExpectedSoon, isExpectedToday: $isExpectedToday, isOverdue: $isOverdue, urgency: $urgency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringIncomeStatusImpl &&
            (identical(other.income, income) || other.income == income) &&
            (identical(other.daysUntilExpected, daysUntilExpected) ||
                other.daysUntilExpected == daysUntilExpected) &&
            (identical(other.isExpectedSoon, isExpectedSoon) ||
                other.isExpectedSoon == isExpectedSoon) &&
            (identical(other.isExpectedToday, isExpectedToday) ||
                other.isExpectedToday == isExpectedToday) &&
            (identical(other.isOverdue, isOverdue) ||
                other.isOverdue == isOverdue) &&
            (identical(other.urgency, urgency) || other.urgency == urgency));
  }

  @override
  int get hashCode => Object.hash(runtimeType, income, daysUntilExpected,
      isExpectedSoon, isExpectedToday, isOverdue, urgency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringIncomeStatusImplCopyWith<_$RecurringIncomeStatusImpl>
      get copyWith => __$$RecurringIncomeStatusImplCopyWithImpl<
          _$RecurringIncomeStatusImpl>(this, _$identity);
}

abstract class _RecurringIncomeStatus extends RecurringIncomeStatus {
  const factory _RecurringIncomeStatus(
          {required final RecurringIncome income,
          required final int daysUntilExpected,
          required final bool isExpectedSoon,
          required final bool isExpectedToday,
          required final bool isOverdue,
          required final RecurringIncomeUrgency urgency}) =
      _$RecurringIncomeStatusImpl;
  const _RecurringIncomeStatus._() : super._();

  @override
  RecurringIncome get income;
  @override
  int get daysUntilExpected;
  @override
  bool get isExpectedSoon;
  @override
  bool get isExpectedToday;
  @override
  bool get isOverdue;
  @override
  RecurringIncomeUrgency get urgency;
  @override
  @JsonKey(ignore: true)
  _$$RecurringIncomeStatusImplCopyWith<_$RecurringIncomeStatusImpl>
      get copyWith => throw _privateConstructorUsedError;
}
