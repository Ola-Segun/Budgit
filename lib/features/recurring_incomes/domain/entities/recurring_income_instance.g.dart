// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_income_instance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecurringIncomeInstanceImpl _$$RecurringIncomeInstanceImplFromJson(
        Map<String, dynamic> json) =>
    _$RecurringIncomeInstanceImpl(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      receivedDate: DateTime.parse(json['receivedDate'] as String),
      transactionId: json['transactionId'] as String?,
      notes: json['notes'] as String?,
      accountId: json['accountId'] as String?,
    );

Map<String, dynamic> _$$RecurringIncomeInstanceImplToJson(
        _$RecurringIncomeInstanceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'receivedDate': instance.receivedDate.toIso8601String(),
      'transactionId': instance.transactionId,
      'notes': instance.notes,
      'accountId': instance.accountId,
    };
