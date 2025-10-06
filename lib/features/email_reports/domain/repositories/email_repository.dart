import '../../../../core/error/result.dart';
import '../entities/email_report.dart';

/// Repository interface for email operations
abstract class EmailRepository {
  /// Generate PDF report
  Future<Result<String>> generatePdfReport(ReportType type, DateTime startDate, DateTime endDate);

  /// Send email with attachment
  Future<Result<void>> sendEmail(EmailReport report);

  /// Get email configuration
  Future<Result<EmailConfig>> getEmailConfig();

  /// Save email configuration
  Future<Result<void>> saveEmailConfig(EmailConfig config);

  /// Test email configuration
  Future<Result<bool>> testEmailConfig(EmailConfig config);
}