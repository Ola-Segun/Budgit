import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/insight_providers.dart';
import '../widgets/financial_health_score_card.dart';
import '../widgets/spending_trends_chart.dart';
import '../widgets/category_analysis_chart.dart';
import '../widgets/what_if_scenario_card.dart';
import '../widgets/expense_forecast_card.dart';

class InsightsDashboardScreen extends ConsumerWidget {
  const InsightsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightState = ref.watch(insightNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights & Reports'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: insightState.when(
        data: (state) => _buildContent(context, state, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create report screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic state, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(insightNotifierProvider.notifier).refresh();
      },
      child: SingleChildScrollView(
        padding: AppSpacing.screenPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Financial Insights',
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(AppSpacing.md),
            Text(
              'Advanced analytics to help you make better financial decisions',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Gap(AppSpacing.xl),

            // Financial Health Score
            const FinancialHealthScoreCard(),
            Gap(AppSpacing.lg),

            // Analytics Grid
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SpendingTrendsChart(),
                      Gap(AppSpacing.lg),
                      const WhatIfScenarioCard(),
                    ],
                  ),
                ),
                Gap(AppSpacing.lg),
                Expanded(
                  child: Column(
                    children: [
                      const CategoryAnalysisChart(),
                      Gap(AppSpacing.lg),
                      const ExpenseForecastCard(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}