import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../accounts/domain/entities/account.dart';
import '../../../accounts/domain/usecases/create_account.dart';
import '../../../budgets/domain/entities/budget.dart';
import '../../../budgets/domain/usecases/create_budget.dart';
import '../../data/datasources/user_profile_hive_datasource.dart';
import '../../domain/entities/income_source.dart';
import '../../domain/entities/user_profile.dart';
import '../states/onboarding_state.dart';

/// State notifier for onboarding flow management
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final CreateBudget _createBudget;
  final CreateAccount _createAccount;
  final UserProfileHiveDataSource _userProfileDataSource;

  bool _isDisposed = false;

  OnboardingNotifier({
    required CreateBudget createBudget,
    required CreateAccount createAccount,
    required UserProfileHiveDataSource userProfileDataSource,
  })  : _createBudget = createBudget,
        _createAccount = createAccount,
        _userProfileDataSource = userProfileDataSource,
        super(const OnboardingState()) {
    _loadExistingProfile();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  /// Check if notifier is disposed
  bool get isDisposed => _isDisposed;

  Future<void> _loadExistingProfile() async {
    if (_isDisposed) return;

    final result = await _userProfileDataSource.getUserProfile();

    if (_isDisposed) return;

    result.when(
      success: (profile) {
        if (_isDisposed) return;

        if (profile != null) {
          if (!_isDisposed) {
            state = state.copyWith(userProfile: profile);
          }
          if (profile.hasCompletedOnboarding && !_isDisposed) {
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
    if (_isDisposed) return;

    debugPrint('OnboardingNotifier: Creating user profile - email: $email, name: $name');
    final userProfile = UserProfile.create(email: email, name: name);
    if (!_isDisposed) {
      state = state.copyWith(userProfile: userProfile);
    }
    debugPrint('OnboardingNotifier: User profile created successfully');
    _nextStep();
  }

  /// Select budget type and proceed
  void selectBudgetType(BudgetType budgetType) {
    if (_isDisposed) return;

    debugPrint('OnboardingNotifier: Selecting budget type: $budgetType');
    final updatedData = state.onboardingData.copyWith(selectedBudgetType: budgetType);
    if (!_isDisposed) {
      state = state.copyWith(onboardingData: updatedData);
    }
    debugPrint('OnboardingNotifier: Budget type selected successfully');
    _nextStep();
  }

  /// Add income source
  void addIncomeSource(IncomeSource incomeSource) {
    if (_isDisposed) return;

    final updatedSources = [...state.onboardingData.incomeSources, incomeSource];
    final updatedData = state.onboardingData.copyWith(incomeSources: updatedSources);
    if (!_isDisposed) {
      state = state.copyWith(onboardingData: updatedData);
    }
  }

  /// Remove income source
  void removeIncomeSource(String incomeSourceId) {
    if (_isDisposed) return;

    final updatedSources = state.onboardingData.incomeSources
        .where((source) => source.id != incomeSourceId)
        .toList();
    final updatedData = state.onboardingData.copyWith(incomeSources: updatedSources);
    if (!_isDisposed) {
      state = state.copyWith(onboardingData: updatedData);
    }
  }

  /// Confirm income and proceed to budget setup
  void confirmIncome() {
    if (_isDisposed) return;

    debugPrint('OnboardingNotifier: Confirming income - sources count: ${state.onboardingData.incomeSources.length}');
    if (state.onboardingData.incomeSources.isNotEmpty) {
      // Auto-populate budget categories based on selected type
      final defaultCategories = state.onboardingData.getDefaultCategories();
      debugPrint('OnboardingNotifier: Generated ${defaultCategories.length} default budget categories');
      final updatedData = state.onboardingData.copyWith(budgetCategories: defaultCategories);
      if (!_isDisposed) {
        state = state.copyWith(onboardingData: updatedData);
      }
      debugPrint('OnboardingNotifier: Income confirmed, proceeding to budget setup');
      _nextStep();
    } else {
      debugPrint('OnboardingNotifier: Cannot confirm income - no income sources');
    }
  }

  /// Update budget category amount
  void updateBudgetCategory(String categoryId, double amount) {
    if (_isDisposed) return;

    final updatedCategories = state.onboardingData.budgetCategories.map((category) {
      return category.id == categoryId ? category.copyWith(amount: amount) : category;
    }).toList();
    final updatedData = state.onboardingData.copyWith(budgetCategories: updatedCategories);
    if (!_isDisposed) {
      state = state.copyWith(onboardingData: updatedData);
    }
  }

  /// Add custom budget category
  void addBudgetCategory(BudgetCategory category) {
    if (_isDisposed) return;

    final updatedCategories = [...state.onboardingData.budgetCategories, category];
    final updatedData = state.onboardingData.copyWith(budgetCategories: updatedCategories);
    if (!_isDisposed) {
      state = state.copyWith(onboardingData: updatedData);
    }
  }

  /// Remove budget category
  void removeBudgetCategory(String categoryId) {
    if (_isDisposed) return;

    final updatedCategories = state.onboardingData.budgetCategories
        .where((category) => category.id != categoryId)
        .toList();
    final updatedData = state.onboardingData.copyWith(budgetCategories: updatedCategories);
    if (!_isDisposed) {
      state = state.copyWith(onboardingData: updatedData);
    }
  }

  /// Confirm budget setup and proceed
  void confirmBudgetSetup() {
    if (_isDisposed) return;

    debugPrint('OnboardingNotifier: Confirming budget setup - categories count: ${state.onboardingData.budgetCategories.length}');
    if (state.onboardingData.budgetCategories.isNotEmpty) {
      debugPrint('OnboardingNotifier: Budget setup confirmed, proceeding to bank connection');
      _nextStep();
    } else {
      debugPrint('OnboardingNotifier: Cannot confirm budget setup - no budget categories');
    }
  }

  /// Set bank connection preference
  void setBankConnectionPreference(bool wantsConnection) {
    if (_isDisposed) return;

    debugPrint('OnboardingNotifier: Setting bank connection preference: $wantsConnection');
    final updatedData = state.onboardingData.copyWith(wantsBankConnection: wantsConnection);
    if (!_isDisposed) {
      state = state.copyWith(onboardingData: updatedData);
    }
    debugPrint('OnboardingNotifier: Bank connection preference set, proceeding to completion');
    _nextStep();
  }

  /// Complete onboarding
  Future<bool> completeOnboarding() async {
    if (_isDisposed) return false;

    debugPrint('OnboardingNotifier: Starting onboarding completion process');
    debugPrint('OnboardingNotifier: Onboarding data complete: ${state.onboardingData.isComplete}, user profile exists: ${state.userProfile != null}');

    if (!state.onboardingData.isComplete || state.userProfile == null) {
      debugPrint('OnboardingNotifier: Cannot complete onboarding - data incomplete or no user profile');
      return false;
    }

    debugPrint('OnboardingNotifier: Setting loading state and clearing errors');
    if (!_isDisposed) {
      state = state.copyWith(isLoading: true, error: null);
    }

    // Track created resources for rollback
    bool budgetCreated = false;
    bool accountCreated = false;
    String? createdBudgetId;
    String? createdAccountId;

    try {
      // Step 1: Create the budget
      debugPrint('OnboardingNotifier: Creating budget from onboarding data');
      final budget = await _createBudgetFromOnboardingData();
      budgetCreated = true;
      createdBudgetId = budget.id;
      debugPrint('OnboardingNotifier: Budget created successfully: $createdBudgetId');

      // Step 2: Create a default checking account
      debugPrint('OnboardingNotifier: Creating default checking account');
      final account = await _createDefaultAccount();
      accountCreated = true;
      createdAccountId = account.id;
      debugPrint('OnboardingNotifier: Account created successfully: $createdAccountId');

      // Step 3: Mark user profile as completed
      debugPrint('OnboardingNotifier: Marking user profile as completed');
      final completedProfile = state.userProfile!.completeOnboarding();

      // Step 4: Save the completed profile to storage
      debugPrint('OnboardingNotifier: Saving completed user profile');
      final saveResult = await _userProfileDataSource.saveUserProfile(completedProfile);
      final success = saveResult.when(
        success: (_) {
          debugPrint('OnboardingNotifier: User profile saved successfully');
          return true;
        },
        error: (failure) {
          debugPrint('OnboardingNotifier: Failed to save user profile: ${failure.message}');
          return false;
        },
      );

      if (!success) {
        debugPrint('OnboardingNotifier: Failed to save user profile, throwing exception');
        throw Exception('Failed to save user profile');
      }

      debugPrint('OnboardingNotifier: Updating state to completed');
      if (!_isDisposed) {
        final newState = state.copyWith(
          userProfile: completedProfile,
          isCompleted: true,
          isLoading: false,
        );
        debugPrint('OnboardingNotifier: New state - isCompleted: ${newState.isCompleted}, userProfile: ${newState.userProfile != null}');
        state = newState;
      }

      debugPrint('OnboardingNotifier: Onboarding completed successfully');
      return true;
    } catch (e, stackTrace) {
      debugPrint('OnboardingNotifier: Error during onboarding completion: $e');
      debugPrint('OnboardingNotifier: Stack trace: $stackTrace');

      // Rollback created resources
      await _rollbackOnboarding(createdBudgetId, createdAccountId, budgetCreated, accountCreated);

      if (!_isDisposed) {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to complete onboarding: ${e.toString()}',
        );
      }
      return false;
    }
  }

  /// Go to next step
  void nextStep() {
    if (_isDisposed) return;
    _nextStep();
  }

  /// Go to previous step
  void previousStep() {
    if (_isDisposed) return;

    final previous = state.previousStep;
    if (previous != null && !_isDisposed) {
      state = state.copyWith(currentStep: previous);
    }
  }

  /// Go to specific step
  void goToStep(OnboardingStep step) {
    if (_isDisposed) return;

    if (!_isDisposed) {
      state = state.copyWith(currentStep: step);
    }
  }

  /// Reset onboarding
  void reset() {
    if (_isDisposed) return;

    if (!_isDisposed) {
      state = const OnboardingState();
    }
  }

  void _nextStep() {
    if (_isDisposed) return;

    final next = state.nextStep;
    if (next != null && !_isDisposed) {
      state = state.copyWith(currentStep: next);
    }
  }

  Future<Budget> _createBudgetFromOnboardingData() async {
    final data = state.onboardingData;
    final now = DateTime.now();
    final endDate = DateTime(now.year, now.month + 1, now.day - 1); // End of current month

    // Generate unique budget name to avoid conflicts
    final baseName = '${data.selectedBudgetType!.displayName} Budget';
    String uniqueName = baseName;
    int counter = 1;

    // Keep trying until we find a unique name
    while (true) {
      debugPrint('OnboardingNotifier: Attempting to create budget with name: $uniqueName');
      final testBudget = Budget(
        id: 'budget_${now.millisecondsSinceEpoch}_$counter',
        name: uniqueName,
        type: data.selectedBudgetType!,
        startDate: now,
        endDate: endDate,
        createdAt: now,
        categories: data.budgetCategories,
        description: 'Created during onboarding',
        isActive: true,
      );

      final result = await _createBudget(testBudget);
      if (result.isSuccess) {
        debugPrint('OnboardingNotifier: Budget created successfully with name: $uniqueName');
        return testBudget;
      } else if (result.failureOrNull?.message.contains('unique') == true ||
                 result.failureOrNull?.message.contains('already in use') == true) {
        // Name conflict, try next counter
        counter++;
        uniqueName = '$baseName $counter';
        debugPrint('OnboardingNotifier: Budget name conflict, trying: $uniqueName');
      } else {
        // Different error, throw it
        throw Exception('Failed to create budget: ${result.failureOrNull?.message}');
      }
    }
  }

  Future<Account> _createDefaultAccount() async {
    final now = DateTime.now();

    final defaultAccount = Account(
      id: 'default_checking_${now.millisecondsSinceEpoch}',
      name: 'Checking Account',
      type: AccountType.bankAccount,
      cachedBalance: 0.0,
      lastBalanceUpdate: now,
      currency: 'USD',
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );

    final result = await _createAccount(defaultAccount);
    return result.when(
      success: (_) => defaultAccount,
      error: (failure) => throw Exception('Failed to create default account: ${failure.message}'),
    );
  }

  /// Rollback onboarding resources in case of failure
  Future<void> _rollbackOnboarding(String? budgetId, String? accountId, bool budgetCreated, bool accountCreated) async {
    debugPrint('OnboardingNotifier: Starting rollback - budget: $budgetCreated, account: $accountCreated');

    // Rollback in reverse order
    if (accountCreated && accountId != null) {
      try {
        debugPrint('OnboardingNotifier: Rolling back account: $accountId');
        // Note: We don't have a delete account use case in the notifier, but we can access it via providers
        // For now, just log the rollback need - in a real implementation, you'd inject delete use cases
        debugPrint('OnboardingNotifier: Account rollback needed but not implemented: $accountId');
      } catch (e) {
        debugPrint('OnboardingNotifier: Failed to rollback account $accountId: $e');
      }
    }

    if (budgetCreated && budgetId != null) {
      try {
        debugPrint('OnboardingNotifier: Rolling back budget: $budgetId');
        // Note: Similar to account, budget deletion would need to be implemented
        debugPrint('OnboardingNotifier: Budget rollback needed but not implemented: $budgetId');
      } catch (e) {
        debugPrint('OnboardingNotifier: Failed to rollback budget $budgetId: $e');
      }
    }

    debugPrint('OnboardingNotifier: Rollback completed');
  }
}