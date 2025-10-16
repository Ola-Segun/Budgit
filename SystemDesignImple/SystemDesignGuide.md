# Complete Design System Analysis & Redesign for Budget Management App

## 📊 Analysis of Undesigned App Screenshots

### **Identified Screens & Components:**

#### 1. **Categories Screen** (Image 1)
- **Current Design:** Blue header, white list items with icons
- **Components:**
  - List of category items with colored icons
  - Edit/Delete actions per item
  - Bottom navigation bar
  - Add button in header

#### 2. **Bill Detail Screen** (Images 2-4)
- **Current Design:** Status badge, information cards, payment history
- **Components:**
  - Status indicator (Upcoming/Paid)
  - Amount display
  - Due date information
  - Bill information card
  - Linked account display
  - Payment history list
  - Action button (checkmark FAB)

#### 3. **Goals Screen** (Images 3-7)
- **Current Design:** Summary cards, active goals list, timeline
- **Components:**
  - Statistics cards (Total Goals, Completed, Total Target, Progress)
  - Goal cards with progress bars
  - Timeline visualization
  - Goal information table
  - Contribution history
  - Add contribution button

#### 4. **Home/Dashboard Screen** (Images 8-10)
- **Current Design:** Month selector, upcoming payments, recent transactions
- **Components:**
  - Month/period selector
  - Upcoming payments section (Bills/Income tabs)
  - Recent transactions list
  - Insights section (empty state)
  - Quick action buttons

#### 5. **Transaction Screens** (Images 1-2, 12-20)
- **Current Design:** Summary cards, filter options, swipe actions
- **Components:**
  - Monthly summary (Income/Expenses/Net)
  - Savings rate indicator
  - Transaction list grouped by date
  - Swipe actions (Edit/Delete/Duplicate/Category)
  - Filter system (Date, Category, Amount)
  - Search functionality
  - Empty states

#### 6. **Add Transaction/Category Modals** (Images 7, 11)
- **Current Design:** Bottom sheets with forms
- **Components:**
  - Category selector (icon grid)
  - Form fields
  - Action buttons

#### 7. **Bills & Subscriptions** (Images 13, 19-20)
- **Current Design:** Summary metrics, bill lists, income tracking
- **Components:**
  - Statistics cards
  - Filter toggles
  - Bill/Income lists
  - Quick action buttons

---

## 🎨 Redesign Strategy

### **Design Philosophy**
Combine:
- **TrackFinz:** Friendly illustrations, teal primary color, rounded friendly shapes
- **Pink App:** Clean minimalism, clear information hierarchy, efficient layouts
- **Modern Budget Tracker:** Professional yet approachable, data-driven design

