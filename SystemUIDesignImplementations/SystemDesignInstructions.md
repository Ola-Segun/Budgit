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
import '../SystemDesignImple/app_colors.dart';

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
import '../SystemDesignImple/app_colors.dart';
import '../SystemDesignImple/app_typography.dart';
import '../SystemDesignImple/app_dimensions.dart';

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
import '../SystemDesignImple/core/theme/app_theme.dart';
import '../SystemDesignImple/core/theme/app_colors.dart';
import '../SystemDesignImple/core/theme/app_typography.dart';
import '../SystemDesignImple/core/theme/app_dimensions.dart';

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



      Step 1.5: Create Extension Utilities
dart// lib/core/extensions/context_extensions.dart
// 🔧 INSTRUCTION: Helper extensions for easier access to theme

import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  /// Access theme data easily
  ThemeData get theme => Theme.of(this);
  
  /// Access color scheme
  ColorScheme get colorScheme => theme.colorScheme;
  
  /// Access text theme
  TextTheme get textTheme => theme.textTheme;
  
  /// Screen size helpers
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  
  /// Responsive breakpoints
  bool get isMobile => screenWidth < 640;
  bool get isTablet => screenWidth >= 640 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;
  
  /// Navigation helpers
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }
  
  /// Show snackbar helper
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : null,
      ),
    );
  }
}

// lib/core/extensions/number_extensions.dart
// 💰 INSTRUCTION: Format numbers for display

import 'package:intl/intl.dart';

extension NumberExtensions on num {
  /// Format as currency: 1234.56 -> "$1,234.56"
  String toCurrency({String symbol = '\$', int decimals = 2}) {
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimals,
    ).format(this);
  }
  
  /// Format with commas: 1234567 -> "1,234,567"
  String toFormatted() {
    return NumberFormat('#,###').format(this);
  }
  
  /// Compact format: 1500000 -> "1.5M"
  String toCompact() {
    return NumberFormat.compact().format(this);
  }
  
  /// Percentage: 0.85 -> "85%"
  String toPercentage({int decimals = 0}) {
    return NumberFormat.percentPattern()
        .format(this)
        .replaceAll('.00', '');
  }
}

// lib/core/extensions/date_extensions.dart
// 📅 INSTRUCTION: Format dates for display

import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// Format as "Oct 16, 2025"
  String toDisplayDate() {
    return DateFormat('MMM dd, yyyy').format(this);
  }
  
  /// Format as "Today", "Yesterday", or date
  String toRelativeDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(year, month, day);
    
    if (dateToCheck == today) return 'Today';
    if (dateToCheck == yesterday) return 'Yesterday';
    return DateFormat('MMM dd').format(this);
  }
  
  /// Format as "2 hours ago"
  String toTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);
    
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
  
  /// Check if date is in current month
  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }
}
Step 1.6: Create Gap Widget
dart// lib/shared/presentation/widgets/common/gap.dart
// 📏 INSTRUCTION: Spacing widget (replace SizedBox everywhere)

import 'package:flutter/widgets.dart';
import '../../../../core/theme/app_dimensions.dart';

/// Responsive spacing widget
/// Replaces SizedBox for consistent spacing
class Gap extends StatelessWidget {
  final double size;
  final bool isHorizontal;
  
  const Gap(this.size, {super.key}) : isHorizontal = false;
  const Gap.horizontal(this.size, {super.key}) : isHorizontal = true;
  
  // Named constructors for common sizes
  const Gap.xs({super.key}) : size = AppDimensions.spacing1, isHorizontal = false;
  const Gap.sm({super.key}) : size = AppDimensions.spacing2, isHorizontal = false;
  const Gap.md({super.key}) : size = AppDimensions.spacing3, isHorizontal = false;
  const Gap.lg({super.key}) : size = AppDimensions.spacing4, isHorizontal = false;
  const Gap.xl({super.key}) : size = AppDimensions.spacing6, isHorizontal = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isHorizontal ? size : null,
      height: isHorizontal ? null : size,
    );
  }
}

🎯 PHASE 2: Core Components (Week 2)
Priority: HIGH - Build reusable components
Step 2.1: Create Button Components
dart// lib/shared/presentation/widgets/buttons/app_button.dart
// 🔘 INSTRUCTION: Primary button component

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../common/gap.dart';

