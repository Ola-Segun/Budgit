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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const Gap(16),
              Text(
                'Error loading insights',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap(8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(24),
              FilledButton.icon(
                onPressed: () => ref.invalidate(insightNotifierProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create report screen
        },
        tooltip: 'Create Report',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic state, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final isDesktop = screenWidth >= 900;

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(insightNotifierProvider.notifier).refresh();
      },
      child: SingleChildScrollView(
        padding: AppSpacing.screenPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
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

            // Analytics Section - Responsive Layout
            if (isDesktop)
              // Desktop: 2-column grid
              _buildDesktopGrid()
            else if (isTablet)
              // Tablet: 2-column grid with responsive sizing
              _buildTabletGrid()
            else
              // Mobile: Single column stack
              _buildMobileStack(),
          ],
        ),
      ),
    );
  }

  /// Mobile layout - vertical stack
  Widget _buildMobileStack() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SpendingTrendsChart(),
        Gap(AppSpacing.lg),
        const CategoryAnalysisChart(),
        Gap(AppSpacing.lg),
        const WhatIfScenarioCard(),
        Gap(AppSpacing.lg),
        const ExpenseForecastCard(),
      ],
    );
  }

  /// Tablet layout - 2 columns with proper constraints
  Widget _buildTabletGrid() {
    return Column(
      children: [
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
    );
  }

  /// Desktop layout - 2 columns optimized for large screens
  Widget _buildDesktopGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  const SpendingTrendsChart(),
                  Gap(AppSpacing.lg),
                  const WhatIfScenarioCard(),
                ],
              ),
            ),
            Gap(AppSpacing.lg),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  const CategoryAnalysisChart(),
                  Gap(AppSpacing.lg),
                  const ExpenseForecastCard(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}