import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

/// Floating Action Button for adding transactions
class AddTransactionFAB extends StatelessWidget {
  const AddTransactionFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.push('/transactions/add'),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }
}