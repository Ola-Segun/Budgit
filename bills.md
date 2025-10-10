# Deep Analysis: Account-Bill Relationship in Flutter Budget App

## 1. Conceptual Relationship Model

### Core Relationship Structure

```
┌─────────────────────────────────────────────────────────────┐
│                   BILL PAYMENT ECOSYSTEM                     │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐                           ┌──────────────┐ │
│  │   ACCOUNT    │ ◄──── pays from ─────────►│     BILL     │ │
│  │              │                           │              │ │
│  │ - Balance    │ ◄─── updates balance      │ - Amount     │ │
│  │ - Type       │                           │ - Due Date   │ │
│  └──────────────┘                           │ - Frequency  │ │
│         │                                    └──────────────┘ │
│         │                                           │         │
│         │ creates                          creates  │         │
│         ▼                                           ▼         │
│  ┌──────────────┐                           ┌──────────────┐ │
│  │ TRANSACTION  │ ◄────── linked to ───────►│BILL PAYMENT │ │
│  │ - Amount     │                           │ - Paid Date  │ │
│  │ - Account    │                           │ - Status     │ │
│  │ - Category   │                           │ - Reference  │ │
│  └──────────────┘                           └──────────────┘ │
│         │                                           │         │
│         │ triggers                         triggers │         │
│         ▼                                           ▼         │
│  ┌──────────────┐                           ┌──────────────┐ │
│  │NOTIFICATION  │                           │  REMINDER    │ │
│  │ - Payment    │                           │ - Due Soon   │ │
│  │   Confirmed  │                           │ - Overdue    │ │
│  └──────────────┘                           └──────────────┘ │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

### Relationship Philosophy

**The account-bill relationship represents recurring financial obligations that must be tracked, predicted, and paid from specific accounts.**

**Key Principles:**
1. **Recurring Nature**: Bills repeat on a schedule (monthly, quarterly, annually)
2. **Predictability**: Bills enable future cash flow planning
3. **Payment Tracking**: Each bill payment creates a transaction
4. **Account Association**: Bills can be linked to specific accounts for auto-payment tracking
5. **Status Management**: Bills have states (unpaid, paid, overdue, upcoming)

---

## 2. Domain Model Design

### Entity Definitions

```dart
// lib/features/bills/domain/entities/bill.dart

@freezed
class Bill with _$Bill {
  const factory Bill({
    required String id,
    required String name,
    required String categoryId,
    required double amount,
    required DateTime dueDate,
    required BillFrequency frequency,
    
    // ═══ ACCOUNT RELATIONSHIP ═══
    String? defaultAccountId,  // Account to pay from
    
    // ═══ BILL DETAILS ═══
    String? description,
    String? payee,
    String? website,
    String? accountNumber,  // Masked: ****1234
    
    // ═══ NOTIFICATION SETTINGS ═══
    @Default(true) bool reminderEnabled,
    @Default(3) int reminderDaysBefore,
    
    // ═══ AUTO-PAY ═══
    @Default(false) bool isAutoPay,
    DateTime? autoPayDate,  // Date when auto-pay processes
    
    // ═══ STATUS ═══
    @Default(true) bool isActive,
    DateTime? lastPaidDate,
    DateTime? nextDueDate,
    
    // ═══ METADATA ═══
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
    Color? color,
    IconData? icon,
  }) = _Bill;
  
  factory Bill.fromJson(Map<String, dynamic> json) =>
      _$BillFromJson(json);
}

enum BillFrequency {
  weekly,
  biweekly,
  monthly,
  quarterly,
  semiannually,
  annually,
  custom
}

// Extension methods for business logic
extension BillExtension on Bill {
  /// Is this bill due soon?
  bool isDueSoon([int daysThreshold = 7]) {
    if (nextDueDate == null) return false;
    final now = DateTime.now();
    final difference = nextDueDate!.difference(now).inDays;
    return difference >= 0 && difference <= daysThreshold;
  }
  
