// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BudgetTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  BudgetType get type => throw _privateConstructorUsedError;
  List<BudgetCategoryTemplate> get categories =>
      throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  int? get color => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetTemplateCopyWith<BudgetTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetTemplateCopyWith<$Res> {
  factory $BudgetTemplateCopyWith(
          BudgetTemplate value, $Res Function(BudgetTemplate) then) =
      _$BudgetTemplateCopyWithImpl<$Res, BudgetTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      BudgetType type,
      List<BudgetCategoryTemplate> categories,
      String? icon,
      int? color});
}

/// @nodoc
class _$BudgetTemplateCopyWithImpl<$Res, $Val extends BudgetTemplate>
    implements $BudgetTemplateCopyWith<$Res> {
  _$BudgetTemplateCopyWithImpl(this._value, this._then);

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
    Object? type = null,
    Object? categories = null,
    Object? icon = freezed,
    Object? color = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BudgetType,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<BudgetCategoryTemplate>,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetTemplateImplCopyWith<$Res>
    implements $BudgetTemplateCopyWith<$Res> {
  factory _$$BudgetTemplateImplCopyWith(_$BudgetTemplateImpl value,
          $Res Function(_$BudgetTemplateImpl) then) =
      __$$BudgetTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      BudgetType type,
      List<BudgetCategoryTemplate> categories,
      String? icon,
      int? color});
}

/// @nodoc
class __$$BudgetTemplateImplCopyWithImpl<$Res>
    extends _$BudgetTemplateCopyWithImpl<$Res, _$BudgetTemplateImpl>
    implements _$$BudgetTemplateImplCopyWith<$Res> {
  __$$BudgetTemplateImplCopyWithImpl(
      _$BudgetTemplateImpl _value, $Res Function(_$BudgetTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? categories = null,
    Object? icon = freezed,
    Object? color = freezed,
  }) {
    return _then(_$BudgetTemplateImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BudgetType,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<BudgetCategoryTemplate>,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$BudgetTemplateImpl extends _BudgetTemplate {
  const _$BudgetTemplateImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.type,
      required final List<BudgetCategoryTemplate> categories,
      this.icon,
      this.color})
      : _categories = categories,
        super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final BudgetType type;
  final List<BudgetCategoryTemplate> _categories;
  @override
  List<BudgetCategoryTemplate> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final String? icon;
  @override
  final int? color;

  @override
  String toString() {
    return 'BudgetTemplate(id: $id, name: $name, description: $description, type: $type, categories: $categories, icon: $icon, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, type,
      const DeepCollectionEquality().hash(_categories), icon, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetTemplateImplCopyWith<_$BudgetTemplateImpl> get copyWith =>
      __$$BudgetTemplateImplCopyWithImpl<_$BudgetTemplateImpl>(
          this, _$identity);
}

abstract class _BudgetTemplate extends BudgetTemplate {
  const factory _BudgetTemplate(
      {required final String id,
      required final String name,
      required final String description,
      required final BudgetType type,
      required final List<BudgetCategoryTemplate> categories,
      final String? icon,
      final int? color}) = _$BudgetTemplateImpl;
  const _BudgetTemplate._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  BudgetType get type;
  @override
  List<BudgetCategoryTemplate> get categories;
  @override
  String? get icon;
  @override
  int? get color;
  @override
  @JsonKey(ignore: true)
  _$$BudgetTemplateImplCopyWith<_$BudgetTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BudgetCategoryTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  int? get color => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetCategoryTemplateCopyWith<BudgetCategoryTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCategoryTemplateCopyWith<$Res> {
  factory $BudgetCategoryTemplateCopyWith(BudgetCategoryTemplate value,
          $Res Function(BudgetCategoryTemplate) then) =
      _$BudgetCategoryTemplateCopyWithImpl<$Res, BudgetCategoryTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      String? description,
      String? icon,
      int? color});
}

/// @nodoc
class _$BudgetCategoryTemplateCopyWithImpl<$Res,
        $Val extends BudgetCategoryTemplate>
    implements $BudgetCategoryTemplateCopyWith<$Res> {
  _$BudgetCategoryTemplateCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetCategoryTemplateImplCopyWith<$Res>
    implements $BudgetCategoryTemplateCopyWith<$Res> {
  factory _$$BudgetCategoryTemplateImplCopyWith(
          _$BudgetCategoryTemplateImpl value,
          $Res Function(_$BudgetCategoryTemplateImpl) then) =
      __$$BudgetCategoryTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      String? description,
      String? icon,
      int? color});
}

/// @nodoc
class __$$BudgetCategoryTemplateImplCopyWithImpl<$Res>
    extends _$BudgetCategoryTemplateCopyWithImpl<$Res,
        _$BudgetCategoryTemplateImpl>
    implements _$$BudgetCategoryTemplateImplCopyWith<$Res> {
  __$$BudgetCategoryTemplateImplCopyWithImpl(
      _$BudgetCategoryTemplateImpl _value,
      $Res Function(_$BudgetCategoryTemplateImpl) _then)
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
  }) {
    return _then(_$BudgetCategoryTemplateImpl(
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
    ));
  }
}

/// @nodoc

class _$BudgetCategoryTemplateImpl extends _BudgetCategoryTemplate {
  const _$BudgetCategoryTemplateImpl(
      {required this.id,
      required this.name,
      required this.amount,
      this.description,
      this.icon,
      this.color})
      : super._();

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

  @override
  String toString() {
    return 'BudgetCategoryTemplate(id: $id, name: $name, amount: $amount, description: $description, icon: $icon, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetCategoryTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, amount, description, icon, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetCategoryTemplateImplCopyWith<_$BudgetCategoryTemplateImpl>
      get copyWith => __$$BudgetCategoryTemplateImplCopyWithImpl<
          _$BudgetCategoryTemplateImpl>(this, _$identity);
}

abstract class _BudgetCategoryTemplate extends BudgetCategoryTemplate {
  const factory _BudgetCategoryTemplate(
      {required final String id,
      required final String name,
      required final double amount,
      final String? description,
      final String? icon,
      final int? color}) = _$BudgetCategoryTemplateImpl;
  const _BudgetCategoryTemplate._() : super._();

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
  @JsonKey(ignore: true)
  _$$BudgetCategoryTemplateImplCopyWith<_$BudgetCategoryTemplateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
