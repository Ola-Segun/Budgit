// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_scanning_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReceiptScanningState {
  /// Whether camera is being initialized
  bool get isInitializing => throw _privateConstructorUsedError;

  /// Whether camera is initialized and ready
  bool get isInitialized => throw _privateConstructorUsedError;

  /// Whether receipt is being processed
  bool get isProcessing => throw _privateConstructorUsedError;

  /// Extracted receipt data (null if not processed yet)
  ReceiptData? get receiptData => throw _privateConstructorUsedError;

  /// Error message (null if no error)
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReceiptScanningStateCopyWith<ReceiptScanningState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptScanningStateCopyWith<$Res> {
  factory $ReceiptScanningStateCopyWith(ReceiptScanningState value,
          $Res Function(ReceiptScanningState) then) =
      _$ReceiptScanningStateCopyWithImpl<$Res, ReceiptScanningState>;
  @useResult
  $Res call(
      {bool isInitializing,
      bool isInitialized,
      bool isProcessing,
      ReceiptData? receiptData,
      String? error});

  $ReceiptDataCopyWith<$Res>? get receiptData;
}

/// @nodoc
class _$ReceiptScanningStateCopyWithImpl<$Res,
        $Val extends ReceiptScanningState>
    implements $ReceiptScanningStateCopyWith<$Res> {
  _$ReceiptScanningStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitializing = null,
    Object? isInitialized = null,
    Object? isProcessing = null,
    Object? receiptData = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isInitializing: null == isInitializing
          ? _value.isInitializing
          : isInitializing // ignore: cast_nullable_to_non_nullable
              as bool,
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      receiptData: freezed == receiptData
          ? _value.receiptData
          : receiptData // ignore: cast_nullable_to_non_nullable
              as ReceiptData?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReceiptDataCopyWith<$Res>? get receiptData {
    if (_value.receiptData == null) {
      return null;
    }

    return $ReceiptDataCopyWith<$Res>(_value.receiptData!, (value) {
      return _then(_value.copyWith(receiptData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReceiptScanningStateImplCopyWith<$Res>
    implements $ReceiptScanningStateCopyWith<$Res> {
  factory _$$ReceiptScanningStateImplCopyWith(_$ReceiptScanningStateImpl value,
          $Res Function(_$ReceiptScanningStateImpl) then) =
      __$$ReceiptScanningStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isInitializing,
      bool isInitialized,
      bool isProcessing,
      ReceiptData? receiptData,
      String? error});

  @override
  $ReceiptDataCopyWith<$Res>? get receiptData;
}

/// @nodoc
class __$$ReceiptScanningStateImplCopyWithImpl<$Res>
    extends _$ReceiptScanningStateCopyWithImpl<$Res, _$ReceiptScanningStateImpl>
    implements _$$ReceiptScanningStateImplCopyWith<$Res> {
  __$$ReceiptScanningStateImplCopyWithImpl(_$ReceiptScanningStateImpl _value,
      $Res Function(_$ReceiptScanningStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitializing = null,
    Object? isInitialized = null,
    Object? isProcessing = null,
    Object? receiptData = freezed,
    Object? error = freezed,
  }) {
    return _then(_$ReceiptScanningStateImpl(
      isInitializing: null == isInitializing
          ? _value.isInitializing
          : isInitializing // ignore: cast_nullable_to_non_nullable
              as bool,
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      receiptData: freezed == receiptData
          ? _value.receiptData
          : receiptData // ignore: cast_nullable_to_non_nullable
              as ReceiptData?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ReceiptScanningStateImpl extends _ReceiptScanningState {
  const _$ReceiptScanningStateImpl(
      {this.isInitializing = false,
      this.isInitialized = false,
      this.isProcessing = false,
      this.receiptData,
      this.error})
      : super._();

  /// Whether camera is being initialized
  @override
  @JsonKey()
  final bool isInitializing;

  /// Whether camera is initialized and ready
  @override
  @JsonKey()
  final bool isInitialized;

  /// Whether receipt is being processed
  @override
  @JsonKey()
  final bool isProcessing;

  /// Extracted receipt data (null if not processed yet)
  @override
  final ReceiptData? receiptData;

  /// Error message (null if no error)
  @override
  final String? error;

  @override
  String toString() {
    return 'ReceiptScanningState(isInitializing: $isInitializing, isInitialized: $isInitialized, isProcessing: $isProcessing, receiptData: $receiptData, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptScanningStateImpl &&
            (identical(other.isInitializing, isInitializing) ||
                other.isInitializing == isInitializing) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.receiptData, receiptData) ||
                other.receiptData == receiptData) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isInitializing, isInitialized,
      isProcessing, receiptData, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptScanningStateImplCopyWith<_$ReceiptScanningStateImpl>
      get copyWith =>
          __$$ReceiptScanningStateImplCopyWithImpl<_$ReceiptScanningStateImpl>(
              this, _$identity);
}

abstract class _ReceiptScanningState extends ReceiptScanningState {
  const factory _ReceiptScanningState(
      {final bool isInitializing,
      final bool isInitialized,
      final bool isProcessing,
      final ReceiptData? receiptData,
      final String? error}) = _$ReceiptScanningStateImpl;
  const _ReceiptScanningState._() : super._();

  @override

  /// Whether camera is being initialized
  bool get isInitializing;
  @override

  /// Whether camera is initialized and ready
  bool get isInitialized;
  @override

  /// Whether receipt is being processed
  bool get isProcessing;
  @override

  /// Extracted receipt data (null if not processed yet)
  ReceiptData? get receiptData;
  @override

  /// Error message (null if no error)
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$ReceiptScanningStateImplCopyWith<_$ReceiptScanningStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
