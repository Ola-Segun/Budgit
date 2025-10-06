// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insight_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InsightState {
  List<Insight> get insights => throw _privateConstructorUsedError;
  InsightsSummary? get insightsSummary => throw _privateConstructorUsedError;
  FinancialHealthScore? get healthScore => throw _privateConstructorUsedError;
  List<FinancialReport> get reports => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingSummary => throw _privateConstructorUsedError;
  bool get isLoadingHealthScore => throw _privateConstructorUsedError;
  bool get isCreatingReport => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get summaryError => throw _privateConstructorUsedError;
  String? get healthScoreError => throw _privateConstructorUsedError;
  String? get reportError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InsightStateCopyWith<InsightState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightStateCopyWith<$Res> {
  factory $InsightStateCopyWith(
          InsightState value, $Res Function(InsightState) then) =
      _$InsightStateCopyWithImpl<$Res, InsightState>;
  @useResult
  $Res call(
      {List<Insight> insights,
      InsightsSummary? insightsSummary,
      FinancialHealthScore? healthScore,
      List<FinancialReport> reports,
      bool isLoading,
      bool isLoadingSummary,
      bool isLoadingHealthScore,
      bool isCreatingReport,
      String? error,
      String? summaryError,
      String? healthScoreError,
      String? reportError});

  $InsightsSummaryCopyWith<$Res>? get insightsSummary;
  $FinancialHealthScoreCopyWith<$Res>? get healthScore;
}

