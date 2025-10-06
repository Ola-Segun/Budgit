// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_budget.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SharedBudget {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  List<String> get memberIds => throw _privateConstructorUsedError;
  List<String> get pendingInvites => throw _privateConstructorUsedError;
  double get totalBudget => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SharedBudgetCopyWith<SharedBudget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SharedBudgetCopyWith<$Res> {
  factory $SharedBudgetCopyWith(
          SharedBudget value, $Res Function(SharedBudget) then) =
      _$SharedBudgetCopyWithImpl<$Res, SharedBudget>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String ownerId,
      List<String> memberIds,
      List<String> pendingInvites,
      double totalBudget,
      DateTime createdAt,
      DateTime updatedAt,
      bool isActive,
      String? category});
}

/// @nodoc
class _$SharedBudgetCopyWithImpl<$Res, $Val extends SharedBudget>
    implements $SharedBudgetCopyWith<$Res> {
  _$SharedBudgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? ownerId = null,
    Object? memberIds = null,
    Object? pendingInvites = null,
    Object? totalBudget = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isActive = null,
    Object? category = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      memberIds: null == memberIds
          ? _value.memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      pendingInvites: null == pendingInvites
          ? _value.pendingInvites
          : pendingInvites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalBudget: null == totalBudget
          ? _value.totalBudget
          : totalBudget // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SharedBudgetImplCopyWith<$Res>
    implements $SharedBudgetCopyWith<$Res> {
  factory _$$SharedBudgetImplCopyWith(
          _$SharedBudgetImpl value, $Res Function(_$SharedBudgetImpl) then) =
      __$$SharedBudgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String ownerId,
      List<String> memberIds,
      List<String> pendingInvites,
      double totalBudget,
      DateTime createdAt,
      DateTime updatedAt,
      bool isActive,
      String? category});
}

/// @nodoc
class __$$SharedBudgetImplCopyWithImpl<$Res>
    extends _$SharedBudgetCopyWithImpl<$Res, _$SharedBudgetImpl>
    implements _$$SharedBudgetImplCopyWith<$Res> {
  __$$SharedBudgetImplCopyWithImpl(
      _$SharedBudgetImpl _value, $Res Function(_$SharedBudgetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? ownerId = null,
    Object? memberIds = null,
    Object? pendingInvites = null,
    Object? totalBudget = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isActive = null,
    Object? category = freezed,
  }) {
    return _then(_$SharedBudgetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      memberIds: null == memberIds
          ? _value._memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      pendingInvites: null == pendingInvites
          ? _value._pendingInvites
          : pendingInvites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalBudget: null == totalBudget
          ? _value.totalBudget
          : totalBudget // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SharedBudgetImpl extends _SharedBudget {
  const _$SharedBudgetImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.ownerId,
      required final List<String> memberIds,
      required final List<String> pendingInvites,
      required this.totalBudget,
      required this.createdAt,
      required this.updatedAt,
      this.isActive = true,
      this.category})
      : _memberIds = memberIds,
        _pendingInvites = pendingInvites,
        super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String ownerId;
  final List<String> _memberIds;
  @override
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  final List<String> _pendingInvites;
  @override
  List<String> get pendingInvites {
    if (_pendingInvites is EqualUnmodifiableListView) return _pendingInvites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingInvites);
  }

  @override
  final double totalBudget;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? category;

  @override
  String toString() {
    return 'SharedBudget(id: $id, name: $name, description: $description, ownerId: $ownerId, memberIds: $memberIds, pendingInvites: $pendingInvites, totalBudget: $totalBudget, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SharedBudgetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality()
                .equals(other._memberIds, _memberIds) &&
            const DeepCollectionEquality()
                .equals(other._pendingInvites, _pendingInvites) &&
            (identical(other.totalBudget, totalBudget) ||
                other.totalBudget == totalBudget) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      ownerId,
      const DeepCollectionEquality().hash(_memberIds),
      const DeepCollectionEquality().hash(_pendingInvites),
      totalBudget,
      createdAt,
      updatedAt,
      isActive,
      category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SharedBudgetImplCopyWith<_$SharedBudgetImpl> get copyWith =>
      __$$SharedBudgetImplCopyWithImpl<_$SharedBudgetImpl>(this, _$identity);
}

