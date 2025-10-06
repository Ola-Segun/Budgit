// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IncomeSource {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  PayFrequency get frequency => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IncomeSourceCopyWith<IncomeSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeSourceCopyWith<$Res> {
  factory $IncomeSourceCopyWith(
          IncomeSource value, $Res Function(IncomeSource) then) =
      _$IncomeSourceCopyWithImpl<$Res, IncomeSource>;
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      PayFrequency frequency,
      String? description});
}

/// @nodoc
class _$IncomeSourceCopyWithImpl<$Res, $Val extends IncomeSource>
    implements $IncomeSourceCopyWith<$Res> {
  _$IncomeSourceCopyWithImpl(this._value, this._then);

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
    Object? frequency = null,
    Object? description = freezed,
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
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as PayFrequency,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IncomeSourceImplCopyWith<$Res>
    implements $IncomeSourceCopyWith<$Res> {
  factory _$$IncomeSourceImplCopyWith(
          _$IncomeSourceImpl value, $Res Function(_$IncomeSourceImpl) then) =
      __$$IncomeSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double amount,
      PayFrequency frequency,
      String? description});
}

/// @nodoc
class __$$IncomeSourceImplCopyWithImpl<$Res>
    extends _$IncomeSourceCopyWithImpl<$Res, _$IncomeSourceImpl>
    implements _$$IncomeSourceImplCopyWith<$Res> {
  __$$IncomeSourceImplCopyWithImpl(
      _$IncomeSourceImpl _value, $Res Function(_$IncomeSourceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? amount = null,
    Object? frequency = null,
    Object? description = freezed,
  }) {
    return _then(_$IncomeSourceImpl(
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
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as PayFrequency,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$IncomeSourceImpl extends _IncomeSource {
  const _$IncomeSourceImpl(
      {required this.id,
      required this.name,
      required this.amount,
      required this.frequency,
      this.description})
      : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final double amount;
  @override
  final PayFrequency frequency;
  @override
  final String? description;

  @override
  String toString() {
    return 'IncomeSource(id: $id, name: $name, amount: $amount, frequency: $frequency, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncomeSourceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, amount, frequency, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncomeSourceImplCopyWith<_$IncomeSourceImpl> get copyWith =>
      __$$IncomeSourceImplCopyWithImpl<_$IncomeSourceImpl>(this, _$identity);
}

abstract class _IncomeSource extends IncomeSource {
  const factory _IncomeSource(
      {required final String id,
      required final String name,
      required final double amount,
      required final PayFrequency frequency,
      final String? description}) = _$IncomeSourceImpl;
  const _IncomeSource._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  double get amount;
  @override
  PayFrequency get frequency;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$IncomeSourceImplCopyWith<_$IncomeSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
