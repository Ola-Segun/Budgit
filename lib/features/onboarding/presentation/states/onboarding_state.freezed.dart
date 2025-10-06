// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OnboardingState {
  OnboardingStep get currentStep => throw _privateConstructorUsedError;
  UserProfile? get userProfile => throw _privateConstructorUsedError;
  OnboardingData get onboardingData => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnboardingStateCopyWith<OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
          OnboardingState value, $Res Function(OnboardingState) then) =
      _$OnboardingStateCopyWithImpl<$Res, OnboardingState>;
  @useResult
  $Res call(
      {OnboardingStep currentStep,
      UserProfile? userProfile,
      OnboardingData onboardingData,
      bool isLoading,
      String? error,
      bool isCompleted});

  $UserProfileCopyWith<$Res>? get userProfile;
  $OnboardingDataCopyWith<$Res> get onboardingData;
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res, $Val extends OnboardingState>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? userProfile = freezed,
    Object? onboardingData = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as OnboardingStep,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
      onboardingData: null == onboardingData
          ? _value.onboardingData
          : onboardingData // ignore: cast_nullable_to_non_nullable
              as OnboardingData,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res>? get userProfile {
    if (_value.userProfile == null) {
      return null;
    }

    return $UserProfileCopyWith<$Res>(_value.userProfile!, (value) {
      return _then(_value.copyWith(userProfile: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OnboardingDataCopyWith<$Res> get onboardingData {
    return $OnboardingDataCopyWith<$Res>(_value.onboardingData, (value) {
      return _then(_value.copyWith(onboardingData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OnboardingStateImplCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$$OnboardingStateImplCopyWith(_$OnboardingStateImpl value,
          $Res Function(_$OnboardingStateImpl) then) =
      __$$OnboardingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OnboardingStep currentStep,
      UserProfile? userProfile,
      OnboardingData onboardingData,
      bool isLoading,
      String? error,
      bool isCompleted});

  @override
  $UserProfileCopyWith<$Res>? get userProfile;
  @override
  $OnboardingDataCopyWith<$Res> get onboardingData;
}

/// @nodoc
class __$$OnboardingStateImplCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$OnboardingStateImpl>
    implements _$$OnboardingStateImplCopyWith<$Res> {
  __$$OnboardingStateImplCopyWithImpl(
      _$OnboardingStateImpl _value, $Res Function(_$OnboardingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? userProfile = freezed,
    Object? onboardingData = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? isCompleted = null,
  }) {
    return _then(_$OnboardingStateImpl(
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as OnboardingStep,
      userProfile: freezed == userProfile
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
      onboardingData: null == onboardingData
          ? _value.onboardingData
          : onboardingData // ignore: cast_nullable_to_non_nullable
              as OnboardingData,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OnboardingStateImpl extends _OnboardingState {
  const _$OnboardingStateImpl(
      {this.currentStep = OnboardingStep.welcome,
      this.userProfile,
      this.onboardingData = const OnboardingData(),
      this.isLoading = false,
      this.error,
      this.isCompleted = false})
      : super._();

  @override
  @JsonKey()
  final OnboardingStep currentStep;
  @override
  final UserProfile? userProfile;
  @override
  @JsonKey()
  final OnboardingData onboardingData;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool isCompleted;

  @override
  String toString() {
    return 'OnboardingState(currentStep: $currentStep, userProfile: $userProfile, onboardingData: $onboardingData, isLoading: $isLoading, error: $error, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingStateImpl &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            (identical(other.onboardingData, onboardingData) ||
                other.onboardingData == onboardingData) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentStep, userProfile,
      onboardingData, isLoading, error, isCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      __$$OnboardingStateImplCopyWithImpl<_$OnboardingStateImpl>(
          this, _$identity);
}

abstract class _OnboardingState extends OnboardingState {
  const factory _OnboardingState(
      {final OnboardingStep currentStep,
      final UserProfile? userProfile,
      final OnboardingData onboardingData,
      final bool isLoading,
      final String? error,
      final bool isCompleted}) = _$OnboardingStateImpl;
  const _OnboardingState._() : super._();

  @override
  OnboardingStep get currentStep;
  @override
  UserProfile? get userProfile;
  @override
  OnboardingData get onboardingData;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  bool get isCompleted;
  @override
  @JsonKey(ignore: true)
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