  /// Is this bill overdue?
  bool get isOverdue {
    if (nextDueDate == null) return false;
    return DateTime.now().isAfter(nextDueDate!);
  }
  
  /// Days until due (negative if overdue)
  int get daysUntilDue {
    if (nextDueDate == null) return 0;
    return nextDueDate!.difference(DateTime.now()).inDays;
  }
  
  /// Calculate next due date based on frequency
  DateTime calculateNextDueDate(DateTime fromDate) {
    switch (frequency) {
      case BillFrequency.weekly:
        return fromDate.add(const Duration(days: 7));
      case BillFrequency.biweekly:
        return fromDate.add(const Duration(days: 14));
      case BillFrequency.monthly:
        return DateTime(
          fromDate.year,
          fromDate.month + 1,
          fromDate.day,
        );
      case BillFrequency.quarterly:
        return DateTime(
          fromDate.year,
          fromDate.month + 3,
          fromDate.day,
        );
      case BillFrequency.semiannually:
        return DateTime(
          fromDate.year,
          fromDate.month + 6,
          fromDate.day,
        );
      case BillFrequency.annually:
        return DateTime(
          fromDate.year + 1,
          fromDate.month,
          fromDate.day,
        );
      case BillFrequency.custom:
        return fromDate;  // Handled separately
    }
  }
  
  /// Annual cost of this bill
  double get annualCost {
    switch (frequency) {
      case BillFrequency.weekly:
        return amount * 52;
      case BillFrequency.biweekly:
        return amount * 26;
      case BillFrequency.monthly:
        return amount * 12;
      case BillFrequency.quarterly:
        return amount * 4;
      case BillFrequency.semiannually:
        return amount * 2;
      case BillFrequency.annually:
        return amount;
      case BillFrequency.custom:
        return amount * 12;  // Estimate
    }
  }
  
  /// Status indicator
  BillStatus get status {
    if (isOverdue) return BillStatus.overdue;
    if (isDueSoon(3)) return BillStatus.dueSoon;
    if (isDueSoon(7)) return BillStatus.upcoming;
    return BillStatus.scheduled;
  }
}

enum BillStatus {
  scheduled,   // Normal, not due yet
  upcoming,    // Due within 7 days
  dueSoon,     // Due within 3 days
  overdue      // Past due date
}
```

```dart
// lib/features/bills/domain/entities/bill_payment.dart

@freezed
class BillPayment with _$BillPayment {
  const factory BillPayment({
    required String id,
    required String billId,
    required double amountPaid,
    required DateTime paidDate,
    required DateTime dueDate,
    
    // ═══ ACCOUNT & TRANSACTION LINK ═══
    String? accountId,         // Account paid from
    String? transactionId,     // Associated transaction
    
    // ═══ PAYMENT DETAILS ═══
    PaymentMethod? paymentMethod,
    String? confirmationNumber,
    String? notes,
    
    // ═══ STATUS ═══
    PaymentStatus status,
    @Default(false) bool wasLate,
    double? lateFee,
    
    // ═══ METADATA ═══
    DateTime? createdAt,
  }) = _BillPayment;
  
  factory BillPayment.fromJson(Map<String, dynamic> json) =>
      _$BillPaymentFromJson(json);
}

enum PaymentMethod {
  cash,
  bankTransfer,
  creditCard,
  debitCard,
  check,
  autopay,
  other
}

enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled
}

extension BillPaymentExtension on BillPayment {
  bool get isPaid => status == PaymentStatus.completed;
  
  bool get isFailed => status == PaymentStatus.failed;
  
