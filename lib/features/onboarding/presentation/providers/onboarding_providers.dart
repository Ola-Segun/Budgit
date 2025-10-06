import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart' as core_providers;
import '../../../budgets/domain/usecases/create_budget.dart';
import '../../data/datasources/user_profile_hive_datasource.dart';
import '../../domain/entities/onboarding_data.dart';
import '../../domain/entities/user_profile.dart';
import '../notifiers/onboarding_notifier.dart';
import '../states/onboarding_state.dart';

/// Provider for user profile data source
final userProfileDataSourceProvider = Provider<UserProfileHiveDataSource>((ref) {
  final dataSource = UserProfileHiveDataSource();
  // Note: Initialization is handled in appInitializationProvider
  return dataSource;
});

/// Provider for CreateBudget use case
final createBudgetProvider = Provider<CreateBudget>((ref) {
  return ref.read(core_providers.createBudgetProvider);
});

/// State notifier provider for onboarding state management
final onboardingNotifierProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  final createBudget = ref.watch(createBudgetProvider);
  final userProfileDataSource = ref.watch(userProfileDataSourceProvider);

  return OnboardingNotifier(
    createBudget: createBudget,
    userProfileDataSource: userProfileDataSource,
  );
});

/// Provider for checking if user has completed onboarding
final hasCompletedOnboardingProvider = Provider<bool>((ref) {
  final onboardingState = ref.watch(onboardingNotifierProvider);
  return onboardingState.isCompleted;
});

/// Provider for current onboarding step
final currentOnboardingStepProvider = Provider<OnboardingStep>((ref) {
  final onboardingState = ref.watch(onboardingNotifierProvider);
  return onboardingState.currentStep;
});

/// Provider for onboarding progress
final onboardingProgressProvider = Provider<double>((ref) {
  final onboardingState = ref.watch(onboardingNotifierProvider);
  return onboardingState.progress;
});

/// Provider for onboarding data
final onboardingDataProvider = Provider<OnboardingData>((ref) {
  final onboardingState = ref.watch(onboardingNotifierProvider);
  return onboardingState.onboardingData;
});

/// Provider for user profile
final userProfileProvider = Provider<UserProfile?>((ref) {
  final onboardingState = ref.watch(onboardingNotifierProvider);
  return onboardingState.userProfile;
});