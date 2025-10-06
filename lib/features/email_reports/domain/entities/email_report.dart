import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_report.freezed.dart';

/// Email report entity
@freezed
class EmailReport with _$EmailReport {
  const factory EmailReport({
    required String id,
    required String subject,
    required String body,
    required List<String> recipients,
    required ReportType type,
    required DateTime generatedAt,
    String? attachmentPath,
    @Default(false) bool isSent,
    DateTime? sentAt,
  }) = _EmailReport;

  const EmailReport._();
}

/// Report type enumeration
enum ReportType {
  monthlySummary('Monthly Summary'),
  budgetReport('Budget Report'),
  transactionHistory('Transaction History'),
  billReminders('Bill Reminders'),
  custom('Custom');

  const ReportType(this.displayName);

  final String displayName;
}

/// Email configuration
@freezed
class EmailConfig with _$EmailConfig {
  const factory EmailConfig({
    required String smtpServer,
    required int smtpPort,
    required String username,
    required String password,
    @Default(true) bool useSSL,
    String? fromEmail,
    String? fromName,
  }) = _EmailConfig;

  const EmailConfig._();
}