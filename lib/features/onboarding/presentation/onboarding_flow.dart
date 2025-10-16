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
class OnboardingFlow extends ConsumerStatefulWidget {
  const OnboardingFlow({super.key});

  @override
  ConsumerState<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow> {
  final Map<OnboardingStep, GlobalKey> _screenKeys = {};

  @override
  void initState() {
    super.initState();
    // Initialize keys for each screen to maintain state properly
    for (final step in OnboardingStep.values) {
      _screenKeys[step] = GlobalKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(currentOnboardingStepProvider);

    // Get the index of the current step
    final currentIndex = OnboardingStep.values.indexOf(currentStep);

    // Use IndexedStack to maintain widget state and prevent deactivation issues
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          WelcomeScreen(key: _screenKeys[OnboardingStep.welcome]),
          BudgetTypeSelectionScreen(key: _screenKeys[OnboardingStep.budgetType]),
          IncomeEntryScreen(key: _screenKeys[OnboardingStep.income]),
          BudgetSetupScreen(key: _screenKeys[OnboardingStep.budgetSetup]),
          BankConnectionScreen(key: _screenKeys[OnboardingStep.bankConnection]),
          CompletionScreen(key: _screenKeys[OnboardingStep.completion]),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clear any pending operations when disposing
    super.dispose();
  }
}