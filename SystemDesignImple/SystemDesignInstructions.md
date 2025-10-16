# 🎯 Complete AI Copilot Implementation Guide: Budget App UI Transformation

## 📚 Table of Contents
1. [Project Overview & Context](#project-overview)
2. [Prerequisites & Setup](#prerequisites)
3. [Phase-by-Phase Implementation](#implementation-phases)
4. [Component Development Guide](#component-guide)
5. [Screen-by-Screen Transformation](#screen-transformation)
6. [Quality Assurance Checklist](#qa-checklist)
7. [Future-Proofing Strategy](#future-strategy)
8. [Common Pitfalls & Solutions](#pitfalls)

---

## 1. Project Overview & Context {#project-overview}

### **Mission Statement**
Transform the existing budget management app from its current blue-themed design to a modern, friendly hybrid design system combining:
- **TrackFinz**: Friendly, teen-focused aesthetic with teal primary color
- **Pink App**: Clean minimalism and efficient layouts
- **Modern Budget Tracker**: Professional data-driven approach

### **Core Design Principles to Follow**
```yaml
principles:
  - name: "Progressive Enhancement"
    description: "Start with functional core, add polish incrementally"
    
  - name: "Consistency First"
    description: "Every component must follow the design system"
    
  - name: "Mobile-First Responsive"
    description: "Design for smallest screen, scale up"
    
  - name: "Accessibility by Default"
    description: "Min 48px touch targets, 4.5:1 contrast ratio"
    
  - name: "Performance Conscious"
    description: "Lazy load, optimize images, efficient animations"
```

### **Success Metrics**
- ✅ All screens match new design system
- ✅ Component reusability >80%
- ✅ Accessibility score >95%
- ✅ Load time <2 seconds
- ✅ Consistent 60fps animations
- ✅ Zero design inconsistencies

---

## 2. Prerequisites & Setup {#prerequisites}

### **Required Knowledge**
```yaml
flutter_skills:
  essential:
    - Flutter widgets and composition
    - State management (Riverpod)
    - Navigation (GoRouter)
    - Theming and styling
    - Responsive layouts
  
  advanced:
    - Custom animations
    - Custom painters
    - Performance optimization
    - Accessibility implementation
```

### **Project Structure Setup**
```bash
# Step 1: Create folder structure
lib/
├── main.dart
├── app.dart
├── core/
│   ├── theme/
│   │   ├── app_theme.dart           # Main theme configuration
│   │   ├── app_colors.dart          # Color constants
│   │   ├── app_typography.dart      # Typography styles
│   │   ├── app_dimensions.dart      # Spacing, radius constants
│   │   └── app_shadows.dart         # Shadow definitions
│   ├── constants/
│   │   ├── app_constants.dart       # App-wide constants
│   │   └── asset_paths.dart         # Asset path constants
│   ├── router/
│   │   └── app_router.dart          # Navigation configuration
│   ├── extensions/
│   │   ├── context_extensions.dart  # BuildContext helpers
│   │   ├── number_extensions.dart   # Number formatting
│   │   └── date_extensions.dart     # Date helpers
│   └── utils/
│       ├── validators.dart          # Form validators
│       └── formatters.dart          # Text formatters
├── shared/
│   └── presentation/
│       └── widgets/
│           ├── buttons/              # Button components
│           ├── cards/                # Card components
│           ├── inputs/               # Input components
│           ├── modals/               # Modal components
│           ├── states/               # Loading, empty, error
│           └── common/               # Shared UI elements
└── features/
    ├── home/
    ├── transactions/
    ├── categories/
    ├── goals/
    └── bills/
```

### **Dependencies Installation**
```yaml
# pubspec.yaml - Copy this exact configuration

name: budget_management_app
description: Modern budget tracking application
version: 2.0.0+1

environment:
  sdk: '>=3.2.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5

  # Navigation
  go_router: ^13.2.0

  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.2.2

  # UI & Theming
  google_fonts: ^6.1.0
  gap: ^3.0.1

  # Charts & Visualization
  fl_chart: ^0.66.0

  # Animations
  flutter_animate: ^4.5.0
  animations: ^2.0.11
  lottie: ^3.1.0

  # Components
  shimmer: ^3.0.0
  flutter_slidable: ^3.0.1

  # Forms
  currency_text_input_formatter: ^2.2.0

  # Icons
  lucide_icons: ^0.263.0

  # Utilities
  intl: ^0.19.0
  freezed_annotation: ^2.4.1

dev_dependencies:
  flutter_test:
    sdk: flutter

  # Code Generation
  build_runner: ^2.4.8
  hive_generator: ^2.0.1
  riverpod_generator: ^2.4.0
  freezed: ^2.4.7

  # Linting
  flutter_lints: ^3.0.1

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/animations/
    - assets/icons/
```

### **Initial Setup Commands**
```bash
# Step 1: Install dependencies
flutter pub get

# Step 2: Run code generation
flutter pub run build_runner build --delete-conflicting-outputs

# Step 3: Verify setup
flutter analyze

# Step 4: Run app to test
flutter run
```

---

## 3. Phase-by-Phase Implementation {#implementation-phases}

### **🎯 PHASE 1: Foundation (Week 1) - CRITICAL**

#### **Priority: MAXIMUM - Do This First**

**Objective**: Establish the design system foundation that everything else depends on.

#### **Step 1.1: Create Color System**
```dart
// lib/core/theme/app_colors.dart
// 🎨 INSTRUCTION: Copy this file EXACTLY as shown

import 'package:flutter/material.dart';

/// Central color system for the application
/// Based on hybrid design: TrackFinz (teal) + Pink App (clean) + Modern Budget Tracker
class AppColors {
  AppColors._(); // Private constructor prevents instantiation

  // ═══════════════════════════════════════════════════════════
  // PRIMARY COLORS - Teal from TrackFinz
  // ═══════════════════════════════════════════════════════════
  
  /// Main brand color - Use for primary actions, active states
  static const Color primary = Color(0xFF14B8A6);
  
  /// Lighter teal - Use for hover states, backgrounds
  static const Color primaryLight = Color(0xFF5EEAD4);
  
  /// Darker teal - Use for pressed states
  static const Color primaryDark = Color(0xFF0F766E);
  
  /// Accent teal - Use for highlights
  static const Color primaryAccent = Color(0xFF2DD4BF);

  // ═══════════════════════════════════════════════════════════
  // SECONDARY COLORS - Pink for warmth
  // ═══════════════════════════════════════════════════════════
  
  static const Color secondary = Color(0xFFEC4899);
  static const Color secondaryLight = Color(0xFFF9A8D4);
  static const Color secondaryDark = Color(0xFFDB2777);

  // ═══════════════════════════════════════════════════════════
  // SEMANTIC COLORS - Status indicators
  // ═══════════════════════════════════════════════════════════
  
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // ═══════════════════════════════════════════════════════════
  // NEUTRAL COLORS - Backgrounds, surfaces
  // ═══════════════════════════════════════════════════════════
  
  static const Color background = Color(0xFFF8FAFC);
  static const Color backgroundAlt = Color(0xFFF1F5F9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  
  // Borders
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderSubtle = Color(0xFFF1F5F9);
  
  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textDisabled = Color(0xFFCBD5E1);

  // ═══════════════════════════════════════════════════════════
  // CATEGORY COLORS - For transactions/budgets
  // ═══════════════════════════════════════════════════════════
  
  static const Map<String, Color> categoryColors = {
    'food': Color(0xFFF97316),
    'transport': Color(0xFF3B82F6),
    'shopping': Color(0xFFEC4899),
    'entertainment': Color(0xFF8B5CF6),
    'health': Color(0xFF10B981),
    'utilities': Color(0xFF06B6D4),
    'housing': Color(0xFF6366F1),
    'education': Color(0xFFFBBF24),
    'business': Color(0xFF14B8A6),
  };

  // ═══════════════════════════════════════════════════════════
  // GRADIENTS
  // ═══════════════════════════════════════════════════════════
  
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF14B8A6), Color(0xFF2DD4BF)],
  );

  // ═══════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════
  
  /// Get category color by name, returns primary if not found
  static Color getCategoryColor(String category) {
    return categoryColors[category.toLowerCase()] ?? primary;
  }
  
  /// Get category color with opacity for backgrounds
  static Color getCategoryBackground(String category, {double opacity = 0.1}) {
    return getCategoryColor(category).withOpacity(opacity);
  }
}
```

#### **Step 1.2: Create Typography System**
```dart
// lib/core/theme/app_typography.dart
// 📝 INSTRUCTION: This defines ALL text styles in the app

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Central typography system
/// Uses Inter font for modern, clean look
class AppTypography {
  AppTypography._();

  // Font family
  static String get fontFamily => GoogleFonts.inter().fontFamily!;

  // ═══════════════════════════════════════════════════════════
  // TEXT THEME - For Material Theme
  // ═══════════════════════════════════════════════════════════
  
  static TextTheme get textTheme => TextTheme(
        displayLarge: hero,
        displayMedium: display,
        displaySmall: h1,
        headlineLarge: h1,
        headlineMedium: h2,
        headlineSmall: h3,
        titleLarge: h2,
        titleMedium: h3,
        bodyLarge: body,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: bodyMedium,
        labelMedium: caption,
        labelSmall: overline,
      );

  // ═══════════════════════════════════════════════════════════
  // DISPLAY STYLES - Large headers, hero text
  // ═══════════════════════════════════════════════════════════
  
  /// Hero style - Use for splash screens, major moments
  /// Example: "Welcome to Budget App"
  static final TextStyle hero = GoogleFonts.inter(
    fontSize: 56,
    height: 1.1,
    fontWeight: FontWeight.w800,
    letterSpacing: -2.5,
    color: AppColors.textPrimary,
  );

  /// Display style - Use for large balance displays
  /// Example: "$1,234.56"
  static final TextStyle display = GoogleFonts.inter(
    fontSize: 40,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.5,
    color: AppColors.textPrimary,
  );

  // ═══════════════════════════════════════════════════════════
  // HEADING STYLES
  // ═══════════════════════════════════════════════════════════
  
  /// H1 - Use for screen titles
  /// Example: "Transactions", "Budget Overview"
  static final TextStyle h1 = GoogleFonts.inter(
    fontSize: 28,
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
    color: AppColors.textPrimary,
  );

  /// H2 - Use for section headers
  /// Example: "Recent Transactions", "Active Goals"
  static final TextStyle h2 = GoogleFonts.inter(
    fontSize: 22,
    height: 1.3,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
    color: AppColors.textPrimary,
  );

  /// H3 - Use for card titles, subsections
  /// Example: "Food & Dining", "Monthly Budget"
  static final TextStyle h3 = GoogleFonts.inter(
    fontSize: 18,
    height: 1.4,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    color: AppColors.textPrimary,
  );

  // ═══════════════════════════════════════════════════════════
  // BODY STYLES
  // ═══════════════════════════════════════════════════════════
  
  /// Body - Use for main content, descriptions
  /// Example: Transaction descriptions, form labels
  static final TextStyle body = GoogleFonts.inter(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// Body Medium - Use for emphasized body text
  /// Example: Button labels, important text
  static final TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// Body Small - Use for secondary information
  /// Example: Subtitles, helper text
  static final TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    color: AppColors.textSecondary,
  );

  // ═══════════════════════════════════════════════════════════
  // SUPPORTING STYLES
  // ═══════════════════════════════════════════════════════════
  
  /// Caption - Use for timestamps, metadata
  /// Example: "2 hours ago", "Oct 16"
  static final TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    height: 1.4,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
  );

  /// Overline - Use for labels, tags
  /// Example: "EXPENSE", "INCOME"
  static final TextStyle overline = GoogleFonts.inter(
    fontSize: 11,
    height: 1.4,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: AppColors.textSecondary,
  );

  // ═══════════════════════════════════════════════════════════
  // SPECIAL PURPOSE STYLES
  // ═══════════════════════════════════════════════════════════
  
  /// Currency - Use for transaction amounts
  /// Includes tabular figures for alignment
  static final TextStyle currency = GoogleFonts.inter(
    fontSize: 32,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    color: AppColors.textPrimary,
    fontFeatures: [const FontFeature.tabularFigures()],
  );

  /// Currency Large - Use for balance displays
  static final TextStyle currencyLarge = GoogleFonts.inter(
    fontSize: 48,
    height: 1.1,
    fontWeight: FontWeight.w700,
    letterSpacing: -2,
    color: AppColors.textPrimary,
    fontFeatures: [const FontFeature.tabularFigures()],
  );

  /// Button Text
  static final TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
}
```

#### **Step 1.3: Create Dimensions System**
```dart
// lib/core/theme/app_dimensions.dart
// 📐 INSTRUCTION: All spacing, sizing, and radius values

class AppDimensions {
  AppDimensions._();

  // ═══════════════════════════════════════════════════════════
  // BORDER RADIUS - Rounded corners
  // ═══════════════════════════════════════════════════════════
  
  static const double radiusXs = 6;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radius2xl = 24;
  static const double radiusFull = 9999;

  /// Semantic radius for common components
  static const double buttonRadius = radiusMd;
  static const double cardRadius = radiusLg;
  static const double inputRadius = radiusMd;
  static const double modalRadius = radius2xl;
  static const double categoryIconRadius = radiusMd;

  // ═══════════════════════════════════════════════════════════
  // SPACING SCALE - Based on 4px unit
  // ═══════════════════════════════════════════════════════════
  
  static const double spacing0 = 0;
  static const double spacing1 = 4;
  static const double spacing2 = 8;
  static const double spacing3 = 12;
  static const double spacing4 = 16;
  static const double spacing5 = 20;
  static const double spacing6 = 24;
  static const double spacing8 = 32;
  static const double spacing10 = 40;
  static const double spacing12 = 48;

  /// Semantic spacing for common use cases
  static const double screenPaddingH = 16;
  static const double screenPaddingV = 16;
  static const double cardPadding = 16;
  static const double cardPaddingLarge = 20;
  static const double sectionGap = 24;
  static const double componentGap = 16;

  // ═══════════════════════════════════════════════════════════
  // COMPONENT SIZES
  // ═══════════════════════════════════════════════════════════
  
  /// Icon sizes
  static const double iconXs = 16;
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 28;
  static const double iconXl = 32;

  /// Button heights
  static const double buttonHeightMd = 48;
  static const double buttonHeightLg = 56;

  /// Category icon
  static const double categoryIconSize = 48;

  /// Touch target minimum (accessibility)
  static const double minTouchTarget = 48;

  // ═══════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════
  
  /// Create BorderRadius from radius value
  static BorderRadius borderRadius(double radius) {
    return BorderRadius.circular(radius);
  }

  /// Standard card border radius
  static BorderRadius get cardBorderRadius => borderRadius(cardRadius);

  /// Standard button border radius
  static BorderRadius get buttonBorderRadius => borderRadius(buttonRadius);
}
```

#### **Step 1.4: Create Main Theme**
```dart
// lib/core/theme/app_theme.dart
// 🎨 INSTRUCTION: Main theme configuration

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_dimensions.dart';

class AppTheme {
  AppTheme._();

  /// Light theme - primary theme for the app
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // ═══════════════════════════════════════════════════════════
      // COLOR SCHEME
      // ═══════════════════════════════════════════════════════════
      
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary,
        background: AppColors.background,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        outline: AppColors.border,
      ),
      
      // ═══════════════════════════════════════════════════════════
      // TYPOGRAPHY
      // ═══════════════════════════════════════════════════════════
      
      textTheme: AppTypography.textTheme,
      
      // ═══════════════════════════════════════════════════════════
      // SCAFFOLD
      // ═══════════════════════════════════════════════════════════
      
      scaffoldBackgroundColor: AppColors.background,
      
      // ═══════════════════════════════════════════════════════════
      // APP BAR
      // ═══════════════════════════════════════════════════════════
      
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        titleTextStyle: AppTypography.h3.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
      ),
      
      // ═══════════════════════════════════════════════════════════
      // CARD
      // ═══════════════════════════════════════════════════════════
      
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.cardBorderRadius,
        ),
        color: AppColors.surface,
        margin: EdgeInsets.zero,
      ),
      
      // ═══════════════════════════════════════════════════════════
      // BUTTONS
      // ═══════════════════════════════════════════════════════════
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.borderSubtle,
          disabledForegroundColor: AppColors.textTertiary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.buttonBorderRadius,
          ),
          textStyle: AppTypography.button,
          minimumSize: const Size(120, 48),
        ),
      ),
      
      // ═══════════════════════════════════════════════════════════
      // INPUT DECORATION
      // ═══════════════════════════════════════════════════════════
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: AppColors.border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
        ),
        labelStyle: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
        hintStyle: AppTypography.body.copyWith(color: AppColors.textTertiary),
      ),
      
      // ═══════════════════════════════════════════════════════════
      // FAB
      // ═══════════════════════════════════════════════════════════
      
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // ═══════════════════════════════════════════════════════════
      // BOTTOM NAVIGATION
      // ═══════════════════════════════════════════════════════════
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        selectedLabelStyle: AppTypography.caption.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTypography.caption,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // ═══════════════════════════════════════════════════════════
      // DIVIDER
      // ═══════════════════════════════════════════════════════════
      
      dividerTheme: DividerThemeData(
        color: AppColors.borderSubtle,
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// Dark theme - for future implementation
  static ThemeData darkTheme() {
    // TODO: Implement dark theme
    return lightTheme();
  }
}
```

#### **🎯 CHECKPOINT 1: Verify Foundation**
```dart
// Run this test to verify your foundation setup
// lib/main.dart

import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_typography.dart';
import 'core/theme/app_dimensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App - Foundation Test',
      theme: AppTheme.lightTheme(),
      home: const FoundationTestScreen(),
    );
  }
}

class FoundationTestScreen extends StatelessWidget {
  const FoundationTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foundation Test'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Test Colors
            Text('Colors Test', style: AppTypography.h2),
            SizedBox(height: AppDimensions.spacing4),
            _ColorBox('Primary', AppColors.primary),
            _ColorBox('Secondary', AppColors.secondary),
            _ColorBox('Success', AppColors.success),
            _ColorBox('Error', AppColors.error),
            
            SizedBox(height: AppDimensions.spacing8),
            
            // Test Typography
            Text('Typography Test', style: AppTypography.h2),
            SizedBox(height: AppDimensions.spacing4),
            Text('Hero Style', style: AppTypography.hero),
            Text('Display Style', style: AppTypography.display),
            Text('H1 Style', style: AppTypography.h1),
            Text('H2 Style', style: AppTypography.h2),
            Text('Body Style', style: AppTypography.body),
            Text('Caption Style', style: AppTypography.caption),
            
            SizedBox(height: AppDimensions.spacing8),
            
            // Test Components
            Text('Components Test', style: AppTypography.h2),
            SizedBox(height: AppDimensions.spacing4),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Primary Button'),
            ),
            SizedBox(height: AppDimensions.spacing4),
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.cardPadding),
                child: Text('Card Component', style: AppTypography.body),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  final String label;
  final Color color;

  const _ColorBox(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimensions.spacing2),
      padding: EdgeInsets.