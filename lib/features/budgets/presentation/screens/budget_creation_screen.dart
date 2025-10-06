import 'package:flutter/material.dart';

/// Screen for creating a new budget
class BudgetCreationScreen extends StatelessWidget {
  const BudgetCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Budget'),
      ),
      body: const Center(
        child: Text('Budget Creation Screen - Coming Soon'),
      ),
    );
  }
}