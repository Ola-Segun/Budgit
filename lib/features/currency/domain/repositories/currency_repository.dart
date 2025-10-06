import '../../../../core/error/result.dart';
import '../entities/currency.dart';
import '../entities/currency.dart' as currency_entities;

abstract class CurrencyRepository {
  /// Get all available currencies
  Future<Result<List<Currency>>> getAllCurrencies();

  /// Get currency by code
  Future<Result<Currency?>> getCurrencyByCode(String code);

  /// Get user's base currency
  Future<Result<Currency?>> getBaseCurrency();

  /// Set user's base currency
  Future<Result<void>> setBaseCurrency(String currencyCode);

  /// Get exchange rate between two currencies
  Future<Result<double?>> getExchangeRate(String fromCurrency, String toCurrency);

  /// Convert amount from one currency to another
  Future<Result<double>> convertAmount(double amount, String fromCurrency, String toCurrency);

  /// Update exchange rates (from external API)
  Future<Result<void>> updateExchangeRates();

  /// Get supported currencies for the app
  Future<Result<List<Currency>>> getSupportedCurrencies();
}