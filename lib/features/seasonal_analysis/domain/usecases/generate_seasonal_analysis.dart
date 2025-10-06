import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/repositories/transaction_repository.dart';
import '../entities/seasonal_analysis.dart';

/// Use case for generating seasonal analysis
class GenerateSeasonalAnalysis {
  const GenerateSeasonalAnalysis(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  /// Execute the use case
  Future<Result<SeasonalAnalysis>> call({
    required String userId,
    required AnalysisPeriod period,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      // Calculate date range
      final dateRange = _calculateDateRange(period, startDate, endDate);

      // Get transactions for the period
      final transactionsResult = await _transactionRepository.getByDateRange(
        dateRange.start,
        dateRange.end,
      );

      if (transactionsResult.isError) {
        return Result.error(transactionsResult.failureOrNull!);
      }

      final transactions = transactionsResult.dataOrNull!;

      // Generate analysis
      final analysis = await _generateAnalysis(
        userId,
        period,
        dateRange.start,
        dateRange.end,
        transactions,
      );

      return Result.success(analysis);
    } catch (e) {
      return Result.error(Failure.unknown('Failed to generate seasonal analysis: $e'));
    }
  }

  /// Calculate date range for analysis
  ({DateTime start, DateTime end}) _calculateDateRange(
    AnalysisPeriod period,
    DateTime? startDate,
    DateTime? endDate,
  ) {
    final now = DateTime.now();

    if (startDate != null && endDate != null) {
      return (start: startDate, end: endDate);
    }

    switch (period) {
      case AnalysisPeriod.month:
        final start = DateTime(now.year, now.month, 1);
        final end = DateTime(now.year, now.month + 1, 0);
        return (start: start, end: end);

      case AnalysisPeriod.quarter:
        final quarterStartMonth = ((now.month - 1) ~/ 3) * 3 + 1;
        final start = DateTime(now.year, quarterStartMonth, 1);
        final end = DateTime(now.year, quarterStartMonth + 3, 0);
        return (start: start, end: end);

      case AnalysisPeriod.year:
        final start = DateTime(now.year, 1, 1);
        final end = DateTime(now.year, 12, 31);
        return (start: start, end: end);
    }
  }

  /// Generate seasonal analysis from transactions
  Future<SeasonalAnalysis> _generateAnalysis(
    String userId,
    AnalysisPeriod period,
    DateTime startDate,
    DateTime endDate,
    List<Transaction> transactions,
  ) async {
    // Group transactions by category
    final categoryGroups = <String, List<Transaction>>{};
    for (final transaction in transactions) {
      if (transaction.isExpense) {
        categoryGroups.putIfAbsent(transaction.categoryId, () => []).add(transaction);
      }
    }

    // Generate category spending data
    final categorySpending = <CategorySpending>[];
    for (final entry in categoryGroups.entries) {
      final categoryTransactions = entry.value;
      final totalAmount = categoryTransactions.fold(0.0, (sum, t) => sum + t.amount);
      final transactionCount = categoryTransactions.length;
      final averageAmount = totalAmount / transactionCount;

      // Generate monthly breakdown
      final monthlyBreakdown = _generateMonthlyBreakdown(categoryTransactions, startDate, endDate);

      categorySpending.add(CategorySpending(
        categoryId: entry.key,
        categoryName: 'Category ${entry.key}', // TODO: Get actual category name
        totalAmount: totalAmount,
        transactionCount: transactionCount,
        averageAmount: averageAmount,
        monthlyBreakdown: monthlyBreakdown,
      ));
    }

    // Generate monthly trends
    final monthlyTrends = _generateMonthlyTrends(categorySpending, period);

    // Generate insights and recommendations
    final insights = _generateInsights(categorySpending, monthlyTrends);

    return SeasonalAnalysis(
      id: _generateAnalysisId(),
      userId: userId,
      period: period,
      startDate: startDate,
      endDate: endDate,
      categorySpending: categorySpending,
      monthlyTrends: monthlyTrends,
      insights: insights,
      generatedAt: DateTime.now(),
    );
  }

  /// Generate monthly breakdown for a category
  List<MonthlySpending> _generateMonthlyBreakdown(
    List<Transaction> transactions,
    DateTime startDate,
    DateTime endDate,
  ) {
    final monthlyData = <String, List<Transaction>>{};

    for (final transaction in transactions) {
      final key = '${transaction.date.year}-${transaction.date.month.toString().padLeft(2, '0')}';
      monthlyData.putIfAbsent(key, () => []).add(transaction);
    }

    final breakdown = <MonthlySpending>[];
    var current = DateTime(startDate.year, startDate.month, 1);

    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      final key = '${current.year}-${current.month.toString().padLeft(2, '0')}';
      final monthTransactions = monthlyData[key] ?? [];

      final totalAmount = monthTransactions.fold(0.0, (sum, t) => sum + t.amount);

      breakdown.add(MonthlySpending(
        year: current.year,
        month: current.month,
        totalAmount: totalAmount,
        transactionCount: monthTransactions.length,
      ));

      current = DateTime(current.year, current.month + 1, 1);
    }

    return breakdown;
  }

