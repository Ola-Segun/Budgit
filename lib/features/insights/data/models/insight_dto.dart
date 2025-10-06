import 'package:hive/hive.dart';

import '../../domain/entities/insight.dart';

part 'insight_dto.g.dart';

/// Data Transfer Object for Insight entity
@HiveType(typeId: 9)
class InsightDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String message;

  @HiveField(3)
  late String type; // Store as string

  @HiveField(4)
  late DateTime generatedAt;

  @HiveField(5)
  String? categoryId;

  @HiveField(6)
  String? transactionId;

  @HiveField(7)
  double? amount;

  @HiveField(8)
  double? percentage;

  @HiveField(9)
  String? priority; // Store as string

  @HiveField(10)
  late bool isRead;

  @HiveField(11)
  late bool isArchived;

  @HiveField(12)
  Map<String, dynamic>? metadata;

  /// Default constructor
  InsightDto();

  /// Named constructor for creating from domain entity
  InsightDto.fromDomain(Insight insight) {
    id = insight.id;
    title = insight.title;
    message = insight.message;
    type = insight.type.name;
    generatedAt = insight.generatedAt;
    categoryId = insight.categoryId;
    transactionId = insight.transactionId;
    amount = insight.amount;
    percentage = insight.percentage;
    priority = insight.priority.name;
    isRead = insight.isRead;
    isArchived = insight.isArchived;
    metadata = insight.metadata;
  }

  /// Convert to domain entity
  Insight toDomain() {
    return Insight(
      id: id,
      title: title,
      message: message,
      type: InsightType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => InsightType.recommendation,
      ),
      generatedAt: generatedAt,
      categoryId: categoryId,
      transactionId: transactionId,
      amount: amount,
      percentage: percentage,
      priority: InsightPriority.values.firstWhere(
        (e) => e.name == priority,
        orElse: () => InsightPriority.medium,
      ),
      isRead: isRead,
      isArchived: isArchived,
      metadata: metadata,
    );
  }
}

/// Data Transfer Object for FinancialReport entity
@HiveType(typeId: 10)
class FinancialReportDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late String type; // Store as string

  @HiveField(4)
  late DateTime startDate;

  @HiveField(5)
  late DateTime endDate;

  @HiveField(6)
  late DateTime generatedAt;

  @HiveField(7)
  late Map<String, dynamic> data;

  @HiveField(8)
  late List<String> sections;

  @HiveField(9)
  String? filePath;

  @HiveField(10)
  late bool isExported;

  @HiveField(11)
  Map<String, dynamic>? metadata;

  /// Default constructor
  FinancialReportDto();

  /// Named constructor for creating from domain entity
  FinancialReportDto.fromDomain(FinancialReport report) {
    id = report.id;
    title = report.title;
    description = report.description;
    type = report.type.name;
    startDate = report.startDate;
    endDate = report.endDate;
    generatedAt = report.generatedAt;
    data = report.data;
    sections = report.sections;
    filePath = report.filePath;
    isExported = report.isExported;
    metadata = report.metadata;
  }

  /// Convert to domain entity
  FinancialReport toDomain() {
    return FinancialReport(
      id: id,
      title: title,
      description: description,
      type: FinancialReportType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => FinancialReportType.monthlySummary,
      ),
      startDate: startDate,
      endDate: endDate,
      generatedAt: generatedAt,
      data: data,
      sections: sections,
      filePath: filePath,
      isExported: isExported,
      metadata: metadata,
    );
  }
}