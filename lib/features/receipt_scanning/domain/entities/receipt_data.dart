import 'package:freezed_annotation/freezed_annotation.dart';

part 'receipt_data.freezed.dart';

/// Domain entity representing extracted receipt data
@freezed
class ReceiptData with _$ReceiptData {
  const factory ReceiptData({
    /// Merchant/store name
    required String merchant,

    /// Total amount from the receipt
    required double amount,

    /// Date of the transaction
    required DateTime date,

    /// List of items purchased (initially mock data)
    required List<ReceiptItem> items,

    /// Suggested category based on merchant
    String? suggestedCategory,

    /// Receipt image path
    String? imagePath,
  }) = _ReceiptData;

  const ReceiptData._();

  /// Creates mock receipt data for development/testing
  factory ReceiptData.mock() {
    return ReceiptData(
      merchant: 'Grocery Store',
      amount: 45.67,
      date: DateTime.now(),
      items: [
        ReceiptItem(name: 'Milk', quantity: 1, price: 3.99),
        ReceiptItem(name: 'Bread', quantity: 1, price: 2.49),
        ReceiptItem(name: 'Apples', quantity: 6, price: 5.94),
        ReceiptItem(name: 'Chicken Breast', quantity: 2, price: 12.98),
        ReceiptItem(name: 'Pasta', quantity: 1, price: 1.99),
        ReceiptItem(name: 'Cheese', quantity: 1, price: 4.28),
      ],
      suggestedCategory: 'food',
    );
  }
}

/// Individual item from a receipt
@freezed
class ReceiptItem with _$ReceiptItem {
  const factory ReceiptItem({
    required String name,
    required int quantity,
    required double price,
  }) = _ReceiptItem;

  const ReceiptItem._();

  /// Total price for this item (quantity * price)
  double get total => quantity * price;
}