### **Key Improvements:**
1. **Replace harsh blue (#2962FF)** with Modern Budget Tracker's teal (#14B8A6)
2. **Add friendly illustrations** to empty states
3. **Improve visual hierarchy** with better spacing and typography
4. **Enhance card designs** with subtle shadows and better grouping
5. **Modernize icons** with rounded outline style
6. **Add micro-animations** for better UX
7. **Implement consistent color coding** for transaction types

---

# 🎯 Complete Flutter Theming Setup

```dart
// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_typography.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Light Theme
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryLight,
        tertiary: AppColors.tertiary,
        background: AppColors.background,
        surface: AppColors.surface,
        surfaceVariant: AppColors.backgroundAlt,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
        outline: AppColors.border,
      ),
      
      // Typography
      textTheme: AppTypography.textTheme,
      
      // Scaffold
      scaffoldBackgroundColor: AppColors.background,
      
      // App Bar
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        titleTextStyle: AppTypography.h3.copyWith(
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24,
        ),
      ),
      
      // Card
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        color: AppColors.surface,
        shadowColor: Colors.black.withOpacity(0.06),
        margin: EdgeInsets.zero,
      ),
      
      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.neutral200,
          disabledForegroundColor: AppColors.textTertiary,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          textStyle: AppTypography.bodyMedium,
        ),
      ),
      
      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          textStyle: AppTypography.bodyMedium,
        ),
      ),
      
      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          textStyle: AppTypography.bodyMedium,
        ),
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: BorderSide(
            color: AppColors.border,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: BorderSide(
            color: AppColors.border,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
        labelStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
        hintStyle: AppTypography.body.copyWith(
          color: AppColors.textTertiary,
        ),
      ),
      
      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        selectedLabelStyle: AppTypography.caption.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTypography.caption,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // Dialog
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.surface,
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titleTextStyle: AppTypography.h3.copyWith(
          color: AppColors.textPrimary,
        ),
        contentTextStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      
      // Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        elevation: 24,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.backgroundAlt,
        selectedColor: AppColors.primary,
        disabledColor: AppColors.neutral200,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        labelStyle: AppTypography.bodySmall,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      
      // Divider
      dividerTheme: DividerThemeData(
        color: AppColors.borderSubtle,
        thickness: 1,
        space: 1,
      ),
      
      // List Tile
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        dense: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        titleTextStyle: AppTypography.body.copyWith(
          color: AppColors.textPrimary,
        ),
        subtitleTextStyle: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      
      // Progress Indicator
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.neutral200,
        circularTrackColor: AppColors.neutral200,
      ),
      
      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return Colors.white;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return AppColors.neutral300;
        }),
      ),
      
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // Radio
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return AppColors.neutral300;
        }),
      ),
      
      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.neutral200,
        thumbColor: Colors.white,
        overlayColor: AppColors.primary.withOpacity(0.2),
        valueIndicatorColor: AppColors.primary,
        valueIndicatorTextStyle: AppTypography.bodySmall.copyWith(
          color: Colors.white,
        ),
      ),
      
      // Snack Bar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTypography.bodySmall.copyWith(
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Tab Bar
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTypography.bodyMedium,
        unselectedLabelStyle: AppTypography.bodyMedium,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 3,
          ),
        ),
        indicatorSize: TabBarIndicatorSize.label,
      ),
      
      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.textPrimary.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTypography.bodySmall.copyWith(
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
      ),
    );
  }

  /// Dark Theme
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryLight,
        primaryContainer: AppColors.primary,
        secondary: AppColors.secondaryLight,
        secondaryContainer: AppColors.secondary,
        tertiary: AppColors.tertiaryLight,
        background: const Color(0xFF0F172A),
        surface: const Color(0xFF1E293B),
        surfaceVariant: const Color(0xFF334155),
        error: AppColors.error,
        onPrimary: AppColors.textPrimary,
        onSecondary: Colors.white,
        onBackground: const Color(0xFFF1F5F9),
        onSurface: const Color(0xFFF1F5F9),
        onError: Colors.white,
        outline: const Color(0xFF334155),
      ),
      
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      
      // Similar theme data as light theme with dark colors
      // ...
    );
  }
}

// lib/core/theme/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Private constructor

  // Primary Colors
  static const Color primary = Color(0xFF14B8A6);
  static const Color primaryLight = Color(0xFF5EEAD4);
  static const Color primaryDark = Color(0xFF0F766E);
  static const Color primaryAccent = Color(0xFF2DD4BF);

  // Secondary Colors
  static const Color secondary = Color(0xFFEC4899);
  static const Color secondaryLight = Color(0xFFF9A8D4);
  static const Color secondaryDark = Color(0xFFDB2777);

  // Tertiary Colors
  static const Color tertiary = Color(0xFF8B5CF6);
  static const Color tertiaryLight = Color(0xFFC4B5FD);
  static const Color tertiaryDark = Color(0xFF6D28D9);

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8FAFC);
  static const Color backgroundAlt = Color(0xFFF1F5F9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  
  // Borders
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderSubtle = Color(0xFFF1F5F9);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textDisabled = Color(0xFFCBD5E1);
  static const Color textInverse = Color(0xFFFFFFFF);
  static const Color textLink = Color(0xFF14B8A6);

  // Neutral Scale
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD4D4D4);
  static const Color neutral400 = Color(0xFFA3A3A3);
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral600 = Color(0xFF525252);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral800 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF171717);

  // Category Colors
  static const Color categoryFood = Color(0xFFF97316);
  static const Color categoryTransport = Color(0xFF3B82F6);
  static const Color categoryShopping = Color(0xFFEC4899);
  static const Color categoryEntertainment = Color(0xFF8B5CF6);
  static const Color categoryHealth = Color(0xFF10B981);
  static const Color categoryUtilities = Color(0xFF06B6D4);
  static const Color categoryHousing = Color(0xFF6366F1);
  static const Color categoryEducation = Color(0xFFFBBF24);
  static const Color categoryPersonal = Color(0xFFF59E0B);
  static const Color categoryBusiness = Color(0xFF14B8A6);
  static const Color categorySavings = Color(0xFF10B981);
  static const Color categoryInvestment = Color(0xFF8B5CF6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF14B8A6),
      Color(0xFF2DD4BF),
    ],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFEC4899),
      Color(0xFFF9A8D4),
    ],
  );

  // Overlay Colors
  static const Color overlay = Color(0x990F172A); // rgba(15, 23, 42, 0.6)
  static const Color overlayLight = Color(0x40000000);
}

// lib/core/theme/app_typography.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  // Base font family
  static String get fontFamily => GoogleFonts.inter().fontFamily!;
  static String get displayFontFamily => GoogleFonts.inter().fontFamily!;

  // Text Theme
  static TextTheme get textTheme => TextTheme(
        displayLarge: hero,
        displayMedium: display,
        displaySmall: h1,
        headlineLarge: h1,
        headlineMedium: h2,
        headlineSmall: h3,
        titleLarge: h2,
        titleMedium: h3,
        titleSmall: bodyMedium,
        bodyLarge: body,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: bodyMedium,
        labelMedium: caption,
        labelSmall: overline,
      );

  // Display Styles
  static final TextStyle hero = GoogleFonts.inter(
    fontSize: 56,
    height: 1.1,
    fontWeight: FontWeight.w800,
    letterSpacing: -2.5,
    color: AppColors.textPrimary,
  );

  static final TextStyle display = GoogleFonts.inter(
    fontSize: 40,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -1.5,
    color: AppColors.textPrimary,
  );

  // Heading Styles
  static final TextStyle h1 = GoogleFonts.inter(
    fontSize: 28,
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
    color: AppColors.textPrimary,
  );

  static final TextStyle h2 = GoogleFonts.inter(
    fontSize: 22,
    height: 1.3,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
    color: AppColors.textPrimary,
  );

  static final TextStyle h3 = GoogleFonts.inter(
    fontSize: 18,
    height: 1.4,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    color: AppColors.textPrimary,
  );

  // Body Styles
  static final TextStyle body = GoogleFonts.inter(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    color: AppColors.textSecondary,
  );

  // Supporting Styles
  static final TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    height: 1.4,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
  );

  static final TextStyle overline = GoogleFonts.inter(
    fontSize: 11,
    height: 1.4,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: AppColors.textSecondary,
  );

  // Currency Styles
  static final TextStyle currency = GoogleFonts.inter(
    fontSize: 32,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    color: AppColors.textPrimary,
    fontFeatures: [const FontFeature.tabularFigures()],
  );

  static final TextStyle currencyLarge = GoogleFonts.inter(
    fontSize: 48,
    height: 1.1,
    fontWeight: FontWeight.w700,
    letterSpacing: -2,
    color: AppColors.textPrimary,
    fontFeatures: [const FontFeature.tabularFigures()],
  );

  // Button Text
  static final TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    color: Colors.white,
  );
}

// lib/core/theme/app_dimensions.dart

class AppDimensions {
  AppDimensions._();

  // Border Radius
  static const double radiusXs = 6;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radius2xl = 24;
  static const double radius3xl = 28;
  static const double radiusFull = 9999;

  // Spacing
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
  static const double spacing14 = 56;
  static const double spacing16 = 64;

  // Semantic Spacing
  static const double screenPaddingH = 16;
  static const double screenPaddingV = 16;
  static const double cardPadding = 16;
  static const double cardPaddingLarge = 20;
  static const double listItemPadding = 12;
  static const double sectionGap = 24;
  static const double componentGap = 16;
  static const double tightGap = 8;

  // Icon Sizes
  static const double iconXs = 16;
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 28;
  static const double iconXl = 32;
  static const double icon2xl = 40;

  // Button Heights
  static const double buttonHeightSm = 36;
  static const double buttonHeightMd = 48;
  static const double buttonHeightLg = 56;

  // Category Icon
  static const double categoryIconSize = 48;
  static const double categoryIconRadius = 12;

  // Avatar Sizes
  static const double avatarXs = 24;
  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarLg = 56;
  static const double avatarXl = 72;
  static const double avatar2xl = 96;

  // Card Dimensions
  static const double cardMinHeight = 80;
  static const double balanceCardHeight = 180;

  // Bottom Sheet
  static const double bottomSheetRadius = 24;
  static const double bottomSheetHandleWidth = 36;
  static const double bottomSheetHandleHeight = 4;

  // App Bar
  static const double appBarHeight = 56;

  // Bottom Navigation
  static const double bottomNavHeight = 72;

  // FAB
  static const double fabSize = 56;
  static const double fabRadius = 16;
}
```

---

# 📱 Complete JSON Design System for Redesigned Budget App

```json
{
  "budgetManagementApp": {
    "metadata": {
      "appName": "Budget Management Pro",
      "version": "2.0.0",
      "designSystem": "Hybrid: TrackFinz + Pink App + Modern Budget Tracker",
      "platform": "Flutter (iOS/Android)",
      "lastUpdated": "2025-01-16"
    },
    
    "screens": {
      "homeScreen": {
        "route": "/home",
        "title": "Home",
        "layout": {
          "type": "scroll",
          "padding": 16,
          "backgroundColor": "#F8FAFC"
        },
        "components": [
          {
            "id": "monthSelector",
            "type": "header",
            "position": "top",
            "sticky": false,
            "design": {
              "height": 64,
              "paddingHorizontal": 16,
              "paddingVertical": 12,
              "backgroundColor": "transparent",
              "layout": "horizontal",
              "justifyContent": "space-between",
              "components": {
                "title": {
                  "text": "October 2025",
                  "fontSize": 28,
                  "fontWeight": 700,
                  "color": "#0F172A"
                },
                "actions": [
                  {
                    "type": "iconButton",
                    "icon": "settings",
                    "size": 24,
                    "color": "#475569"
                  },
                  {
                    "type": "iconButton",
                    "icon": "bell",
                    "size": 24,
                    "color": "#475569",
                    "badge": true
                  }
                ]
              }
            }
          },
          {
            "id": "monthSummaryCard",
            "type": "card",
            "margin": {"top": 16, "bottom": 24},
            "design": {
              "borderRadius": 20,
              "padding": 24,
              "background": "linear-gradient(135deg, #14B8A6 0%, #2DD4BF 100%)",
              "elevation": 2,
              "content": {
                "layout": "vertical",
                "header": {
                  "label": "This Month",
                  "fontSize": 14,
                  "fontWeight": 500,
                  "color": "#FFFFFF",
                  "opacity": 0.9
                },
                "metrics": {
                  "layout": "horizontal",
                  "gap": 16,
                  "marginTop": 16,
                  "items": [
                    {
                      "type": "metric",
                      "label": "Income",
                      "value": "$1000.00",
                      "icon": "trending-up",
                      "iconColor": "#FFFFFF",
                      "textColor": "#FFFFFF",
                      "fontSize": 14,
                      "valueFontSize": 18,
                      "valueWeight": 700
                    },
                    {
                      "type": "metric",
                      "label": "Expenses",
                      "value": "$300.00",
                      "icon": "trending-down",
                      "iconColor": "#FFFFFF",
                      "textColor": "#FFFFFF",
                      "fontSize": 14,
                      "valueFontSize": 18,
                      "valueWeight": 700
                    },
                    {
                      "type": "metric",
                      "label": "Net Worth",
                      "value": "$700.00",
                      "icon": "plus",
                      "iconColor": "#FFFFFF",
                      "textColor": "#FFFFFF",
                      "fontSize": 14,
                      "valueFontSize": 18,
                      "valueWeight": 700
                    }
                  ]
                },
                "totalBalance": {
                  "marginTop": 16,
                  "value": "$700.00",
                  "fontSize": 40,
                  "fontWeight": 700,
                  "color": "#FFFFFF",
                  "letterSpacing": -1.5
                }
              }
            }
          },
          {
            "id": "quickActions",
            "type": "actionRow",
            "margin": {"bottom": 24},
            "design": {
              "layout": "horizontal",
              "gap": 12,
              "scrollable": true,
              "items": [
                {
                  "type": "actionCard",
                  "icon": "plus",
                  "label": "Add Transaction",
                  "iconSize": 24,
                  "width": 120,
                  "height": 100,
                  "borderRadius": 16,
                  "backgroundColor": "#F0FDFA",
                  "iconColor": "#14B8A6",
                  "textColor": "#0F172A",
                  "fontSize": 13,
                  "fontWeight": 600
                },
                {
                  "type": "actionCard",
                  "icon": "credit-card",
                  "label": "View Accounts",
                  "iconSize": 24,
                  "width": 120,
                  "height": 100,
                  "borderRadius": 16,
                  "backgroundColor": "#EFF6FF",
                  "iconColor": "#3B82F6",
                  "textColor": "#0F172A",
                  "fontSize": 13,
                  "fontWeight": 600
                },
                {
                  "type": "actionCard",
                  "icon": "repeat",
                  "label": "Recurring Income",
                  "iconSize": 24,
                  "width": 120,
                  "height": 100,
                  "borderRadius": 16,
                  "backgroundColor": "#FEFCE8",
                  "iconColor": "#F59E0B",
                  "textColor": "#0F172A",
                  "fontSize": 13,
                  "fontWeight": 600
                },
                {
                  "type": "actionCard",
                  "icon": "camera",
                  "label": "Scan Receipt",
                  "iconSize": 24,
                  "width": 120,
                  "height": 100,
                  "borderRadius": 16,
                  "backgroundColor": "#FCE7F3",
                  "iconColor": "#EC4899",
                  "textColor": "#0F172A",
                  "fontSize": 13,
                  "fontWeight": 600
                }
              ]
            }
          },
          {
            "id": "budgetOverviewSection",
            "type": "section",
            "design": {
              "header": {
                "title": "Budget Overview",
                "fontSize": 22,
                "fontWeight": 600,
                "color": "#0F172A",
                "action": {
                  "label": "See All",
                  "fontSize": 14,
                  "fontWeight": 600,
                  "color": "#14B8A6"
                }
              },
              "marginBottom": 16
            }
          },
          {
            "id": "budgetGrid",
            "type": "grid",
            "margin": {"bottom": 24},
            "design": {
              "columns": 2,
              "gap": 12,
              "items": [
                {
                  "type": "budgetCard",
                  "category": "Car Purchase",
                  "icon": "car",
                  "iconColor": "#3B82F6",
                  "iconBackground": "#EFF6FF",
                  "spent": 200,
                  "budget": 1000,
                  "borderRadius": 16,
                  "padding": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 1,
                  "progressBar": {
                    "height": 8,
                    "borderRadius": 4,
                    "backgroundColor": "#E2E8F0",
                    "fillColor": "#3B82F6"
                  }
                },
                {
                  "type": "budgetCard",
                  "category": "Utilities",
                  "icon": "zap",
                  "iconColor": "#06B6D4",
                  "iconBackground": "#ECFEFF",
                  "spent": 100,
                  "budget": 500,
                  "borderRadius": 16,
                  "padding": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 1,
                  "progressBar": {
                    "height": 8,
                    "borderRadius": 4,
                    "backgroundColor": "#E2E8F0",
                    "fillColor": "#06B6D4"
                  }
                }
              ]
            }
          },
          {
            "id": "upcomingPaymentsSection",
            "type": "section",
            "design": {
              "header": {
                "title": "Upcoming Payments & Income",
                "fontSize": 22,
                "fontWeight": 600,
                "color": "#0F172A",
                "action": {
                  "label": "View All",
                  "fontSize": 14,
                  "fontWeight": 600,
                  "color": "#14B8A6"
                }
              },
              "marginBottom": 16
            }
          },
          {
            "id": "upcomingPaymentsTabs",
            "type": "segmentedControl",
            "margin": {"bottom": 16},
            "design": {
              "backgroundColor": "#F8FAFC",
              "borderRadius": 12,
              "padding": 4,
              "height": 44,
              "segments": [
                {
                  "label": "Bills",
                  "value": "bills"
                },
                {
                  "label": "Income",
                  "value": "income"
                }
              ],
              "selectedBackgroundColor": "#FFFFFF",
              "selectedTextColor": "#14B8A6",
              "unselectedTextColor": "#64748B",
              "fontSize": 14,
              "fontWeight": 600,
              "elevation": 0.5
            }
          },
          {
            "id": "upcomingPaymentsList",
            "type": "list",
            "margin": {"bottom": 24},
            "design": {
              "items": [
                {
                  "type": "paymentItem",
                  "title": "Bill 1",
                  "subtitle": "Due in 30 days",
                  "amount": "$50.00",
                  "status": "upcoming",
                  "statusColor": "#14B8A6",
                  "borderLeft": {
                    "width": 4,
                    "color": "#3B82F6",
                    "radius": 12
                  },
                  "padding": 16,
                  "backgroundColor": "#FFFFFF",
                  "borderRadius": 12,
                  "marginBottom": 8,
                  "elevation": 0.5
                },
                {
                  "type": "paymentItem",
                  "title": "income 2",
                  "subtitle": "14 overdue",
                  "amount": "+$200.00",
                  "status": "overdue",
                  "statusColor": "#EF4444",
                  "borderLeft": {
                    "width": 4,
                    "color": "#EF4444",
                    "radius": 12
                  },
                  "padding": 16,
                  "backgroundColor": "#FFFFFF",
                  "borderRadius": 12,
                  "marginBottom": 8,
                  "elevation": 0.5
                }
              ]
            }
          },
          {
            "id": "recentTransactionsSection",
            "type": "section",
            "design": {
              "header": {
                "title": "Recent Transactions",
                "fontSize": 22,
                "fontWeight": 600,
                "color": "#0F172A",
                "action": {
                  "label": "View All",
                  "fontSize": 14,
                  "fontWeight": 600,
                  "color": "#14B8A6"
                }
              },
              "marginBottom": 16
            }
          },
          {
            "id": "recentTransactionsList",
            "type": "groupedList",
            "design": {
              "groupBy": "date",
              "dateFormat": "Today, Yesterday, MMM dd",
              "items": [
                {
                  "date": "Today",
                  "transactions": [
                    {
                      "type": "transactionItem",
                      "title": "Transaction",
                      "subtitle": "salary • 01:32",
                      "amount": "+$200.00",
                      "amountColor": "#10B981",
                      "icon": {
                        "name": "trending-up",
                        "size": 24,
                        "color": "#10B981",
                        "backgroundColor": "#D1FAE5",
                        "borderRadius": 12,
                        "containerSize": 48
                      },
                      "padding": 12,
                      "backgroundColor": "#FFFFFF",
                      "borderRadius": 14,
                      "marginBottom": 8,
                      "elevation": 0.5,
                      "swipeActions": {
                        "left": [],
                        "right": [
                          {
                            "type": "edit",
                            "backgroundColor": "#3B82F6",
                            "icon": "edit",
                            "label": "Edit"
                          },
                          {
                            "type": "delete",
                            "backgroundColor": "#EF4444",
                            "icon": "trash",
                            "label": "Delete"
                          }
                        ]
                      }
                    }
                  ]
                }
              ]
            }
          },
          {
            "id": "insightsSection",
            "type": "section",
            "design": {
              "header": {
                "title": "Insights",
                "fontSize": 22,
                "fontWeight": 600,
                "color": "#0F172A"
              },
              "marginBottom": 16
            }
          },
          {
            "id": "insightsEmpty",
            "type": "emptyState",
            "design": {
              "padding": 40,
              "borderRadius": 16,
              "backgroundColor": "#FFFFFF",
              "elevation": 0.5,
              "illustration": {
                "type": "lottie",
                "asset": "insights_empty.json",
                "size": 180
              },
              "title": {
                "text": "No insights available",
                "fontSize": 16,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginTop": 16
              },
              "message": {
                "text": "Track more transactions to see personalized insights",
                "fontSize": 14,
                "color": "#64748B",
                "marginTop": 8,
                "textAlign": "center"
              }
            }
          }
        ],
        "fab": {
          "type": "extended",
          "icon": "plus",
          "label": "Add",
          "size": 56,
          "borderRadius": 16,
          "backgroundColor": "#14B8A6",
          "iconColor": "#FFFFFF",
          "textColor": "#FFFFFF",
          "elevation": 4,
          "position": "bottom-right",
          "margin": 16
        }
      },
      
      "transactionsScreen": {
        "route": "/transactions",
        "title": "Transactions",
        "layout": {
          "type": "scroll",
          "padding": 0,
          "backgroundColor": "#F8FAFC"
        },
        "appBar": {
          "backgroundColor": "#14B8A6",
          "foregroundColor": "#FFFFFF",
          "elevation": 0,
          "title": "Transactions",
          "centerTitle": true,
          "actions": [
            {
              "type": "iconButton",
              "icon": "more-vertical",
              "color": "#FFFFFF"
            }
          ]
        },
        "components": [
          {
            "id": "filterChips",
            "type": "chipRow",
            "padding": 16,
            "backgroundColor": "#FFFFFF",
            "design": {
              "layout": "horizontal",
              "scrollable": true,
              "gap": 8,
              "chips": [
                {
                  "type": "filterChip",
                  "icon": "search",
                  "iconOnly": true,
                  "size": 40,
                  "borderRadius": 12,
                  "backgroundColor": "#F8FAFC",
                  "iconColor": "#475569"
                },
                {
                  "type": "filterChip",
                  "icon": "calendar",
                  "label": "Date",
                  "height": 40,
                  "paddingHorizontal": 16,
                  "borderRadius": 12,
                  "backgroundColor": "#F8FAFC",
                  "textColor": "#0F172A",
                  "iconColor": "#14B8A6",
                  "fontSize": 14,
                  "fontWeight": 600
                },
                {
                  "type": "filterChip",
                  "icon": "tag",
                  "label": "Category",
                  "height": 40,
                  "paddingHorizontal": 16,
                  "borderRadius": 12,
                  "backgroundColor": "#F8FAFC",
                  "textColor": "#0F172A",
                  "iconColor": "#14B8A6",
                  "fontSize": 14,
                  "fontWeight": 600
                },
                {
                  "type": "filterChip",
                  "icon": "dollar-sign",
                  "label": "Amount",
                  "height": 40,
                  "paddingHorizontal": 16,
                  "borderRadius": 12,
                  "backgroundColor": "#F8FAFC",
                  "textColor": "#0F172A",
                  "iconColor": "#14B8A6",
                  "fontSize": 14,
                  "fontWeight": 600
                }
              ]
            }
          },
          {
            "id": "monthlySummary",
            "type": "card",
            "margin": {"horizontal": 16, "top": 16, "bottom": 16},
            "design": {
              "borderRadius": 16,
              "padding": 20,
              "backgroundColor": "#FFFFFF",
              "elevation": 0.5,
              "header": {
                "text": "This Month",
                "fontSize": 16,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 16
              },
              "metrics": {
                "layout": "horizontal",
                "gap": 12,
                "items": [
                  {
                    "label": "Income",
                    "value": "$2000.00",
                    "icon": "trending-up",
                    "backgroundColor": "#D1FAE5",
                    "textColor": "#10B981",
                    "flex": 1,
                    "padding": 12,
                    "borderRadius": 12,
                    "fontSize": 13,
                    "valueFontSize": 18,
                    "valueWeight": 700
                  },
                  {
                    "label": "Expenses",
                    "value": "$350.00",
                    "icon": "trending-down",
                    "backgroundColor": "#FEE2E2",
                    "textColor": "#EF4444",
                    "flex": 1,
                    "padding": 12,
                    "borderRadius": 12,
                    "fontSize": 13,
                    "valueFontSize": 18,
                    "valueWeight": 700
                  },
                  {
                    "label": "Net",
                    "value": "+$1650.00",
                    "icon": "plus",
                    "backgroundColor": "#F0FDFA",
                    "textColor": "#14B8A6",
                    "flex": 1,
                    "padding": 12,
                    "borderRadius": 12,
                    "fontSize": 13,
                    "valueFontSize": 18,
                    "valueWeight": 700
                  }
                ]
              },
              "savingsRate": {
                "icon": "thumbs-up",
                "iconColor": "#F59E0B",
                "label": "Savings Rate: 82.5%",
                "fontSize": 13,
                "fontWeight": 600,
                "color": "#F59E0B",
                "marginTop": 12
              },
              "transactionCount": {
                "text": "4 transactions",
                "fontSize": 12,
                "color": "#94A3B8",
                "marginTop": 4
              }
            }
          },
          {
            "id": "transactionsList",
            "type": "groupedList",
            "padding": {"horizontal": 16, "bottom": 16},
            "design": {
              "groupBy": "date",
              "groupHeader": {
                "fontSize": 16,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 12,
                "marginTop": 16
              },
              "items": [
                {
                  "date": "Today",
                  "transactions": [
                    {
                      "id": "tx1",
                      "type": "transactionTile",
                      "title": "Sales",
                      "subtitle": "monthly sales\nOther • Account savings • Oct 09",
                      "amount": "+$500.00",
                      "amountColor": "#10B981",
                      "time": "07:34",
                      "icon": {
                        "name": "briefcase",
                        "backgroundColor": "#EFF6FF",
                        "iconColor": "#3B82F6",
                        "size": 48,
                        "iconSize": 24,
                        "borderRadius": 12
                      },
                      "backgroundColor": "#FFFFFF",
                      "borderRadius": 14,
                      "padding": 12,
                      "marginBottom": 8,
                      "elevation": 0.5,
                      "swipeActions": {
                        "enabled": true,
                        "threshold": 0.3
                      }
                    }
                  ]
                },
                {
                  "date": "Yesterday",
                  "transactions": [
                    {
                      "id": "tx2",
                      "type": "transactionTile",
                      "title": "Critical Health Dues",
                      "subtitle": "An Emergency Health treatments payment\nHealthcare • Account checking • Oct 08",
                      "amount": "-$500.00",
                      "amountColor": "#EF4444",
                      "icon": {
                        "name": "heart",
                        "backgroundColor": "#FEE2E2",
                        "iconColor": "#EF4444",
                        "size": 48,
                        "iconSize": 24,
                        "borderRadius": 12
                      },
                      "backgroundColor": "#FFFFFF",
                      "borderRadius": 14,
                      "padding": 12,
                      "marginBottom": 8,
                      "elevation": 0.5
                    }
                  ]
                }
              ]
            }
          },
          {
            "id": "loadMoreButton",
            "type": "button",
            "margin": {"horizontal": 16, "bottom": 24},
            "design": {
              "variant": "secondary",
              "label": "Load More",
              "icon": "chevron-down",
              "height": 48,
              "borderRadius": 12,
              "backgroundColor": "#F8FAFC",
              "textColor": "#14B8A6",
              "fontSize": 16,
              "fontWeight": 600
            }
          }
        ],
        "emptyState": {
          "illustration": {
            "type": "lottie",
            "asset": "empty_transactions.json",
            "size": 200
          },
          "title": "No transactions yet",
          "message": "Add your first transaction to get started",
          "actionButton": {
            "label": "Add Transaction",
            "icon": "plus",
            "backgroundColor": "#14B8A6",
            "textColor": "#FFFFFF"
          }
        },
        "fab": {
          "type": "standard",
          "icon": "plus",
          "label": "Add",
          "size": 56,
          "borderRadius": 16,
          "backgroundColor": "#14B8A6",
          "iconColor": "#FFFFFF",
          "elevation": 4,
          "position": "bottom-right",
          "margin": 16
        }
      },
      
      "categoriesScreen": {
        "route": "/categories",
        "title": "Categories",
        "layout": {
          "type": "scroll",
          "padding": 0,
          "backgroundColor": "#F8FAFC"
        },
        "appBar": {
          "backgroundColor": "#14B8A6",
          "foregroundColor": "#FFFFFF",
          "elevation": 0,
          "leading": {
            "type": "backButton",
            "icon": "arrow-left",
            "color": "#FFFFFF"
          },
          "title": "Categories",
          "centerTitle": true,
          "actions": [
            {
              "type": "iconButton",
              "icon": "plus",
              "color": "#FFFFFF"
            }
          ]
        },
        "components": [
          {
            "id": "categoryList",
            "type": "list",
            "padding": 16,
            "design": {
              "gap": 8,
              "items": [
                {
                  "type": "categoryItem",
                  "name": "Car Purchase",
                  "subtitle": "Expense",
                  "icon": {
                    "name": "car",
                    "backgroundColor": "#EFF6FF",
                    "iconColor": "#3B82F6",
                    "size": 48,
                    "iconSize": 24,
                    "borderRadius": 12
                  },
                  "actions": [
                    {
                      "type": "iconButton",
                      "icon": "edit",
                      "color": "#64748B",
                      "size": 40,
                      "backgroundColor": "#F8FAFC",
                      "borderRadius": 10
                    },
                    {
                      "type": "iconButton",
                      "icon": "trash",
                      "color": "#64748B",
                      "size": 40,
                      "backgroundColor": "#F8FAFC",
                      "borderRadius": 10
                    }
                  ],
                  "padding": 16,
                  "backgroundColor": "#FFFFFF",
                  "borderRadius": 14,
                  "elevation": 0.5
                },
                {
                  "type": "categoryItem",
                  "name": "Food & Dining",
                  "subtitle": "Expense",
                  "icon": {
                    "name": "utensils",
                    "backgroundColor": "#FEF3C7",
                    "iconColor": "#F97316",
                    "size": 48,
                    "iconSize": 24,
                    "borderRadius": 12
                  },
                  "actions": [
                    {
                      "type": "iconButton",
                      "icon": "edit",
                      "color": "#64748B",
                      "size": 40,
                      "backgroundColor": "#F8FAFC",
                      "borderRadius": 10
                    },
                    {
                      "type": "iconButton",
                      "icon": "trash",
                      "color": "#64748B",
                      "size": 40,
                      "backgroundColor": "#F8FAFC",
                      "borderRadius": 10
                    }
                  ],
                  "padding": 16,
                  "backgroundColor": "#FFFFFF",
                  "borderRadius": 14,
                  "elevation": 0.5
                }
              ]
            }
          }
        ]
      },
      
      "goalsScreen": {
        "route": "/goals",
        "title": "Goals",
        "layout": {
          "type": "scroll",
          "padding": 16,
          "backgroundColor": "#F8FAFC"
        },
        "appBar": {
          "backgroundColor": "#14B8A6",
          "foregroundColor": "#FFFFFF",
          "elevation": 0,
          "title": "Goals",
          "centerTitle": true,
          "actions": [
            {
              "type": "iconButton",
              "icon": "plus",
              "color": "#FFFFFF"
            }
          ]
        },
        "components": [
          {
            "id": "goalsSummaryGrid",
            "type": "grid",
            "margin": {"bottom": 24},
            "design": {
              "columns": 2,
              "gap": 12,
              "items": [
                {
                  "type": "metricCard",
                  "icon": "flag",
                  "iconColor": "#3B82F6",
                  "iconBackground": "#EFF6FF",
                  "value": "2",
                  "label": "Total Goals",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                },
                {
                  "type": "metricCard",
                  "icon": "check-circle",
                  "iconColor": "#10B981",
                  "iconBackground": "#D1FAE5",
                  "value": "0/2",
                  "label": "Completed",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                },
                {
                  "type": "metricCard",
                  "icon": "dollar-sign",
                  "iconColor": "#EC4899",
                  "iconBackground": "#FCE7F3",
                  "value": "$5700",
                  "label": "Total Target",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                },
                {
                  "type": "metricCard",
                  "icon": "trending-up",
                  "iconColor": "#F59E0B",
                  "iconBackground": "#FEF3C7",
                  "value": "9%",
                  "label": "Progress",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                }
              ]
            }
          },
          {
            "id": "activeGoalsHeader",
            "type": "sectionHeader",
            "margin": {"bottom": 16},
            "design": {
              "title": "Active Goals",
              "fontSize": 22,
              "fontWeight": 600,
              "color": "#0F172A"
            }
          },
          {
            "id": "goalsList",
            "type": "list",
            "design": {
              "gap": 12,
              "items": [
                {
                  "type": "goalCard",
                  "title": "Mercedes Benz",
                  "description": "A new car",
                  "current": 500,
                  "target": 5000,
                  "percentage": 10,
                  "daysLeft": 364,
                  "priority": "Medium",
                  "categoryIcon": {
                    "name": "car",
                    "backgroundColor": "#EFF6FF",
                    "iconColor": "#3B82F6",
                    "size": 56,
                    "iconSize": 28,
                    "borderRadius": 12
                  },
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5,
                  "progressBar": {
                    "height": 8,
                    "borderRadius": 4,
                    "backgroundColor": "#E2E8F0",
                    "fillColor": "#14B8A6",
                    "marginTop": 12,
                    "marginBottom": 12
                  },
                  "footer": {
                    "layout": "horizontal",
                    "justifyContent": "space-between",
                    "current": {
                      "fontSize": 20,
                      "fontWeight": 700,
                      "color": "#14B8A6"
                    },
                    "target": {
                      "fontSize": 16,
                      "color": "#64748B"
                    },
                    "badge": {
                      "text": "Medium",
                      "backgroundColor": "#FEF3C7",
                      "textColor": "#F59E0B",
                      "padding": {"horizontal": 10, "vertical": 6},
                      "borderRadius": 8,
                      "fontSize": 12,
                      "fontWeight": 600
                    }
                  }
                },
                {
                  "type": "goalCard",
                  "title": "iPhone 16",
                  "description": "A new Phone",
                  "current": 0,
                  "target": 700,
                  "percentage": 0,
                  "daysLeft": 364,
                  "priority": "Medium",
                  "categoryIcon": {
                    "name": "smartphone",
                    "backgroundColor": "#FCE7F3",
                    "iconColor": "#EC4899",
                    "size": 56,
                    "iconSize": 28,
                    "borderRadius": 12
                  },
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5,
                  "progressBar": {
                    "height": 8,
                    "borderRadius": 4,
                    "backgroundColor": "#E2E8F0",
                    "fillColor": "#E2E8F0",
                    "marginTop": 12,
                    "marginBottom": 12
                  }
                }
              ]
            }
          }
        ]
      },
      
      "goalDetailScreen": {
"route": "/goals/:id",
        "title": "Goal Details",
        "layout": {
          "type": "scroll",
          "padding": 16,
          "backgroundColor": "#F8FAFC"
        },
        "appBar": {
          "backgroundColor": "#14B8A6",
          "foregroundColor": "#FFFFFF",
          "elevation": 0,
          "leading": {
            "type": "backButton",
            "icon": "arrow-left",
            "color": "#FFFFFF"
          },
          "title": "Goal Title",
          "centerTitle": true,
          "actions": [
            {
              "type": "iconButton",
              "icon": "more-vertical",
              "color": "#FFFFFF"
            }
          ]
        },
        "components": [
          {
            "id": "goalProgressCard",
            "type": "card",
            "margin": {"bottom": 16},
            "design": {
              "borderRadius": 20,
              "padding": 24,
              "background": "linear-gradient(135deg, #14B8A6 0%, #2DD4BF 100%)",
              "elevation": 2,
              "categoryIcon": {
                "name": "car",
                "size": 56,
                "iconSize": 28,
                "backgroundColor": "rgba(255, 255, 255, 0.2)",
                "iconColor": "#FFFFFF",
                "borderRadius": 14,
                "marginBottom": 16
              },
              "title": {
                "text": "Mercedes Benz",
                "fontSize": 24,
                "fontWeight": 700,
                "color": "#FFFFFF",
                "marginBottom": 8
              },
              "category": {
                "text": "Car Purchase",
                "fontSize": 14,
                "fontWeight": 500,
                "color": "#FFFFFF",
                "opacity": 0.9
              },
              "progressSection": {
                "marginTop": 20,
                "progressBar": {
                  "height": 10,
                  "borderRadius": 5,
                  "backgroundColor": "rgba(255, 255, 255, 0.3)",
                  "fillColor": "#FFFFFF",
                  "marginBottom": 12
                },
                "percentage": {
                  "text": "10% Complete",
                  "fontSize": 16,
                  "fontWeight": 600,
                  "color": "#FFFFFF",
                  "marginBottom": 8
                },
                "amounts": {
                  "layout": "horizontal",
                  "justifyContent": "space-between",
                  "current": {
                    "label": "Current",
                    "value": "$500.00",
                    "fontSize": 14,
                    "labelColor": "rgba(255, 255, 255, 0.8)",
                    "valueColor": "#FFFFFF",
                    "valueWeight": 700
                  },
                  "target": {
                    "label": "Target",
                    "value": "$5000.00",
                    "fontSize": 14,
                    "labelColor": "rgba(255, 255, 255, 0.8)",
                    "valueColor": "#FFFFFF",
                    "valueWeight": 700
                  }
                },
                "remaining": {
                  "layout": "horizontal",
                  "justifyContent": "space-between",
                  "marginTop": 12,
                  "remaining": {
                    "label": "Remaining",
                    "value": "$4500.00",
                    "fontSize": 14,
                    "labelColor": "rgba(255, 255, 255, 0.8)",
                    "valueColor": "#FFFFFF"
                  },
                  "daysLeft": {
                    "label": "Days Left",
                    "value": "364",
                    "fontSize": 14,
                    "labelColor": "rgba(255, 255, 255, 0.8)",
                    "valueColor": "#FFFFFF"
                  }
                }
              }
            }
          },
          {
            "id": "timelineCard",
            "type": "card",
            "margin": {"bottom": 16},
            "design": {
              "borderRadius": 16,
              "padding": 20,
              "backgroundColor": "#FFFFFF",
              "elevation": 0.5,
              "header": {
                "icon": "clock",
                "iconColor": "#14B8A6",
                "title": "Timeline",
                "fontSize": 18,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 20
              },
              "timeline": {
                "type": "horizontal",
                "items": [
                  {
                    "label": "Started",
                    "date": "Oct 16",
                    "status": "completed",
                    "dotColor": "#14B8A6"
                  },
                  {
                    "label": "Target",
                    "date": "Oct 16",
                    "status": "pending",
                    "dotColor": "#E2E8F0"
                  }
                ],
                "lineColor": "#E2E8F0",
                "lineHeight": 2,
                "dotSize": 12
              },
              "details": {
                "marginTop": 20,
                "rows": [
                  {
                    "label": "Days Remaining",
                    "value": "364",
                    "fontSize": 14,
                    "labelColor": "#64748B",
                    "valueColor": "#0F172A",
                    "valueWeight": 600
                  },
                  {
                    "label": "Target Date",
                    "value": "October 14, 2026",
                    "fontSize": 14,
                    "labelColor": "#64748B",
                    "valueColor": "#0F172A"
                  },
                  {
                    "label": "Projected Completion",
                    "value": "Oct 25, 2025",
                    "fontSize": 14,
                    "labelColor": "#64748B",
                    "valueColor": "#14B8A6",
                    "valueWeight": 600
                  }
                ]
              }
            }
          },
          {
            "id": "goalInformationCard",
            "type": "card",
            "margin": {"bottom": 16},
            "design": {
              "borderRadius": 16,
              "padding": 20,
              "backgroundColor": "#FFFFFF",
              "elevation": 0.5,
              "header": {
                "text": "Goal Information",
                "fontSize": 18,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 16
              },
              "infoRows": [
                {
                  "label": "Category",
                  "value": "Car Purchase",
                  "icon": "tag"
                },
                {
                  "label": "Priority",
                  "value": "Medium",
                  "icon": "flag",
                  "valueBadge": {
                    "backgroundColor": "#FEF3C7",
                    "textColor": "#F59E0B"
                  }
                },
                {
                  "label": "Target Amount",
                  "value": "$5000.00",
                  "icon": "dollar-sign"
                },
                {
                  "label": "Current Amount",
                  "value": "$500.00",
                  "icon": "wallet"
                },
                {
                  "label": "Remaining",
                  "value": "$4500.00",
                  "icon": "trending-down"
                },
                {
                  "label": "Monthly Needed",
                  "value": "$370.88",
                  "icon": "calendar",
                  "valueColor": "#14B8A6",
                  "valueWeight": 600
                }
              ],
              "rowStyle": {
                "layout": "horizontal",
                "justifyContent": "space-between",
                "paddingVertical": 12,
                "borderBottom": "1px solid #F1F5F9",
                "labelFontSize": 14,
                "labelColor": "#64748B",
                "valueFontSize": 14,
                "valueColor": "#0F172A",
                "iconSize": 20,
                "iconColor": "#94A3B8"
              },
              "description": {
                "marginTop": 16,
                "label": "Description",
                "text": "A new car",
                "fontSize": 14,
                "labelColor": "#64748B",
                "textColor": "#0F172A",
                "marginTop": 4
              }
            }
          },
          {
            "id": "contributionHistorySection",
            "type": "section",
            "design": {
              "header": {
                "title": "Contribution History",
                "fontSize": 18,
                "fontWeight": 600,
                "color": "#0F172A",
                "action": {
                  "label": "View All",
                  "fontSize": 14,
                  "fontWeight": 600,
                  "color": "#14B8A6"
                }
              },
              "marginBottom": 16
            }
          },
          {
            "id": "contributionList",
            "type": "list",
            "margin": {"bottom": 24},
            "design": {
              "items": [
                {
                  "type": "contributionItem",
                  "amount": "$500.00",
                  "date": "Oct 16, 2025",
                  "note": "Initial contribution",
                  "icon": {
                    "name": "plus-circle",
                    "backgroundColor": "#D1FAE5",
                    "iconColor": "#10B981",
                    "size": 40,
                    "iconSize": 20,
                    "borderRadius": 10
                  },
                  "padding": 16,
                  "backgroundColor": "#FFFFFF",
                  "borderRadius": 14,
                  "marginBottom": 8,
                  "elevation": 0.5
                }
              ]
            }
          },
          {
            "id": "contributionEmpty",
            "type": "emptyState",
            "design": {
              "padding": 40,
              "borderRadius": 16,
              "backgroundColor": "#FFFFFF",
              "elevation": 0.5,
              "illustration": {
                "type": "icon",
                "name": "trending-up",
                "size": 64,
                "color": "#CBD5E1"
              },
              "title": {
                "text": "No contributions yet",
                "fontSize": 16,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginTop": 16
              },
              "message": {
                "text": "Start contributing to reach your goal",
                "fontSize": 14,
                "color": "#64748B",
                "marginTop": 8
              }
            }
          }
        ],
        "fab": {
          "type": "standard",
          "icon": "plus",
          "size": 56,
          "borderRadius": 16,
          "backgroundColor": "#14B8A6",
          "iconColor": "#FFFFFF",
          "elevation": 4,
          "position": "bottom-right",
          "margin": 16,
          "action": "addContribution"
        }
      },
      
      "billsScreen": {
        "route": "/bills",
        "title": "Bills & Subscriptions",
        "layout": {
          "type": "scroll",
          "padding": 16,
          "backgroundColor": "#F8FAFC"
        },
        "appBar": {
          "backgroundColor": "#14B8A6",
          "foregroundColor": "#FFFFFF",
          "elevation": 0,
          "leading": {
            "type": "backButton",
            "icon": "arrow-left",
            "color": "#FFFFFF"
          },
          "title": "Bills & Subscriptions",
          "centerTitle": true,
          "actions": [
            {
              "type": "iconButton",
              "icon": "plus",
              "color": "#FFFFFF"
            }
          ]
        },
        "components": [
          {
            "id": "billsSummaryGrid",
            "type": "grid",
            "margin": {"bottom": 24},
            "design": {
              "columns": 2,
              "gap": 12,
              "items": [
                {
                  "type": "metricCard",
                  "icon": "file-text",
                  "iconColor": "#3B82F6",
                  "iconBackground": "#EFF6FF",
                  "value": "2",
                  "label": "Total Bills",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                },
                {
                  "type": "metricCard",
                  "icon": "alert-triangle",
                  "iconColor": "#F59E0B",
                  "iconBackground": "#FEF3C7",
                  "value": "0",
                  "label": "Overdue",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                },
                {
                  "type": "metricCard",
                  "icon": "dollar-sign",
                  "iconColor": "#EC4899",
                  "iconBackground": "#FCE7F3",
                  "value": "$0.00",
                  "label": "Monthly Total",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                },
                {
                  "type": "metricCard",
                  "icon": "check-circle",
                  "iconColor": "#10B981",
                  "iconBackground": "#D1FAE5",
                  "value": "0/0",
                  "label": "Paid",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                },
                {
                  "type": "metricCard",
                  "icon": "trending-up",
                  "iconColor": "#14B8A6",
                  "iconBackground": "#F0FDFA",
                  "value": "$500.00",
                  "label": "Monthly Income",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                },
                {
                  "type": "metricCard",
                  "icon": "credit-card",
                  "iconColor": "#8B5CF6",
                  "iconBackground": "#F3E8FF",
                  "value": "$200.00",
                  "label": "Received",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                },
                {
                  "type": "metricCard",
                  "icon": "link",
                  "iconColor": "#06B6D4",
                  "iconBackground": "#ECFEFF",
                  "value": "2",
                  "label": "Linked to Accounts",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                },
                {
                  "type": "metricCard",
                  "icon": "x-circle",
                  "iconColor": "#94A3B8",
                  "iconBackground": "#F8FAFC",
                  "value": "0",
                  "label": "Unlinked Bills",
                  "padding": 20,
                  "borderRadius": 16,
                  "backgroundColor": "#FFFFFF",
                  "elevation": 0.5
                }
              ]
            }
          },
          {
            "id": "filterByAccountSection",
            "type": "section",
            "margin": {"bottom": 12},
            "design": {
              "title": "Filter by Account",
              "fontSize": 16,
              "fontWeight": 600,
              "color": "#0F172A"
            }
          },
          {
            "id": "accountFilters",
            "type": "chipRow",
            "margin": {"bottom": 24},
            "design": {
              "layout": "horizontal",
              "scrollable": false,
              "gap": 8,
              "chips": [
                {
                  "type": "filterChip",
                  "label": "All Bills",
                  "selected": true,
                  "height": 40,
                  "paddingHorizontal": 16,
                  "borderRadius": 10,
                  "selectedBackgroundColor": "#14B8A6",
                  "selectedTextColor": "#FFFFFF",
                  "unselectedBackgroundColor": "#F8FAFC",
                  "unselectedTextColor": "#64748B",
                  "fontSize": 14,
                  "fontWeight": 600
                },
                {
                  "type": "filterChip",
                  "label": "Linked Only",
                  "selected": false,
                  "height": 40,
                  "paddingHorizontal": 16,
                  "borderRadius": 10,
                  "selectedBackgroundColor": "#14B8A6",
                  "selectedTextColor": "#FFFFFF",
                  "unselectedBackgroundColor": "#F8FAFC",
                  "unselectedTextColor": "#64748B",
                  "fontSize": 14,
                  "fontWeight": 600
                }
              ]
            }
          },
          {
            "id": "linkedAccountChip",
            "type": "chip",
            "margin": {"bottom": 24},
            "design": {
              "icon": "credit-card",
              "iconColor": "#14B8A6",
              "label": "Checking Account",
              "height": 40,
              "paddingHorizontal": 16,
              "borderRadius": 10,
              "backgroundColor": "#F0FDFA",
              "textColor": "#14B8A6",
              "fontSize": 14,
              "fontWeight": 600
            }
          },
          {
            "id": "upcomingBillsSection",
            "type": "section",
            "margin": {"bottom": 12},
            "design": {
              "title": "Upcoming Bills",
              "fontSize": 18,
              "fontWeight": 600,
              "color": "#0F172A"
            }
          },
          {
            "id": "upcomingBillsList",
            "type": "list",
            "margin": {"bottom": 24},
            "design": {
              "gap": 8,
              "items": [
                {
                  "type": "billItem",
                  "title": "Bill 1",
                  "subtitle": "30 days • $50.00",
                  "status": "Normal",
                  "statusBadge": {
                    "backgroundColor": "#F0FDFA",
                    "textColor": "#14B8A6",
                    "fontSize": 12,
                    "fontWeight": 600
                  },
                  "icon": {
                    "name": "file-text",
                    "backgroundColor": "#F8FAFC",
                    "iconColor": "#64748B",
                    "size": 48,
                    "iconSize": 24,
                    "borderRadius": 12
                  },
                  "padding": 16,
                  "backgroundColor": "#FFFFFF",
                  "borderRadius": 14,
                  "elevation": 0.5
                },
                {
                  "type": "billItem",
                  "title": "Bill 2",
                  "subtitle": "30 days • $100.00",
                  "status": "Normal",
                  "statusBadge": {
                    "backgroundColor": "#F0FDFA",
                    "textColor": "#14B8A6",
                    "fontSize": 12,
                    "fontWeight": 600
                  },
                  "icon": {
                    "name": "file-text",
                    "backgroundColor": "#F8FAFC",
                    "iconColor": "#64748B",
                    "size": 48,
                    "iconSize": 24,
                    "borderRadius": 12
                  },
                  "padding": 16,
                  "backgroundColor": "#FFFFFF",
                  "borderRadius": 14,
                  "elevation": 0.5
                }
              ]
            }
          },
          {
            "id": "upcomingIncomesSection",
            "type": "section",
            "margin": {"bottom": 12},
            "design": {
              "title": "Upcoming Incomes",
              "fontSize": 18,
              "fontWeight": 600,
              "color": "#0F172A"
            }
          },
          {
            "id": "upcomingIncomesList",
            "type": "list",
            "design": {
              "gap": 8,
              "items": [
                {
                  "type": "incomeItem",
                  "title": "Salary 1",
                  "subtitle": "30 days • $200.00",
                  "status": "Normal",
                  "statusBadge": {
                    "backgroundColor": "#F0FDFA",
                    "textColor": "#14B8A6",
                    "fontSize": 12,
                    "fontWeight": 600
                  },
                  "icon": {
                    "name": "trending-up",
                    "backgroundColor": "#D1FAE5",
                    "iconColor": "#10B981",
                    "size": 48,
                    "iconSize": 24,
                    "borderRadius": 12
                  },
                  "padding": 16,
                  "backgroundColor": "#FFFFFF",
                  "borderRadius": 14,
                  "elevation": 0.5
                }
              ]
            }
          }
        ]
      },
      
      "billDetailScreen": {
        "route": "/bills/:id",
        "title": "Bill Details",
        "layout": {
          "type": "scroll",
          "padding": 16,
          "backgroundColor": "#F8FAFC"
        },
        "appBar": {
          "backgroundColor": "#14B8A6",
          "foregroundColor": "#FFFFFF",
          "elevation": 0,
          "leading": {
            "type": "backButton",
            "icon": "arrow-left",
            "color": "#FFFFFF"
          },
          "title": "Bill 1",
          "centerTitle": true,
          "actions": [
            {
              "type": "iconButton",
              "icon": "more-vertical",
              "color": "#FFFFFF"
            }
          ]
        },
        "components": [
          {
            "id": "billStatusCard",
            "type": "card",
            "margin": {"bottom": 16},
            "design": {
              "borderRadius": 16,
              "padding": 20,
              "backgroundColor": "#FFFFFF",
              "elevation": 0.5,
              "header": {
                "layout": "horizontal",
                "justifyContent": "space-between",
                "alignItems": "center",
                "title": {
                  "text": "Status",
                  "fontSize": 16,
                  "fontWeight": 600,
                  "color": "#0F172A"
                },
                "statusBadge": {
                  "text": "Upcoming",
                  "backgroundColor": "#F0FDFA",
                  "textColor": "#14B8A6",
                  "padding": {"horizontal": 12, "vertical": 6},
                  "borderRadius": 8,
                  "fontSize": 13,
                  "fontWeight": 600
                }
              },
              "rows": {
                "marginTop": 16,
                "gap": 12,
                "items": [
                  {
                    "label": "Amount",
                    "value": "$50.00",
                    "valueColor": "#10B981",
                    "valueWeight": 700,
                    "valueFontSize": 24
                  },
                  {
                    "label": "Due Date",
                    "value": "Nov 15, 2025",
                    "valueColor": "#0F172A"
                  },
                  {
                    "label": "Days Until Due",
                    "value": "30 days remaining",
                    "valueColor": "#10B981",
                    "valueWeight": 600
                  }
                ]
              }
            }
          },
          {
            "id": "billInformationCard",
            "type": "card",
            "margin": {"bottom": 16},
            "design": {
              "borderRadius": 16,
              "padding": 20,
              "backgroundColor": "#FFFFFF",
              "elevation": 0.5,
              "header": {
                "text": "Bill Information",
                "fontSize": 16,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 16
              },
              "infoRows": [
                {
                  "label": "Name",
                  "value": "Bill 1"
                },
                {
                  "label": "Amount",
                  "value": "$50.00"
                },
                {
                  "label": "Frequency",
                  "value": "Monthly"
                },
                {
                  "label": "Due Date",
                  "value": "Nov 15, 2025"
                }
              ],
              "linkedAccount": {
                "marginTop": 16,
                "label": "Linked Account",
                "fontSize": 14,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 12,
                "accountCard": {
                  "icon": {
                    "name": "credit-card",
                    "backgroundColor": "#F0FDFA",
                    "iconColor": "#14B8A6",
                    "size": 40,
                    "iconSize": 20,
                    "borderRadius": 10
                  },
                  "name": "Checking Account",
                  "subtitle": "Bank Account • USD 202.00",
                  "padding": 12,
                  "backgroundColor": "#F8FAFC",
                  "borderRadius": 12
                }
              },
              "autoPay": {
                "marginTop": 16,
                "layout": "horizontal",
                "justifyContent": "space-between",
                "label": "Auto Pay",
                "value": "Disabled",
                "fontSize": 14,
                "labelColor": "#0F172A",
                "valueColor": "#64748B"
              }
            }
          },
          {
            "id": "paymentHistorySection",
            "type": "section",
            "design": {
              "header": {
                "title": "Payment History",
                "fontSize": 16,
                "fontWeight": 600,
                "color": "#0F172A",
                "action": {
                  "label": "View All",
                  "fontSize": 14,
                  "fontWeight": 600,
                  "color": "#14B8A6"
                }
              },
              "marginBottom": 16
            }
          },
          {
            "id": "paymentHistoryList",
            "type": "list",
            "design": {
              "gap": 8,
              "items": [
                {
                  "type": "paymentHistoryItem",
                  "amount": "$50.00",
                  "date": "Oct 16, 2025",
                  "status": "paid",
                  "icon": {
                    "name": "check-circle",
                    "backgroundColor": "#D1FAE5",
                    "iconColor": "#10B981",
                    "size": 40,
                    "iconSize": 20,
                    "borderRadius": 10
                  },
                  "padding": 16,
                  "backgroundColor": "#FFFFFF",
                  "borderRadius": 14,
                  "elevation": 0.5
                }
              ]
            }
          },
          {
            "id": "paymentEmpty",
            "type": "emptyState",
            "design": {
              "padding": 40,
              "borderRadius": 16,
              "backgroundColor": "#FFFFFF",
              "elevation": 0.5,
              "illustration": {
                "type": "icon",
                "name": "clock",
                "size": 64,
                "color": "#CBD5E1"
              },
              "title": {
                "text": "No payment history",
                "fontSize": 16,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginTop": 16
              },
              "message": {
                "text": "Payment records will appear here",
                "fontSize": 14,
                "color": "#64748B",
                "marginTop": 8
              }
            }
          }
        ],
        "fab": {
          "type": "standard",
          "icon": "check",
          "size": 56,
          "borderRadius": 16,
          "backgroundColor": "#10B981",
          "iconColor": "#FFFFFF",
          "elevation": 4,
          "position": "bottom-right",
          "margin": 16,
          "action": "markAsPaid"
        }
      }
    },
    
    "modals": {
      "addTransactionModal": {
        "type": "bottomSheet",
        "design": {
          "maxHeight": "90%",
          "borderTopRadius": 24,
          "backgroundColor": "#FFFFFF",
          "dragHandle": {
            "width": 36,
            "height": 4,
            "backgroundColor": "#CBD5E1",
            "borderRadius": 2,
            "marginTop": 12,
            "marginBottom": 12
          },
          "padding": 20,
          "components": [
            {
              "id": "modalHeader",
              "type": "header",
              "design": {
                "title": "Add Transaction",
                "fontSize": 22,
                "fontWeight": 700,
                "color": "#0F172A",
                "closeButton": {
                  "position": "right",
                  "icon": "x",
                  "size": 40,
                  "iconSize": 24,
                  "backgroundColor": "#F8FAFC",
                  "iconColor": "#64748B",
                  "borderRadius": 10
                },
                "marginBottom": 24
              }
            },
            {
              "id": "transactionTypeSelector",
              "type": "segmentedControl",
              "margin": {"bottom": 24},
              "design": {
                "backgroundColor": "#F8FAFC",
                "borderRadius": 12,
                "padding": 4,
                "height": 48,
                "segments": [
                  {
                    "icon": "trending-down",
                    "label": "Expense",
                    "value": "expense"
                  },
                  {
                    "icon": "trending-up",
                    "label": "Income",
                    "value": "income"
                  },
                  {
                    "icon": "repeat",
                    "label": "Transfer",
                    "value": "transfer"
                  }
                ],
                "selectedBackgroundColor": "#FFFFFF",
                "selectedTextColor": "#14B8A6",
                "unselectedTextColor": "#64748B",
                "fontSize": 14,
                "fontWeight": 600
              }
            },
            {
              "id": "amountInput",
              "type": "currencyInput",
"margin": {"bottom": 32},
              "design": {
                "height": 80,
                "borderRadius": 16,
                "backgroundColor": "#F8FAFC",
                "fontSize": 48,
                "fontWeight": 700,
                "textAlign": "center",
                "color": "#14B8A6",
                "placeholder": "$0.00",
                "prefix": {
                  "text": "$",
                  "fontSize": 36,
                  "color": "#94A3B8"
                }
              }
            },
            {
              "id": "categorySelector",
              "type": "categoryGrid",
              "margin": {"bottom": 24},
              "design": {
                "label": "Category",
                "fontSize": 14,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 12,
                "columns": 4,
                "gap": 12,
                "items": [
                  {
                    "id": "food",
                    "icon": "utensils",
                    "label": "Food",
                    "iconColor": "#F97316",
                    "iconBackground": "#FEF3C7",
                    "size": 64,
                    "iconSize": 28,
                    "borderRadius": 12,
                    "labelFontSize": 11,
                    "selectedBorderWidth": 2,
                    "selectedBorderColor": "#F97316"
                  },
                  {
                    "id": "transport",
                    "icon": "car",
                    "label": "Transport",
                    "iconColor": "#3B82F6",
                    "iconBackground": "#EFF6FF",
                    "size": 64,
                    "iconSize": 28,
                    "borderRadius": 12,
                    "labelFontSize": 11
                  },
                  {
                    "id": "shopping",
                    "icon": "shopping-bag",
                    "label": "Shopping",
                    "iconColor": "#EC4899",
                    "iconBackground": "#FCE7F3",
                    "size": 64,
                    "iconSize": 28,
                    "borderRadius": 12,
                    "labelFontSize": 11
                  },
                  {
                    "id": "entertainment",
                    "icon": "film",
                    "label": "Fun",
                    "iconColor": "#8B5CF6",
                    "iconBackground": "#F3E8FF",
                    "size": 64,
                    "iconSize": 28,
                    "borderRadius": 12,
                    "labelFontSize": 11
                  }
                ]
              }
            },
            {
              "id": "dateField",
              "type": "formField",
              "margin": {"bottom": 16},
              "design": {
                "label": "Date",
                "value": "Oct 08, 2025",
                "icon": "calendar",
                "height": 56,
                "borderRadius": 12,
                "backgroundColor": "#FFFFFF",
                "borderColor": "#E2E8F0",
                "borderWidth": 1.5,
                "paddingHorizontal": 16,
                "labelFontSize": 14,
                "labelColor": "#64748B",
                "valueFontSize": 16,
                "valueColor": "#0F172A",
                "chevron": true
              }
            },
            {
              "id": "accountField",
              "type": "formField",
              "margin": {"bottom": 16},
              "design": {
                "label": "Account",
                "value": "Checking Account",
                "icon": "credit-card",
                "height": 56,
                "borderRadius": 12,
                "backgroundColor": "#FFFFFF",
                "borderColor": "#E2E8F0",
                "borderWidth": 1.5,
                "paddingHorizontal": 16,
                "chevron": true
              }
            },
            {
              "id": "descriptionField",
              "type": "textArea",
              "margin": {"bottom": 16},
              "design": {
                "label": "Description (optional)",
                "placeholder": "Add a note...",
                "minHeight": 80,
                "maxHeight": 120,
                "borderRadius": 12,
                "backgroundColor": "#FFFFFF",
                "borderColor": "#E2E8F0",
                "borderWidth": 1.5,
                "paddingHorizontal": 16,
                "paddingVertical": 12,
                "fontSize": 16,
                "maxLength": 100,
                "showCounter": true
              }
            },
            {
              "id": "submitButton",
              "type": "button",
              "margin": {"top": 24, "bottom": 16},
              "design": {
                "label": "Add Transaction",
                "height": 56,
                "borderRadius": 14,
                "backgroundColor": "#14B8A6",
                "textColor": "#FFFFFF",
                "fontSize": 16,
                "fontWeight": 600,
                "elevation": 0
              }
            }
          ]
        }
      },
      
      "filterTransactionsModal": {
        "type": "bottomSheet",
        "design": {
          "maxHeight": "80%",
          "borderTopRadius": 24,
          "backgroundColor": "#FFFFFF",
          "dragHandle": {
            "width": 36,
            "height": 4,
            "backgroundColor": "#CBD5E1",
            "borderRadius": 2,
            "marginTop": 12,
            "marginBottom": 12
          },
          "padding": 20,
          "components": [
            {
              "id": "modalHeader",
              "type": "header",
              "design": {
                "title": "Filter Transactions",
                "fontSize": 22,
                "fontWeight": 700,
                "color": "#0F172A",
                "marginBottom": 24
              }
            },
            {
              "id": "transactionTypeFilter",
              "type": "section",
              "design": {
                "label": "Transaction Type",
                "fontSize": 14,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 12,
                "control": {
                  "type": "segmentedControl",
                  "backgroundColor": "#F8FAFC",
                  "borderRadius": 12,
                  "padding": 4,
                  "height": 44,
                  "segments": [
                    {"label": "All", "value": "all"},
                    {"label": "Income", "value": "income"},
                    {"label": "Expense", "value": "expense"}
                  ],
                  "selectedBackgroundColor": "#FFFFFF",
                  "selectedTextColor": "#14B8A6",
                  "unselectedTextColor": "#64748B"
                },
                "marginBottom": 24
              }
            },
            {
              "id": "accountFilter",
              "type": "dropdown",
              "margin": {"bottom": 24},
              "design": {
                "label": "Account",
                "fontSize": 14,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 8,
                "placeholder": "Select Account",
                "value": "All Accounts",
                "height": 48,
                "borderRadius": 12,
                "backgroundColor": "#FFFFFF",
                "borderColor": "#E2E8F0",
                "borderWidth": 1.5,
                "paddingHorizontal": 16
              }
            },
            {
              "id": "categoriesFilter",
              "type": "dropdown",
              "margin": {"bottom": 24},
              "design": {
                "label": "Categories",
                "fontSize": 14,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 8,
                "placeholder": "Select Categories",
                "value": "All Categories",
                "height": 48,
                "borderRadius": 12,
                "backgroundColor": "#FFFFFF",
                "borderColor": "#E2E8F0",
                "borderWidth": 1.5,
                "paddingHorizontal": 16
              }
            },
            {
              "id": "dateRangeFilter",
              "type": "dateRange",
              "margin": {"bottom": 24},
              "design": {
                "label": "Date Range",
                "fontSize": 14,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 12,
                "layout": "horizontal",
                "gap": 12,
                "startDate": {
                  "label": "Start Date",
                  "height": 48,
                  "flex": 1,
                  "borderRadius": 12,
                  "backgroundColor": "#FFFFFF",
                  "borderColor": "#E2E8F0",
                  "borderWidth": 1.5,
                  "icon": "calendar"
                },
                "endDate": {
                  "label": "End Date",
                  "height": 48,
                  "flex": 1,
                  "borderRadius": 12,
                  "backgroundColor": "#FFFFFF",
                  "borderColor": "#E2E8F0",
                  "borderWidth": 1.5,
                  "icon": "calendar"
                }
              }
            },
            {
              "id": "amountRangeFilter",
              "type": "rangeSlider",
              "margin": {"bottom": 32},
              "design": {
                "label": "Amount Range",
                "fontSize": 14,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 12,
                "min": 0,
                "max": 1000,
                "values": [0, 1000],
                "inputs": {
                  "layout": "horizontal",
                  "gap": 12,
                  "minInput": {
                    "label": "Min Amount",
                    "height": 48,
                    "flex": 1,
                    "borderRadius": 12,
                    "backgroundColor": "#FFFFFF",
                    "borderColor": "#E2E8F0",
                    "borderWidth": 1.5
                  },
                  "maxInput": {
                    "label": "Max Amount",
                    "height": 48,
                    "flex": 1,
                    "borderRadius": 12,
                    "backgroundColor": "#FFFFFF",
                    "borderColor": "#E2E8F0",
                    "borderWidth": 1.5
                  }
                }
              }
            },
            {
              "id": "actionButtons",
              "type": "buttonGroup",
              "design": {
                "layout": "horizontal",
                "gap": 12,
                "clearButton": {
                  "label": "Clear",
                  "flex": 1,
                  "height": 56,
                  "borderRadius": 14,
                  "backgroundColor": "#F8FAFC",
                  "textColor": "#64748B",
                  "fontSize": 16,
                  "fontWeight": 600
                },
                "applyButton": {
                  "label": "Apply",
                  "flex": 1,
                  "height": 56,
                  "borderRadius": 14,
                  "backgroundColor": "#14B8A6",
                  "textColor": "#FFFFFF",
                  "fontSize": 16,
                  "fontWeight": 600
                }
              }
            }
          ]
        }
      },
      
      "addCategoryModal": {
        "type": "dialog",
        "design": {
          "maxWidth": 400,
          "borderRadius": 20,
          "backgroundColor": "#FFFFFF",
          "padding": 24,
          "elevation": "xl",
          "components": [
            {
              "id": "modalHeader",
              "type": "header",
              "design": {
                "title": "Add Category",
                "fontSize": 20,
                "fontWeight": 700,
                "color": "#0F172A",
                "marginBottom": 24
              }
            },
            {
              "id": "categoryNameField",
              "type": "textField",
              "margin": {"bottom": 20},
              "design": {
                "label": "Category Name",
                "placeholder": "e.g., Outdoor Meal",
                "height": 48,
                "borderRadius": 12,
                "backgroundColor": "#FFFFFF",
                "borderColor": "#E2E8F0",
                "borderWidth": 1.5
              }
            },
            {
              "id": "categoryTypeDropdown",
              "type": "dropdown",
              "margin": {"bottom": 20},
              "design": {
                "label": "Type",
                "value": "Expense",
                "height": 48,
                "borderRadius": 12,
                "backgroundColor": "#FFFFFF",
                "borderColor": "#E2E8F0",
                "borderWidth": 1.5
              }
            },
            {
              "id": "iconSelector",
              "type": "iconGrid",
              "margin": {"bottom": 20},
              "design": {
                "label": "Icon",
                "fontSize": 14,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 12,
                "columns": 5,
                "gap": 8,
                "items": [
                  {
                    "icon": "utensils",
                    "size": 48,
                    "iconSize": 24,
                    "backgroundColor": "#F8FAFC",
                    "iconColor": "#475569",
                    "borderRadius": 10,
                    "selectedBorderWidth": 2,
                    "selectedBorderColor": "#14B8A6"
                  }
                ]
              }
            },
            {
              "id": "colorSelector",
              "type": "colorPicker",
              "margin": {"bottom": 24},
              "design": {
                "label": "Color",
                "fontSize": 14,
                "fontWeight": 600,
                "color": "#0F172A",
                "marginBottom": 12,
                "layout": "horizontal",
                "gap": 12,
                "colors": [
                  {"value": "#3B82F6", "size": 40},
                  {"value": "#10B981", "size": 40},
                  {"value": "#EF4444", "size": 40},
                  {"value": "#F97316", "size": 40},
                  {"value": "#8B5CF6", "size": 40},
                  {"value": "#EC4899", "size": 40},
                  {"value": "#F59E0B", "size": 40},
                  {"value": "#06B6D4", "size": 40},
                  {"value": "#64748B", "size": 40}
                ],
                "selectedBorderWidth": 3,
                "selectedBorderColor": "#FFFFFF",
                "selectedOutlineWidth": 2,
                "selectedOutlineColor": "#0F172A"
              }
            },
            {
              "id": "actionButtons",
              "type": "buttonGroup",
              "design": {
                "layout": "horizontal",
                "gap": 12,
                "cancelButton": {
                  "label": "Cancel",
                  "flex": 1,
                  "height": 48,
                  "borderRadius": 12,
                  "backgroundColor": "#F8FAFC",
                  "textColor": "#64748B",
                  "fontSize": 16,
                  "fontWeight": 600
                },
                "addButton": {
                  "label": "Add",
                  "flex": 1,
                  "height": 48,
                  "borderRadius": 12,
                  "backgroundColor": "#14B8A6",
                  "textColor": "#FFFFFF",
                  "fontSize": 16,
                  "fontWeight": 600
                }
              }
            }
          ]
        }
      },
      
      "addContributionModal": {
        "type": "bottomSheet",
        "design": {
          "maxHeight": "70%",
          "borderTopRadius": 24,
          "backgroundColor": "#FFFFFF",
          "dragHandle": {
            "width": 36,
            "height": 4,
            "backgroundColor": "#CBD5E1",
            "borderRadius": 2,
            "marginTop": 12,
            "marginBottom": 12
          },
          "padding": 20,
          "components": [
            {
              "id": "modalHeader",
              "type": "header",
              "design": {
                "icon": "plus-circle",
                "iconColor": "#14B8A6",
                "iconSize": 28,
                "title": "Add Contribution",
                "fontSize": 22,
                "fontWeight": 700,
                "color": "#0F172A",
                "marginBottom": 24
              }
            },
            {
              "id": "amountInput",
              "type": "currencyInput",
              "margin": {"bottom": 24},
              "design": {
                "label": "Amount",
                "height": 56,
                "borderRadius": 12,
                "backgroundColor": "#FFFFFF",
                "borderColor": "#E2E8F0",
                "borderWidth": 1.5,
                "fontSize": 24,
                "fontWeight": 700,
                "textAlign": "left",
                "color": "#14B8A6",
                "paddingHorizontal": 16,
                "placeholder": "0.00"
              }
            },
            {
              "id": "dateField",
              "type": "dropdown",
              "margin": {"bottom": 24},
              "design": {
                "label": "Date",
                "value": "Thursday, October 16, 2025",
                "icon": "calendar",
                "iconColor": "#14B8A6",
                "height": 56,
                "borderRadius": 12,
                "backgroundColor": "#FFFFFF",
                "borderColor": "#E2E8F0",
                "borderWidth": 1.5,
                "paddingHorizontal": 16
              }
            },
            {
              "id": "noteField",
              "type": "textArea",
              "margin": {"bottom": 24},
              "design": {
                "label": "Note (Optional)",
                "placeholder": "Add a note about this contribution...",
                "minHeight": 100,
                "maxHeight": 150,
                "borderRadius": 12,
                "backgroundColor": "#FFFFFF",
                "borderColor": "#E2E8F0",
                "borderWidth": 1.5,
                "paddingHorizontal": 16,
                "paddingVertical": 12,
                "fontSize": 16
              }
            },
            {
              "id": "actionButtons",
              "type": "buttonGroup",
              "design": {
                "layout": "horizontal",
                "gap": 12,
                "cancelButton": {
                  "label": "Cancel",
                  "flex": 1,
                  "height": 56,
                  "borderRadius": 14,
                  "backgroundColor": "#F8FAFC",
                  "textColor": "#64748B",
                  "fontSize": 16,
                  "fontWeight": 600
                },
                "addButton": {
                  "label": "Add Contribution",
                  "flex": 2,
                  "height": 56,
                  "borderRadius": 14,
                  "backgroundColor": "#14B8A6",
                  "textColor": "#FFFFFF",
                  "fontSize": 16,
                  "fontWeight": 600
                }
              }
            }
          ]
        }
      },
      
      "confirmationDialog": {
        "type": "dialog",
        "design": {
          "maxWidth": 320,
          "borderRadius": 20,
          "backgroundColor": "#FFFFFF",
          "padding": 24,
          "elevation": "xl",
          "components": [
            {
              "id": "illustration",
              "type": "icon",
              "design": {
                "name": "alert-triangle",
                "size": 64,
                "color": "#F59E0B",
                "marginBottom": 16,
                "alignment": "center"
              }
            },
            {
              "id": "title",
              "type": "text",
              "design": {
                "text": "Delete Transaction?",
                "fontSize": 20,
                "fontWeight": 700,
                "color": "#0F172A",
                "textAlign": "center",
                "marginBottom": 8
              }
            },
            {
              "id": "message",
              "type": "text",
              "design": {
                "text": "This action cannot be undone. Are you sure you want to delete this transaction?",
                "fontSize": 14,
                "color": "#64748B",
                "textAlign": "center",
                "lineHeight": 1.5,
                "marginBottom": 24
              }
            },
            {
              "id": "actionButtons",
              "type": "buttonGroup",
              "design": {
                "layout": "vertical",
                "gap": 12,
                "confirmButton": {
                  "label": "Yes, Delete",
                  "height": 48,
                  "borderRadius": 12,
                  "backgroundColor": "#EF4444",
                  "textColor": "#FFFFFF",
                  "fontSize": 16,
                  "fontWeight": 600
                },
                "cancelButton": {
                  "label": "Cancel",
                  "height": 48,
                  "borderRadius": 12,
                  "backgroundColor": "#F8FAFC",
                  "textColor": "#64748B",
                  "fontSize": 16,
                  "fontWeight": 600
                }
              }
            }
          ]
        }
      }
    },
    
    "navigation": {
      "bottomNavigationBar": {
        "design": {
          "height": 72,
          "backgroundColor": "#FFFFFF",
          "elevation": 8,
          "items": [
            {
              "id": "home",
              "icon": "home",
              "label": "Home",
              "route": "/home",
              "selectedColor": "#14B8A6",
              "unselectedColor": "#94A3B8"
            },
            {
              "id": "transactions",
              "icon": "repeat",
              "label": "Transactions",
              "route": "/transactions",
              "selectedColor": "#14B8A6",
              "unselectedColor": "#94A3B8"
            },
            {
              "id": "budgets",
              "icon": "pie-chart",
              "label": "Budgets",
              "route": "/budgets",
              "selectedColor": "#14B8A6",
              "unselectedColor": "#94A3B8"
            },
            {
              "id": "goals",
              "icon": "target",
              "label": "Goals",
              "route": "/goals",
              "selectedColor": "#14B8A6",
              "unselectedColor": "#94A3B8"
            },
            {
              "id": "more",
              "icon": "more-horizontal",
              "label": "More",
              "route": "/more",
              "selectedColor": "#14B8A6",
              "unselectedColor": "#94A3B8"
            }
          ],
          "iconSize": 24,
          "labelFontSize": 12,
          "labelFontWeight": 500,
          "selectedLabelWeight": 600
        }
      }
    },
    
    "sharedComponents": {
      "swipeActions": {
        "design": {
          "threshold": 0.3,
          "animationDuration": 200,
          "actions": {
            "edit": {
              "backgroundColor": "#3B82F6",
              "icon": "edit",
              "iconColor": "#FFFFFF",
              "iconSize": 20,
              "label": "Edit",
              "labelColor": "#FFFFFF",
              "labelFontSize": 13,
              "labelFontWeight": 600,
              "width": 80
            },
            "delete": {
              "backgroundColor": "#EF4444",
              "icon": "trash",
              "iconColor": "#FFFFFF",
              "iconSize": 20,
              "label": "Delete",
              "labelColor": "#FFFFFF",
              "labelFontSize": 13,
              "labelFontWeight": 600,
              "width": 80
            },
            "duplicate": {
              "backgroundColor": "#14B8A6",
              "icon": "copy",
              "iconColor": "#FFFFFF",
              "iconSize": 20,
              "label": "Duplicate",
              "labelColor": "#FFFFFF",
              "labelFontSize": 13,
              "labelFontWeight": 600,
              "width": 90
            },
            "category": {
              "backgroundColor": "#10B981",
              "icon": "tag",
              "iconColor": "#FFFFFF",
              "iconSize": 20,
              "label": "Category",
              "labelColor": "#FFFFFF",
              "labelFontSize": 13,
              "labelFontWeight": 600,
              "width": 90
            }
          }
        }
      },
      
      "toastNotification": {
        "design": {
          "minHeight": 56,
          "maxWidth": 400,
          "borderRadius": 12,
          "padding": {"horizontal": 16, "vertical": 12},
          "elevation": 4,
          "animationDuration": 300,
          "displayDuration": 3000,
          "position": "bottom",
          "offsetBottom": 100,
          "variants": {
            "success": {
              "backgroundColor": "#10B981",
              "textColor": "#FFFFFF",
              "icon": "check-circle",
              "iconColor": "#FFFFFF"
            },
            "error": {
              "backgroundColor": "#EF4444",
              "textColor": "#FFFFFF",
              "icon": "x-circle",
              "iconColor": "#FFFFFF"
            },
            "info": {
              "backgroundColor": "#3B82F6",
              "textColor": "#FFFFFF",
              "icon": "info",
              "iconColor": "#FFFFFF"
            },
            "warning": {
              "backgroundColor": "#F59E0B",
              "textColor": "#FFFFFF",
              "icon": "alert-triangle",
              "iconColor": "#FFFFFF"
            }
          }
        }
      },
      
      "loadingIndicator": {
        "design": {
          "variants": {
            "spinner": {
              "size": 40,
              "strokeWidth": 4,
              "color": "#14B8A6",
              "animationDuration": 1000
            },
            "overlay": {
              "backgroundColor": "rgba(0, 0, 0, 0.4)",
              "backdropBlur": 2,
              "spinnerSize": 48,
              "spinnerColor": "#FFFFFF"
            },
            "skeleton": {
              "baseColor": "#F1F5F9",
              "highlightColor": "#E2E8F0",
              "animationDuration": 1500,
              "borderRadius": "inherit"
            }
          }
        }
      }
    },
    
    "designTokens": {
      "animations": {
        "durations": {
          "instant": 0,
          "fast": 150,
          "normal": 200,
          "moderate": 300,
          "slow": 400,
          "slower": 600
        },
        "curves": {
          "linear": "linear",
          "easeIn": "cubic-bezier(0.4, 0.0, 1, 1)",
          "easeOut": "cubic-bezier(0.0, 0.0, 0.2, 1)",
          "easeInOut": "cubic-bezier(0.4, 0.0, 0.2, 1)",
          "spring": "cubic-bezier(0.34, 1.56, 0.64, 1)"
        }
      },
      "accessibility": {
        "minTouchTarget": 48,
        "minFontSize": 14,
        "colorContrast": {
          "minimum": 4.5,
          "enhanced": 7
        },
        "focusIndicator": {
          "width": 2,
          "color": "#14B8A6",
          "offset": 2
        }
      }
    }
  }
}


```

---

## 📋 Implementation Summary

### **Key Design Improvements Applied:**

1. **✅ Replaced harsh blue (#2962FF)** with friendly teal (#14B8A6)
2. **✅ Enhanced visual hierarchy** with proper spacing and typography
3. **✅ Modernized all cards** with subtle shadows and rounded corners
4. **✅ Added consistent color coding** for income (green) and expenses (red)
5. **✅ Implemented friendly illustrations** for empty states
6. **✅ Enhanced category icons** with colored backgrounds
7. **✅ Improved transaction tiles** with better information layout
8. **✅ Added swipe actions** for quick edit/delete
9. **✅ Modernized modals** with bottom sheets and better forms
10. **✅ Enhanced goal cards** with progress visualization

### **Design System Features:**

- **Comprehensive component library** covering all screens
- **Consistent spacing system** (4px base unit)
- **Unified color palette** combining TrackFinz and Pink App
- **Modern typography** using Inter font family
- **Flexible theming system** for light/dark modes
- **Accessibility-first** approach with proper touch targets
- **Animation guidelines** for micro-interactions
- **Responsive design** considerations

### **Next Steps for Development:**

1. Implement Flutter theme setup as provided
2. Create reusable component widgets based on JSON specs
3. Build screen layouts following the design system
4. Implement state management with Riverpod
5. Add animations using flutter_animate
6. Test on multiple devices for responsiveness
7. Conduct accessibility audit
8. Perform user testing and iterate

This complete design system ensures **consistency, scalability, and excellent user experience** across the entire budget management application! 🎨✨