  /// Total amount including fees
  double get totalAmount => amountPaid + (lateFee ?? 0);
}
```

---

## 3. Relationship Types & Scenarios

### A. One-to-Many: Account → Bills (Optional Link)

```
Account (1) ───── default for ─────► Bill (Many)
```

**Example:**
- "Checking Account" is default for Netflix, Electricity, Internet bills
- "Credit Card" is default for subscription services
- Bills can also have NO default account (manual selection each time)

**Use Cases:**
1. **Auto-pay tracking**: Know which account bills are automatically deducted from
2. **Cash flow planning**: Predict which accounts need sufficient balance
3. **Account statement reconciliation**: Match bill payments with account transactions

### B. One-to-Many: Bill → Bill Payments (Payment History)

```
Bill (1) ────── payment history ──────► BillPayment (Many)
```

**Example:**
- "Netflix Subscription" has 24 payment records (2 years)
- "Electricity Bill" has 36 payment records (3 years)
- Each payment represents one occurrence of bill being paid

**Use Cases:**
1. **Payment tracking**: See complete history of when bill was paid
2. **Amount variation analysis**: Track how variable bills change over time
3. **On-time payment rate**: Calculate percentage of late payments

### C. One-to-One: Bill Payment → Transaction (Payment Evidence)

```
BillPayment (1) ◄──── creates ────► Transaction (1)
```

**Example:**
- Marking Netflix bill as paid creates a $15.99 expense transaction
- Transaction has reference back to bill payment
- Bill payment has reference to transaction

**Use Cases:**
1. **Balance impact**: Bill payments affect account balance through transactions
2. **Expense categorization**: Bill transactions are auto-categorized
3. **Audit trail**: Link payment record to actual money movement

---

## 4. Bill Payment Flow & Account Integration

### Scenario A: Manual Bill Payment

```
┌─────────────────────────────────────────────────────────┐
│  User marks "Netflix" bill as paid                      │
│  - Bill: Netflix ($15.99/month)                          │
│  - Due Date: October 10, 2025                            │
│  - Account: Checking Account                             │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 1. Validate Payment                                       │
│    ✓ Bill exists and is active                           │
│    ✓ Amount is positive                                  │
│    ✓ Account exists (if specified)                       │
│    ✓ Account has sufficient balance (optional check)     │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 2. Create Bill Payment Record                             │
│    - id: "bp_123"                                         │
│    - billId: "bill_netflix"                               │
│    - amountPaid: 15.99                                    │
│    - paidDate: 2025-10-10                                 │
│    - accountId: "checking_001"                            │
│    - status: completed                                    │
│    - wasLate: false                                       │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 3. Create Associated Transaction                          │
│    - id: "tx_456"                                         │
│    - amount: 15.99                                        │
│    - type: expense                                        │
│    - categoryId: "subscriptions"                          │
│    - accountId: "checking_001"                            │
│    - description: "Netflix - Bill Payment"                │
│    - billPaymentId: "bp_123"  ← LINK                      │
│    - date: 2025-10-10                                     │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 4. Update Account Balance                                 │
│    - Get Account "checking_001"                           │
│    - Current balance: $1000.00                            │
│    - Delta: -$15.99 (expense)                             │
│    - New balance: $984.01                                 │
│    - Save account                                         │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 5. Update Bill Record                                     │
│    - lastPaidDate: 2025-10-10                             │
│    - nextDueDate: 2025-11-10 (calculated from frequency) │
│    - Save bill                                            │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 6. Link Payment to Transaction                            │
│    - Update BillPayment:                                  │
│      transactionId: "tx_456"  ← BIDIRECTIONAL LINK       │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 7. Trigger Side Effects                                   │
│    - Cancel "Bill Due" notification                       │
│    - Send "Payment Confirmed" notification                │
│    - Update budget (if applicable)                        │
│    - Log analytics event                                  │
└──────────────────────────────────────────────────────────┘
```

### Scenario B: Auto-Pay Bill Detection

```
┌─────────────────────────────────────────────────────────┐
│  User adds transaction: $15.99 expense from checking    │
│  Description: "NETFLIX.COM"                              │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 1. Create Transaction (normal flow)                       │
│    - Transaction saved                                    │
│    - Account balance updated                              │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 2. Auto-Match Bill Detection                              │
│    - Search active bills matching:                        │
│      * Similar amount ($15.99 ± 10%)                      │
│      * Similar description (contains "netflix")           │
│      * Due date near transaction date (± 5 days)          │
│      * Same account (if bill has default account)         │
│    - MATCH FOUND: Netflix Bill                            │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 3. Prompt User for Confirmation                           │
│    Dialog: "Is this your Netflix bill payment?"          │
│    - [Yes, mark as paid]                                  │
│    - [No, ignore]                                         │
│    - [Yes, but different bill]                            │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼ (if YES)
┌──────────────────────────────────────────────────────────┐
│ 4. Create Bill Payment Record                             │
│    - Link existing transaction to bill                    │
│    - Create BillPayment record                            │
│    - Update bill's lastPaidDate and nextDueDate           │
└──────────────────────────────────────────────────────────┘
```

### Scenario C: Bill Payment Reversal (Refund/Correction)

```
┌─────────────────────────────────────────────────────────┐
│  User reverses Netflix payment (payment failed/refunded) │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 1. Get Bill Payment Details                               │
│    - billPaymentId: "bp_123"                              │
│    - transactionId: "tx_456"                              │
│    - billId: "bill_netflix"                               │
│    - accountId: "checking_001"                            │
│    - amountPaid: 15.99                                    │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 2. Delete/Cancel Bill Payment Record                      │
│    - Mark status as "cancelled"                           │
│    - OR delete record completely                          │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 3. Handle Associated Transaction                          │
│    Option A: Delete transaction                           │
│    - Reverse account balance (-$15.99 becomes +$15.99)    │
│                                                            │
│    Option B: Keep transaction, mark as refunded           │
│    - Create refund transaction (+$15.99)                  │
│    - Link both transactions                               │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 4. Revert Bill Record                                     │
│    - lastPaidDate: (previous payment date or null)        │
│    - nextDueDate: (original due date)                     │
│    - Bill returns to "unpaid" status                      │
└──────────────────────────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────┐
│ 5. Re-trigger Reminders                                   │
│    - Schedule "Bill Due" notification again               │
│    - Update UI to show bill as unpaid                     │
└──────────────────────────────────────────────────────────┘
```

---

## 5. Data Layer Implementation

### Database Schema

```dart
// lib/features/bills/data/models/bill_dto.dart

