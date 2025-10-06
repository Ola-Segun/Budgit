import 'package:flutter/material.dart';

/// Goals list screen
class GoalsListScreen extends StatelessWidget {
  const GoalsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to add goal screen
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Goals Screen - Coming Soon'),
      ),
    );
  }
}