enum AppButtonVariant { primary, secondary, outline, ghost }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double? height;
  
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? AppDimensions.buttonHeightMd;
    
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(),
        child: isLoading
            ? _buildLoadingIndicator()
            : _buildButtonContent(),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.borderSubtle,
          disabledForegroundColor: AppColors.textTertiary,
        );
      
      case AppButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.backgroundAlt,
          foregroundColor: AppColors.textPrimary,
        );
      
      case AppButtonVariant.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
        );
      
      case AppButtonVariant.ghost:
        return TextButton.styleFrom(
          foregroundColor: AppColors.primary,
        );
    }
  }

  Widget _buildButtonContent() {
    if (icon == null) {
      return Text(label, style: AppTypography.button);
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20),
        const Gap.horizontal(8),
        Text(label, style: AppTypography.button),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}

// lib/shared/presentation/widgets/buttons/app_icon_button.dart
// 🔘 INSTRUCTION: Icon-only button

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? AppColors.backgroundAlt,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            size: size * 0.5,
            color: iconColor ?? AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
Step 2.2: Create Card Components
dart// lib/shared/presentation/widgets/cards/app_card.dart
// 🃏 INSTRUCTION: Base card component

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double? elevation;
  final double? borderRadius;
  
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.gradient,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final cardBorderRadius = borderRadius ?? AppDimensions.cardRadius;
    
    Widget cardContent = Container(
      padding: padding ?? EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: gradient == null ? (backgroundColor ?? AppColors.surface) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: [
          if (elevation != null && elevation! > 0)
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: elevation! * 2,
              offset: Offset(0, elevation!),
            ),
        ],
      ),
      child: child,
    );
    
    if (onTap != null) {
      cardContent = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(cardBorderRadius),
          child: cardContent,
        ),
      );
    }
    
    return cardContent;
  }
}

// lib/shared/presentation/widgets/cards/balance_card.dart
// 💳 INSTRUCTION: Gradient balance card

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/extensions/number_extensions.dart';
import '../common/gap.dart';
import 'app_card.dart';

class BalanceCard extends StatelessWidget {
  final String title;
  final double balance;
  final String subtitle;
  final List<MetricItem>? metrics;
  