@HiveType(typeId: 3)  // Use unique typeId
class BillDTO extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String name;
  
  @HiveField(2)
  String categoryId;
  
  @HiveField(3)
  double amount;
  
  @HiveField(4)
  int dueDate;  // millisecondsSinceEpoch
  
  @HiveField(5)
  String frequency;  // 'weekly', 'monthly', etc.
  
  // ═══ ACCOUNT RELATIONSHIP ═══
  @HiveField(6)
  String? defaultAccountId;
  
  // ═══ DETAILS ═══
  @HiveField(7)
  String? description;
  
  @HiveField(8)
  String? payee;
  
  @HiveField(9)
  String? website;
  
  // ═══ NOTIFICATIONS ═══
  @HiveField(10)
  bool reminderEnabled;
  
  @HiveField(11)
  int reminderDaysBefore;
  
  // ═══ AUTO-PAY ═══
  @HiveField(12)
  bool isAutoPay;
  
  @HiveField(13)
  int? autoPayDate;
  
  // ═══ STATUS ═══
  @HiveField(14)
  bool isActive;
  
  @HiveField(15)
  int? lastPaidDate;
  
  @HiveField(16)
  int? nextDueDate;
  
  // ═══ METADATA ═══
  @HiveField(17)
  int? createdAt;
  
  @HiveField(18)
  int? updatedAt;
  
  @HiveField(19)
  String? notes;
  
  BillDTO({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.amount,
    required this.dueDate,
    required this.frequency,
    this.defaultAccountId,
    this.description,
    this.payee,
    this.website,
    this.reminderEnabled = true,
    this.reminderDaysBefore = 3,
    this.isAutoPay = false,
    this.autoPayDate,
    this.isActive = true,
    this.lastPaidDate,
    this.nextDueDate,
    this.createdAt,
    this.updatedAt,
    this.notes,
  });
}
```

```dart
// lib/features/bills/data/models/bill_payment_dto.dart

