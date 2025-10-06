import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/insight_providers.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Insights Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Coming soon: Financial insights and reports'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(insightNotifierProvider.notifier).refresh();
              },
              child: const Text('Refresh Data'),
            ),
          ],
        ),
      ),
    );
  }
}