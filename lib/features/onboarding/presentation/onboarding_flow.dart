import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/states/onboarding_state.dart';
import 'providers/onboarding_providers.dart';
import 'screens/bank_connection_screen.dart';
import 'screens/budget_setup_screen.dart';
import 'screens/budget_type_selection_screen.dart';
import 'screens/completion_screen.dart';
import 'screens/income_entry_screen.dart';
import 'screens/welcome_screen.dart';

/// Main onboarding flow widget that handles navigation between screens
class OnboardingFlow extends ConsumerWidget {
  const OnboardingFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(currentOnboardingStepProvider);

    // Get the index of the current step
    final currentIndex = OnboardingStep.values.indexOf(currentStep);

    // Use IndexedStack to maintain widget state and prevent deactivation issues
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          WelcomeScreen(),
          BudgetTypeSelectionScreen(),
          IncomeEntryScreen(),
          BudgetSetupScreen(),
          BankConnectionScreen(),
          CompletionScreen(),
        ],
      ),
    );
  }
}