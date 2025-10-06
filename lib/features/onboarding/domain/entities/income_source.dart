import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_source.freezed.dart';

/// Income source entity for onboarding
@freezed
class IncomeSource with _$IncomeSource {
  const factory IncomeSource({
    required String id,
    required String name,
    required double amount,
    required PayFrequency frequency,
    String? description,
  }) = _IncomeSource;

  const IncomeSource._();

  /// Calculate monthly income based on frequency
  double get monthlyAmount {
    switch (frequency) {
      case PayFrequency.weekly:
        return amount * 52 / 12;
      case PayFrequency.biWeekly:
        return amount * 26 / 12;
      case PayFrequency.monthly:
        return amount;
      case PayFrequency.annually:
        return amount / 12;
    }
  }

  /// Validate income source
  bool get isValid => name.trim().isNotEmpty && amount > 0;
}

/// Pay frequency enumeration
enum PayFrequency {
  weekly('Weekly'),
  biWeekly('Bi-Weekly'),
  monthly('Monthly'),
  annually('Annually');

  const PayFrequency(this.displayName);

  final String displayName;
}