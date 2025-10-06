// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DashboardData {
  FinancialSnapshot get financialSnapshot => throw _privateConstructorUsedError;
  List<BudgetCategoryOverview> get budgetOverview =>
      throw _privateConstructorUsedError;
  List<Bill> get upcomingBills => throw _privateConstructorUsedError;
  List<Transaction> get recentTransactions =>
      throw _privateConstructorUsedError;
  List<Insight> get insights => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DashboardDataCopyWith<DashboardData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardDataCopyWith<$Res> {
  factory $DashboardDataCopyWith(
          DashboardData value, $Res Function(DashboardData) then) =
      _$DashboardDataCopyWithImpl<$Res, DashboardData>;
  @useResult
  $Res call(
      {FinancialSnapshot financialSnapshot,
      List<BudgetCategoryOverview> budgetOverview,
      List<Bill> upcomingBills,
      List<Transaction> recentTransactions,
      List<Insight> insights,
      DateTime generatedAt});

  $FinancialSnapshotCopyWith<$Res> get financialSnapshot;
}

/// @nodoc
class _$DashboardDataCopyWithImpl<$Res, $Val extends DashboardData>
    implements $DashboardDataCopyWith<$Res> {
  _$DashboardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? financialSnapshot = null,
    Object? budgetOverview = null,
    Object? upcomingBills = null,
    Object? recentTransactions = null,
    Object? insights = null,
    Object? generatedAt = null,
  }) {
    return _then(_value.copyWith(
      financialSnapshot: null == financialSnapshot
          ? _value.financialSnapshot
          : financialSnapshot // ignore: cast_nullable_to_non_nullable
              as FinancialSnapshot,
      budgetOverview: null == budgetOverview
          ? _value.budgetOverview
          : budgetOverview // ignore: cast_nullable_to_non_nullable
              as List<BudgetCategoryOverview>,
      upcomingBills: null == upcomingBills
          ? _value.upcomingBills
          : upcomingBills // ignore: cast_nullable_to_non_nullable
              as List<Bill>,
      recentTransactions: null == recentTransactions
          ? _value.recentTransactions
          : recentTransactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      insights: null == insights
          ? _value.insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<Insight>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FinancialSnapshotCopyWith<$Res> get financialSnapshot {
    return $FinancialSnapshotCopyWith<$Res>(_value.financialSnapshot, (value) {
      return _then(_value.copyWith(financialSnapshot: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardDataImplCopyWith<$Res>
    implements $DashboardDataCopyWith<$Res> {
  factory _$$DashboardDataImplCopyWith(
          _$DashboardDataImpl value, $Res Function(_$DashboardDataImpl) then) =
      __$$DashboardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FinancialSnapshot financialSnapshot,
      List<BudgetCategoryOverview> budgetOverview,
      List<Bill> upcomingBills,
      List<Transaction> recentTransactions,
      List<Insight> insights,
      DateTime generatedAt});

  @override
  $FinancialSnapshotCopyWith<$Res> get financialSnapshot;
}

/// @nodoc
class __$$DashboardDataImplCopyWithImpl<$Res>
    extends _$DashboardDataCopyWithImpl<$Res, _$DashboardDataImpl>
    implements _$$DashboardDataImplCopyWith<$Res> {
  __$$DashboardDataImplCopyWithImpl(
      _$DashboardDataImpl _value, $Res Function(_$DashboardDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? financialSnapshot = null,
    Object? budgetOverview = null,
    Object? upcomingBills = null,
    Object? recentTransactions = null,
    Object? insights = null,
    Object? generatedAt = null,
  }) {
    return _then(_$DashboardDataImpl(
      financialSnapshot: null == financialSnapshot
          ? _value.financialSnapshot
          : financialSnapshot // ignore: cast_nullable_to_non_nullable
              as FinancialSnapshot,
      budgetOverview: null == budgetOverview
          ? _value._budgetOverview
          : budgetOverview // ignore: cast_nullable_to_non_nullable
              as List<BudgetCategoryOverview>,
      upcomingBills: null == upcomingBills
          ? _value._upcomingBills
          : upcomingBills // ignore: cast_nullable_to_non_nullable
              as List<Bill>,
      recentTransactions: null == recentTransactions
          ? _value._recentTransactions
          : recentTransactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      insights: null == insights
          ? _value._insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<Insight>,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DashboardDataImpl extends _DashboardData {
  const _$DashboardDataImpl(
      {required this.financialSnapshot,
      required final List<BudgetCategoryOverview> budgetOverview,
      required final List<Bill> upcomingBills,
      required final List<Transaction> recentTransactions,
      required final List<Insight> insights,
      required this.generatedAt})
      : _budgetOverview = budgetOverview,
        _upcomingBills = upcomingBills,
        _recentTransactions = recentTransactions,
        _insights = insights,
        super._();

  @override
  final FinancialSnapshot financialSnapshot;
  final List<BudgetCategoryOverview> _budgetOverview;
  @override
  List<BudgetCategoryOverview> get budgetOverview {
    if (_budgetOverview is EqualUnmodifiableListView) return _budgetOverview;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_budgetOverview);
  }

  final List<Bill> _upcomingBills;
  @override
  List<Bill> get upcomingBills {
    if (_upcomingBills is EqualUnmodifiableListView) return _upcomingBills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingBills);
  }

  final List<Transaction> _recentTransactions;
  @override
  List<Transaction> get recentTransactions {
    if (_recentTransactions is EqualUnmodifiableListView)
      return _recentTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentTransactions);
  }

  final List<Insight> _insights;
  @override
  List<Insight> get insights {
    if (_insights is EqualUnmodifiableListView) return _insights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_insights);
  }

  @override
  final DateTime generatedAt;

  @override
  String toString() {
    return 'DashboardData(financialSnapshot: $financialSnapshot, budgetOverview: $budgetOverview, upcomingBills: $upcomingBills, recentTransactions: $recentTransactions, insights: $insights, generatedAt: $generatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardDataImpl &&
            (identical(other.financialSnapshot, financialSnapshot) ||
                other.financialSnapshot == financialSnapshot) &&
            const DeepCollectionEquality()
                .equals(other._budgetOverview, _budgetOverview) &&
            const DeepCollectionEquality()
                .equals(other._upcomingBills, _upcomingBills) &&
            const DeepCollectionEquality()
                .equals(other._recentTransactions, _recentTransactions) &&
            const DeepCollectionEquality().equals(other._insights, _insights) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      financialSnapshot,
      const DeepCollectionEquality().hash(_budgetOverview),
      const DeepCollectionEquality().hash(_upcomingBills),
      const DeepCollectionEquality().hash(_recentTransactions),
      const DeepCollectionEquality().hash(_insights),
      generatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardDataImplCopyWith<_$DashboardDataImpl> get copyWith =>
      __$$DashboardDataImplCopyWithImpl<_$DashboardDataImpl>(this, _$identity);
}

abstract class _DashboardData extends DashboardData {
  const factory _DashboardData(
      {required final FinancialSnapshot financialSnapshot,
      required final List<BudgetCategoryOverview> budgetOverview,
      required final List<Bill> upcomingBills,
      required final List<Transaction> recentTransactions,
      required final List<Insight> insights,
      required final DateTime generatedAt}) = _$DashboardDataImpl;
  const _DashboardData._() : super._();

  @override
  FinancialSnapshot get financialSnapshot;
  @override
  List<BudgetCategoryOverview> get budgetOverview;
  @override
  List<Bill> get upcomingBills;
  @override
  List<Transaction> get recentTransactions;
  @override
  List<Insight> get insights;
  @override
  DateTime get generatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DashboardDataImplCopyWith<_$DashboardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FinancialSnapshot {
  double get spentThisMonth => throw _privateConstructorUsedError;
  double get budgetThisMonth => throw _privateConstructorUsedError;
  double get remainingAmount => throw _privateConstructorUsedError;
  double get progressPercentage => throw _privateConstructorUsedError;
  BudgetHealthStatus get healthStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FinancialSnapshotCopyWith<FinancialSnapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialSnapshotCopyWith<$Res> {
  factory $FinancialSnapshotCopyWith(
          FinancialSnapshot value, $Res Function(FinancialSnapshot) then) =
      _$FinancialSnapshotCopyWithImpl<$Res, FinancialSnapshot>;
  @useResult
  $Res call(
      {double spentThisMonth,
      double budgetThisMonth,
      double remainingAmount,
      double progressPercentage,
      BudgetHealthStatus healthStatus});
}

/// @nodoc
class _$FinancialSnapshotCopyWithImpl<$Res, $Val extends FinancialSnapshot>
    implements $FinancialSnapshotCopyWith<$Res> {
  _$FinancialSnapshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spentThisMonth = null,
    Object? budgetThisMonth = null,
    Object? remainingAmount = null,
    Object? progressPercentage = null,
    Object? healthStatus = null,
  }) {
    return _then(_value.copyWith(
      spentThisMonth: null == spentThisMonth
          ? _value.spentThisMonth
          : spentThisMonth // ignore: cast_nullable_to_non_nullable
              as double,
      budgetThisMonth: null == budgetThisMonth
          ? _value.budgetThisMonth
          : budgetThisMonth // ignore: cast_nullable_to_non_nullable
              as double,
      remainingAmount: null == remainingAmount
          ? _value.remainingAmount
          : remainingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      healthStatus: null == healthStatus
          ? _value.healthStatus
          : healthStatus // ignore: cast_nullable_to_non_nullable
              as BudgetHealthStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinancialSnapshotImplCopyWith<$Res>
    implements $FinancialSnapshotCopyWith<$Res> {
  factory _$$FinancialSnapshotImplCopyWith(_$FinancialSnapshotImpl value,
          $Res Function(_$FinancialSnapshotImpl) then) =
      __$$FinancialSnapshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double spentThisMonth,
      double budgetThisMonth,
      double remainingAmount,
      double progressPercentage,
      BudgetHealthStatus healthStatus});
}

/// @nodoc
class __$$FinancialSnapshotImplCopyWithImpl<$Res>
    extends _$FinancialSnapshotCopyWithImpl<$Res, _$FinancialSnapshotImpl>
    implements _$$FinancialSnapshotImplCopyWith<$Res> {
  __$$FinancialSnapshotImplCopyWithImpl(_$FinancialSnapshotImpl _value,
      $Res Function(_$FinancialSnapshotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spentThisMonth = null,
    Object? budgetThisMonth = null,
    Object? remainingAmount = null,
    Object? progressPercentage = null,
    Object? healthStatus = null,
  }) {
    return _then(_$FinancialSnapshotImpl(
      spentThisMonth: null == spentThisMonth
          ? _value.spentThisMonth
          : spentThisMonth // ignore: cast_nullable_to_non_nullable
              as double,
      budgetThisMonth: null == budgetThisMonth
          ? _value.budgetThisMonth
          : budgetThisMonth // ignore: cast_nullable_to_non_nullable
              as double,
      remainingAmount: null == remainingAmount
          ? _value.remainingAmount
          : remainingAmount // ignore: cast_nullable_to_non_nullable
              as double,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      healthStatus: null == healthStatus
          ? _value.healthStatus
          : healthStatus // ignore: cast_nullable_to_non_nullable
              as BudgetHealthStatus,
    ));
  }
}

/// @nodoc

class _$FinancialSnapshotImpl extends _FinancialSnapshot {
  const _$FinancialSnapshotImpl(
      {required this.spentThisMonth,
      required this.budgetThisMonth,
      required this.remainingAmount,
      required this.progressPercentage,
      required this.healthStatus})
      : super._();

  @override
  final double spentThisMonth;
  @override
  final double budgetThisMonth;
  @override
  final double remainingAmount;
  @override
  final double progressPercentage;
  @override
  final BudgetHealthStatus healthStatus;

  @override
  String toString() {
    return 'FinancialSnapshot(spentThisMonth: $spentThisMonth, budgetThisMonth: $budgetThisMonth, remainingAmount: $remainingAmount, progressPercentage: $progressPercentage, healthStatus: $healthStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialSnapshotImpl &&
            (identical(other.spentThisMonth, spentThisMonth) ||
                other.spentThisMonth == spentThisMonth) &&
            (identical(other.budgetThisMonth, budgetThisMonth) ||
                other.budgetThisMonth == budgetThisMonth) &&
            (identical(other.remainingAmount, remainingAmount) ||
                other.remainingAmount == remainingAmount) &&
            (identical(other.progressPercentage, progressPercentage) ||
                other.progressPercentage == progressPercentage) &&
            (identical(other.healthStatus, healthStatus) ||
                other.healthStatus == healthStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, spentThisMonth, budgetThisMonth,
      remainingAmount, progressPercentage, healthStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialSnapshotImplCopyWith<_$FinancialSnapshotImpl> get copyWith =>
      __$$FinancialSnapshotImplCopyWithImpl<_$FinancialSnapshotImpl>(
          this, _$identity);
}

abstract class _FinancialSnapshot extends FinancialSnapshot {
  const factory _FinancialSnapshot(
          {required final double spentThisMonth,
          required final double budgetThisMonth,
          required final double remainingAmount,
          required final double progressPercentage,
          required final BudgetHealthStatus healthStatus}) =
      _$FinancialSnapshotImpl;
  const _FinancialSnapshot._() : super._();

  @override
  double get spentThisMonth;
  @override
  double get budgetThisMonth;
  @override
  double get remainingAmount;
  @override
  double get progressPercentage;
  @override
  BudgetHealthStatus get healthStatus;
  @override
  @JsonKey(ignore: true)
  _$$FinancialSnapshotImplCopyWith<_$FinancialSnapshotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BudgetCategoryOverview {
  String get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  double get spent => throw _privateConstructorUsedError;
  double get budget => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  BudgetHealthStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetCategoryOverviewCopyWith<BudgetCategoryOverview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCategoryOverviewCopyWith<$Res> {
  factory $BudgetCategoryOverviewCopyWith(BudgetCategoryOverview value,
          $Res Function(BudgetCategoryOverview) then) =
      _$BudgetCategoryOverviewCopyWithImpl<$Res, BudgetCategoryOverview>;
  @useResult
  $Res call(
      {String categoryId,
      String categoryName,
      double spent,
      double budget,
      double percentage,
      BudgetHealthStatus status});
}

/// @nodoc
class _$BudgetCategoryOverviewCopyWithImpl<$Res,
        $Val extends BudgetCategoryOverview>
    implements $BudgetCategoryOverviewCopyWith<$Res> {
  _$BudgetCategoryOverviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? spent = null,
    Object? budget = null,
    Object? percentage = null,
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
      spent: null == spent
          ? _value.spent
          : spent // ignore: cast_nullable_to_non_nullable
              as double,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BudgetHealthStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetCategoryOverviewImplCopyWith<$Res>
    implements $BudgetCategoryOverviewCopyWith<$Res> {
  factory _$$BudgetCategoryOverviewImplCopyWith(
          _$BudgetCategoryOverviewImpl value,
          $Res Function(_$BudgetCategoryOverviewImpl) then) =
      __$$BudgetCategoryOverviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String categoryId,
      String categoryName,
      double spent,
      double budget,
      double percentage,
      BudgetHealthStatus status});
}

/// @nodoc
class __$$BudgetCategoryOverviewImplCopyWithImpl<$Res>
    extends _$BudgetCategoryOverviewCopyWithImpl<$Res,
        _$BudgetCategoryOverviewImpl>
    implements _$$BudgetCategoryOverviewImplCopyWith<$Res> {
  __$$BudgetCategoryOverviewImplCopyWithImpl(
      _$BudgetCategoryOverviewImpl _value,
      $Res Function(_$BudgetCategoryOverviewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? categoryName = null,
    Object? spent = null,
    Object? budget = null,
    Object? percentage = null,
    Object? status = null,
  }) {
    return _then(_$BudgetCategoryOverviewImpl(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      spent: null == spent
          ? _value.spent
          : spent // ignore: cast_nullable_to_non_nullable
              as double,
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BudgetHealthStatus,
    ));
  }
}

/// @nodoc

class _$BudgetCategoryOverviewImpl extends _BudgetCategoryOverview {
  const _$BudgetCategoryOverviewImpl(
      {required this.categoryId,
      required this.categoryName,
      required this.spent,
      required this.budget,
      required this.percentage,
      required this.status})
      : super._();

  @override
  final String categoryId;
  @override
  final String categoryName;
  @override
  final double spent;
  @override
  final double budget;
  @override
  final double percentage;
  @override
  final BudgetHealthStatus status;

  @override
  String toString() {
    return 'BudgetCategoryOverview(categoryId: $categoryId, categoryName: $categoryName, spent: $spent, budget: $budget, percentage: $percentage, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetCategoryOverviewImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.spent, spent) || other.spent == spent) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, categoryId, categoryName, spent, budget, percentage, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetCategoryOverviewImplCopyWith<_$BudgetCategoryOverviewImpl>
      get copyWith => __$$BudgetCategoryOverviewImplCopyWithImpl<
          _$BudgetCategoryOverviewImpl>(this, _$identity);
}

abstract class _BudgetCategoryOverview extends BudgetCategoryOverview {
  const factory _BudgetCategoryOverview(
      {required final String categoryId,
      required final String categoryName,
      required final double spent,
      required final double budget,
      required final double percentage,
      required final BudgetHealthStatus status}) = _$BudgetCategoryOverviewImpl;
  const _BudgetCategoryOverview._() : super._();

  @override
  String get categoryId;
  @override
  String get categoryName;
  @override
  double get spent;
  @override
  double get budget;
  @override
  double get percentage;
  @override
  BudgetHealthStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$BudgetCategoryOverviewImplCopyWith<_$BudgetCategoryOverviewImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DashboardSummary {
  int get totalTransactions => throw _privateConstructorUsedError;
  int get upcomingBillsCount => throw _privateConstructorUsedError;
  int get unreadInsightsCount => throw _privateConstructorUsedError;
  double get monthlySavings => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DashboardSummaryCopyWith<DashboardSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardSummaryCopyWith<$Res> {
  factory $DashboardSummaryCopyWith(
          DashboardSummary value, $Res Function(DashboardSummary) then) =
      _$DashboardSummaryCopyWithImpl<$Res, DashboardSummary>;
  @useResult
  $Res call(
      {int totalTransactions,
      int upcomingBillsCount,
      int unreadInsightsCount,
      double monthlySavings,
      DateTime lastUpdated});
}

/// @nodoc
class _$DashboardSummaryCopyWithImpl<$Res, $Val extends DashboardSummary>
    implements $DashboardSummaryCopyWith<$Res> {
  _$DashboardSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTransactions = null,
    Object? upcomingBillsCount = null,
    Object? unreadInsightsCount = null,
    Object? monthlySavings = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      totalTransactions: null == totalTransactions
          ? _value.totalTransactions
          : totalTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingBillsCount: null == upcomingBillsCount
          ? _value.upcomingBillsCount
          : upcomingBillsCount // ignore: cast_nullable_to_non_nullable
              as int,
      unreadInsightsCount: null == unreadInsightsCount
          ? _value.unreadInsightsCount
          : unreadInsightsCount // ignore: cast_nullable_to_non_nullable
              as int,
      monthlySavings: null == monthlySavings
          ? _value.monthlySavings
          : monthlySavings // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardSummaryImplCopyWith<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  factory _$$DashboardSummaryImplCopyWith(_$DashboardSummaryImpl value,
          $Res Function(_$DashboardSummaryImpl) then) =
      __$$DashboardSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalTransactions,
      int upcomingBillsCount,
      int unreadInsightsCount,
      double monthlySavings,
      DateTime lastUpdated});
}

/// @nodoc
class __$$DashboardSummaryImplCopyWithImpl<$Res>
    extends _$DashboardSummaryCopyWithImpl<$Res, _$DashboardSummaryImpl>
    implements _$$DashboardSummaryImplCopyWith<$Res> {
  __$$DashboardSummaryImplCopyWithImpl(_$DashboardSummaryImpl _value,
      $Res Function(_$DashboardSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTransactions = null,
    Object? upcomingBillsCount = null,
    Object? unreadInsightsCount = null,
    Object? monthlySavings = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$DashboardSummaryImpl(
      totalTransactions: null == totalTransactions
          ? _value.totalTransactions
          : totalTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      upcomingBillsCount: null == upcomingBillsCount
          ? _value.upcomingBillsCount
          : upcomingBillsCount // ignore: cast_nullable_to_non_nullable
              as int,
      unreadInsightsCount: null == unreadInsightsCount
          ? _value.unreadInsightsCount
          : unreadInsightsCount // ignore: cast_nullable_to_non_nullable
              as int,
      monthlySavings: null == monthlySavings
          ? _value.monthlySavings
          : monthlySavings // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DashboardSummaryImpl extends _DashboardSummary {
  const _$DashboardSummaryImpl(
      {required this.totalTransactions,
      required this.upcomingBillsCount,
      required this.unreadInsightsCount,
      required this.monthlySavings,
      required this.lastUpdated})
      : super._();

  @override
  final int totalTransactions;
  @override
  final int upcomingBillsCount;
  @override
  final int unreadInsightsCount;
  @override
  final double monthlySavings;
  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'DashboardSummary(totalTransactions: $totalTransactions, upcomingBillsCount: $upcomingBillsCount, unreadInsightsCount: $unreadInsightsCount, monthlySavings: $monthlySavings, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardSummaryImpl &&
            (identical(other.totalTransactions, totalTransactions) ||
                other.totalTransactions == totalTransactions) &&
            (identical(other.upcomingBillsCount, upcomingBillsCount) ||
                other.upcomingBillsCount == upcomingBillsCount) &&
            (identical(other.unreadInsightsCount, unreadInsightsCount) ||
                other.unreadInsightsCount == unreadInsightsCount) &&
            (identical(other.monthlySavings, monthlySavings) ||
                other.monthlySavings == monthlySavings) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalTransactions,
      upcomingBillsCount, unreadInsightsCount, monthlySavings, lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardSummaryImplCopyWith<_$DashboardSummaryImpl> get copyWith =>
      __$$DashboardSummaryImplCopyWithImpl<_$DashboardSummaryImpl>(
          this, _$identity);
}

abstract class _DashboardSummary extends DashboardSummary {
  const factory _DashboardSummary(
      {required final int totalTransactions,
      required final int upcomingBillsCount,
      required final int unreadInsightsCount,
      required final double monthlySavings,
      required final DateTime lastUpdated}) = _$DashboardSummaryImpl;
  const _DashboardSummary._() : super._();

  @override
  int get totalTransactions;
  @override
  int get upcomingBillsCount;
  @override
  int get unreadInsightsCount;
  @override
  double get monthlySavings;
  @override
  DateTime get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$DashboardSummaryImplCopyWith<_$DashboardSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
