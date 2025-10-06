import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/onboarding_data.dart';
import '../../domain/entities/user_profile.dart';

part 'onboarding_state.freezed.dart';

/// State for onboarding flow management
@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(OnboardingStep.welcome) OnboardingStep currentStep,
    UserProfile? userProfile,
    @Default(OnboardingData()) OnboardingData onboardingData,
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isCompleted,
  }) = _OnboardingState;

  const OnboardingState._();

  /// Check if current step is valid
  bool get isCurrentStepValid {
    switch (currentStep) {
      case OnboardingStep.welcome:
        return userProfile != null;
      case OnboardingStep.budgetType:
        return onboardingData.selectedBudgetType != null;
      case OnboardingStep.income:
        return onboardingData.incomeSources.isNotEmpty;
      case OnboardingStep.budgetSetup:
        return onboardingData.budgetCategories.isNotEmpty;
      case OnboardingStep.bankConnection:
        return true; // Optional step
      case OnboardingStep.completion:
        return isCompleted;
    }
  }

  /// Check if can proceed to next step
  bool get canProceed => isCurrentStepValid && !isLoading;

  /// Get next step
  OnboardingStep? get nextStep {
    switch (currentStep) {
      case OnboardingStep.welcome:
        return OnboardingStep.budgetType;
      case OnboardingStep.budgetType:
        return OnboardingStep.income;
      case OnboardingStep.income:
        return OnboardingStep.budgetSetup;
      case OnboardingStep.budgetSetup:
        return OnboardingStep.bankConnection;
      case OnboardingStep.bankConnection:
        return OnboardingStep.completion;
      case OnboardingStep.completion:
        return null;
    }
  }

  /// Get previous step
  OnboardingStep? get previousStep {
    switch (currentStep) {
      case OnboardingStep.welcome:
        return null;
      case OnboardingStep.budgetType:
        return OnboardingStep.welcome;
      case OnboardingStep.income:
        return OnboardingStep.budgetType;
      case OnboardingStep.budgetSetup:
        return OnboardingStep.income;
      case OnboardingStep.bankConnection:
        return OnboardingStep.budgetSetup;
      case OnboardingStep.completion:
        return OnboardingStep.bankConnection;
    }
  }

  /// Get progress percentage (0.0 to 1.0)
  double get progress {
    const totalSteps = 6;
    final currentIndex = OnboardingStep.values.indexOf(currentStep);
    return (currentIndex + 1) / totalSteps;
  }

  /// Get progress step text
  String get progressText => '${OnboardingStep.values.indexOf(currentStep) + 1} of ${OnboardingStep.values.length}';
}

/// Steps in the onboarding flow
enum OnboardingStep {
  welcome('Welcome'),
  budgetType('Budget Type'),
  income('Income'),
  budgetSetup('Budget Setup'),
  bankConnection('Bank Connection'),
  completion('Complete');

  const OnboardingStep(this.displayName);

  final String displayName;
}