abstract class _SharedBudget extends SharedBudget {
  const factory _SharedBudget(
      {required final String id,
      required final String name,
      final String? description,
      required final String ownerId,
      required final List<String> memberIds,
      required final List<String> pendingInvites,
      required final double totalBudget,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final bool isActive,
      final String? category}) = _$SharedBudgetImpl;
  const _SharedBudget._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get ownerId;
  @override
  List<String> get memberIds;
  @override
  List<String> get pendingInvites;
  @override
  double get totalBudget;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  bool get isActive;
  @override
  String? get category;
  @override
  @JsonKey(ignore: true)
  _$$SharedBudgetImplCopyWith<_$SharedBudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BudgetMember {
  String get userId => throw _privateConstructorUsedError;
  BudgetPermission get permission => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;
  DateTime? get lastActivityAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BudgetMemberCopyWith<BudgetMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetMemberCopyWith<$Res> {
  factory $BudgetMemberCopyWith(
          BudgetMember value, $Res Function(BudgetMember) then) =
      _$BudgetMemberCopyWithImpl<$Res, BudgetMember>;
  @useResult
  $Res call(
      {String userId,
      BudgetPermission permission,
      DateTime joinedAt,
      DateTime? lastActivityAt});
}

/// @nodoc
class _$BudgetMemberCopyWithImpl<$Res, $Val extends BudgetMember>
    implements $BudgetMemberCopyWith<$Res> {
  _$BudgetMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? permission = null,
    Object? joinedAt = null,
    Object? lastActivityAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      permission: null == permission
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as BudgetPermission,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetMemberImplCopyWith<$Res>
    implements $BudgetMemberCopyWith<$Res> {
  factory _$$BudgetMemberImplCopyWith(
          _$BudgetMemberImpl value, $Res Function(_$BudgetMemberImpl) then) =
      __$$BudgetMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      BudgetPermission permission,
      DateTime joinedAt,
      DateTime? lastActivityAt});
}

/// @nodoc
class __$$BudgetMemberImplCopyWithImpl<$Res>
    extends _$BudgetMemberCopyWithImpl<$Res, _$BudgetMemberImpl>
    implements _$$BudgetMemberImplCopyWith<$Res> {
  __$$BudgetMemberImplCopyWithImpl(
      _$BudgetMemberImpl _value, $Res Function(_$BudgetMemberImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? permission = null,
    Object? joinedAt = null,
    Object? lastActivityAt = freezed,
  }) {
    return _then(_$BudgetMemberImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      permission: null == permission
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as BudgetPermission,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$BudgetMemberImpl extends _BudgetMember {
  const _$BudgetMemberImpl(
      {required this.userId,
      required this.permission,
      required this.joinedAt,
      this.lastActivityAt})
      : super._();

  @override
  final String userId;
  @override
  final BudgetPermission permission;
  @override
  final DateTime joinedAt;
  @override
  final DateTime? lastActivityAt;

  @override
  String toString() {
    return 'BudgetMember(userId: $userId, permission: $permission, joinedAt: $joinedAt, lastActivityAt: $lastActivityAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetMemberImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.permission, permission) ||
                other.permission == permission) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, permission, joinedAt, lastActivityAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetMemberImplCopyWith<_$BudgetMemberImpl> get copyWith =>
      __$$BudgetMemberImplCopyWithImpl<_$BudgetMemberImpl>(this, _$identity);
}

abstract class _BudgetMember extends BudgetMember {
  const factory _BudgetMember(
      {required final String userId,
      required final BudgetPermission permission,
      required final DateTime joinedAt,
      final DateTime? lastActivityAt}) = _$BudgetMemberImpl;
  const _BudgetMember._() : super._();

  @override
  String get userId;
  @override
  BudgetPermission get permission;
  @override
  DateTime get joinedAt;
  @override
  DateTime? get lastActivityAt;
  @override
  @JsonKey(ignore: true)
  _$$BudgetMemberImplCopyWith<_$BudgetMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
