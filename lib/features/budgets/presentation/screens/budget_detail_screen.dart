import 'package:flutter/material.dart';

/// Screen for displaying budget details
class BudgetDetailScreen extends StatelessWidget {
  const BudgetDetailScreen({
    super.key,
    required this.budgetId,
  });

  final String budgetId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Details'),
      ),
      body: Center(
        child: Text('Budget Detail Screen - Coming Soon\nBudget ID: $budgetId'),
      ),
    );
  }
}