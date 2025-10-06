import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../entities/currency.dart';
import '../repositories/currency_repository.dart';

/// Use case for converting amounts between currencies
class ConvertCurrency {
  const ConvertCurrency(this._repository);

  final CurrencyRepository _repository;

  /// Execute the use case
  Future<Result<double>> call({
    required double amount,
    required String fromCurrency,
    required String toCurrency,
  }) async {
    try {
      // Validate input
      final validationResult = _validateInput(amount, fromCurrency, toCurrency);
      if (validationResult.isError) {
        return validationResult;
      }

      // If same currency, return original amount
      if (fromCurrency == toCurrency) {
        return Result.success(amount);
      }

      // Convert using repository
      final result = await _repository.convertAmount(amount, fromCurrency, toCurrency);
      return result;
    } catch (e) {
      return Result.error(Failure.unknown('Failed to convert currency: $e'));
    }
  }

  /// Validate input parameters
  Result<double> _validateInput(double amount, String fromCurrency, String toCurrency) {
    if (amount < 0) {
      return Result.error(Failure.validation(
        'Amount cannot be negative',
        {'amount': 'Amount must be positive'},
      ));
    }

    if (fromCurrency.trim().isEmpty) {
      return Result.error(Failure.validation(
        'From currency is required',
        {'fromCurrency': 'From currency is required'},
      ));
    }

    if (toCurrency.trim().isEmpty) {
      return Result.error(Failure.validation(
        'To currency is required',
        {'toCurrency': 'To currency is required'},
      ));
    }

    return Result.success(amount); // Dummy success for validation
  }
}