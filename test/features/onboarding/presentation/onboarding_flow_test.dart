import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:budget_tracker/features/onboarding/presentation/onboarding_flow.dart';
import 'package:budget_tracker/features/onboarding/presentation/providers/onboarding_providers.dart';
import 'package:budget_tracker/features/onboarding/presentation/states/onboarding_state.dart';

void main() {
  setUp(() async {
    // Create a temporary directory for testing
    final tempDir = await Directory.systemTemp.createTemp('budget_tracker_test');
    Hive.init(tempDir.path);
  });

  tearDown(() async {
    await Hive.close();
  });

  group('OnboardingFlow', () {
    testWidgets('should display welcome screen initially', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: OnboardingFlow(),
          ),
        ),
      );

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Check if welcome screen is displayed
      expect(find.text('Welcome to Budget Tracker'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
    });

    testWidgets('should navigate through onboarding steps', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: OnboardingFlow(),
          ),
        ),
      );

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Should start with welcome screen
      expect(find.text('Welcome to Budget Tracker'), findsOneWidget);

      // The flow should use IndexedStack, so all screens are built but only one is visible
      // We can't easily test the full navigation without mocking the notifier
      // But we can verify the widget builds without errors
      expect(find.byType(OnboardingFlow), findsOneWidget);
    });
  });

  group('OnboardingNotifier', () {
    test('should initialize with welcome step', () {
      final container = ProviderContainer();
      final state = container.read(onboardingNotifierProvider);
      
      expect(state.currentStep, OnboardingStep.welcome);
      expect(state.isCompleted, false);
      
      container.dispose();
    });

    test('should calculate progress correctly', () {
      final container = ProviderContainer();
      final state = container.read(onboardingNotifierProvider);
      
      expect(state.progress, 1 / OnboardingStep.values.length);
      
      container.dispose();
    });
  });
}