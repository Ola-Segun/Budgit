import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.freezed.dart';

/// Currency entity for multi-currency support
@freezed
class Currency with _$Currency {
  const factory Currency({
    required String code, // USD, EUR, GBP, etc.
    required String name, // US Dollar, Euro, British Pound, etc.
    required String symbol, // $, €, £, etc.
    required String flag, // 🇺🇸, 🇪🇺, 🇬🇧, etc.
    required int decimalPlaces, // Usually 2
    @Default(true) bool isActive,
    @Default(false) bool isBaseCurrency, // For the user's primary currency
  }) = _Currency;

  const Currency._();

  /// Get formatted amount with currency symbol
  String formatAmount(double amount) {
    final formattedAmount = amount.toStringAsFixed(decimalPlaces);
    return '$symbol$formattedAmount';
  }

  /// Get currency display name with flag
  String get displayName => '$flag $name ($code)';

  /// Common currencies
  static const usd = Currency(
    code: 'USD',
    name: 'US Dollar',
    symbol: '\$',
    flag: '🇺🇸',
    decimalPlaces: 2,
  );

  static const eur = Currency(
    code: 'EUR',
    name: 'Euro',
    symbol: '€',
    flag: '🇪🇺',
    decimalPlaces: 2,
  );

  static const gbp = Currency(
    code: 'GBP',
    name: 'British Pound',
    symbol: '£',
    flag: '🇬🇧',
    decimalPlaces: 2,
  );

  static const jpy = Currency(
    code: 'JPY',
    name: 'Japanese Yen',
    symbol: '¥',
    flag: '🇯🇵',
    decimalPlaces: 0,
  );

  static const cad = Currency(
    code: 'CAD',
    name: 'Canadian Dollar',
    symbol: 'C\$',
    flag: '🇨🇦',
    decimalPlaces: 2,
  );

  static const aud = Currency(
    code: 'AUD',
    name: 'Australian Dollar',
    symbol: 'A\$',
    flag: '🇦🇺',
    decimalPlaces: 2,
  );

  static const chf = Currency(
    code: 'CHF',
    name: 'Swiss Franc',
    symbol: 'CHF',
    flag: '🇨🇭',
    decimalPlaces: 2,
  );

  static const cny = Currency(
    code: 'CNY',
    name: 'Chinese Yuan',
    symbol: '¥',
    flag: '🇨🇳',
    decimalPlaces: 2,
  );

  static const sek = Currency(
    code: 'SEK',
    name: 'Swedish Krona',
    symbol: 'kr',
    flag: '🇸🇪',
    decimalPlaces: 2,
  );

  static const nzd = Currency(
    code: 'NZD',
    name: 'New Zealand Dollar',
    symbol: 'NZ\$',
    flag: '🇳🇿',
    decimalPlaces: 2,
  );

  /// List of common currencies
  static const List<Currency> commonCurrencies = [
    usd,
    eur,
    gbp,
    jpy,
    cad,
    aud,
    chf,
    cny,
    sek,
    nzd,
  ];

  /// Get currency by code
  static Currency? fromCode(String code) {
    return commonCurrencies.firstWhere(
      (currency) => currency.code == code,
      orElse: () => usd, // Default to USD
    );
  }
}

/// Exchange rate between two currencies
@freezed
class ExchangeRate with _$ExchangeRate {
  const factory ExchangeRate({
    required String fromCurrency,
    required String toCurrency,
    required double rate,
    required DateTime lastUpdated,
    String? source, // API source like 'fixer.io', 'currencyapi.com'
  }) = _ExchangeRate;

  const ExchangeRate._();

  /// Convert amount using this exchange rate
  double convert(double amount) => amount * rate;

  /// Get inverse rate (toCurrency to fromCurrency)
  double get inverseRate => 1 / rate;

  /// Check if rate is stale (older than 1 day)
  bool get isStale => DateTime.now().difference(lastUpdated).inDays > 1;

  /// Get rate identifier
  String get id => '${fromCurrency}_$toCurrency';
}