  /// Generate monthly trends
  List<MonthlyTrend> _generateMonthlyTrends(
    List<CategorySpending> categorySpending,
    AnalysisPeriod period,
  ) {
    // Simplified trend analysis - in a real app this would be more sophisticated
    final trends = <MonthlyTrend>[];

    for (var month = 1; month <= 12; month++) {
      final monthlyAmounts = categorySpending
          .expand((category) => category.monthlyBreakdown)
          .where((monthly) => monthly.month == month)
          .map((monthly) => monthly.totalAmount)
          .toList();

      if (monthlyAmounts.isNotEmpty) {
        final average = monthlyAmounts.reduce((a, b) => a + b) / monthlyAmounts.length;
        final median = _calculateMedian(monthlyAmounts);

        // Simple trend calculation
        final direction = TrendDirection.stable; // TODO: Implement proper trend analysis
        final changePercentage = 0.0; // TODO: Calculate actual change

        trends.add(MonthlyTrend(
          month: month,
          averageSpending: average,
          medianSpending: median,
          direction: direction,
          changePercentage: changePercentage,
        ));
      }
    }

    return trends;
  }

  /// Generate insights and recommendations
  SeasonalInsights _generateInsights(
    List<CategorySpending> categorySpending,
    List<MonthlyTrend> monthlyTrends,
  ) {
    final findings = <String>[];
    final recommendations = <BudgetRecommendation>[];
    final patterns = <String>[];

    // Generate basic insights
    if (categorySpending.isNotEmpty) {
      final topCategory = categorySpending.reduce((a, b) =>
          a.totalAmount > b.totalAmount ? a : b);
      findings.add('Your highest spending category is ${topCategory.categoryName} with \$${topCategory.totalAmount.toStringAsFixed(2)}');

      // Generate recommendations
      for (final category in categorySpending) {
        if (category.percentageChange != null && category.percentageChange! > 20) {
          recommendations.add(BudgetRecommendation(
            categoryId: category.categoryId,
            categoryName: category.categoryName,
            type: RecommendationType.monitor,
            description: 'Spending increased by ${category.percentageChange!.toStringAsFixed(1)}% - monitor closely',
            suggestedAmount: category.averageAmount * 1.1,
            currentAverage: category.averageAmount,
          ));
        }
      }
    }

    // Determine risk level
    final riskLevel = recommendations.length > 3 ? RiskLevel.high :
                     recommendations.length > 1 ? RiskLevel.medium : RiskLevel.low;

    return SeasonalInsights(
      keyFindings: findings,
      recommendations: recommendations,
      seasonalPatterns: patterns,
      spendingRisk: riskLevel,
    );
  }

  /// Calculate median of a list of numbers
  double _calculateMedian(List<double> values) {
    if (values.isEmpty) return 0.0;
    final sorted = List<double>.from(values)..sort();
    final middle = sorted.length ~/ 2;
    if (sorted.length.isEven) {
      return (sorted[middle - 1] + sorted[middle]) / 2;
    } else {
      return sorted[middle];
    }
  }

  /// Generate unique analysis ID
  String _generateAnalysisId() {
    return 'analysis_${DateTime.now().millisecondsSinceEpoch}';
  }
}