  const BalanceCard({
    super.key,
    required this.title,
    required this.balance,
    required this.subtitle,
    this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      gradient: AppColors.primaryGradient,
      padding: EdgeInsets.all(AppDimensions.cardPaddingLarge),
      borderRadius: 20,
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            title,
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const Gap.sm(),
          
          // Balance
          Text(
            balance.toCurrency(),
            style: AppTypography.currencyLarge.copyWith(
              color: Colors.white,
            ),
          ),
          const Gap.xs(),
          
          // Subtitle
          Text(
            subtitle,
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          
          // Metrics (if provided)
          if (metrics != null) ...[
            const Gap.lg(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: metrics!.map((metric) {
                return _MetricDisplay(metric: metric);
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class MetricItem {
  final String label;
  final String value;
  final IconData? icon;
  
  const MetricItem({
    required this.label,
    required this.value,
    this.icon,
  });
}

class _MetricDisplay extends StatelessWidget {
  final MetricItem metric;
  
  const _MetricDisplay({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (metric.icon != null) ...[
          Icon(metric.icon, size: 16, color: Colors.white.withOpacity(0.9)),
          const Gap.xs(),
        ],
        Text(
          metric.label,
          style: AppTypography.caption.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        const Gap.xs(),
        Text(
          metric.value,
          style: AppTypography.h3.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
Step 2.3: Create Input Components
dart// lib/shared/presentation/widgets/inputs/app_text_field.dart
// 📝 INSTRUCTION: Standard text input

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../common/gap.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  
  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (label != null) ...[
          Text(
            label!,
            style: AppTypography.bodySmall.copyWith(
              color: errorText != null ? AppColors.error : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap.sm(),
        ],
        
        // Text field
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          style: AppTypography.body,
          decoration: InputDecoration(
            hintText: hint,
            helperText: helperText,
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

// lib/shared/presentation/widgets/inputs/currency_input.dart
// 💰 INSTRUCTION: Currency input with formatting

import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'app_text_field.dart';

class CurrencyInput extends StatelessWidget {
  final String? label;
  final TextEditingController controller;
  final ValueChanged<double>? onChanged;
  final String? errorText;
  
  const CurrencyInput({
    super.key,
    this.label,
    required this.controller,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      controller: controller,
      errorText: errorText,
      keyboardType: TextInputType.number,
      inputFormatters: [
        CurrencyTextInputFormatter(
          locale: 'en_US',
          decimalDigits: 2,
          symbol: '\$',
        ),
      ],
      onChanged: (value) {
        if (onChanged != null) {
          final numValue = double.tryParse(
            value.replaceAll(RegExp(r'[^\d.]'), ''),
          );
          if (numValue != null) {
            onChanged!(numValue);
          }
        }
      },
    );
  }
}
Step 2.4: Create State Components
dart// lib/shared/presentation/widgets/states/empty_state.dart
// 🗑️ INSTRUCTION: Empty state component

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../common/gap.dart';
import '../buttons/app_button.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.spacing10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.backgroundAlt,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 60,
                color: AppColors.textTertiary,
              ),
            ),
            const Gap.xl(),
            
            // Title
            Text(
              title,
              style: AppTypography.h2,
              textAlign: TextAlign.center,
            ),
            const Gap.sm(),
            
            // Message
            Text(
              message,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            
            // Action button
            if (actionLabel != null && onAction != null) ...[
              const Gap.xl(),
              AppButton(
                label: actionLabel!,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// lib/shared/presentation/widgets/states/loading_skeleton.dart
// ⏳ INSTRUCTION: Loading skeleton for lists

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../common/gap.dart';

class LoadingSkeleton extends StatelessWidget {
  final int itemCount;
  
  const LoadingSkeleton({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      separatorBuilder: (_, __) => const Gap.sm(),
      itemBuilder: (context, index) => const _SkeletonItem(),
    );
  }
}

class _SkeletonItem extends StatelessWidget {
  const _SkeletonItem();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.backgroundAlt,
      highlightColor: AppColors.surface,
      child: Container(
        padding: EdgeInsets.all(AppDimensions.spacing3),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        child: Row(
          children: [
            // Icon skeleton
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const Gap.md(),
            
            // Content skeleton
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Gap.sm(),
                  Container(
                    height: 12,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            
            // Amount skeleton
            Container(
              height: 20,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

🎯 CHECKPOINT 2: Test Component Library
dart// Create test screen to verify all components
// lib/test_components_screen.dart

import 'package:flutter/material.dart';
import 'shared/presentation/widgets/buttons/app_button.dart';
import 'shared/presentation/widgets/buttons/app_icon_button.dart';
import 'shared/presentation/widgets/cards/app_card.dart';
import 'shared/presentation/widgets/cards/balance_card.dart';
import 'shared/presentation/widgets/inputs/app_text_field.dart';
import 'shared/presentation/widgets/inputs/currency_input.dart';
import 'shared/presentation/widgets/states/empty_state.dart';
import 'shared/presentation/widgets/states/loading_skeleton.dart';
import 'core/theme/app_dimensions.dart';
import 'shared/presentation/widgets/common/gap.dart';

class TestComponentsScreen extends StatelessWidget {
  const TestComponentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Library Test'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Buttons Test
            AppButton(
              label: 'Primary Button',
              onPressed: () {},
            ),
            const Gap.md(),
            AppButton(
              label: 'Secondary Button',
              variant: AppButtonVariant.secondary,
              onPressed: () {},
            ),
            const Gap.md(),
            AppButton(
              label: 'With Icon',
              icon: Icons.add,
              onPressed: () {},
            ),
            const Gap.xl(),
            
            // Cards Test
            BalanceCard(
              title: 'Total Balance',
              balance: 1234.56,
              subtitle: 'As of today',
              metrics: [
                MetricItem(label: 'Income', value: '\$2,000', icon: Icons.trending_up),
                MetricItem(label: 'Expenses', value: '\$765', icon: Icons.trending_down),
              ],
            ),
            const Gap.xl(),
            
            // Input Test
            AppTextField(
              label: 'Description',
              hint: 'Enter description',
            ),
            const Gap.md(),
            CurrencyInput(
              label: 'Amount',
              controller: TextEditingController(),
            ),
            const Gap.xl(),
            
            // Empty State Test
            SizedBox(
              height: 300,
              child: EmptyState(
                icon: Icons.inbox,
                title: 'No Data',
                message: 'This is an empty state example',
                actionLabel: 'Add Item',
                onAction: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
✅ At this point, you should have:

✓ Complete design system foundation
✓ Reusable component library
✓ All utilities and extensions
✓ Test screen showing all components