/// @nodoc
class _$InsightStateCopyWithImpl<$Res, $Val extends InsightState>
    implements $InsightStateCopyWith<$Res> {
  _$InsightStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? insights = null,
    Object? insightsSummary = freezed,
    Object? healthScore = freezed,
    Object? reports = null,
    Object? isLoading = null,
    Object? isLoadingSummary = null,
    Object? isLoadingHealthScore = null,
    Object? isCreatingReport = null,
    Object? error = freezed,
    Object? summaryError = freezed,
    Object? healthScoreError = freezed,
    Object? reportError = freezed,
  }) {
    return _then(_value.copyWith(
      insights: null == insights
          ? _value.insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<Insight>,
      insightsSummary: freezed == insightsSummary
          ? _value.insightsSummary
          : insightsSummary // ignore: cast_nullable_to_non_nullable
              as InsightsSummary?,
      healthScore: freezed == healthScore
          ? _value.healthScore
          : healthScore // ignore: cast_nullable_to_non_nullable
              as FinancialHealthScore?,
      reports: null == reports
          ? _value.reports
          : reports // ignore: cast_nullable_to_non_nullable
              as List<FinancialReport>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingSummary: null == isLoadingSummary
          ? _value.isLoadingSummary
          : isLoadingSummary // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingHealthScore: null == isLoadingHealthScore
          ? _value.isLoadingHealthScore
          : isLoadingHealthScore // ignore: cast_nullable_to_non_nullable
              as bool,
      isCreatingReport: null == isCreatingReport
          ? _value.isCreatingReport
          : isCreatingReport // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      summaryError: freezed == summaryError
          ? _value.summaryError
          : summaryError // ignore: cast_nullable_to_non_nullable
              as String?,
      healthScoreError: freezed == healthScoreError
          ? _value.healthScoreError
          : healthScoreError // ignore: cast_nullable_to_non_nullable
              as String?,
      reportError: freezed == reportError
          ? _value.reportError
          : reportError // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InsightsSummaryCopyWith<$Res>? get insightsSummary {
    if (_value.insightsSummary == null) {
      return null;
    }

    return $InsightsSummaryCopyWith<$Res>(_value.insightsSummary!, (value) {
      return _then(_value.copyWith(insightsSummary: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FinancialHealthScoreCopyWith<$Res>? get healthScore {
    if (_value.healthScore == null) {
      return null;
    }

    return $FinancialHealthScoreCopyWith<$Res>(_value.healthScore!, (value) {
      return _then(_value.copyWith(healthScore: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InsightStateImplCopyWith<$Res>
    implements $InsightStateCopyWith<$Res> {
  factory _$$InsightStateImplCopyWith(
          _$InsightStateImpl value, $Res Function(_$InsightStateImpl) then) =
      __$$InsightStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Insight> insights,
      InsightsSummary? insightsSummary,
      FinancialHealthScore? healthScore,
      List<FinancialReport> reports,
      bool isLoading,
      bool isLoadingSummary,
      bool isLoadingHealthScore,
      bool isCreatingReport,
      String? error,
      String? summaryError,
      String? healthScoreError,
      String? reportError});

  @override
  $InsightsSummaryCopyWith<$Res>? get insightsSummary;
  @override
  $FinancialHealthScoreCopyWith<$Res>? get healthScore;
}

/// @nodoc
class __$$InsightStateImplCopyWithImpl<$Res>
    extends _$InsightStateCopyWithImpl<$Res, _$InsightStateImpl>
    implements _$$InsightStateImplCopyWith<$Res> {
  __$$InsightStateImplCopyWithImpl(
      _$InsightStateImpl _value, $Res Function(_$InsightStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? insights = null,
    Object? insightsSummary = freezed,
    Object? healthScore = freezed,
    Object? reports = null,
    Object? isLoading = null,
    Object? isLoadingSummary = null,
    Object? isLoadingHealthScore = null,
    Object? isCreatingReport = null,
    Object? error = freezed,
    Object? summaryError = freezed,
    Object? healthScoreError = freezed,
    Object? reportError = freezed,
  }) {
    return _then(_$InsightStateImpl(
      insights: null == insights
          ? _value._insights
          : insights // ignore: cast_nullable_to_non_nullable
              as List<Insight>,
      insightsSummary: freezed == insightsSummary
          ? _value.insightsSummary
          : insightsSummary // ignore: cast_nullable_to_non_nullable
              as InsightsSummary?,
      healthScore: freezed == healthScore
          ? _value.healthScore
          : healthScore // ignore: cast_nullable_to_non_nullable
              as FinancialHealthScore?,
      reports: null == reports
          ? _value._reports
          : reports // ignore: cast_nullable_to_non_nullable
              as List<FinancialReport>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingSummary: null == isLoadingSummary
          ? _value.isLoadingSummary
          : isLoadingSummary // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingHealthScore: null == isLoadingHealthScore
          ? _value.isLoadingHealthScore
          : isLoadingHealthScore // ignore: cast_nullable_to_non_nullable
              as bool,
      isCreatingReport: null == isCreatingReport
          ? _value.isCreatingReport
          : isCreatingReport // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      summaryError: freezed == summaryError
          ? _value.summaryError
          : summaryError // ignore: cast_nullable_to_non_nullable
              as String?,
      healthScoreError: freezed == healthScoreError
          ? _value.healthScoreError
          : healthScoreError // ignore: cast_nullable_to_non_nullable
              as String?,
      reportError: freezed == reportError
          ? _value.reportError
          : reportError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InsightStateImpl extends _InsightState {
  const _$InsightStateImpl(
      {final List<Insight> insights = const [],
      this.insightsSummary,
      this.healthScore,
      final List<FinancialReport> reports = const [],
      this.isLoading = false,
      this.isLoadingSummary = false,
      this.isLoadingHealthScore = false,
      this.isCreatingReport = false,
      this.error,
      this.summaryError,
      this.healthScoreError,
      this.reportError})
      : _insights = insights,
        _reports = reports,
        super._();

  final List<Insight> _insights;
  @override
  @JsonKey()
  List<Insight> get insights {
    if (_insights is EqualUnmodifiableListView) return _insights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_insights);
  }

  @override
  final InsightsSummary? insightsSummary;
  @override
  final FinancialHealthScore? healthScore;
  final List<FinancialReport> _reports;
  @override
  @JsonKey()
  List<FinancialReport> get reports {
    if (_reports is EqualUnmodifiableListView) return _reports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reports);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingSummary;
  @override
  @JsonKey()
  final bool isLoadingHealthScore;
  @override
  @JsonKey()
  final bool isCreatingReport;
  @override
  final String? error;
  @override
  final String? summaryError;
  @override
  final String? healthScoreError;
  @override
  final String? reportError;

  @override
  String toString() {
    return 'InsightState(insights: $insights, insightsSummary: $insightsSummary, healthScore: $healthScore, reports: $reports, isLoading: $isLoading, isLoadingSummary: $isLoadingSummary, isLoadingHealthScore: $isLoadingHealthScore, isCreatingReport: $isCreatingReport, error: $error, summaryError: $summaryError, healthScoreError: $healthScoreError, reportError: $reportError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightStateImpl &&
            const DeepCollectionEquality().equals(other._insights, _insights) &&
            (identical(other.insightsSummary, insightsSummary) ||
                other.insightsSummary == insightsSummary) &&
            (identical(other.healthScore, healthScore) ||
                other.healthScore == healthScore) &&
            const DeepCollectionEquality().equals(other._reports, _reports) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingSummary, isLoadingSummary) ||
                other.isLoadingSummary == isLoadingSummary) &&
            (identical(other.isLoadingHealthScore, isLoadingHealthScore) ||
                other.isLoadingHealthScore == isLoadingHealthScore) &&
            (identical(other.isCreatingReport, isCreatingReport) ||
                other.isCreatingReport == isCreatingReport) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.summaryError, summaryError) ||
                other.summaryError == summaryError) &&
            (identical(other.healthScoreError, healthScoreError) ||
                other.healthScoreError == healthScoreError) &&
            (identical(other.reportError, reportError) ||
                other.reportError == reportError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_insights),
      insightsSummary,
      healthScore,
      const DeepCollectionEquality().hash(_reports),
      isLoading,
      isLoadingSummary,
      isLoadingHealthScore,
      isCreatingReport,
      error,
      summaryError,
      healthScoreError,
      reportError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightStateImplCopyWith<_$InsightStateImpl> get copyWith =>
      __$$InsightStateImplCopyWithImpl<_$InsightStateImpl>(this, _$identity);
}

abstract class _InsightState extends InsightState {
  const factory _InsightState(
      {final List<Insight> insights,
      final InsightsSummary? insightsSummary,
      final FinancialHealthScore? healthScore,
      final List<FinancialReport> reports,
      final bool isLoading,
      final bool isLoadingSummary,
      final bool isLoadingHealthScore,
      final bool isCreatingReport,
      final String? error,
      final String? summaryError,
      final String? healthScoreError,
      final String? reportError}) = _$InsightStateImpl;
  const _InsightState._() : super._();

  @override
  List<Insight> get insights;
  @override
  InsightsSummary? get insightsSummary;
  @override
  FinancialHealthScore? get healthScore;
  @override
  List<FinancialReport> get reports;
  @override
  bool get isLoading;
  @override
  bool get isLoadingSummary;
  @override
  bool get isLoadingHealthScore;
  @override
  bool get isCreatingReport;
  @override
  String? get error;
  @override
  String? get summaryError;
  @override
  String? get healthScoreError;
  @override
  String? get reportError;
  @override
  @JsonKey(ignore: true)
  _$$InsightStateImplCopyWith<_$InsightStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InsightFilter {
  InsightType? get type => throw _privateConstructorUsedError;
  InsightPriority? get priority => throw _privateConstructorUsedError;
  bool? get isRead => throw _privateConstructorUsedError;
  bool? get isArchived => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InsightFilterCopyWith<InsightFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightFilterCopyWith<$Res> {
  factory $InsightFilterCopyWith(
          InsightFilter value, $Res Function(InsightFilter) then) =
      _$InsightFilterCopyWithImpl<$Res, InsightFilter>;
  @useResult
  $Res call(
      {InsightType? type,
      InsightPriority? priority,
      bool? isRead,
      bool? isArchived,
      DateTime? startDate,
      DateTime? endDate});
}

/// @nodoc
class _$InsightFilterCopyWithImpl<$Res, $Val extends InsightFilter>
    implements $InsightFilterCopyWith<$Res> {
  _$InsightFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? priority = freezed,
    Object? isRead = freezed,
    Object? isArchived = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InsightType?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as InsightPriority?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      isArchived: freezed == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsightFilterImplCopyWith<$Res>
    implements $InsightFilterCopyWith<$Res> {
  factory _$$InsightFilterImplCopyWith(
          _$InsightFilterImpl value, $Res Function(_$InsightFilterImpl) then) =
      __$$InsightFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {InsightType? type,
      InsightPriority? priority,
      bool? isRead,
      bool? isArchived,
      DateTime? startDate,
      DateTime? endDate});
}

/// @nodoc
class __$$InsightFilterImplCopyWithImpl<$Res>
    extends _$InsightFilterCopyWithImpl<$Res, _$InsightFilterImpl>
    implements _$$InsightFilterImplCopyWith<$Res> {
  __$$InsightFilterImplCopyWithImpl(
      _$InsightFilterImpl _value, $Res Function(_$InsightFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? priority = freezed,
    Object? isRead = freezed,
    Object? isArchived = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_$InsightFilterImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InsightType?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as InsightPriority?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      isArchived: freezed == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$InsightFilterImpl extends _InsightFilter {
  const _$InsightFilterImpl(
      {this.type,
      this.priority,
      this.isRead,
      this.isArchived,
      this.startDate,
      this.endDate})
      : super._();

  @override
  final InsightType? type;
  @override
  final InsightPriority? priority;
  @override
  final bool? isRead;
  @override
  final bool? isArchived;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'InsightFilter(type: $type, priority: $priority, isRead: $isRead, isArchived: $isArchived, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightFilterImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, type, priority, isRead, isArchived, startDate, endDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightFilterImplCopyWith<_$InsightFilterImpl> get copyWith =>
      __$$InsightFilterImplCopyWithImpl<_$InsightFilterImpl>(this, _$identity);
}

abstract class _InsightFilter extends InsightFilter {
  const factory _InsightFilter(
      {final InsightType? type,
      final InsightPriority? priority,
      final bool? isRead,
      final bool? isArchived,
      final DateTime? startDate,
      final DateTime? endDate}) = _$InsightFilterImpl;
  const _InsightFilter._() : super._();

  @override
  InsightType? get type;
  @override
  InsightPriority? get priority;
  @override
  bool? get isRead;
  @override
  bool? get isArchived;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  @JsonKey(ignore: true)
  _$$InsightFilterImplCopyWith<_$InsightFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InsightStats {
  int get totalInsights => throw _privateConstructorUsedError;
  int get unreadInsights => throw _privateConstructorUsedError;
  int get highPriorityInsights => throw _privateConstructorUsedError;
  int get archivedInsights => throw _privateConstructorUsedError;
  int get totalReports => throw _privateConstructorUsedError;
  double get averageHealthScore => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InsightStatsCopyWith<InsightStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightStatsCopyWith<$Res> {
  factory $InsightStatsCopyWith(
          InsightStats value, $Res Function(InsightStats) then) =
      _$InsightStatsCopyWithImpl<$Res, InsightStats>;
  @useResult
  $Res call(
      {int totalInsights,
      int unreadInsights,
      int highPriorityInsights,
      int archivedInsights,
      int totalReports,
      double averageHealthScore});
}

/// @nodoc
class _$InsightStatsCopyWithImpl<$Res, $Val extends InsightStats>
    implements $InsightStatsCopyWith<$Res> {
  _$InsightStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInsights = null,
    Object? unreadInsights = null,
    Object? highPriorityInsights = null,
    Object? archivedInsights = null,
    Object? totalReports = null,
    Object? averageHealthScore = null,
  }) {
    return _then(_value.copyWith(
      totalInsights: null == totalInsights
          ? _value.totalInsights
          : totalInsights // ignore: cast_nullable_to_non_nullable
              as int,
      unreadInsights: null == unreadInsights
          ? _value.unreadInsights
          : unreadInsights // ignore: cast_nullable_to_non_nullable
              as int,
      highPriorityInsights: null == highPriorityInsights
          ? _value.highPriorityInsights
          : highPriorityInsights // ignore: cast_nullable_to_non_nullable
              as int,
      archivedInsights: null == archivedInsights
          ? _value.archivedInsights
          : archivedInsights // ignore: cast_nullable_to_non_nullable
              as int,
      totalReports: null == totalReports
          ? _value.totalReports
          : totalReports // ignore: cast_nullable_to_non_nullable
              as int,
      averageHealthScore: null == averageHealthScore
          ? _value.averageHealthScore
          : averageHealthScore // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsightStatsImplCopyWith<$Res>
    implements $InsightStatsCopyWith<$Res> {
  factory _$$InsightStatsImplCopyWith(
          _$InsightStatsImpl value, $Res Function(_$InsightStatsImpl) then) =
      __$$InsightStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalInsights,
      int unreadInsights,
      int highPriorityInsights,
      int archivedInsights,
      int totalReports,
      double averageHealthScore});
}

/// @nodoc
class __$$InsightStatsImplCopyWithImpl<$Res>
    extends _$InsightStatsCopyWithImpl<$Res, _$InsightStatsImpl>
    implements _$$InsightStatsImplCopyWith<$Res> {
  __$$InsightStatsImplCopyWithImpl(
      _$InsightStatsImpl _value, $Res Function(_$InsightStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInsights = null,
    Object? unreadInsights = null,
    Object? highPriorityInsights = null,
    Object? archivedInsights = null,
    Object? totalReports = null,
    Object? averageHealthScore = null,
  }) {
    return _then(_$InsightStatsImpl(
      totalInsights: null == totalInsights
          ? _value.totalInsights
          : totalInsights // ignore: cast_nullable_to_non_nullable
              as int,
      unreadInsights: null == unreadInsights
          ? _value.unreadInsights
          : unreadInsights // ignore: cast_nullable_to_non_nullable
              as int,
      highPriorityInsights: null == highPriorityInsights
          ? _value.highPriorityInsights
          : highPriorityInsights // ignore: cast_nullable_to_non_nullable
              as int,
      archivedInsights: null == archivedInsights
          ? _value.archivedInsights
          : archivedInsights // ignore: cast_nullable_to_non_nullable
              as int,
      totalReports: null == totalReports
          ? _value.totalReports
          : totalReports // ignore: cast_nullable_to_non_nullable
              as int,
      averageHealthScore: null == averageHealthScore
          ? _value.averageHealthScore
          : averageHealthScore // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$InsightStatsImpl extends _InsightStats {
  const _$InsightStatsImpl(
      {this.totalInsights = 0,
      this.unreadInsights = 0,
      this.highPriorityInsights = 0,
      this.archivedInsights = 0,
      this.totalReports = 0,
      this.averageHealthScore = 0.0})
      : super._();

  @override
  @JsonKey()
  final int totalInsights;
  @override
  @JsonKey()
  final int unreadInsights;
  @override
  @JsonKey()
  final int highPriorityInsights;
  @override
  @JsonKey()
  final int archivedInsights;
  @override
  @JsonKey()
  final int totalReports;
  @override
  @JsonKey()
  final double averageHealthScore;

  @override
  String toString() {
    return 'InsightStats(totalInsights: $totalInsights, unreadInsights: $unreadInsights, highPriorityInsights: $highPriorityInsights, archivedInsights: $archivedInsights, totalReports: $totalReports, averageHealthScore: $averageHealthScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightStatsImpl &&
            (identical(other.totalInsights, totalInsights) ||
                other.totalInsights == totalInsights) &&
            (identical(other.unreadInsights, unreadInsights) ||
                other.unreadInsights == unreadInsights) &&
            (identical(other.highPriorityInsights, highPriorityInsights) ||
                other.highPriorityInsights == highPriorityInsights) &&
            (identical(other.archivedInsights, archivedInsights) ||
                other.archivedInsights == archivedInsights) &&
            (identical(other.totalReports, totalReports) ||
                other.totalReports == totalReports) &&
            (identical(other.averageHealthScore, averageHealthScore) ||
                other.averageHealthScore == averageHealthScore));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalInsights, unreadInsights,
      highPriorityInsights, archivedInsights, totalReports, averageHealthScore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightStatsImplCopyWith<_$InsightStatsImpl> get copyWith =>
      __$$InsightStatsImplCopyWithImpl<_$InsightStatsImpl>(this, _$identity);
}

abstract class _InsightStats extends InsightStats {
  const factory _InsightStats(
      {final int totalInsights,
      final int unreadInsights,
      final int highPriorityInsights,
      final int archivedInsights,
      final int totalReports,
      final double averageHealthScore}) = _$InsightStatsImpl;
  const _InsightStats._() : super._();

  @override
  int get totalInsights;
  @override
  int get unreadInsights;
  @override
  int get highPriorityInsights;
  @override
  int get archivedInsights;
  @override
  int get totalReports;
  @override
  double get averageHealthScore;
  @override
  @JsonKey(ignore: true)
  _$$InsightStatsImplCopyWith<_$InsightStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
