// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EmailReport {
  String get id => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  List<String> get recipients => throw _privateConstructorUsedError;
  ReportType get type => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  String? get attachmentPath => throw _privateConstructorUsedError;
  bool get isSent => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmailReportCopyWith<EmailReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailReportCopyWith<$Res> {
  factory $EmailReportCopyWith(
          EmailReport value, $Res Function(EmailReport) then) =
      _$EmailReportCopyWithImpl<$Res, EmailReport>;
  @useResult
  $Res call(
      {String id,
      String subject,
      String body,
      List<String> recipients,
      ReportType type,
      DateTime generatedAt,
      String? attachmentPath,
      bool isSent,
      DateTime? sentAt});
}

/// @nodoc
class _$EmailReportCopyWithImpl<$Res, $Val extends EmailReport>
    implements $EmailReportCopyWith<$Res> {
  _$EmailReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject = null,
    Object? body = null,
    Object? recipients = null,
    Object? type = null,
    Object? generatedAt = null,
    Object? attachmentPath = freezed,
    Object? isSent = null,
    Object? sentAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      recipients: null == recipients
          ? _value.recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReportType,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attachmentPath: freezed == attachmentPath
          ? _value.attachmentPath
          : attachmentPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isSent: null == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailReportImplCopyWith<$Res>
    implements $EmailReportCopyWith<$Res> {
  factory _$$EmailReportImplCopyWith(
          _$EmailReportImpl value, $Res Function(_$EmailReportImpl) then) =
      __$$EmailReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String subject,
      String body,
      List<String> recipients,
      ReportType type,
      DateTime generatedAt,
      String? attachmentPath,
      bool isSent,
      DateTime? sentAt});
}

