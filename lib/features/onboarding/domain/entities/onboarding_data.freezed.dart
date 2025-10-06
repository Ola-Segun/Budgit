// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OnboardingData {
  BudgetType? get selectedBudgetType => throw _privateConstructorUsedError;
  List<IncomeSource> get incomeSources => throw _privateConstructorUsedError;
  List<BudgetCategory> get budgetCategories =>
      throw _privateConstructorUsedError;
  bool get wantsBankConnection => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnboardingDataCopyWith<OnboardingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingDataCopyWith<$Res> {
  factory $OnboardingDataCopyWith(
          OnboardingData value, $Res Function(OnboardingData) then) =
      _$OnboardingDataCopyWithImpl<$Res, OnboardingData>;
  @useResult
  $Res call(
      {BudgetType? selectedBudgetType,
      List<IncomeSource> incomeSources,
      List<BudgetCategory> budgetCategories,
      bool wantsBankConnection});
}

/// @nodoc
class _$OnboardingDataCopyWithImpl<$Res, $Val extends OnboardingData>
    implements $OnboardingDataCopyWith<$Res> {
  _$OnboardingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedBudgetType = freezed,
    Object? incomeSources = null,
    Object? budgetCategories = null,
    Object? wantsBankConnection = null,
  }) {
    return _then(_value.copyWith(
      selectedBudgetType: freezed == selectedBudgetType
          ? _value.selectedBudgetType
          : selectedBudgetType // ignore: cast_nullable_to_non_nullable
              as BudgetType?,
      incomeSources: null == incomeSources
          ? _value.incomeSources
          : incomeSources // ignore: cast_nullable_to_non_nullable
              as List<IncomeSource>,
      budgetCategories: null == budgetCategories
          ? _value.budgetCategories
          : budgetCategories // ignore: cast_nullable_to_non_nullable
              as List<BudgetCategory>,
      wantsBankConnection: null == wantsBankConnection
          ? _value.wantsBankConnection
          : wantsBankConnection // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnboardingDataImplCopyWith<$Res>
    implements $OnboardingDataCopyWith<$Res> {
  factory _$$OnboardingDataImplCopyWith(_$OnboardingDataImpl value,
          $Res Function(_$OnboardingDataImpl) then) =
      __$$OnboardingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BudgetType? selectedBudgetType,
      List<IncomeSource> incomeSources,
      List<BudgetCategory> budgetCategories,
      bool wantsBankConnection});
}

/// @nodoc
class __$$OnboardingDataImplCopyWithImpl<$Res>
    extends _$OnboardingDataCopyWithImpl<$Res, _$OnboardingDataImpl>
    implements _$$OnboardingDataImplCopyWith<$Res> {
  __$$OnboardingDataImplCopyWithImpl(
      _$OnboardingDataImpl _value, $Res Function(_$OnboardingDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedBudgetType = freezed,
    Object? incomeSources = null,
    Object? budgetCategories = null,
    Object? wantsBankConnection = null,
  }) {
    return _then(_$OnboardingDataImpl(
      selectedBudgetType: freezed == selectedBudgetType
          ? _value.selectedBudgetType
          : selectedBudgetType // ignore: cast_nullable_to_non_nullable
              as BudgetType?,
      incomeSources: null == incomeSources
          ? _value._incomeSources
          : incomeSources // ignore: cast_nullable_to_non_nullable
              as List<IncomeSource>,
      budgetCategories: null == budgetCategories
          ? _value._budgetCategories
          : budgetCategories // ignore: cast_nullable_to_non_nullable
              as List<BudgetCategory>,
      wantsBankConnection: null == wantsBankConnection
          ? _value.wantsBankConnection
          : wantsBankConnection // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OnboardingDataImpl extends _OnboardingData {
  const _$OnboardingDataImpl(
      {this.selectedBudgetType,
      final List<IncomeSource> incomeSources = const [],
      final List<BudgetCategory> budgetCategories = const [],
      this.wantsBankConnection = false})
      : _incomeSources = incomeSources,
        _budgetCategories = budgetCategories,
        super._();

  @override
  final BudgetType? selectedBudgetType;
  final List<IncomeSource> _incomeSources;
  @override
  @JsonKey()
  List<IncomeSource> get incomeSources {
    if (_incomeSources is EqualUnmodifiableListView) return _incomeSources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incomeSources);
  }

  final List<BudgetCategory> _budgetCategories;
  @override
  @JsonKey()
  List<BudgetCategory> get budgetCategories {
    if (_budgetCategories is EqualUnmodifiableListView)
      return _budgetCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_budgetCategories);
  }

  @override
  @JsonKey()
  final bool wantsBankConnection;

  @override
  String toString() {
    return 'OnboardingData(selectedBudgetType: $selectedBudgetType, incomeSources: $incomeSources, budgetCategories: $budgetCategories, wantsBankConnection: $wantsBankConnection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingDataImpl &&
            (identical(other.selectedBudgetType, selectedBudgetType) ||
                other.selectedBudgetType == selectedBudgetType) &&
            const DeepCollectionEquality()
                .equals(other._incomeSources, _incomeSources) &&
            const DeepCollectionEquality()
                .equals(other._budgetCategories, _budgetCategories) &&
            (identical(other.wantsBankConnection, wantsBankConnection) ||
                other.wantsBankConnection == wantsBankConnection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedBudgetType,
      const DeepCollectionEquality().hash(_incomeSources),
      const DeepCollectionEquality().hash(_budgetCategories),
      wantsBankConnection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingDataImplCopyWith<_$OnboardingDataImpl> get copyWith =>
      __$$OnboardingDataImplCopyWithImpl<_$OnboardingDataImpl>(
          this, _$identity);
}

abstract class _OnboardingData extends OnboardingData {
  const factory _OnboardingData(
      {final BudgetType? selectedBudgetType,
      final List<IncomeSource> incomeSources,
      final List<BudgetCategory> budgetCategories,
      final bool wantsBankConnection}) = _$OnboardingDataImpl;
  const _OnboardingData._() : super._();

  @override
  BudgetType? get selectedBudgetType;
  @override
  List<IncomeSource> get incomeSources;
  @override
  List<BudgetCategory> get budgetCategories;
  @override
  bool get wantsBankConnection;
  @override
  @JsonKey(ignore: true)
  _$$OnboardingDataImplCopyWith<_$OnboardingDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
