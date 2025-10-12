import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:budget_tracker/features/transactions/presentation/screens/category_management_screen.dart';

void main() {
  group('CategoryManagementScreen', () {
    testWidgets('should build without crashing', (tester) async {
      // Build the screen with ProviderScope
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CategoryManagementScreen(),
          ),
        ),
      );

      // Wait for the widget to build and settle
      await tester.pumpAndSettle();

      // Verify that the screen builds successfully (no crash)
      expect(find.byType(CategoryManagementScreen), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Categories'), findsOneWidget);
    });

    testWidgets('should have basic UI elements', (tester) async {
      // Build the screen
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CategoryManagementScreen(),
          ),
        ),
      );

      // Wait for the widget to build
      await tester.pumpAndSettle();

      // Verify basic UI elements are present
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('Categories'), findsOneWidget);
    });
  });
}