@HiveType(typeId: 4)
class BillPaymentDTO extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String billId;
  
  @HiveField(2)
  double amountPaid;
  
  @HiveField(3)
  int paidDate;
  
  @HiveField(4)
  int dueDate;
  
  // ═══ LINKS ═══
  @HiveField(5)
  String? accountId;
  
  @HiveField(6)
  String? transactionId;
  
  // ═══ PAYMENT DETAILS ═══
  @HiveField(7)
  String? paymentMethod;
  
  @HiveField(8)
  String? confirmationNumber;
  
  @HiveField(9)
  String? notes;
  
  // ═══ STATUS ═══
  @HiveField(10)
  String status;  // 'completed', 'pending', etc.
  
  @HiveField(11)
  bool wasLate;
  
  @HiveField(12)
  double? lateFee;
  
  @HiveField(13)
  int? createdAt;
  
  BillPaymentDTO({
    required this.id,
    required this.billId,
    required this.amountPaid,
    required this.paidDate,
    required this.dueDate,
    this.accountId,
    this.transactionId,
    this.paymentMethod,
    this.confirmationNumber,
    this.notes,
    required this.status,
    this.wasLate = false,
    this.lateFee,
    this.createdAt,
  });
}
```

### Enhanced Transaction DTO

```dart
// lib/features/transactions/data/models/transaction_dto.dart
// ADD these fields to existing TransactionDTO

@HiveType(typeId: 0)
class TransactionDTO extends HiveObject {
  // ... existing fields ...
  
  // ═══ BILL PAYMENT LINK ═══
  @HiveField(18)  // Use next available field number
  String? billPaymentId;
  
  @HiveField(19)
  bool isBillPayment;
  
  // ... existing constructor with new fields ...
}
```

### Repository Implementation

```dart
// lib/features/bills/data/repositories/bill_repository_impl.dart

class BillRepositoryImpl implements BillRepository {
  final Box<BillDTO> _billBox;
  final Box<BillPaymentDTO> _paymentBox;
  
  BillRepositoryImpl(this._billBox, this._paymentBox);
  
  @override
  Future<Result<List<Bill>>> getAll() async {
    try {
      final dtos = _billBox.values.toList();
      final bills = dtos.map(BillMapper.toDomain).toList();
      return Result.success(bills);
    } catch (e) {
      return Result.error(Failure.cache('Failed to fetch bills: $e'));
    }
  }
  
  @override
  Future<Result<List<Bill>>> getByAccount(String accountId) async {
    try {
      final dtos = _billBox.values
          .where((dto) => dto.defaultAccountId == accountId)
          .toList();
      
      final bills = dtos.map(BillMapper.toDomain).toList();
      return Result.success(bills);
    } catch (e) {
      return Result.error(Failure.cache('Failed to fetch bills: $e'));
    }
  }
  
  @override
  Future<Result<List<Bill>>> getUpcoming({int days = 30}) async {
    try {
      final now = DateTime.now();
      final future = now.add(Duration(days: days));
      final nowMs = now.millisecondsSinceEpoch;
      final futureMs = future.millisecondsSinceEpoch;
      
      final dtos = _billBox.values
          .where((dto) =>
              dto.isActive &&
              dto.nextDueDate != null &&
              dto.nextDueDate! >= nowMs &&
              dto.nextDueDate! <= futureMs)
          .toList();
      
      final bills = dtos.map(BillMapper.toDomain).toList();
      
      // Sort by due date
      bills.sort((a, b) => a.nextDueDate!.compareTo(b.nextDueDate!));
      
      return Result.success(bills);
    } catch (e) {
      return Result.error(Failure.cache('Failed to fetch upcoming bills: $e'));
    }
  }
  
