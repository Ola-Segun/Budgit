// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Budget {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  BudgetType get type => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<BudgetCategory> get categories => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get allowRollover => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetCopyWith<Budget> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCopyWith<$Res> {
  factory $BudgetCopyWith(Budget value, $Res Function(Budget) then) =
      _$BudgetCopyWithImpl<$Res, Budget>;
  @useResult
  $Res call(
      {String id,
      String name,
      BudgetType type,
      DateTime startDate,
      DateTime endDate,
      DateTime createdAt,
      List<BudgetCategory> categories,
      String? description,
      bool isActive,
      bool allowRollover});
}

/// @nodoc
class _$BudgetCopyWithImpl<$Res, $Val extends Budget>
    implements $BudgetCopyWith<$Res> {
  _$BudgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? createdAt = null,
    Object? categories = null,
    Object? description = freezed,
    Object? isActive = null,
    Object? allowRollover = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BudgetType,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<BudgetCategory>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRollover: null == allowRollover
          ? _value.allowRollover
          : allowRollover // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetImplCopyWith<$Res> implements $BudgetCopyWith<$Res> {
  factory _$$BudgetImplCopyWith(
          _$BudgetImpl value, $Res Function(_$BudgetImpl) then) =
      __$$BudgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      BudgetType type,
      DateTime startDate,
      DateTime endDate,
      DateTime createdAt,
      List<BudgetCategory> categories,
      String? description,
      bool isActive,
      bool allowRollover});
}

/// @nodoc
class __$$BudgetImplCopyWithImpl<$Res>
    extends _$BudgetCopyWithImpl<$Res, _$BudgetImpl>
    implements _$$BudgetImplCopyWith<$Res> {
  __$$BudgetImplCopyWithImpl(
      _$BudgetImpl _value, $Res Function(_$BudgetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? createdAt = null,
    Object? categories = null,
    Object? description = freezed,
    Object? isActive = null,
    Object? allowRollover = null,
  }) {
    return _then(_$BudgetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BudgetType,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<BudgetCategory>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      allowRollover: null == allowRollover
          ? _value.allowRollover
          : allowRollover // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BudgetImpl extends _Budget {
  const _$BudgetImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.startDate,
      required this.endDate,
      required this.createdAt,
      required final List<BudgetCategory> categories,
      this.description,
      this.isActive = false,
      this.allowRollover = false})
      : _categories = categories,
        super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final BudgetType type;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final DateTime createdAt;
  final List<BudgetCategory> _categories;
  @override
  List<BudgetCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final String? description;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool allowRollover;

  @override
  String toString() {
    return 'Budget(id: $id, name: $name, type: $type, startDate: $startDate, endDate: $endDate, createdAt: $createdAt, categories: $categories, description: $description, isActive: $isActive, allowRollover: $allowRollover)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.allowRollover, allowRollover) ||
                other.allowRollover == allowRollover));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      startDate,
      endDate,
      createdAt,
      const DeepCollectionEquality().hash(_categories),
      description,
      isActive,
      allowRollover);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetImplCopyWith<_$BudgetImpl> get copyWith =>
      __$$BudgetImplCopyWithImpl<_$BudgetImpl>(this, _$identity);
}

abstract class _Budget extends Budget {
  const factory _Budget(
      {required final String id,
      required final String name,
      required final BudgetType type,
      required final DateTime startDate,
      required final DateTime endDate,
      required final DateTime createdAt,
      required final List<BudgetCategory> categories,
      final String? description,
      final bool isActive,
      final bool allowRollover}) = _$BudgetImpl;
  const _Budget._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  BudgetType get type;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  DateTime get createdAt;
  @override
  List<BudgetCategory> get categories;
  @override
  String? get description;
  @override
  bool get isActive;
  @override
  bool get allowRollover;
  @override
  @JsonKey(ignore: true)
  _$$BudgetImplCopyWith<_$BudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BudgetCategory {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  int? get color => throw _privateConstructorUsedError;
  List<String> get subcategories => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetCategoryCopyWith<BudgetCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCategoryCopyWith<$Res> {
  factory $BudgetCategoryCopyWith(
          BudgetCategory value, $Res Function(BudgetCategory) then) =
      _$BudgetCategoryCopyWithImpl<$Res, BudgetCategory>;
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      String? description,
      String? icon,
      int? color,
      List<String> subcategories});
}