/// @nodoc
class __$$EmailReportImplCopyWithImpl<$Res>
    extends _$EmailReportCopyWithImpl<$Res, _$EmailReportImpl>
    implements _$$EmailReportImplCopyWith<$Res> {
  __$$EmailReportImplCopyWithImpl(
      _$EmailReportImpl _value, $Res Function(_$EmailReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subject = null,
    Object? body = null,
    Object? recipients = null,
    Object? type = null,
    Object? generatedAt = null,
    Object? attachmentPath = freezed,
    Object? isSent = null,
    Object? sentAt = freezed,
  }) {
    return _then(_$EmailReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      recipients: null == recipients
          ? _value._recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReportType,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      attachmentPath: freezed == attachmentPath
          ? _value.attachmentPath
          : attachmentPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isSent: null == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$EmailReportImpl extends _EmailReport {
  const _$EmailReportImpl(
      {required this.id,
      required this.subject,
      required this.body,
      required final List<String> recipients,
      required this.type,
      required this.generatedAt,
      this.attachmentPath,
      this.isSent = false,
      this.sentAt})
      : _recipients = recipients,
        super._();

  @override
  final String id;
  @override
  final String subject;
  @override
  final String body;
  final List<String> _recipients;
  @override
  List<String> get recipients {
    if (_recipients is EqualUnmodifiableListView) return _recipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipients);
  }

  @override
  final ReportType type;
  @override
  final DateTime generatedAt;
  @override
  final String? attachmentPath;
  @override
  @JsonKey()
  final bool isSent;
  @override
  final DateTime? sentAt;

  @override
  String toString() {
    return 'EmailReport(id: $id, subject: $subject, body: $body, recipients: $recipients, type: $type, generatedAt: $generatedAt, attachmentPath: $attachmentPath, isSent: $isSent, sentAt: $sentAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality()
                .equals(other._recipients, _recipients) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.attachmentPath, attachmentPath) ||
                other.attachmentPath == attachmentPath) &&
            (identical(other.isSent, isSent) || other.isSent == isSent) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      subject,
      body,
      const DeepCollectionEquality().hash(_recipients),
      type,
      generatedAt,
      attachmentPath,
      isSent,
      sentAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailReportImplCopyWith<_$EmailReportImpl> get copyWith =>
      __$$EmailReportImplCopyWithImpl<_$EmailReportImpl>(this, _$identity);
}

abstract class _EmailReport extends EmailReport {
  const factory _EmailReport(
      {required final String id,
      required final String subject,
      required final String body,
      required final List<String> recipients,
      required final ReportType type,
      required final DateTime generatedAt,
      final String? attachmentPath,
      final bool isSent,
      final DateTime? sentAt}) = _$EmailReportImpl;
  const _EmailReport._() : super._();

  @override
  String get id;
  @override
  String get subject;
  @override
  String get body;
  @override
  List<String> get recipients;
  @override
  ReportType get type;
  @override
  DateTime get generatedAt;
  @override
  String? get attachmentPath;
  @override
  bool get isSent;
  @override
  DateTime? get sentAt;
  @override
  @JsonKey(ignore: true)
  _$$EmailReportImplCopyWith<_$EmailReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EmailConfig {
  String get smtpServer => throw _privateConstructorUsedError;
  int get smtpPort => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool get useSSL => throw _privateConstructorUsedError;
  String? get fromEmail => throw _privateConstructorUsedError;
  String? get fromName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmailConfigCopyWith<EmailConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailConfigCopyWith<$Res> {
  factory $EmailConfigCopyWith(
          EmailConfig value, $Res Function(EmailConfig) then) =
      _$EmailConfigCopyWithImpl<$Res, EmailConfig>;
  @useResult
  $Res call(
      {String smtpServer,
      int smtpPort,
      String username,
      String password,
      bool useSSL,
      String? fromEmail,
      String? fromName});
}

/// @nodoc
class _$EmailConfigCopyWithImpl<$Res, $Val extends EmailConfig>
    implements $EmailConfigCopyWith<$Res> {
  _$EmailConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smtpServer = null,
    Object? smtpPort = null,
    Object? username = null,
    Object? password = null,
    Object? useSSL = null,
    Object? fromEmail = freezed,
    Object? fromName = freezed,
  }) {
    return _then(_value.copyWith(
      smtpServer: null == smtpServer
          ? _value.smtpServer
          : smtpServer // ignore: cast_nullable_to_non_nullable
              as String,
      smtpPort: null == smtpPort
          ? _value.smtpPort
          : smtpPort // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      useSSL: null == useSSL
          ? _value.useSSL
          : useSSL // ignore: cast_nullable_to_non_nullable
              as bool,
      fromEmail: freezed == fromEmail
          ? _value.fromEmail
          : fromEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      fromName: freezed == fromName
          ? _value.fromName
          : fromName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailConfigImplCopyWith<$Res>
    implements $EmailConfigCopyWith<$Res> {
  factory _$$EmailConfigImplCopyWith(
          _$EmailConfigImpl value, $Res Function(_$EmailConfigImpl) then) =
      __$$EmailConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String smtpServer,
      int smtpPort,
      String username,
      String password,
      bool useSSL,
      String? fromEmail,
      String? fromName});
}

/// @nodoc
class __$$EmailConfigImplCopyWithImpl<$Res>
    extends _$EmailConfigCopyWithImpl<$Res, _$EmailConfigImpl>
    implements _$$EmailConfigImplCopyWith<$Res> {
  __$$EmailConfigImplCopyWithImpl(
      _$EmailConfigImpl _value, $Res Function(_$EmailConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smtpServer = null,
    Object? smtpPort = null,
    Object? username = null,
    Object? password = null,
    Object? useSSL = null,
    Object? fromEmail = freezed,
    Object? fromName = freezed,
  }) {
    return _then(_$EmailConfigImpl(
      smtpServer: null == smtpServer
          ? _value.smtpServer
          : smtpServer // ignore: cast_nullable_to_non_nullable
              as String,
      smtpPort: null == smtpPort
          ? _value.smtpPort
          : smtpPort // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      useSSL: null == useSSL
          ? _value.useSSL
          : useSSL // ignore: cast_nullable_to_non_nullable
              as bool,
      fromEmail: freezed == fromEmail
          ? _value.fromEmail
          : fromEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      fromName: freezed == fromName
          ? _value.fromName
          : fromName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$EmailConfigImpl extends _EmailConfig {
  const _$EmailConfigImpl(
      {required this.smtpServer,
      required this.smtpPort,
      required this.username,
      required this.password,
      this.useSSL = true,
      this.fromEmail,
      this.fromName})
      : super._();

  @override
  final String smtpServer;
  @override
  final int smtpPort;
  @override
  final String username;
  @override
  final String password;
  @override
  @JsonKey()
  final bool useSSL;
  @override
  final String? fromEmail;
  @override
  final String? fromName;

  @override
  String toString() {
    return 'EmailConfig(smtpServer: $smtpServer, smtpPort: $smtpPort, username: $username, password: $password, useSSL: $useSSL, fromEmail: $fromEmail, fromName: $fromName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailConfigImpl &&
            (identical(other.smtpServer, smtpServer) ||
                other.smtpServer == smtpServer) &&
            (identical(other.smtpPort, smtpPort) ||
                other.smtpPort == smtpPort) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.useSSL, useSSL) || other.useSSL == useSSL) &&
            (identical(other.fromEmail, fromEmail) ||
                other.fromEmail == fromEmail) &&
            (identical(other.fromName, fromName) ||
                other.fromName == fromName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, smtpServer, smtpPort, username,
      password, useSSL, fromEmail, fromName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailConfigImplCopyWith<_$EmailConfigImpl> get copyWith =>
      __$$EmailConfigImplCopyWithImpl<_$EmailConfigImpl>(this, _$identity);
}

abstract class _EmailConfig extends EmailConfig {
  const factory _EmailConfig(
      {required final String smtpServer,
      required final int smtpPort,
      required final String username,
      required final String password,
      final bool useSSL,
      final String? fromEmail,
      final String? fromName}) = _$EmailConfigImpl;
  const _EmailConfig._() : super._();

  @override
  String get smtpServer;
  @override
  int get smtpPort;
  @override
  String get username;
  @override
  String get password;
  @override
  bool get useSSL;
  @override
  String? get fromEmail;
  @override
  String? get fromName;
  @override
  @JsonKey(ignore: true)
  _$$EmailConfigImplCopyWith<_$EmailConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