  @override
  Future<Result<List<Bill>>> getOverdue() async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch;
      
      final dtos = _billBox.values
          .where((dto) =>
              dto.isActive &&
              dto.nextDueDate != null &&
              dto.nextDueDate! < now)
          .toList();
      
      final bills = dtos.map(BillMapper.toDomain).toList();
      return Result.success(bills);
    } catch (e) {
      return Result.error(Failure.cache('Failed to fetch overdue bills: $e'));
    }
  }
  
  @override
  Future<Result<List<BillPayment>>> getPaymentHistory(String billId) async {
    try {
      final dtos = _paymentBox.values
          .where((dto) => dto.billId == billId)
          .toList()
          ..sort((a, b) => b.paidDate.compareTo(a.paidDate)); // Recent first
      
      final payments = dtos.map(BillPaymentMapper.toDomain).toList();
      return Result.success(payments);
    } catch (e) {
      return Result.error(Failure.cache('Failed to fetch payment history: $e'));
    }
  }
  
  @override
  Future<Result<BillStatistics>> getStatistics() async {
    try {
      final bills = await getAll();
      
      return bills.when(
        success: (billList) {
          final activeBills = billList.where((b) => b.isActive);
          
          final totalMonthly = activeBills.fold<double>(
            0,
            (sum, bill) => sum + _calculateMonthlyAmount(bill),
          );
          
          final totalAnnual = activeBills.fold<double>(
            0,
            (sum, bill) => sum + bill.annualCost,
          );
          
          final upcomingCount = activeBills.where((b) => b.isDueSoon(7)).length;
          final overdueCount = activeBills.where((b) => b.isOverdue).length;
          
          return Result.success(BillStatistics(
            totalBills: activeBills.length,
            totalMonthlyAmount: totalMonthly,
            totalAnnualAmount: totalAnnual,
            upcomingBillsCount: upcomingCount,
            overdueBillsCount: overdueCount,
          ));
        },
        error: (failure) => Result.error(failure),
      );
    } catch (e) {
      return Result.error(Failure.unknown(e.toString()));
    }
  }
  
  double _calculateMonthlyAmount(Bill bill) {
    switch (bill.frequency) {
      case BillFrequency.weekly:
        return bill.amount * 52 / 12;
      case BillFrequency.biweekly:
        return bill.amount * 26 / 12;
      case BillFrequency.monthly:
        return bill.amount;
      case BillFrequency.quarterly:
        return bill.amount / 3;
      case BillFrequency.semiannually:
        return bill.amount / 6;
      case BillFrequency.annually:
        return bill.amount / 12;
      case BillFrequency.custom:
        return bill.amount;
    }
  }
}

@freezed
class BillStatistics with _$BillStatistics {
  const factory BillStatistics({
    required int totalBills,
    required double totalMonthlyAmount,
    required double totalAnnualAmount,
    required int upcomingBillsCount,
    required int overdueBillsCount,
  }) = _BillStatistics;
}
```

---

## 6. Use Case Implementations

### A. Mark Bill as Paid (with Transaction Creation)

```dart
// lib/features/bills/domain/usecases/mark_bill_as_paid.dart

class MarkBillAsPaid {
  final BillRepository _billRepository;
  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;
  final NotificationService _notificationService;
  final Logger _logger;
  
  MarkBillAsPaid(
    this._billRepository,
    this._transactionRepository,
    this._accountRepository,
    this._notificationService,
    this._logger,
  );
  
  Future<Result<BillPayment>> call({
    required String billId,
    required DateTime paidDate,
    String? accountId,
    double? actualAmount,  // If different from bill amount
    PaymentMethod? paymentMethod,
    String?