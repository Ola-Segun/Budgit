import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../budgets/domain/entities/budget.dart';
import '../../../budgets/domain/usecases/create_budget.dart';
import '../../data/datasources/user_profile_hive_datasource.dart';
import '../../domain/entities/income_source.dart';
import '../../domain/entities/user_profile.dart';
import '../states/onboarding_state.dart';

/// State notifier for onboarding flow management
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final CreateBudget _createBudget;
  final UserProfileHiveDataSource _userProfileDataSource;

  OnboardingNotifier({
    required CreateBudget createBudget,
    required UserProfileHiveDataSource userProfileDataSource,
  })  : _createBudget = createBudget,
        _userProfileDataSource = userProfileDataSource,
        super(const OnboardingState()) {
    _loadExistingProfile();
  }

  Future<void> _loadExistingProfile() async {
    final result = await _userProfileDataSource.getUserProfile();
    result.when(
      success: (profile) {
        if (profile != null) {
          state = state.copyWith(userProfile: profile);
          if (profile.hasCompletedOnboarding) {
            state = state.copyWith(isCompleted: true);
          }
        }
      },
      error: (failure) {
        // Handle error - for now just log
        debugPrint('Failed to load user profile: ${failure.message}');
      },
    );
  }

  /// Create user profile and proceed to next step
  void createUserProfile(String email, {String? name}) {
    final userProfile = UserProfile.create(email: email, name: name);
    state = state.copyWith(userProfile: userProfile);
    _nextStep();
  }

  /// Select budget type and proceed
  void selectBudgetType(BudgetType budgetType) {
    final updatedData = state.onboardingData.copyWith(selectedBudgetType: budgetType);
    state = state.copyWith(onboardingData: updatedData);
    _nextStep();
  }

  /// Add income source
  void addIncomeSource(IncomeSource incomeSource) {
    final updatedSources = [...state.onboardingData.incomeSources, incomeSource];
    final updatedData = state.onboardingData.copyWith(incomeSources: updatedSources);
    state = state.copyWith(onboardingData: updatedData);
  }

  /// Remove income source
  void removeIncomeSource(String incomeSourceId) {
    final updatedSources = state.onboardingData.incomeSources
        .where((source) => source.id != incomeSourceId)
        .toList();
    final updatedData = state.onboardingData.copyWith(incomeSources: updatedSources);
    state = state.copyWith(onboardingData: updatedData);
  }

  /// Confirm income and proceed to budget setup
  void confirmIncome() {
    if (state.onboardingData.incomeSources.isNotEmpty) {
      // Auto-populate budget categories based on selected type
      final defaultCategories = state.onboardingData.getDefaultCategories();
      final updatedData = state.onboardingData.copyWith(budgetCategories: defaultCategories);
      state = state.copyWith(onboardingData: updatedData);
      _nextStep();
    }
  }

  /// Update budget category amount
  void updateBudgetCategory(String categoryId, double amount) {
    final updatedCategories = state.onboardingData.budgetCategories.map((category) {
      return category.id == categoryId ? category.copyWith(amount: amount) : category;
    }).toList();
    final updatedData = state.onboardingData.copyWith(budgetCategories: updatedCategories);
    state = state.copyWith(onboardingData: updatedData);
  }

  /// Add custom budget category
  void addBudgetCategory(BudgetCategory category) {
    final updatedCategories = [...state.onboardingData.budgetCategories, category];
    final updatedData = state.onboardingData.copyWith(budgetCategories: updatedCategories);
    state = state.copyWith(onboardingData: updatedData);
  }

  /// Remove budget category
  void removeBudgetCategory(String categoryId) {
    final updatedCategories = state.onboardingData.budgetCategories
        .where((category) => category.id != categoryId)
        .toList();
    final updatedData = state.onboardingData.copyWith(budgetCategories: updatedCategories);
    state = state.copyWith(onboardingData: updatedData);
  }

  /// Confirm budget setup and proceed
  void confirmBudgetSetup() {
    if (state.onboardingData.budgetCategories.isNotEmpty) {
      _nextStep();
    }
  }

  /// Set bank connection preference
  void setBankConnectionPreference(bool wantsConnection) {
    final updatedData = state.onboardingData.copyWith(wantsBankConnection: wantsConnection);
    state = state.copyWith(onboardingData: updatedData);
    _nextStep();
  }

  /// Complete onboarding
  Future<bool> completeOnboarding() async {
    if (!state.onboardingData.isComplete || state.userProfile == null) {
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Create the budget
      final budget = await _createBudgetFromOnboardingData();

      // Mark user profile as completed
      final completedProfile = state.userProfile!.completeOnboarding();

      // Save the completed profile to storage
      final saveResult = await _userProfileDataSource.saveUserProfile(completedProfile);
      final success = saveResult.when(
        success: (_) => true,
        error: (failure) {
          debugPrint('Failed to save user profile: ${failure.message}');
          return false;
        },
      );

      if (!success) {
        throw Exception('Failed to save user profile');
      }

      state = state.copyWith(
        userProfile: completedProfile,
        isCompleted: true,
        isLoading: false,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  /// Go to next step
  void nextStep() {
    _nextStep();
  }

  /// Go to previous step
  void previousStep() {
    final previous = state.previousStep;
    if (previous != null) {
      state = state.copyWith(currentStep: previous);
    }
  }

  /// Go to specific step
  void goToStep(OnboardingStep step) {
    state = state.copyWith(currentStep: step);
  }

  /// Reset onboarding
  void reset() {
    state = const OnboardingState();
  }

  void _nextStep() {
    final next = state.nextStep;
    if (next != null) {
      state = state.copyWith(currentStep: next);
    }
  }

  Future<void> _createBudgetFromOnboardingData() async {
    final data = state.onboardingData;
    final now = DateTime.now();
    final endDate = DateTime(now.year, now.month + 1, now.day - 1); // End of current month

    final budget = Budget(
      id: 'budget_${now.millisecondsSinceEpoch}',
      name: '${data.selectedBudgetType!.displayName} Budget',
      type: data.selectedBudgetType!,
      startDate: now,
      endDate: endDate,
      categories: data.budgetCategories,
      description: 'Created during onboarding',
      isActive: true,
    );

    final result = await _createBudget(budget);
    return result.when(
      success: (_) => null,
      error: (failure) => throw Exception(failure.message),
    );
  }
}