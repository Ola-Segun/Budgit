// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Insight {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  InsightType get type => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  double? get percentage => throw _privateConstructorUsedError;
  InsightPriority get priority => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InsightCopyWith<Insight> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightCopyWith<$Res> {
  factory $InsightCopyWith(Insight value, $Res Function(Insight) then) =
      _$InsightCopyWithImpl<$Res, Insight>;
  @useResult
  $Res call(
      {String id,
      String title,
      String message,
      InsightType type,
      DateTime generatedAt,
      String? categoryId,
      String? transactionId,
      double? amount,
      double? percentage,
      InsightPriority priority,
      bool isRead,
      bool isArchived,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$InsightCopyWithImpl<$Res, $Val extends Insight>
    implements $InsightCopyWith<$Res> {
  _$InsightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? type = null,
    Object? generatedAt = null,
    Object? categoryId = freezed,
    Object? transactionId = freezed,
    Object? amount = freezed,
    Object? percentage = freezed,
    Object? priority = null,
    Object? isRead = null,
    Object? isArchived = null,
    Object? metadata = freezed,
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
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InsightType,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      percentage: freezed == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as InsightPriority,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsightImplCopyWith<$Res> implements $InsightCopyWith<$Res> {
  factory _$$InsightImplCopyWith(
          _$InsightImpl value, $Res Function(_$InsightImpl) then) =
      __$$InsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String message,
      InsightType type,
      DateTime generatedAt,
      String? categoryId,
      String? transactionId,
      double? amount,
      double? percentage,
      InsightPriority priority,
      bool isRead,
      bool isArchived,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$InsightImplCopyWithImpl<$Res>
    extends _$InsightCopyWithImpl<$Res, _$InsightImpl>
    implements _$$InsightImplCopyWith<$Res> {
  __$$InsightImplCopyWithImpl(
      _$InsightImpl _value, $Res Function(_$InsightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? message = null,
    Object? type = null,
    Object? generatedAt = null,
    Object? categoryId = freezed,
    Object? transactionId = freezed,
    Object? amount = freezed,
    Object? percentage = freezed,
    Object? priority = null,
    Object? isRead = null,
    Object? isArchived = null,
    Object? metadata = freezed,
  }) {
    return _then(_$InsightImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InsightType,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      percentage: freezed == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as InsightPriority,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$InsightImpl extends _Insight {
  const _$InsightImpl(
      {required this.id,
      required this.title,
      required this.message,
      required this.type,
      required this.generatedAt,
      this.categoryId,
      this.transactionId,
      this.amount,
      this.percentage,
      this.priority = InsightPriority.medium,
      this.isRead = false,
      this.isArchived = false,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata,
        super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final String message;
  @override
  final InsightType type;
  @override
  final DateTime generatedAt;
  @override
  final String? categoryId;
  @override
  final String? transactionId;
  @override
  final double? amount;
  @override
  final double? percentage;
  @override
  @JsonKey()
  final InsightPriority priority;
  @override
  @JsonKey()
  final bool isRead;
  @override
  @JsonKey()
  final bool isArchived;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Insight(id: $id, title: $title, message: $message, type: $type, generatedAt: $generatedAt, categoryId: $categoryId, transactionId: $transactionId, amount: $amount, percentage: $percentage, priority: $priority, isRead: $isRead, isArchived: $isArchived, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      message,
      type,
      generatedAt,
      categoryId,
      transactionId,
      amount,
      percentage,
      priority,
      isRead,
      isArchived,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightImplCopyWith<_$InsightImpl> get copyWith =>
      __$$InsightImplCopyWithImpl<_$InsightImpl>(this, _$identity);
}

abstract class _Insight extends Insight {
  const factory _Insight(
      {required final String id,
      required final String title,
      required final String message,
      required final InsightType type,
      required final DateTime generatedAt,
      final String? categoryId,
      final String? transactionId,
      final double? amount,
      final double? percentage,
      final InsightPriority priority,
      final bool isRead,
      final bool isArchived,
      final Map<String, dynamic>? metadata}) = _$InsightImpl;
  const _Insight._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  String get message;
  @override
  InsightType get type;
  @override
  DateTime get generatedAt;
  @override
  String? get categoryId;
  @override
  String? get transactionId;
  @override
  double? get amount;
  @override
  double? get percentage;
  @override
  InsightPriority get priority;
  @override
  bool get isRead;
  @override
  bool get isArchived;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$InsightImplCopyWith<_$InsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SpendingTrend {
  DateTime get period => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get previousAmount => throw _privateConstructorUsedError;
  double get changeAmount => throw _privateConstructorUsedError;
  double get changePercentage => throw _privateConstructorUsedError;
  TrendDirection get direction => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String? get categoryName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpendingTrendCopyWith<SpendingTrend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpendingTrendCopyWith<$Res> {
  factory $SpendingTrendCopyWith(
          SpendingTrend value, $Res Function(SpendingTrend) then) =
      _$SpendingTrendCopyWithImpl<$Res, SpendingTrend>;
  @useResult
  $Res call(
      {DateTime period,
      double amount,
      double previousAmount,
      double changeAmount,
      double changePercentage,
      TrendDirection direction,
      String categoryId,
      String? categoryName});
}

/// @nodoc
class _$SpendingTrendCopyWithImpl<$Res, $Val extends SpendingTrend>
    implements $SpendingTrendCopyWith<$Res> {
  _$SpendingTrendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? amount = null,
    Object? previousAmount = null,
    Object? changeAmount = null,
    Object? changePercentage = null,
    Object? direction = null,
    Object? categoryId = null,
    Object? categoryName = freezed,
  }) {
    return _then(_value.copyWith(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      previousAmount: null == previousAmount
          ? _value.previousAmount
          : previousAmount // ignore: cast_nullable_to_non_nullable
              as double,
      changeAmount: null == changeAmount
          ? _value.changeAmount
          : changeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpendingTrendImplCopyWith<$Res>
    implements $SpendingTrendCopyWith<$Res> {
  factory _$$SpendingTrendImplCopyWith(
          _$SpendingTrendImpl value, $Res Function(_$SpendingTrendImpl) then) =
      __$$SpendingTrendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime period,
      double amount,
      double previousAmount,
      double changeAmount,
      double changePercentage,
      TrendDirection direction,
      String categoryId,
      String? categoryName});
}

/// @nodoc
class __$$SpendingTrendImplCopyWithImpl<$Res>
    extends _$SpendingTrendCopyWithImpl<$Res, _$SpendingTrendImpl>
    implements _$$SpendingTrendImplCopyWith<$Res> {
  __$$SpendingTrendImplCopyWithImpl(
      _$SpendingTrendImpl _value, $Res Function(_$SpendingTrendImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? amount = null,
    Object? previousAmount = null,
    Object? changeAmount = null,
    Object? changePercentage = null,
    Object? direction = null,
    Object? categoryId = null,
    Object? categoryName = freezed,
  }) {
    return _then(_$SpendingTrendImpl(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      previousAmount: null == previousAmount
          ? _value.previousAmount
          : previousAmount // ignore: cast_nullable_to_non_nullable
              as double,
      changeAmount: null == changeAmount
          ? _value.changeAmount
          : changeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SpendingTrendImpl extends _SpendingTrend {
  const _$SpendingTrendImpl(
      {required this.period,
      required this.amount,
      required this.previousAmount,
      required this.changeAmount,
      required this.changePercentage,
      required this.direction,
      required this.categoryId,
      this.categoryName})
      : super._();

  @override
  final DateTime period;
  @override
  final double amount;
  @override
  final double previousAmount;
  @override
  final double changeAmount;
  @override
  final double changePercentage;
  @override
  final TrendDirection direction;
  @override
  final String categoryId;
  @override
  final String? categoryName;

  @override
  String toString() {
    return 'SpendingTrend(period: $period, amount: $amount, previousAmount: $previousAmount, changeAmount: $changeAmount, changePercentage: $changePercentage, direction: $direction, categoryId: $categoryId, categoryName: $categoryName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpendingTrendImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.previousAmount, previousAmount) ||
                other.previousAmount == previousAmount) &&
            (identical(other.changeAmount, changeAmount) ||
                other.changeAmount == changeAmount) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, period, amount, previousAmount,
      changeAmount, changePercentage, direction, categoryId, categoryName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpendingTrendImplCopyWith<_$SpendingTrendImpl> get copyWith =>
      __$$SpendingTrendImplCopyWithImpl<_$SpendingTrendImpl>(this, _$identity);
}

abstract class _SpendingTrend extends SpendingTrend {
  const factory _SpendingTrend(
      {required final DateTime period,
      required final double amount,
      required final double previousAmount,
      required final double changeAmount,
      required final double changePercentage,
      required final TrendDirection direction,
      required final String categoryId,
      final String? categoryName}) = _$SpendingTrendImpl;
  const _SpendingTrend._() : super._();

  @override
  DateTime get period;
  @override
  double get amount;
  @override
  double get previousAmount;
  @override
  double get changeAmount;
  @override
  double get changePercentage;
  @override
  TrendDirection get direction;
  @override
  String get categoryId;
  @override
  String? get categoryName;
  @override
  @JsonKey(ignore: true)
  _$$SpendingTrendImplCopyWith<_$SpendingTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CategoryAnalysis {
  String get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  double get totalSpent => throw _privateConstructorUsedError;
  double get budgetAmount => throw _privateConstructorUsedError;
  double get percentageOfBudget => throw _privateConstructorUsedError;
  double get percentageOfTotalSpending => throw _privateConstructorUsedError;
  int get transactionCount => throw _privateConstructorUsedError;
  double get averageTransactionAmount => throw _privateConstructorUsedError;
  DateTime get period => throw _privateConstructorUsedError;
  CategoryHealthStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryAnalysisCopyWith<CategoryAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryAnalysisCopyWith<$Res> {
  factory $CategoryAnalysisCopyWith(
          CategoryAnalysis value, $Res Function(CategoryAnalysis) then) =
      _$CategoryAnalysisCopyWithImpl<$Res, CategoryAnalysis>;
  @useResult
  $Res call(
      {String categoryId,
      String categoryName,
      double totalSpent,
      double budgetAmount,
      double percentageOfBudget,
      double percentageOfTotalSpending,
      int transactionCount,
      double averageTransactionAmount,
      DateTime period,
      CategoryHealthStatus status});
}

/// @nodoc
class _$CategoryAnalysisCopyWithImpl<$Res, $Val extends CategoryAnalysis>
    implements $CategoryAnalysisCopyWith<$Res> {
  _$CategoryAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? totalSpent = null,
    Object? budgetAmount = null,
    Object? percentageOfBudget = null,
    Object? percentageOfTotalSpending = null,
    Object? transactionCount = null,
    Object? averageTransactionAmount = null,
    Object? period = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      budgetAmount: null == budgetAmount
          ? _value.budgetAmount
          : budgetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      percentageOfBudget: null == percentageOfBudget
          ? _value.percentageOfBudget
          : percentageOfBudget // ignore: cast_nullable_to_non_nullable
              as double,
      percentageOfTotalSpending: null == percentageOfTotalSpending
          ? _value.percentageOfTotalSpending
          : percentageOfTotalSpending // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageTransactionAmount: null == averageTransactionAmount
          ? _value.averageTransactionAmount
          : averageTransactionAmount // ignore: cast_nullable_to_non_nullable
              as double,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CategoryHealthStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryAnalysisImplCopyWith<$Res>
    implements $CategoryAnalysisCopyWith<$Res> {
  factory _$$CategoryAnalysisImplCopyWith(_$CategoryAnalysisImpl value,
          $Res Function(_$CategoryAnalysisImpl) then) =
      __$$CategoryAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String categoryId,
      String categoryName,
      double totalSpent,
      double budgetAmount,
      double percentageOfBudget,
      double percentageOfTotalSpending,
      int transactionCount,
      double averageTransactionAmount,
      DateTime period,
      CategoryHealthStatus status});
}

/// @nodoc
class __$$CategoryAnalysisImplCopyWithImpl<$Res>
    extends _$CategoryAnalysisCopyWithImpl<$Res, _$CategoryAnalysisImpl>
    implements _$$CategoryAnalysisImplCopyWith<$Res> {
  __$$CategoryAnalysisImplCopyWithImpl(_$CategoryAnalysisImpl _value,
      $Res Function(_$CategoryAnalysisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? totalSpent = null,
    Object? budgetAmount = null,
    Object? percentageOfBudget = null,
    Object? percentageOfTotalSpending = null,
    Object? transactionCount = null,
    Object? averageTransactionAmount = null,
    Object? period = null,
    Object? status = null,
  }) {
    return _then(_$CategoryAnalysisImpl(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      budgetAmount: null == budgetAmount
          ? _value.budgetAmount
          : budgetAmount // ignore: cast_nullable_to_non_nullable
              as double,
      percentageOfBudget: null == percentageOfBudget
          ? _value.percentageOfBudget
          : percentageOfBudget // ignore: cast_nullable_to_non_nullable
              as double,
      percentageOfTotalSpending: null == percentageOfTotalSpending
          ? _value.percentageOfTotalSpending
          : percentageOfTotalSpending // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageTransactionAmount: null == averageTransactionAmount
          ? _value.averageTransactionAmount
          : averageTransactionAmount // ignore: cast_nullable_to_non_nullable
              as double,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CategoryHealthStatus,
    ));
  }
}

/// @nodoc

class _$CategoryAnalysisImpl extends _CategoryAnalysis {
  const _$CategoryAnalysisImpl(
      {required this.categoryId,
      required this.categoryName,
      required this.totalSpent,
      required this.budgetAmount,
      required this.percentageOfBudget,
      required this.percentageOfTotalSpending,
      required this.transactionCount,
      required this.averageTransactionAmount,
      required this.period,
      required this.status})
      : super._();

  @override
  final String categoryId;
  @override
  final String categoryName;
  @override
  final double totalSpent;
  @override
  final double budgetAmount;
  @override
  final double percentageOfBudget;
  @override
  final double percentageOfTotalSpending;
  @override
  final int transactionCount;
  @override
  final double averageTransactionAmount;
  @override
  final DateTime period;
  @override
  final CategoryHealthStatus status;

  @override
  String toString() {
    return 'CategoryAnalysis(categoryId: $categoryId, categoryName: $categoryName, totalSpent: $totalSpent, budgetAmount: $budgetAmount, percentageOfBudget: $percentageOfBudget, percentageOfTotalSpending: $percentageOfTotalSpending, transactionCount: $transactionCount, averageTransactionAmount: $averageTransactionAmount, period: $period, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryAnalysisImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.budgetAmount, budgetAmount) ||
                other.budgetAmount == budgetAmount) &&
            (identical(other.percentageOfBudget, percentageOfBudget) ||
                other.percentageOfBudget == percentageOfBudget) &&
            (identical(other.percentageOfTotalSpending,
                    percentageOfTotalSpending) ||
                other.percentageOfTotalSpending == percentageOfTotalSpending) &&
            (identical(other.transactionCount, transactionCount) ||
                other.transactionCount == transactionCount) &&
            (identical(
                    other.averageTransactionAmount, averageTransactionAmount) ||
                other.averageTransactionAmount == averageTransactionAmount) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      categoryId,
      categoryName,
      totalSpent,
      budgetAmount,
      percentageOfBudget,
      percentageOfTotalSpending,
      transactionCount,
      averageTransactionAmount,
      period,
      status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryAnalysisImplCopyWith<_$CategoryAnalysisImpl> get copyWith =>
      __$$CategoryAnalysisImplCopyWithImpl<_$CategoryAnalysisImpl>(
          this, _$identity);
}

abstract class _CategoryAnalysis extends CategoryAnalysis {
  const factory _CategoryAnalysis(
      {required final String categoryId,
      required final String categoryName,
      required final double totalSpent,
      required final double budgetAmount,
      required final double percentageOfBudget,
      required final double percentageOfTotalSpending,
      required final int transactionCount,
      required final double averageTransactionAmount,
      required final DateTime period,
      required final CategoryHealthStatus status}) = _$CategoryAnalysisImpl;
  const _CategoryAnalysis._() : super._();

  @override
  String get categoryId;
  @override
  String get categoryName;
  @override
  double get totalSpent;
  @override
  double get budgetAmount;
  @override
  double get percentageOfBudget;
  @override
  double get percentageOfTotalSpending;
  @override
  int get transactionCount;
  @override
  double get averageTransactionAmount;
  @override
  DateTime get period;
  @override
  CategoryHealthStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$CategoryAnalysisImplCopyWith<_$CategoryAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MonthlySummary {
  DateTime get month => throw _privateConstructorUsedError;
  double get totalIncome => throw _privateConstructorUsedError;
  double get totalExpenses => throw _privateConstructorUsedError;
  double get totalSavings => throw _privateConstructorUsedError;
  double get savingsRate => throw _privateConstructorUsedError;
  double get budgetAdherence => throw _privateConstructorUsedError;
  List<CategoryAnalysis> get categoryBreakdown =>
      throw _privateConstructorUsedError;
  List<SpendingTrend> get trends => throw _privateConstructorUsedError;
  int get totalTransactions => throw _privateConstructorUsedError;
  double get averageTransactionAmount => throw _privateConstructorUsedError;
  double get largestExpense => throw _privateConstructorUsedError;
  String get topSpendingCategory => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MonthlySummaryCopyWith<MonthlySummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlySummaryCopyWith<$Res> {
  factory $MonthlySummaryCopyWith(
          MonthlySummary value, $Res Function(MonthlySummary) then) =
      _$MonthlySummaryCopyWithImpl<$Res, MonthlySummary>;
  @useResult
  $Res call(
      {DateTime month,
      double totalIncome,
      double totalExpenses,
      double totalSavings,
      double savingsRate,
      double budgetAdherence,
      List<CategoryAnalysis> categoryBreakdown,
      List<SpendingTrend> trends,
      int totalTransactions,
      double averageTransactionAmount,
      double largestExpense,
      String topSpendingCategory});
}

/// @nodoc
class _$MonthlySummaryCopyWithImpl<$Res, $Val extends MonthlySummary>
    implements $MonthlySummaryCopyWith<$Res> {
  _$MonthlySummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? totalIncome = null,
    Object? totalExpenses = null,
    Object? totalSavings = null,
    Object? savingsRate = null,
    Object? budgetAdherence = null,
    Object? categoryBreakdown = null,
    Object? trends = null,
    Object? totalTransactions = null,
    Object? averageTransactionAmount = null,
    Object? largestExpense = null,
    Object? topSpendingCategory = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalIncome: null == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double,
      totalExpenses: null == totalExpenses
          ? _value.totalExpenses
          : totalExpenses // ignore: cast_nullable_to_non_nullable
              as double,
      totalSavings: null == totalSavings
          ? _value.totalSavings
          : totalSavings // ignore: cast_nullable_to_non_nullable
              as double,
      savingsRate: null == savingsRate
          ? _value.savingsRate
          : savingsRate // ignore: cast_nullable_to_non_nullable
              as double,
      budgetAdherence: null == budgetAdherence
          ? _value.budgetAdherence
          : budgetAdherence // ignore: cast_nullable_to_non_nullable
              as double,
      categoryBreakdown: null == categoryBreakdown
          ? _value.categoryBreakdown
          : categoryBreakdown // ignore: cast_nullable_to_non_nullable
              as List<CategoryAnalysis>,
      trends: null == trends
          ? _value.trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<SpendingTrend>,
      totalTransactions: null == totalTransactions
          ? _value.totalTransactions
          : totalTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      averageTransactionAmount: null == averageTransactionAmount
          ? _value.averageTransactionAmount
          : averageTransactionAmount // ignore: cast_nullable_to_non_nullable
              as double,
      largestExpense: null == largestExpense
          ? _value.largestExpense
          : largestExpense // ignore: cast_nullable_to_non_nullable
              as double,
      topSpendingCategory: null == topSpendingCategory
          ? _value.topSpendingCategory
          : topSpendingCategory // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlySummaryImplCopyWith<$Res>
    implements $MonthlySummaryCopyWith<$Res> {
  factory _$$MonthlySummaryImplCopyWith(_$MonthlySummaryImpl value,
          $Res Function(_$MonthlySummaryImpl) then) =
      __$$MonthlySummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime month,
      double totalIncome,
      double totalExpenses,
      double totalSavings,
      double savingsRate,
      double budgetAdherence,
      List<CategoryAnalysis> categoryBreakdown,
      List<SpendingTrend> trends,
      int totalTransactions,
      double averageTransactionAmount,
      double largestExpense,
      String topSpendingCategory});
}

/// @nodoc
class __$$MonthlySummaryImplCopyWithImpl<$Res>
    extends _$MonthlySummaryCopyWithImpl<$Res, _$MonthlySummaryImpl>
    implements _$$MonthlySummaryImplCopyWith<$Res> {
  __$$MonthlySummaryImplCopyWithImpl(
      _$MonthlySummaryImpl _value, $Res Function(_$MonthlySummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? totalIncome = null,
    Object? totalExpenses = null,
    Object? totalSavings = null,
    Object? savingsRate = null,
    Object? budgetAdherence = null,
    Object? categoryBreakdown = null,
    Object? trends = null,
    Object? totalTransactions = null,
    Object? averageTransactionAmount = null,
    Object? largestExpense = null,
    Object? topSpendingCategory = null,
  }) {
    return _then(_$MonthlySummaryImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalIncome: null == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double,
      totalExpenses: null == totalExpenses
          ? _value.totalExpenses
          : totalExpenses // ignore: cast_nullable_to_non_nullable
              as double,
      totalSavings: null == totalSavings
          ? _value.totalSavings
          : totalSavings // ignore: cast_nullable_to_non_nullable
              as double,
      savingsRate: null == savingsRate
          ? _value.savingsRate
          : savingsRate // ignore: cast_nullable_to_non_nullable
              as double,
      budgetAdherence: null == budgetAdherence
          ? _value.budgetAdherence
          : budgetAdherence // ignore: cast_nullable_to_non_nullable
              as double,
      categoryBreakdown: null == categoryBreakdown
          ? _value._categoryBreakdown
          : categoryBreakdown // ignore: cast_nullable_to_non_nullable
              as List<CategoryAnalysis>,
      trends: null == trends
          ? _value._trends
          : trends // ignore: cast_nullable_to_non_nullable
              as List<SpendingTrend>,
      totalTransactions: null == totalTransactions
          ? _value.totalTransactions
          : totalTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      averageTransactionAmount: null == averageTransactionAmount
          ? _value.averageTransactionAmount
          : averageTransactionAmount // ignore: cast_nullable_to_non_nullable
              as double,
      largestExpense: null == largestExpense
          ? _value.largestExpense
          : largestExpense // ignore: cast_nullable_to_non_nullable
              as double,
      topSpendingCategory: null == topSpendingCategory
          ? _value.topSpendingCategory
          : topSpendingCategory // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MonthlySummaryImpl extends _MonthlySummary {
  const _$MonthlySummaryImpl(
      {required this.month,
      required this.totalIncome,
      required this.totalExpenses,
      required this.totalSavings,
      required this.savingsRate,
      required this.budgetAdherence,
      required final List<CategoryAnalysis> categoryBreakdown,
      required final List<SpendingTrend> trends,
      required this.totalTransactions,
      required this.averageTransactionAmount,
      required this.largestExpense,
      required this.topSpendingCategory})
      : _categoryBreakdown = categoryBreakdown,
        _trends = trends,
        super._();

  @override
  final DateTime month;
  @override
  final double totalIncome;
  @override
  final double totalExpenses;
  @override
  final double totalSavings;
  @override
  final double savingsRate;
  @override
  final double budgetAdherence;
  final List<CategoryAnalysis> _categoryBreakdown;
  @override
  List<CategoryAnalysis> get categoryBreakdown {
    if (_categoryBreakdown is EqualUnmodifiableListView)
      return _categoryBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryBreakdown);
  }

  final List<SpendingTrend> _trends;
  @override
  List<SpendingTrend> get trends {
    if (_trends is EqualUnmodifiableListView) return _trends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trends);
  }

  @override
  final int totalTransactions;
  @override
  final double averageTransactionAmount;
  @override
  final double largestExpense;
  @override
  final String topSpendingCategory;

  @override
  String toString() {
    return 'MonthlySummary(month: $month, totalIncome: $totalIncome, totalExpenses: $totalExpenses, totalSavings: $totalSavings, savingsRate: $savingsRate, budgetAdherence: $budgetAdherence, categoryBreakdown: $categoryBreakdown, trends: $trends, totalTransactions: $totalTransactions, averageTransactionAmount: $averageTransactionAmount, largestExpense: $largestExpense, topSpendingCategory: $topSpendingCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlySummaryImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.totalExpenses, totalExpenses) ||
                other.totalExpenses == totalExpenses) &&
            (identical(other.totalSavings, totalSavings) ||
                other.totalSavings == totalSavings) &&
            (identical(other.savingsRate, savingsRate) ||
                other.savingsRate == savingsRate) &&
            (identical(other.budgetAdherence, budgetAdherence) ||
                other.budgetAdherence == budgetAdherence) &&
            const DeepCollectionEquality()
                .equals(other._categoryBreakdown, _categoryBreakdown) &&
            const DeepCollectionEquality().equals(other._trends, _trends) &&
            (identical(other.totalTransactions, totalTransactions) ||
                other.totalTransactions == totalTransactions) &&
            (identical(
                    other.averageTransactionAmount, averageTransactionAmount) ||
                other.averageTransactionAmount == averageTransactionAmount) &&
            (identical(other.largestExpense, largestExpense) ||
                other.largestExpense == largestExpense) &&
            (identical(other.topSpendingCategory, topSpendingCategory) ||
                other.topSpendingCategory == topSpendingCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      month,
      totalIncome,
      totalExpenses,
      totalSavings,
      savingsRate,
      budgetAdherence,
      const DeepCollectionEquality().hash(_categoryBreakdown),
      const DeepCollectionEquality().hash(_trends),
      totalTransactions,
      averageTransactionAmount,
      largestExpense,
      topSpendingCategory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlySummaryImplCopyWith<_$MonthlySummaryImpl> get copyWith =>
      __$$MonthlySummaryImplCopyWithImpl<_$MonthlySummaryImpl>(
          this, _$identity);
}

abstract class _MonthlySummary extends MonthlySummary {
  const factory _MonthlySummary(
      {required final DateTime month,
      required final double totalIncome,
      required final double totalExpenses,
      required final double totalSavings,
      required final double savingsRate,
      required final double budgetAdherence,
      required final List<CategoryAnalysis> categoryBreakdown,
      required final List<SpendingTrend> trends,
      required final int totalTransactions,
      required final double averageTransactionAmount,
      required final double largestExpense,
      required final String topSpendingCategory}) = _$MonthlySummaryImpl;
  const _MonthlySummary._() : super._();

  @override
  DateTime get month;
  @override
  double get totalIncome;
  @override
  double get totalExpenses;
  @override
  double get totalSavings;
  @override
  double get savingsRate;
  @override
  double get budgetAdherence;
  @override
  List<CategoryAnalysis> get categoryBreakdown;
  @override
  List<SpendingTrend> get trends;
  @override
  int get totalTransactions;
  @override
  double get averageTransactionAmount;
  @override
  double get largestExpense;
  @override
  String get topSpendingCategory;
  @override
  @JsonKey(ignore: true)
  _$$MonthlySummaryImplCopyWith<_$MonthlySummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FinancialHealthScore {
  int get overallScore => throw _privateConstructorUsedError;
  FinancialHealthGrade get grade => throw _privateConstructorUsedError;
  Map<String, int> get componentScores => throw _privateConstructorUsedError;
  List<String> get strengths => throw _privateConstructorUsedError;
  List<String> get weaknesses => throw _privateConstructorUsedError;
  List<String> get recommendations => throw _privateConstructorUsedError;
  DateTime get calculatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FinancialHealthScoreCopyWith<FinancialHealthScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialHealthScoreCopyWith<$Res> {
  factory $FinancialHealthScoreCopyWith(FinancialHealthScore value,
          $Res Function(FinancialHealthScore) then) =
      _$FinancialHealthScoreCopyWithImpl<$Res, FinancialHealthScore>;
  @useResult
  $Res call(
      {int overallScore,
      FinancialHealthGrade grade,
      Map<String, int> componentScores,
      List<String> strengths,
      List<String> weaknesses,
      List<String> recommendations,
      DateTime calculatedAt});
}

/// @nodoc
class _$FinancialHealthScoreCopyWithImpl<$Res,
        $Val extends FinancialHealthScore>
    implements $FinancialHealthScoreCopyWith<$Res> {
  _$FinancialHealthScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallScore = null,
    Object? grade = null,
    Object? componentScores = null,
    Object? strengths = null,
    Object? weaknesses = null,
    Object? recommendations = null,
    Object? calculatedAt = null,
  }) {
    return _then(_value.copyWith(
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as int,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as FinancialHealthGrade,
      componentScores: null == componentScores
          ? _value.componentScores
          : componentScores // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      strengths: null == strengths
          ? _value.strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      weaknesses: null == weaknesses
          ? _value.weaknesses
          : weaknesses // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinancialHealthScoreImplCopyWith<$Res>
    implements $FinancialHealthScoreCopyWith<$Res> {
  factory _$$FinancialHealthScoreImplCopyWith(_$FinancialHealthScoreImpl value,
          $Res Function(_$FinancialHealthScoreImpl) then) =
      __$$FinancialHealthScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int overallScore,
      FinancialHealthGrade grade,
      Map<String, int> componentScores,
      List<String> strengths,
      List<String> weaknesses,
      List<String> recommendations,
      DateTime calculatedAt});
}

/// @nodoc
class __$$FinancialHealthScoreImplCopyWithImpl<$Res>
    extends _$FinancialHealthScoreCopyWithImpl<$Res, _$FinancialHealthScoreImpl>
    implements _$$FinancialHealthScoreImplCopyWith<$Res> {
  __$$FinancialHealthScoreImplCopyWithImpl(_$FinancialHealthScoreImpl _value,
      $Res Function(_$FinancialHealthScoreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallScore = null,
    Object? grade = null,
    Object? componentScores = null,
    Object? strengths = null,
    Object? weaknesses = null,
    Object? recommendations = null,
    Object? calculatedAt = null,
  }) {
    return _then(_$FinancialHealthScoreImpl(
      overallScore: null == overallScore
          ? _value.overallScore
          : overallScore // ignore: cast_nullable_to_non_nullable
              as int,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as FinancialHealthGrade,
      componentScores: null == componentScores
          ? _value._componentScores
          : componentScores // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      strengths: null == strengths
          ? _value._strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      weaknesses: null == weaknesses
          ? _value._weaknesses
          : weaknesses // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$FinancialHealthScoreImpl extends _FinancialHealthScore {
  const _$FinancialHealthScoreImpl(
      {required this.overallScore,
      required this.grade,
      required final Map<String, int> componentScores,
      required final List<String> strengths,
      required final List<String> weaknesses,
      required final List<String> recommendations,
      required this.calculatedAt})
      : _componentScores = componentScores,
        _strengths = strengths,
        _weaknesses = weaknesses,
        _recommendations = recommendations,
        super._();

  @override
  final int overallScore;
  @override
  final FinancialHealthGrade grade;
  final Map<String, int> _componentScores;
  @override
  Map<String, int> get componentScores {
    if (_componentScores is EqualUnmodifiableMapView) return _componentScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_componentScores);
  }

  final List<String> _strengths;
  @override
  List<String> get strengths {
    if (_strengths is EqualUnmodifiableListView) return _strengths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strengths);
  }

  final List<String> _weaknesses;
  @override
  List<String> get weaknesses {
    if (_weaknesses is EqualUnmodifiableListView) return _weaknesses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weaknesses);
  }

  final List<String> _recommendations;
  @override
  List<String> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  @override
  final DateTime calculatedAt;

  @override
  String toString() {
    return 'FinancialHealthScore(overallScore: $overallScore, grade: $grade, componentScores: $componentScores, strengths: $strengths, weaknesses: $weaknesses, recommendations: $recommendations, calculatedAt: $calculatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialHealthScoreImpl &&
            (identical(other.overallScore, overallScore) ||
                other.overallScore == overallScore) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            const DeepCollectionEquality()
                .equals(other._componentScores, _componentScores) &&
            const DeepCollectionEquality()
                .equals(other._strengths, _strengths) &&
            const DeepCollectionEquality()
                .equals(other._weaknesses, _weaknesses) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            (identical(other.calculatedAt, calculatedAt) ||
                other.calculatedAt == calculatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      overallScore,
      grade,
      const DeepCollectionEquality().hash(_componentScores),
      const DeepCollectionEquality().hash(_strengths),
      const DeepCollectionEquality().hash(_weaknesses),
      const DeepCollectionEquality().hash(_recommendations),
      calculatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialHealthScoreImplCopyWith<_$FinancialHealthScoreImpl>
      get copyWith =>
          __$$FinancialHealthScoreImplCopyWithImpl<_$FinancialHealthScoreImpl>(
              this, _$identity);
}

abstract class _FinancialHealthScore extends FinancialHealthScore {
  const factory _FinancialHealthScore(
      {required final int overallScore,
      required final FinancialHealthGrade grade,
      required final Map<String, int> componentScores,
      required final List<String> strengths,
      required final List<String> weaknesses,
      required final List<String> recommendations,
      required final DateTime calculatedAt}) = _$FinancialHealthScoreImpl;
  const _FinancialHealthScore._() : super._();

  @override
  int get overallScore;
  @override
  FinancialHealthGrade get grade;
  @override
  Map<String, int> get componentScores;
  @override
  List<String> get strengths;
  @override
  List<String> get weaknesses;
  @override
  List<String> get recommendations;
  @override
  DateTime get calculatedAt;
  @override
  @JsonKey(ignore: true)
  _$$FinancialHealthScoreImplCopyWith<_$FinancialHealthScoreImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FinancialReport {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  FinancialReportType get type => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  List<String> get sections => throw _privateConstructorUsedError;
  String? get filePath => throw _privateConstructorUsedError;
  bool get isExported => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FinancialReportCopyWith<FinancialReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialReportCopyWith<$Res> {
  factory $FinancialReportCopyWith(
          FinancialReport value, $Res Function(FinancialReport) then) =
      _$FinancialReportCopyWithImpl<$Res, FinancialReport>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      FinancialReportType type,
      DateTime startDate,
      DateTime endDate,
      DateTime generatedAt,
      Map<String, dynamic> data,
      List<String> sections,
      String? filePath,
      bool isExported,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$FinancialReportCopyWithImpl<$Res, $Val extends FinancialReport>
    implements $FinancialReportCopyWith<$Res> {
  _$FinancialReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? generatedAt = null,
    Object? data = null,
    Object? sections = null,
    Object? filePath = freezed,
    Object? isExported = null,
    Object? metadata = freezed,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FinancialReportType,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      isExported: null == isExported
          ? _value.isExported
          : isExported // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinancialReportImplCopyWith<$Res>
    implements $FinancialReportCopyWith<$Res> {
  factory _$$FinancialReportImplCopyWith(_$FinancialReportImpl value,
          $Res Function(_$FinancialReportImpl) then) =
      __$$FinancialReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      FinancialReportType type,
      DateTime startDate,
      DateTime endDate,
      DateTime generatedAt,
      Map<String, dynamic> data,
      List<String> sections,
      String? filePath,
      bool isExported,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$FinancialReportImplCopyWithImpl<$Res>
    extends _$FinancialReportCopyWithImpl<$Res, _$FinancialReportImpl>
    implements _$$FinancialReportImplCopyWith<$Res> {
  __$$FinancialReportImplCopyWithImpl(
      _$FinancialReportImpl _value, $Res Function(_$FinancialReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? generatedAt = null,
    Object? data = null,
    Object? sections = null,
    Object? filePath = freezed,
    Object? isExported = null,
    Object? metadata = freezed,
  }) {
    return _then(_$FinancialReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FinancialReportType,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sections: null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      isExported: null == isExported
          ? _value.isExported
          : isExported // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$FinancialReportImpl extends _FinancialReport {
  const _$FinancialReportImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.startDate,
      required this.endDate,
      required this.generatedAt,
      required final Map<String, dynamic> data,
      required final List<String> sections,
      this.filePath,
      this.isExported = false,
      final Map<String, dynamic>? metadata})
      : _data = data,
        _sections = sections,
        _metadata = metadata,
        super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final FinancialReportType type;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final DateTime generatedAt;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  final List<String> _sections;
  @override
  List<String> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  final String? filePath;
  @override
  @JsonKey()
  final bool isExported;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'FinancialReport(id: $id, title: $title, description: $description, type: $type, startDate: $startDate, endDate: $endDate, generatedAt: $generatedAt, data: $data, sections: $sections, filePath: $filePath, isExported: $isExported, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.isExported, isExported) ||
                other.isExported == isExported) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      type,
      startDate,
      endDate,
      generatedAt,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_sections),
      filePath,
      isExported,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialReportImplCopyWith<_$FinancialReportImpl> get copyWith =>
      __$$FinancialReportImplCopyWithImpl<_$FinancialReportImpl>(
          this, _$identity);
}

abstract class _FinancialReport extends FinancialReport {
  const factory _FinancialReport(
      {required final String id,
      required final String title,
      required final String description,
      required final FinancialReportType type,
      required final DateTime startDate,
      required final DateTime endDate,
      required final DateTime generatedAt,
      required final Map<String, dynamic> data,
      required final List<String> sections,
      final String? filePath,
      final bool isExported,
      final Map<String, dynamic>? metadata}) = _$FinancialReportImpl;
  const _FinancialReport._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  FinancialReportType get type;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  DateTime get generatedAt;
  @override
  Map<String, dynamic> get data;
  @override
  List<String> get sections;
  @override
  String? get filePath;
  @override
  bool get isExported;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$FinancialReportImplCopyWith<_$FinancialReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InsightsSummary {
  List<Insight> get recentInsights => throw _privateConstructorUsedError;
  FinancialHealthScore get healthScore => throw _privateConstructorUsedError;
  MonthlySummary get currentMonthSummary => throw _privateConstructorUsedError;
  List<SpendingTrend> get keyTrends => throw _privateConstructorUsedError;
  List<CategoryAnalysis> get categoryAnalysis =>
      throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InsightsSummaryCopyWith<InsightsSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightsSummaryCopyWith<$Res> {
  factory $InsightsSummaryCopyWith(
          InsightsSummary value, $Res Function(InsightsSummary) then) =
      _$InsightsSummaryCopyWithImpl<$Res, InsightsSummary>;
  @useResult
  $Res call(
      {List<Insight> recentInsights,
      FinancialHealthScore healthScore,
      MonthlySummary currentMonthSummary,
      List<SpendingTrend> keyTrends,
      List<CategoryAnalysis> categoryAnalysis,
      DateTime generatedAt});

  $FinancialHealthScoreCopyWith<$Res> get healthScore;
  $MonthlySummaryCopyWith<$Res> get currentMonthSummary;
}

/// @nodoc
class _$InsightsSummaryCopyWithImpl<$Res, $Val extends InsightsSummary>
    implements $InsightsSummaryCopyWith<$Res> {
  _$InsightsSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recentInsights = null,
    Object? healthScore = null,
    Object? currentMonthSummary = null,
    Object? keyTrends = null,
    Object? categoryAnalysis = null,
    Object? generatedAt = null,
  }) {
    return _then(_value.copyWith(
      recentInsights: null == recentInsights
          ? _value.recentInsights
          : recentInsights // ignore: cast_nullable_to_non_nullable
              as List<Insight>,
      healthScore: null == healthScore
          ? _value.healthScore
          : healthScore // ignore: cast_nullable_to_non_nullable
              as FinancialHealthScore,
      currentMonthSummary: null == currentMonthSummary
          ? _value.currentMonthSummary
          : currentMonthSummary // ignore: cast_nullable_to_non_nullable
              as MonthlySummary,
      keyTrends: null == keyTrends
          ? _value.keyTrends
          : keyTrends // ignore: cast_nullable_to_non_nullable
              as List<SpendingTrend>,
      categoryAnalysis: null == categoryAnalysis
          ? _value.categoryAnalysis
          : categoryAnalysis // ignore: cast_nullable_to_non_nullable
              as List<CategoryAnalysis>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FinancialHealthScoreCopyWith<$Res> get healthScore {
    return $FinancialHealthScoreCopyWith<$Res>(_value.healthScore, (value) {
      return _then(_value.copyWith(healthScore: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MonthlySummaryCopyWith<$Res> get currentMonthSummary {
    return $MonthlySummaryCopyWith<$Res>(_value.currentMonthSummary, (value) {
      return _then(_value.copyWith(currentMonthSummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InsightsSummaryImplCopyWith<$Res>
    implements $InsightsSummaryCopyWith<$Res> {
  factory _$$InsightsSummaryImplCopyWith(_$InsightsSummaryImpl value,
          $Res Function(_$InsightsSummaryImpl) then) =
      __$$InsightsSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Insight> recentInsights,
      FinancialHealthScore healthScore,
      MonthlySummary currentMonthSummary,
      List<SpendingTrend> keyTrends,
      List<CategoryAnalysis> categoryAnalysis,
      DateTime generatedAt});

  @override
  $FinancialHealthScoreCopyWith<$Res> get healthScore;
  @override
  $MonthlySummaryCopyWith<$Res> get currentMonthSummary;
}

/// @nodoc
class __$$InsightsSummaryImplCopyWithImpl<$Res>
    extends _$InsightsSummaryCopyWithImpl<$Res, _$InsightsSummaryImpl>
    implements _$$InsightsSummaryImplCopyWith<$Res> {
  __$$InsightsSummaryImplCopyWithImpl(
      _$InsightsSummaryImpl _value, $Res Function(_$InsightsSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recentInsights = null,
    Object? healthScore = null,
    Object? currentMonthSummary = null,
    Object? keyTrends = null,
    Object? categoryAnalysis = null,
    Object? generatedAt = null,
  }) {
    return _then(_$InsightsSummaryImpl(
      recentInsights: null == recentInsights
          ? _value._recentInsights
          : recentInsights // ignore: cast_nullable_to_non_nullable
              as List<Insight>,
      healthScore: null == healthScore
          ? _value.healthScore
          : healthScore // ignore: cast_nullable_to_non_nullable
              as FinancialHealthScore,
      currentMonthSummary: null == currentMonthSummary
          ? _value.currentMonthSummary
          : currentMonthSummary // ignore: cast_nullable_to_non_nullable
              as MonthlySummary,
      keyTrends: null == keyTrends
          ? _value._keyTrends
          : keyTrends // ignore: cast_nullable_to_non_nullable
              as List<SpendingTrend>,
      categoryAnalysis: null == categoryAnalysis
          ? _value._categoryAnalysis
          : categoryAnalysis // ignore: cast_nullable_to_non_nullable
              as List<CategoryAnalysis>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$InsightsSummaryImpl extends _InsightsSummary {
  const _$InsightsSummaryImpl(
      {required final List<Insight> recentInsights,
      required this.healthScore,
      required this.currentMonthSummary,
      required final List<SpendingTrend> keyTrends,
      required final List<CategoryAnalysis> categoryAnalysis,
      required this.generatedAt})
      : _recentInsights = recentInsights,
        _keyTrends = keyTrends,
        _categoryAnalysis = categoryAnalysis,
        super._();

  final List<Insight> _recentInsights;
  @override
  List<Insight> get recentInsights {
    if (_recentInsights is EqualUnmodifiableListView) return _recentInsights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentInsights);
  }

  @override
  final FinancialHealthScore healthScore;
  @override
  final MonthlySummary currentMonthSummary;
  final List<SpendingTrend> _keyTrends;
  @override
  List<SpendingTrend> get keyTrends {
    if (_keyTrends is EqualUnmodifiableListView) return _keyTrends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyTrends);
  }

  final List<CategoryAnalysis> _categoryAnalysis;
  @override
  List<CategoryAnalysis> get categoryAnalysis {
    if (_categoryAnalysis is EqualUnmodifiableListView)
      return _categoryAnalysis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryAnalysis);
  }

  @override
  final DateTime generatedAt;

  @override
  String toString() {
    return 'InsightsSummary(recentInsights: $recentInsights, healthScore: $healthScore, currentMonthSummary: $currentMonthSummary, keyTrends: $keyTrends, categoryAnalysis: $categoryAnalysis, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightsSummaryImpl &&
            const DeepCollectionEquality()
                .equals(other._recentInsights, _recentInsights) &&
            (identical(other.healthScore, healthScore) ||
                other.healthScore == healthScore) &&
            (identical(other.currentMonthSummary, currentMonthSummary) ||
                other.currentMonthSummary == currentMonthSummary) &&
            const DeepCollectionEquality()
                .equals(other._keyTrends, _keyTrends) &&
            const DeepCollectionEquality()
                .equals(other._categoryAnalysis, _categoryAnalysis) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_recentInsights),
      healthScore,
      currentMonthSummary,
      const DeepCollectionEquality().hash(_keyTrends),
      const DeepCollectionEquality().hash(_categoryAnalysis),
      generatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightsSummaryImplCopyWith<_$InsightsSummaryImpl> get copyWith =>
      __$$InsightsSummaryImplCopyWithImpl<_$InsightsSummaryImpl>(
          this, _$identity);
}

abstract class _InsightsSummary extends InsightsSummary {
  const factory _InsightsSummary(
      {required final List<Insight> recentInsights,
      required final FinancialHealthScore healthScore,
      required final MonthlySummary currentMonthSummary,
      required final List<SpendingTrend> keyTrends,
      required final List<CategoryAnalysis> categoryAnalysis,
      required final DateTime generatedAt}) = _$InsightsSummaryImpl;
  const _InsightsSummary._() : super._();

  @override
  List<Insight> get recentInsights;
  @override
  FinancialHealthScore get healthScore;
  @override
  MonthlySummary get currentMonthSummary;
  @override
  List<SpendingTrend> get keyTrends;
  @override
  List<CategoryAnalysis> get categoryAnalysis;
  @override
  DateTime get generatedAt;
  @override
  @JsonKey(ignore: true)
  _$$InsightsSummaryImplCopyWith<_$InsightsSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
