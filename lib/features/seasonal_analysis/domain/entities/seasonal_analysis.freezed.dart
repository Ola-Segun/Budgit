// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seasonal_analysis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SeasonalAnalysis {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  AnalysisPeriod get period => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  List<CategorySpending> get categorySpending =>
      throw _privateConstructorUsedError;
  List<MonthlyTrend> get monthlyTrends => throw _privateConstructorUsedError;
  SeasonalInsights get insights => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeasonalAnalysisCopyWith<SeasonalAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonalAnalysisCopyWith<$Res> {
  factory $SeasonalAnalysisCopyWith(
          SeasonalAnalysis value, $Res Function(SeasonalAnalysis) then) =
      _$SeasonalAnalysisCopyWithImpl<$Res, SeasonalAnalysis>;
  @useResult
  $Res call(
      {String id,
      String userId,
      AnalysisPeriod period,
      DateTime startDate,
      DateTime endDate,
      List<CategorySpending> categorySpending,
      List<MonthlyTrend> monthlyTrends,
      SeasonalInsights insights,
      DateTime generatedAt});

  $SeasonalInsightsCopyWith<$Res> get insights;
}

/// @nodoc
class _$SeasonalAnalysisCopyWithImpl<$Res, $Val extends SeasonalAnalysis>
    implements $SeasonalAnalysisCopyWith<$Res> {
  _$SeasonalAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? period = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? categorySpending = null,
    Object? monthlyTrends = null,
    Object? insights = null,
    Object? generatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as AnalysisPeriod,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categorySpending: null == categorySpending
          ? _value.categorySpending
          : categorySpending // ignore: cast_nullable_to_non_nullable
              as List<CategorySpending>,
      monthlyTrends: null == monthlyTrends
          ? _value.monthlyTrends
          : monthlyTrends // ignore: cast_nullable_to_non_nullable
              as List<MonthlyTrend>,
      insights: null == insights
          ? _value.insights
          : insights // ignore: cast_nullable_to_non_nullable
              as SeasonalInsights,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SeasonalInsightsCopyWith<$Res> get insights {
    return $SeasonalInsightsCopyWith<$Res>(_value.insights, (value) {
      return _then(_value.copyWith(insights: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SeasonalAnalysisImplCopyWith<$Res>
    implements $SeasonalAnalysisCopyWith<$Res> {
  factory _$$SeasonalAnalysisImplCopyWith(_$SeasonalAnalysisImpl value,
          $Res Function(_$SeasonalAnalysisImpl) then) =
      __$$SeasonalAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      AnalysisPeriod period,
      DateTime startDate,
      DateTime endDate,
      List<CategorySpending> categorySpending,
      List<MonthlyTrend> monthlyTrends,
      SeasonalInsights insights,
      DateTime generatedAt});

  @override
  $SeasonalInsightsCopyWith<$Res> get insights;
}

/// @nodoc
class __$$SeasonalAnalysisImplCopyWithImpl<$Res>
    extends _$SeasonalAnalysisCopyWithImpl<$Res, _$SeasonalAnalysisImpl>
    implements _$$SeasonalAnalysisImplCopyWith<$Res> {
  __$$SeasonalAnalysisImplCopyWithImpl(_$SeasonalAnalysisImpl _value,
      $Res Function(_$SeasonalAnalysisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? period = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? categorySpending = null,
    Object? monthlyTrends = null,
    Object? insights = null,
    Object? generatedAt = null,
  }) {
    return _then(_$SeasonalAnalysisImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as AnalysisPeriod,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categorySpending: null == categorySpending
          ? _value._categorySpending
          : categorySpending // ignore: cast_nullable_to_non_nullable
              as List<CategorySpending>,
      monthlyTrends: null == monthlyTrends
          ? _value._monthlyTrends
          : monthlyTrends // ignore: cast_nullable_to_non_nullable
              as List<MonthlyTrend>,
      insights: null == insights
          ? _value.insights
          : insights // ignore: cast_nullable_to_non_nullable
              as SeasonalInsights,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$SeasonalAnalysisImpl extends _SeasonalAnalysis {
  const _$SeasonalAnalysisImpl(
      {required this.id,
      required this.userId,
      required this.period,
      required this.startDate,
      required this.endDate,
      required final List<CategorySpending> categorySpending,
      required final List<MonthlyTrend> monthlyTrends,
      required this.insights,
      required this.generatedAt})
      : _categorySpending = categorySpending,
        _monthlyTrends = monthlyTrends,
        super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final AnalysisPeriod period;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  final List<CategorySpending> _categorySpending;
  @override
  List<CategorySpending> get categorySpending {
    if (_categorySpending is EqualUnmodifiableListView)
      return _categorySpending;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categorySpending);
  }

  final List<MonthlyTrend> _monthlyTrends;
  @override
  List<MonthlyTrend> get monthlyTrends {
    if (_monthlyTrends is EqualUnmodifiableListView) return _monthlyTrends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyTrends);
  }

  @override
  final SeasonalInsights insights;
  @override
  final DateTime generatedAt;

  @override
  String toString() {
    return 'SeasonalAnalysis(id: $id, userId: $userId, period: $period, startDate: $startDate, endDate: $endDate, categorySpending: $categorySpending, monthlyTrends: $monthlyTrends, insights: $insights, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonalAnalysisImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality()
                .equals(other._categorySpending, _categorySpending) &&
            const DeepCollectionEquality()
                .equals(other._monthlyTrends, _monthlyTrends) &&
            (identical(other.insights, insights) ||
                other.insights == insights) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      period,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(_categorySpending),
      const DeepCollectionEquality().hash(_monthlyTrends),
      insights,
      generatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonalAnalysisImplCopyWith<_$SeasonalAnalysisImpl> get copyWith =>
      __$$SeasonalAnalysisImplCopyWithImpl<_$SeasonalAnalysisImpl>(
          this, _$identity);
}

abstract class _SeasonalAnalysis extends SeasonalAnalysis {
  const factory _SeasonalAnalysis(
      {required final String id,
      required final String userId,
      required final AnalysisPeriod period,
      required final DateTime startDate,
      required final DateTime endDate,
      required final List<CategorySpending> categorySpending,
      required final List<MonthlyTrend> monthlyTrends,
      required final SeasonalInsights insights,
      required final DateTime generatedAt}) = _$SeasonalAnalysisImpl;
  const _SeasonalAnalysis._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  AnalysisPeriod get period;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  List<CategorySpending> get categorySpending;
  @override
  List<MonthlyTrend> get monthlyTrends;
  @override
  SeasonalInsights get insights;
  @override
  DateTime get generatedAt;
  @override
  @JsonKey(ignore: true)
  _$$SeasonalAnalysisImplCopyWith<_$SeasonalAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CategorySpending {
  String get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  int get transactionCount => throw _privateConstructorUsedError;
  double get averageAmount => throw _privateConstructorUsedError;
  List<MonthlySpending> get monthlyBreakdown =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategorySpendingCopyWith<CategorySpending> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorySpendingCopyWith<$Res> {
  factory $CategorySpendingCopyWith(
          CategorySpending value, $Res Function(CategorySpending) then) =
      _$CategorySpendingCopyWithImpl<$Res, CategorySpending>;
  @useResult
  $Res call(
      {String categoryId,
      String categoryName,
      double totalAmount,
      int transactionCount,
      double averageAmount,
      List<MonthlySpending> monthlyBreakdown});
}

/// @nodoc
class _$CategorySpendingCopyWithImpl<$Res, $Val extends CategorySpending>
    implements $CategorySpendingCopyWith<$Res> {
  _$CategorySpendingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? totalAmount = null,
    Object? transactionCount = null,
    Object? averageAmount = null,
    Object? monthlyBreakdown = null,
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
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageAmount: null == averageAmount
          ? _value.averageAmount
          : averageAmount // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyBreakdown: null == monthlyBreakdown
          ? _value.monthlyBreakdown
          : monthlyBreakdown // ignore: cast_nullable_to_non_nullable
              as List<MonthlySpending>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategorySpendingImplCopyWith<$Res>
    implements $CategorySpendingCopyWith<$Res> {
  factory _$$CategorySpendingImplCopyWith(_$CategorySpendingImpl value,
          $Res Function(_$CategorySpendingImpl) then) =
      __$$CategorySpendingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String categoryId,
      String categoryName,
      double totalAmount,
      int transactionCount,
      double averageAmount,
      List<MonthlySpending> monthlyBreakdown});
}

/// @nodoc
class __$$CategorySpendingImplCopyWithImpl<$Res>
    extends _$CategorySpendingCopyWithImpl<$Res, _$CategorySpendingImpl>
    implements _$$CategorySpendingImplCopyWith<$Res> {
  __$$CategorySpendingImplCopyWithImpl(_$CategorySpendingImpl _value,
      $Res Function(_$CategorySpendingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? totalAmount = null,
    Object? transactionCount = null,
    Object? averageAmount = null,
    Object? monthlyBreakdown = null,
  }) {
    return _then(_$CategorySpendingImpl(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageAmount: null == averageAmount
          ? _value.averageAmount
          : averageAmount // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyBreakdown: null == monthlyBreakdown
          ? _value._monthlyBreakdown
          : monthlyBreakdown // ignore: cast_nullable_to_non_nullable
              as List<MonthlySpending>,
    ));
  }
}

/// @nodoc

class _$CategorySpendingImpl extends _CategorySpending {
  const _$CategorySpendingImpl(
      {required this.categoryId,
      required this.categoryName,
      required this.totalAmount,
      required this.transactionCount,
      required this.averageAmount,
      required final List<MonthlySpending> monthlyBreakdown})
      : _monthlyBreakdown = monthlyBreakdown,
        super._();

  @override
  final String categoryId;
  @override
  final String categoryName;
  @override
  final double totalAmount;
  @override
  final int transactionCount;
  @override
  final double averageAmount;
  final List<MonthlySpending> _monthlyBreakdown;
  @override
  List<MonthlySpending> get monthlyBreakdown {
    if (_monthlyBreakdown is EqualUnmodifiableListView)
      return _monthlyBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyBreakdown);
  }

  @override
  String toString() {
    return 'CategorySpending(categoryId: $categoryId, categoryName: $categoryName, totalAmount: $totalAmount, transactionCount: $transactionCount, averageAmount: $averageAmount, monthlyBreakdown: $monthlyBreakdown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategorySpendingImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.transactionCount, transactionCount) ||
                other.transactionCount == transactionCount) &&
            (identical(other.averageAmount, averageAmount) ||
                other.averageAmount == averageAmount) &&
            const DeepCollectionEquality()
                .equals(other._monthlyBreakdown, _monthlyBreakdown));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      categoryId,
      categoryName,
      totalAmount,
      transactionCount,
      averageAmount,
      const DeepCollectionEquality().hash(_monthlyBreakdown));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategorySpendingImplCopyWith<_$CategorySpendingImpl> get copyWith =>
      __$$CategorySpendingImplCopyWithImpl<_$CategorySpendingImpl>(
          this, _$identity);
}

abstract class _CategorySpending extends CategorySpending {
  const factory _CategorySpending(
          {required final String categoryId,
          required final String categoryName,
          required final double totalAmount,
          required final int transactionCount,
          required final double averageAmount,
          required final List<MonthlySpending> monthlyBreakdown}) =
      _$CategorySpendingImpl;
  const _CategorySpending._() : super._();

  @override
  String get categoryId;
  @override
  String get categoryName;
  @override
  double get totalAmount;
  @override
  int get transactionCount;
  @override
  double get averageAmount;
  @override
  List<MonthlySpending> get monthlyBreakdown;
  @override
  @JsonKey(ignore: true)
  _$$CategorySpendingImplCopyWith<_$CategorySpendingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MonthlySpending {
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  int get transactionCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MonthlySpendingCopyWith<MonthlySpending> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlySpendingCopyWith<$Res> {
  factory $MonthlySpendingCopyWith(
          MonthlySpending value, $Res Function(MonthlySpending) then) =
      _$MonthlySpendingCopyWithImpl<$Res, MonthlySpending>;
  @useResult
  $Res call({int year, int month, double totalAmount, int transactionCount});
}

/// @nodoc
class _$MonthlySpendingCopyWithImpl<$Res, $Val extends MonthlySpending>
    implements $MonthlySpendingCopyWith<$Res> {
  _$MonthlySpendingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? totalAmount = null,
    Object? transactionCount = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlySpendingImplCopyWith<$Res>
    implements $MonthlySpendingCopyWith<$Res> {
  factory _$$MonthlySpendingImplCopyWith(_$MonthlySpendingImpl value,
          $Res Function(_$MonthlySpendingImpl) then) =
      __$$MonthlySpendingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int year, int month, double totalAmount, int transactionCount});
}

/// @nodoc
class __$$MonthlySpendingImplCopyWithImpl<$Res>
    extends _$MonthlySpendingCopyWithImpl<$Res, _$MonthlySpendingImpl>
    implements _$$MonthlySpendingImplCopyWith<$Res> {
  __$$MonthlySpendingImplCopyWithImpl(
      _$MonthlySpendingImpl _value, $Res Function(_$MonthlySpendingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? totalAmount = null,
    Object? transactionCount = null,
  }) {
    return _then(_$MonthlySpendingImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MonthlySpendingImpl extends _MonthlySpending {
  const _$MonthlySpendingImpl(
      {required this.year,
      required this.month,
      required this.totalAmount,
      required this.transactionCount})
      : super._();

  @override
  final int year;
  @override
  final int month;
  @override
  final double totalAmount;
  @override
  final int transactionCount;

  @override
  String toString() {
    return 'MonthlySpending(year: $year, month: $month, totalAmount: $totalAmount, transactionCount: $transactionCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlySpendingImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.transactionCount, transactionCount) ||
                other.transactionCount == transactionCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, year, month, totalAmount, transactionCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlySpendingImplCopyWith<_$MonthlySpendingImpl> get copyWith =>
      __$$MonthlySpendingImplCopyWithImpl<_$MonthlySpendingImpl>(
          this, _$identity);
}

abstract class _MonthlySpending extends MonthlySpending {
  const factory _MonthlySpending(
      {required final int year,
      required final int month,
      required final double totalAmount,
      required final int transactionCount}) = _$MonthlySpendingImpl;
  const _MonthlySpending._() : super._();

  @override
  int get year;
  @override
  int get month;
  @override
  double get totalAmount;
  @override
  int get transactionCount;
  @override
  @JsonKey(ignore: true)
  _$$MonthlySpendingImplCopyWith<_$MonthlySpendingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MonthlyTrend {
  int get month => throw _privateConstructorUsedError;
  double get averageSpending => throw _privateConstructorUsedError;
  double get medianSpending => throw _privateConstructorUsedError;
  TrendDirection get direction => throw _privateConstructorUsedError;
  double get changePercentage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MonthlyTrendCopyWith<MonthlyTrend> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyTrendCopyWith<$Res> {
  factory $MonthlyTrendCopyWith(
          MonthlyTrend value, $Res Function(MonthlyTrend) then) =
      _$MonthlyTrendCopyWithImpl<$Res, MonthlyTrend>;
  @useResult
  $Res call(
      {int month,
      double averageSpending,
      double medianSpending,
      TrendDirection direction,
      double changePercentage});
}

/// @nodoc
class _$MonthlyTrendCopyWithImpl<$Res, $Val extends MonthlyTrend>
    implements $MonthlyTrendCopyWith<$Res> {
  _$MonthlyTrendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? averageSpending = null,
    Object? medianSpending = null,
    Object? direction = null,
    Object? changePercentage = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      averageSpending: null == averageSpending
          ? _value.averageSpending
          : averageSpending // ignore: cast_nullable_to_non_nullable
              as double,
      medianSpending: null == medianSpending
          ? _value.medianSpending
          : medianSpending // ignore: cast_nullable_to_non_nullable
              as double,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyTrendImplCopyWith<$Res>
    implements $MonthlyTrendCopyWith<$Res> {
  factory _$$MonthlyTrendImplCopyWith(
          _$MonthlyTrendImpl value, $Res Function(_$MonthlyTrendImpl) then) =
      __$$MonthlyTrendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int month,
      double averageSpending,
      double medianSpending,
      TrendDirection direction,
      double changePercentage});
}

/// @nodoc
class __$$MonthlyTrendImplCopyWithImpl<$Res>
    extends _$MonthlyTrendCopyWithImpl<$Res, _$MonthlyTrendImpl>
    implements _$$MonthlyTrendImplCopyWith<$Res> {
  __$$MonthlyTrendImplCopyWithImpl(
      _$MonthlyTrendImpl _value, $Res Function(_$MonthlyTrendImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? averageSpending = null,
    Object? medianSpending = null,
    Object? direction = null,
    Object? changePercentage = null,
  }) {
    return _then(_$MonthlyTrendImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      averageSpending: null == averageSpending
          ? _value.averageSpending
          : averageSpending // ignore: cast_nullable_to_non_nullable
              as double,
      medianSpending: null == medianSpending
          ? _value.medianSpending
          : medianSpending // ignore: cast_nullable_to_non_nullable
              as double,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as TrendDirection,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$MonthlyTrendImpl extends _MonthlyTrend {
  const _$MonthlyTrendImpl(
      {required this.month,
      required this.averageSpending,
      required this.medianSpending,
      required this.direction,
      required this.changePercentage})
      : super._();

  @override
  final int month;
  @override
  final double averageSpending;
  @override
  final double medianSpending;
  @override
  final TrendDirection direction;
  @override
  final double changePercentage;

  @override
  String toString() {
    return 'MonthlyTrend(month: $month, averageSpending: $averageSpending, medianSpending: $medianSpending, direction: $direction, changePercentage: $changePercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyTrendImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.averageSpending, averageSpending) ||
                other.averageSpending == averageSpending) &&
            (identical(other.medianSpending, medianSpending) ||
                other.medianSpending == medianSpending) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, month, averageSpending,
      medianSpending, direction, changePercentage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyTrendImplCopyWith<_$MonthlyTrendImpl> get copyWith =>
      __$$MonthlyTrendImplCopyWithImpl<_$MonthlyTrendImpl>(this, _$identity);
}

abstract class _MonthlyTrend extends MonthlyTrend {
  const factory _MonthlyTrend(
      {required final int month,
      required final double averageSpending,
      required final double medianSpending,
      required final TrendDirection direction,
      required final double changePercentage}) = _$MonthlyTrendImpl;
  const _MonthlyTrend._() : super._();

  @override
  int get month;
  @override
  double get averageSpending;
  @override
  double get medianSpending;
  @override
  TrendDirection get direction;
  @override
  double get changePercentage;
  @override
  @JsonKey(ignore: true)
  _$$MonthlyTrendImplCopyWith<_$MonthlyTrendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SeasonalInsights {
  List<String> get keyFindings => throw _privateConstructorUsedError;
  List<BudgetRecommendation> get recommendations =>
      throw _privateConstructorUsedError;
  List<String> get seasonalPatterns => throw _privateConstructorUsedError;
  RiskLevel get spendingRisk => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeasonalInsightsCopyWith<SeasonalInsights> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonalInsightsCopyWith<$Res> {
  factory $SeasonalInsightsCopyWith(
          SeasonalInsights value, $Res Function(SeasonalInsights) then) =
      _$SeasonalInsightsCopyWithImpl<$Res, SeasonalInsights>;
  @useResult
  $Res call(
      {List<String> keyFindings,
      List<BudgetRecommendation> recommendations,
      List<String> seasonalPatterns,
      RiskLevel spendingRisk});
}

/// @nodoc
class _$SeasonalInsightsCopyWithImpl<$Res, $Val extends SeasonalInsights>
    implements $SeasonalInsightsCopyWith<$Res> {
  _$SeasonalInsightsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyFindings = null,
    Object? recommendations = null,
    Object? seasonalPatterns = null,
    Object? spendingRisk = null,
  }) {
    return _then(_value.copyWith(
      keyFindings: null == keyFindings
          ? _value.keyFindings
          : keyFindings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value.recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<BudgetRecommendation>,
      seasonalPatterns: null == seasonalPatterns
          ? _value.seasonalPatterns
          : seasonalPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendingRisk: null == spendingRisk
          ? _value.spendingRisk
          : spendingRisk // ignore: cast_nullable_to_non_nullable
              as RiskLevel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeasonalInsightsImplCopyWith<$Res>
    implements $SeasonalInsightsCopyWith<$Res> {
  factory _$$SeasonalInsightsImplCopyWith(_$SeasonalInsightsImpl value,
          $Res Function(_$SeasonalInsightsImpl) then) =
      __$$SeasonalInsightsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> keyFindings,
      List<BudgetRecommendation> recommendations,
      List<String> seasonalPatterns,
      RiskLevel spendingRisk});
}

/// @nodoc
class __$$SeasonalInsightsImplCopyWithImpl<$Res>
    extends _$SeasonalInsightsCopyWithImpl<$Res, _$SeasonalInsightsImpl>
    implements _$$SeasonalInsightsImplCopyWith<$Res> {
  __$$SeasonalInsightsImplCopyWithImpl(_$SeasonalInsightsImpl _value,
      $Res Function(_$SeasonalInsightsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyFindings = null,
    Object? recommendations = null,
    Object? seasonalPatterns = null,
    Object? spendingRisk = null,
  }) {
    return _then(_$SeasonalInsightsImpl(
      keyFindings: null == keyFindings
          ? _value._keyFindings
          : keyFindings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendations: null == recommendations
          ? _value._recommendations
          : recommendations // ignore: cast_nullable_to_non_nullable
              as List<BudgetRecommendation>,
      seasonalPatterns: null == seasonalPatterns
          ? _value._seasonalPatterns
          : seasonalPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendingRisk: null == spendingRisk
          ? _value.spendingRisk
          : spendingRisk // ignore: cast_nullable_to_non_nullable
              as RiskLevel,
    ));
  }
}

/// @nodoc

class _$SeasonalInsightsImpl extends _SeasonalInsights {
  const _$SeasonalInsightsImpl(
      {required final List<String> keyFindings,
      required final List<BudgetRecommendation> recommendations,
      required final List<String> seasonalPatterns,
      required this.spendingRisk})
      : _keyFindings = keyFindings,
        _recommendations = recommendations,
        _seasonalPatterns = seasonalPatterns,
        super._();

  final List<String> _keyFindings;
  @override
  List<String> get keyFindings {
    if (_keyFindings is EqualUnmodifiableListView) return _keyFindings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyFindings);
  }

  final List<BudgetRecommendation> _recommendations;
  @override
  List<BudgetRecommendation> get recommendations {
    if (_recommendations is EqualUnmodifiableListView) return _recommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendations);
  }

  final List<String> _seasonalPatterns;
  @override
  List<String> get seasonalPatterns {
    if (_seasonalPatterns is EqualUnmodifiableListView)
      return _seasonalPatterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seasonalPatterns);
  }

  @override
  final RiskLevel spendingRisk;

  @override
  String toString() {
    return 'SeasonalInsights(keyFindings: $keyFindings, recommendations: $recommendations, seasonalPatterns: $seasonalPatterns, spendingRisk: $spendingRisk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonalInsightsImpl &&
            const DeepCollectionEquality()
                .equals(other._keyFindings, _keyFindings) &&
            const DeepCollectionEquality()
                .equals(other._recommendations, _recommendations) &&
            const DeepCollectionEquality()
                .equals(other._seasonalPatterns, _seasonalPatterns) &&
            (identical(other.spendingRisk, spendingRisk) ||
                other.spendingRisk == spendingRisk));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_keyFindings),
      const DeepCollectionEquality().hash(_recommendations),
      const DeepCollectionEquality().hash(_seasonalPatterns),
      spendingRisk);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonalInsightsImplCopyWith<_$SeasonalInsightsImpl> get copyWith =>
      __$$SeasonalInsightsImplCopyWithImpl<_$SeasonalInsightsImpl>(
          this, _$identity);
}

abstract class _SeasonalInsights extends SeasonalInsights {
  const factory _SeasonalInsights(
      {required final List<String> keyFindings,
      required final List<BudgetRecommendation> recommendations,
      required final List<String> seasonalPatterns,
      required final RiskLevel spendingRisk}) = _$SeasonalInsightsImpl;
  const _SeasonalInsights._() : super._();

  @override
  List<String> get keyFindings;
  @override
  List<BudgetRecommendation> get recommendations;
  @override
  List<String> get seasonalPatterns;
  @override
  RiskLevel get spendingRisk;
  @override
  @JsonKey(ignore: true)
  _$$SeasonalInsightsImplCopyWith<_$SeasonalInsightsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BudgetRecommendation {
  String get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  RecommendationType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get suggestedAmount => throw _privateConstructorUsedError;
  double get currentAverage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetRecommendationCopyWith<BudgetRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetRecommendationCopyWith<$Res> {
  factory $BudgetRecommendationCopyWith(BudgetRecommendation value,
          $Res Function(BudgetRecommendation) then) =
      _$BudgetRecommendationCopyWithImpl<$Res, BudgetRecommendation>;
  @useResult
  $Res call(
      {String categoryId,
      String categoryName,
      RecommendationType type,
      String description,
      double suggestedAmount,
      double currentAverage});
}

/// @nodoc
class _$BudgetRecommendationCopyWithImpl<$Res,
        $Val extends BudgetRecommendation>
    implements $BudgetRecommendationCopyWith<$Res> {
  _$BudgetRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? type = null,
    Object? description = null,
    Object? suggestedAmount = null,
    Object? currentAverage = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecommendationType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedAmount: null == suggestedAmount
          ? _value.suggestedAmount
          : suggestedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      currentAverage: null == currentAverage
          ? _value.currentAverage
          : currentAverage // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetRecommendationImplCopyWith<$Res>
    implements $BudgetRecommendationCopyWith<$Res> {
  factory _$$BudgetRecommendationImplCopyWith(_$BudgetRecommendationImpl value,
          $Res Function(_$BudgetRecommendationImpl) then) =
      __$$BudgetRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String categoryId,
      String categoryName,
      RecommendationType type,
      String description,
      double suggestedAmount,
      double currentAverage});
}

/// @nodoc
class __$$BudgetRecommendationImplCopyWithImpl<$Res>
    extends _$BudgetRecommendationCopyWithImpl<$Res, _$BudgetRecommendationImpl>
    implements _$$BudgetRecommendationImplCopyWith<$Res> {
  __$$BudgetRecommendationImplCopyWithImpl(_$BudgetRecommendationImpl _value,
      $Res Function(_$BudgetRecommendationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? type = null,
    Object? description = null,
    Object? suggestedAmount = null,
    Object? currentAverage = null,
  }) {
    return _then(_$BudgetRecommendationImpl(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RecommendationType,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedAmount: null == suggestedAmount
          ? _value.suggestedAmount
          : suggestedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      currentAverage: null == currentAverage
          ? _value.currentAverage
          : currentAverage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$BudgetRecommendationImpl extends _BudgetRecommendation {
  const _$BudgetRecommendationImpl(
      {required this.categoryId,
      required this.categoryName,
      required this.type,
      required this.description,
      required this.suggestedAmount,
      required this.currentAverage})
      : super._();

  @override
  final String categoryId;
  @override
  final String categoryName;
  @override
  final RecommendationType type;
  @override
  final String description;
  @override
  final double suggestedAmount;
  @override
  final double currentAverage;

  @override
  String toString() {
    return 'BudgetRecommendation(categoryId: $categoryId, categoryName: $categoryName, type: $type, description: $description, suggestedAmount: $suggestedAmount, currentAverage: $currentAverage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetRecommendationImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.suggestedAmount, suggestedAmount) ||
                other.suggestedAmount == suggestedAmount) &&
            (identical(other.currentAverage, currentAverage) ||
                other.currentAverage == currentAverage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, categoryId, categoryName, type,
      description, suggestedAmount, currentAverage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetRecommendationImplCopyWith<_$BudgetRecommendationImpl>
      get copyWith =>
          __$$BudgetRecommendationImplCopyWithImpl<_$BudgetRecommendationImpl>(
              this, _$identity);
}

abstract class _BudgetRecommendation extends BudgetRecommendation {
  const factory _BudgetRecommendation(
      {required final String categoryId,
      required final String categoryName,
      required final RecommendationType type,
      required final String description,
      required final double suggestedAmount,
      required final double currentAverage}) = _$BudgetRecommendationImpl;
  const _BudgetRecommendation._() : super._();

  @override
  String get categoryId;
  @override
  String get categoryName;
  @override
  RecommendationType get type;
  @override
  String get description;
  @override
  double get suggestedAmount;
  @override
  double get currentAverage;
  @override
  @JsonKey(ignore: true)
  _$$BudgetRecommendationImplCopyWith<_$BudgetRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
