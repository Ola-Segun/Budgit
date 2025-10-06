import 'package:hive/hive.dart';

import '../../domain/entities/bill.dart';

part 'bill_dto.g.dart';

/// Data Transfer Object for Bill entity
/// Used for Hive storage - never expose domain entities directly to storage
@HiveType(typeId: 6)
class BillDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late double amount;

  @HiveField(3)
  late DateTime dueDate;

  @HiveField(4)
  late String frequency; // Store as string for Hive compatibility

  @HiveField(5)
  late String categoryId;

  @HiveField(6)
  String? description;

  @HiveField(7)
  String? payee;

  @HiveField(8)
  String? accountId;

  @HiveField(9)
  late bool isAutoPay;

  @HiveField(10)
  late bool isPaid;

  @HiveField(11)
  DateTime? lastPaidDate;

  @HiveField(12)
  DateTime? nextDueDate;

  @HiveField(13)
  String? website;

  @HiveField(14)
  String? notes;

  @HiveField(15)
  late String cancellationDifficulty; // Store as string

  @HiveField(16)
  DateTime? lastPriceIncrease;

  @HiveField(17)
  List<BillPaymentDto>? paymentHistory;

  /// Default constructor
  BillDto();

  /// Named constructor for creating from domain entity
  BillDto.fromDomain(Bill bill) {
    id = bill.id;
    name = bill.name;
    amount = bill.amount;
    dueDate = bill.dueDate;
    frequency = bill.frequency.name; // Convert enum to string
    categoryId = bill.categoryId;
    description = bill.description;
    payee = bill.payee;
    accountId = bill.accountId;
    isAutoPay = bill.isAutoPay;
    isPaid = bill.isPaid;
    lastPaidDate = bill.lastPaidDate;
    nextDueDate = bill.nextDueDate;
    website = bill.website;
    notes = bill.notes;
    cancellationDifficulty = bill.cancellationDifficulty.name; // Convert enum to string
    lastPriceIncrease = bill.lastPriceIncrease;
    paymentHistory = bill.paymentHistory.map((payment) => BillPaymentDto.fromDomain(payment)).toList();
  }

  /// Convert to domain entity
  Bill toDomain() {
    return Bill(
      id: id,
      name: name,
      amount: amount,
      dueDate: dueDate,
      frequency: BillFrequency.values.firstWhere(
        (e) => e.name == frequency,
        orElse: () => BillFrequency.monthly, // Default fallback
      ),
      categoryId: categoryId,
      description: description,
      payee: payee,
      accountId: accountId,
      isAutoPay: isAutoPay,
      isPaid: isPaid,
      lastPaidDate: lastPaidDate,
      nextDueDate: nextDueDate,
      website: website,
      notes: notes,
      cancellationDifficulty: BillDifficulty.values.firstWhere(
        (e) => e.name == cancellationDifficulty,
        orElse: () => BillDifficulty.easy, // Default fallback
      ),
      lastPriceIncrease: lastPriceIncrease,
      paymentHistory: paymentHistory?.map((dto) => dto.toDomain()).toList() ?? [],
    );
  }
}

/// Data Transfer Object for BillPayment entity
@HiveType(typeId: 7)
class BillPaymentDto extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late DateTime paymentDate;

  @HiveField(3)
  String? transactionId;

  @HiveField(4)
  String? notes;

  @HiveField(5)
  late String method; // Store as string for Hive compatibility

  /// Default constructor
  BillPaymentDto();

  /// Named constructor for creating from domain entity
  BillPaymentDto.fromDomain(BillPayment payment) {
    id = payment.id;
    amount = payment.amount;
    paymentDate = payment.paymentDate;
    transactionId = payment.transactionId;
    notes = payment.notes;
    method = payment.method.name; // Convert enum to string
  }

  /// Convert to domain entity
  BillPayment toDomain() {
    return BillPayment(
      id: id,
      amount: amount,
      paymentDate: paymentDate,
      transactionId: transactionId,
      notes: notes,
      method: PaymentMethod.values.firstWhere(
        (e) => e.name == method,
        orElse: () => PaymentMethod.other, // Default fallback
      ),
    );
  }
}