/// @nodoc
class _$BudgetCategoryCopyWithImpl<$Res, $Val extends BudgetCategory>
    implements $BudgetCategoryCopyWith<$Res> {
  _$BudgetCategoryCopyWithImpl(this._value, this._then);

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
    Object? description = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? subcategories = null,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
      subcategories: null == subcategories
          ? _value.subcategories
          : subcategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetCategoryImplCopyWith<$Res>
    implements $BudgetCategoryCopyWith<$Res> {
  factory _$$BudgetCategoryImplCopyWith(_$BudgetCategoryImpl value,
          $Res Function(_$BudgetCategoryImpl) then) =
      __$$BudgetCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      String? description,
      String? icon,
      int? color,
      List<String> subcategories});
}

/// @nodoc
class __$$BudgetCategoryImplCopyWithImpl<$Res>
    extends _$BudgetCategoryCopyWithImpl<$Res, _$BudgetCategoryImpl>
    implements _$$BudgetCategoryImplCopyWith<$Res> {
  __$$BudgetCategoryImplCopyWithImpl(
      _$BudgetCategoryImpl _value, $Res Function(_$BudgetCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? subcategories = null,
  }) {
    return _then(_$BudgetCategoryImpl(
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
      subcategories: null == subcategories
          ? _value._subcategories
          : subcategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$BudgetCategoryImpl extends _BudgetCategory {
  const _$BudgetCategoryImpl(
      {required this.id,
      required this.name,
      required this.amount,
      this.description,
      this.icon,
      this.color,
      final List<String> subcategories = const []})
      : _subcategories = subcategories,
        super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final double amount;
  @override
  final String? description;
  @override
  final String? icon;
  @override
  final int? color;
  final List<String> _subcategories;
  @override
  @JsonKey()
  List<String> get subcategories {
    if (_subcategories is EqualUnmodifiableListView) return _subcategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subcategories);
  }

  @override
  String toString() {
    return 'BudgetCategory(id: $id, name: $name, amount: $amount, description: $description, icon: $icon, color: $color, subcategories: $subcategories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality()
                .equals(other._subcategories, _subcategories));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, amount, description,
      icon, color, const DeepCollectionEquality().hash(_subcategories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetCategoryImplCopyWith<_$BudgetCategoryImpl> get copyWith =>
      __$$BudgetCategoryImplCopyWithImpl<_$BudgetCategoryImpl>(
          this, _$identity);
}

abstract class _BudgetCategory extends BudgetCategory {
  const factory _BudgetCategory(
      {required final String id,
      required final String name,
      required final double amount,
      final String? description,
      final String? icon,
      final int? color,
      final List<String> subcategories}) = _$BudgetCategoryImpl;
  const _BudgetCategory._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  double get amount;
  @override
  String? get description;
  @override
  String? get icon;
  @override
  int? get color;
  @override
  List<String> get subcategories;
  @override
  @JsonKey(ignore: true)
  _$$BudgetCategoryImplCopyWith<_$BudgetCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BudgetStatus {
  Budget get budget => throw _privateConstructorUsedError;
  double get totalSpent => throw _privateConstructorUsedError;
  double get totalBudget => throw _privateConstructorUsedError;
  List<CategoryStatus> get categoryStatuses =>
      throw _privateConstructorUsedError;
  int get daysRemaining => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetStatusCopyWith<BudgetStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetStatusCopyWith<$Res> {
  factory $BudgetStatusCopyWith(
          BudgetStatus value, $Res Function(BudgetStatus) then) =
      _$BudgetStatusCopyWithImpl<$Res, BudgetStatus>;
  @useResult
  $Res call(
      {Budget budget,
      double totalSpent,
      double totalBudget,
      List<CategoryStatus> categoryStatuses,
      int daysRemaining});

  $BudgetCopyWith<$Res> get budget;
}

/// @nodoc
class _$BudgetStatusCopyWithImpl<$Res, $Val extends BudgetStatus>
    implements $BudgetStatusCopyWith<$Res> {
  _$BudgetStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? budget = null,
    Object? totalSpent = null,
    Object? totalBudget = null,
    Object? categoryStatuses = null,
    Object? daysRemaining = null,
  }) {
    return _then(_value.copyWith(
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as Budget,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      totalBudget: null == totalBudget
          ? _value.totalBudget
          : totalBudget // ignore: cast_nullable_to_non_nullable
              as double,
      categoryStatuses: null == categoryStatuses
          ? _value.categoryStatuses
          : categoryStatuses // ignore: cast_nullable_to_non_nullable
              as List<CategoryStatus>,
      daysRemaining: null == daysRemaining
          ? _value.daysRemaining
          : daysRemaining // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BudgetCopyWith<$Res> get budget {
    return $BudgetCopyWith<$Res>(_value.budget, (value) {
      return _then(_value.copyWith(budget: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BudgetStatusImplCopyWith<$Res>
    implements $BudgetStatusCopyWith<$Res> {
  factory _$$BudgetStatusImplCopyWith(
          _$BudgetStatusImpl value, $Res Function(_$BudgetStatusImpl) then) =
      __$$BudgetStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Budget budget,
      double totalSpent,
      double totalBudget,
      List<CategoryStatus> categoryStatuses,
      int daysRemaining});

  @override
  $BudgetCopyWith<$Res> get budget;
}

/// @nodoc
class __$$BudgetStatusImplCopyWithImpl<$Res>
    extends _$BudgetStatusCopyWithImpl<$Res, _$BudgetStatusImpl>
    implements _$$BudgetStatusImplCopyWith<$Res> {
  __$$BudgetStatusImplCopyWithImpl(
      _$BudgetStatusImpl _value, $Res Function(_$BudgetStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? budget = null,
    Object? totalSpent = null,
    Object? totalBudget = null,
    Object? categoryStatuses = null,
    Object? daysRemaining = null,
  }) {
    return _then(_$BudgetStatusImpl(
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as Budget,
      totalSpent: null == totalSpent
          ? _value.totalSpent
          : totalSpent // ignore: cast_nullable_to_non_nullable
              as double,
      totalBudget: null == totalBudget
          ? _value.totalBudget
          : totalBudget // ignore: cast_nullable_to_non_nullable
              as double,
      categoryStatuses: null == categoryStatuses
          ? _value._categoryStatuses
          : categoryStatuses // ignore: cast_nullable_to_non_nullable
              as List<CategoryStatus>,
      daysRemaining: null == daysRemaining
          ? _value.daysRemaining
          : daysRemaining // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BudgetStatusImpl extends _BudgetStatus {
  const _$BudgetStatusImpl(
      {required this.budget,
      required this.totalSpent,
      required this.totalBudget,
      required final List<CategoryStatus> categoryStatuses,
      required this.daysRemaining})
      : _categoryStatuses = categoryStatuses,
        super._();

  @override
  final Budget budget;
  @override
  final double totalSpent;
  @override
  final double totalBudget;
  final List<CategoryStatus> _categoryStatuses;
  @override
  List<CategoryStatus> get categoryStatuses {
    if (_categoryStatuses is EqualUnmodifiableListView)
      return _categoryStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryStatuses);
  }

  @override
  final int daysRemaining;

  @override
  String toString() {
    return 'BudgetStatus(budget: $budget, totalSpent: $totalSpent, totalBudget: $totalBudget, categoryStatuses: $categoryStatuses, daysRemaining: $daysRemaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetStatusImpl &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.totalBudget, totalBudget) ||
                other.totalBudget == totalBudget) &&
            const DeepCollectionEquality()
                .equals(other._categoryStatuses, _categoryStatuses) &&
            (identical(other.daysRemaining, daysRemaining) ||
                other.daysRemaining == daysRemaining));
  }

  @override
  int get hashCode => Object.hash(runtimeType, budget, totalSpent, totalBudget,
      const DeepCollectionEquality().hash(_categoryStatuses), daysRemaining);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetStatusImplCopyWith<_$BudgetStatusImpl> get copyWith =>
      __$$BudgetStatusImplCopyWithImpl<_$BudgetStatusImpl>(this, _$identity);
}

abstract class _BudgetStatus extends BudgetStatus {
  const factory _BudgetStatus(
      {required final Budget budget,
      required final double totalSpent,
      required final double totalBudget,
      required final List<CategoryStatus> categoryStatuses,
      required final int daysRemaining}) = _$BudgetStatusImpl;
  const _BudgetStatus._() : super._();

  @override
  Budget get budget;
  @override
  double get totalSpent;
  @override
  double get totalBudget;
  @override
  List<CategoryStatus> get categoryStatuses;
  @override
  int get daysRemaining;
  @override
  @JsonKey(ignore: true)
  _$$BudgetStatusImplCopyWith<_$BudgetStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CategoryStatus {
  String get categoryId => throw _privateConstructorUsedError;
  double get spent => throw _privateConstructorUsedError;
  double get budget => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  BudgetHealth get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryStatusCopyWith<CategoryStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryStatusCopyWith<$Res> {
  factory $CategoryStatusCopyWith(
          CategoryStatus value, $Res Function(CategoryStatus) then) =
      _$CategoryStatusCopyWithImpl<$Res, CategoryStatus>;
  @useResult
  $Res call(
      {String categoryId,
      double spent,
      double budget,
      double percentage,
      BudgetHealth status});
}

/// @nodoc
class _$CategoryStatusCopyWithImpl<$Res, $Val extends CategoryStatus>
    implements $CategoryStatusCopyWith<$Res> {
  _$CategoryStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
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
              as BudgetHealth,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryStatusImplCopyWith<$Res>
    implements $CategoryStatusCopyWith<$Res> {
  factory _$$CategoryStatusImplCopyWith(_$CategoryStatusImpl value,
          $Res Function(_$CategoryStatusImpl) then) =
      __$$CategoryStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String categoryId,
      double spent,
      double budget,
      double percentage,
      BudgetHealth status});
}

/// @nodoc
class __$$CategoryStatusImplCopyWithImpl<$Res>
    extends _$CategoryStatusCopyWithImpl<$Res, _$CategoryStatusImpl>
    implements _$$CategoryStatusImplCopyWith<$Res> {
  __$$CategoryStatusImplCopyWithImpl(
      _$CategoryStatusImpl _value, $Res Function(_$CategoryStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? spent = null,
    Object? budget = null,
    Object? percentage = null,
    Object? status = null,
  }) {
    return _then(_$CategoryStatusImpl(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
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
              as BudgetHealth,
    ));
  }
}

/// @nodoc

class _$CategoryStatusImpl extends _CategoryStatus {
  const _$CategoryStatusImpl(
      {required this.categoryId,
      required this.spent,
      required this.budget,
      required this.percentage,
      required this.status})
      : super._();

  @override
  final String categoryId;
  @override
  final double spent;
  @override
  final double budget;
  @override
  final double percentage;
  @override
  final BudgetHealth status;

  @override
  String toString() {
    return 'CategoryStatus(categoryId: $categoryId, spent: $spent, budget: $budget, percentage: $percentage, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryStatusImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.spent, spent) || other.spent == spent) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, categoryId, spent, budget, percentage, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryStatusImplCopyWith<_$CategoryStatusImpl> get copyWith =>
      __$$CategoryStatusImplCopyWithImpl<_$CategoryStatusImpl>(
          this, _$identity);
}

abstract class _CategoryStatus extends CategoryStatus {
  const factory _CategoryStatus(
      {required final String categoryId,
      required final double spent,
      required final double budget,
      required final double percentage,
      required final BudgetHealth status}) = _$CategoryStatusImpl;
  const _CategoryStatus._() : super._();

  @override
  String get categoryId;
  @override
  double get spent;
  @override
  double get budget;
  @override
  double get percentage;
  @override
  BudgetHealth get status;
  @override
  @JsonKey(ignore: true)
  _$$CategoryStatusImplCopyWith<_$CategoryStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
